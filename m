From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH] setup: return correct prefix if worktree is '/'
Date: Fri, 25 Mar 2011 22:11:56 +0700
Message-ID: <AANLkTi=tZiVvBPy-VoTp+nWTPTrvpgY9OBPR-D0b7K5-@mail.gmail.com>
References: <20110325100254.GH30350@login.drsnuggles.stderr.nl>
 <1301060989-7246-1-git-send-email-pclouds@gmail.com> <4D8CA3EF.3010403@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Matthijs Kooijman <matthijs@stdin.nl>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Fri Mar 25 16:12:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q38h6-0004C4-SG
	for gcvg-git-2@lo.gmane.org; Fri, 25 Mar 2011 16:12:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750881Ab1CYPMv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Mar 2011 11:12:51 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:62656 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750824Ab1CYPMv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Mar 2011 11:12:51 -0400
Received: by wya21 with SMTP id 21so1185972wya.19
        for <git@vger.kernel.org>; Fri, 25 Mar 2011 08:12:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=i+4TSxWCdhYmNv/h99FFcOnlTIvbcJXlGLNnDW4K8io=;
        b=HVpLbg9/z+dAAqXVywc7fzcRA5VRI+cqxLN27+8HZic7PYuTUBeXruYZBUXYaet5gA
         RFLgzZIPVPC9GWspDOmDJigVsO33QDXehh2H7ofV3OXoy/MHVms6MDgDrUOqBAZvzhh3
         axgjbEJtJEzA0fjYRr/0olIWagkA2pF0Ja/ec=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=HMDfSkCWr/lNHQcNpdRdpYpX8mOB/33T4pLk74zHovwVef3norGeR7OPH75Y1CZJT3
         uzLf/DRF6Jen0ilYgl6InYMIgGQT6e9JvuHo1QLkV7SV0CvjJx9p5sKwBBwCp+mzIp0A
         xnrehuWWyvrfkGpB3+oEuonD3rjiPszpcuR9M=
Received: by 10.216.242.134 with SMTP id i6mr2098207wer.81.1301065946094; Fri,
 25 Mar 2011 08:12:26 -0700 (PDT)
Received: by 10.216.163.202 with HTTP; Fri, 25 Mar 2011 08:11:56 -0700 (PDT)
In-Reply-To: <4D8CA3EF.3010403@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169989>

2011/3/25 Michael J Gruber <git@drmicha.warpmail.net>:
> Wait wait, the bug bisects to
>
> 490544b (get_cwd_relative(): do not misinterpret suffix as subdirectory,
> 2010-05-22)

Well, we've had a few bugs in this area lately :) That one was fixed
by fbbb4e1 (get_cwd_relative(): do not misinterpret root path -
2010-11-20), which was also noticed by Mathijs.

> for me, using
>
> git bisect run sh -c "make || exit 125; cd /etc; GIT_DIR=/tmp/a/.git
> ~/src/git/git-add fstab || exit 1"
>
> and a repo in /tmp/a/.git with core.worktree set to "/".
>
> The issue is that in get_relative_cwd() of dir.c, "dir" (and maybe
> ("cwd") may or may not end in "/", so even with dir="/etc/" and
> cwd="/etc" we would not recognize we are within the repo. Patch for that
> is coming.
>
> Note that by doing something like the above, we can test / without being
> root as long as we have files there which we can rely on being readable,
> or can rely on /tmp being there.

Sounds good, as long as we stick to standard paths, like /etc/fstab.
But that won't work on Windows. I don't even know if any file is
always at a known location in C:\.
-- 
Duy
