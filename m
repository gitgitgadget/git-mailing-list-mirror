From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: cherry-pick / pre-commit hook?
Date: Tue, 28 Dec 2010 14:38:20 -0800 (PST)
Message-ID: <m3vd2djzhp.fsf@localhost.localdomain>
References: <m2wrnktcl2.wl%dave@boostpro.com>
	<20101208175324.GB5687@burratino> <m2oc8wt0xc.wl%dave@boostpro.com>
	<20101208220514.GA8865@burratino> <m2d3oo9cwr.wl%dave@boostpro.com>
	<20101227093729.GB1201@burratino>
	<7vy679wynd.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Dave Abrahams <dave@boostpro.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 28 23:38:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PXiBY-000647-Vu
	for gcvg-git-2@lo.gmane.org; Tue, 28 Dec 2010 23:38:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752824Ab0L1WiY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Dec 2010 17:38:24 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:36551 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752696Ab0L1WiX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Dec 2010 17:38:23 -0500
Received: by fxm20 with SMTP id 20so10088386fxm.19
        for <git@vger.kernel.org>; Tue, 28 Dec 2010 14:38:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=guBvIAGPPZ4Kf4lWl2+YwplxQ/sAouHEQBToM4Vrg1E=;
        b=f3k0+ipomb1n9bfqTk1vnQU0R/sRvbpjYAEsGl30/zQ7h4VDIc7F7IoDCf64zHNYG3
         p3qUN8bbX3G/ujIrMMF4dE0BZEaRHUV038xMh3/QZVUSeE3vULHKRqENl3tY+pRw1jsm
         XebxLfZMzXHdvdsclJENb4dcklFwKXn+QPFL8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=E2ru33ofasbF7f8OhwajPddfYHd9Nk3TDGPVjBq92Fxg+leDAw2gYZS3HAvAOuOK91
         DCMDwepao6RoARyj5FqFHddsSg4iC0qyRcDpmrUIcVJ73REJZ407QBlUNQds1YfghSpZ
         BMGSFTABJGLNI8KkAz8kAABquYLGlVM8394cs=
Received: by 10.223.83.11 with SMTP id d11mr4310443fal.37.1293575901958;
        Tue, 28 Dec 2010 14:38:21 -0800 (PST)
Received: from localhost.localdomain (abws45.neoplus.adsl.tpnet.pl [83.8.242.45])
        by mx.google.com with ESMTPS id f24sm3337646fak.24.2010.12.28.14.38.14
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 28 Dec 2010 14:38:20 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id oBSMbUCA007794;
	Tue, 28 Dec 2010 23:37:37 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id oBSMb7EN007790;
	Tue, 28 Dec 2010 23:37:07 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <7vy679wynd.fsf@alter.siamese.dyndns.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164290>

Junio C Hamano <gitster@pobox.com> writes:

> I think the basic direction could be (I haven't thought things through,
> just a strawman):
> 
>  - Allow --verify/--no-verify to all commands that possibly create a new
>    commit, and run pre-commit hook where an updated index is about to be
>    made into a commit (for some commands this may not be very easy);
> 
>  - The guideline of picking the default would probably look like this:
> 
>    (1) for existing commands, keep the current behaviour;
> 
>    (2) for a new command, --verify should be the default if the command is
>        primarily about letting the user do what s/he would/could/should
>        have done as "git commit" in the first place (e.g. cherry-picking
>        one's own commit from a separate branch or rebasing one's own
>        unpublished branch on top of updated upstream), and --no-verify
>        otherwise (i.e. taking other's work and using it in a context
>        different from the original).

Does it mean that for now (and perhaps also for later) it means that
"git commit" by default runs pre-commit hook, unless one use
--no-verify, and that all comands that create a new commit (rebase,
cherry-pick, revert, merge/pull) can request for pre-commit hook to be
run (if they create commit) with --verify?

I think it is a very good idea, though I don't know how difficult it
would be to make all commands that can create commit accept --verify..

-- 
Jakub Narebski
Poland
ShadeHawk on #git
