From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Alternates corruption issue
Date: Tue, 31 Jan 2012 15:40:47 -0600
Message-ID: <20120131214047.GA13547@burratino>
References: <1328018729.13744.26.camel@ted>
 <20120131193922.GA31551@sigill.intra.peff.net>
 <7v1uqf8vqu.fsf@alter.siamese.dyndns.org>
 <20120131204417.GA30969@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Richard Purdie <richard.purdie@linuxfoundation.org>,
	GIT Mailing-list <git@vger.kernel.org>,
	"Hart, Darren" <darren.hart@intel.com>,
	"Ashfield, Bruce" <Bruce.Ashfield@windriver.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jan 31 22:41:15 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RsLRy-0000tw-9b
	for gcvg-git-2@plane.gmane.org; Tue, 31 Jan 2012 22:41:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755328Ab2AaVlI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 Jan 2012 16:41:08 -0500
Received: from mail-we0-f174.google.com ([74.125.82.174]:45072 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755248Ab2AaVlH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Jan 2012 16:41:07 -0500
Received: by werb13 with SMTP id b13so427365wer.19
        for <git@vger.kernel.org>; Tue, 31 Jan 2012 13:41:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=o/yNwTF0WbxnRZsShsIQvMD5pImeggKGpbnIzOxmtPc=;
        b=wf+vHfQ0rTwuVtZrvmmQIE5z9Z6pwaQJYhZEWBSHuNCnliavkUPEimrqrbR2z4CpDN
         KfJoIxN1UQv+df1ikIN4T0iCtDccT1/UwvG7sttNkWhYoDcAabHqcVRv59vFiF+c/DWq
         akTlzbkS/JnJI1U9xFifdJJwWFtnaRasSnFZk=
Received: by 10.216.132.148 with SMTP id o20mr1691381wei.33.1328046064926;
        Tue, 31 Jan 2012 13:41:04 -0800 (PST)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id y1sm15207490wiw.6.2012.01.31.13.41.02
        (version=SSLv3 cipher=OTHER);
        Tue, 31 Jan 2012 13:41:03 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20120131204417.GA30969@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189473>

Jeff King wrote:

> No, it does not match. While the sequence I outlined above makes the
> most sense to me, it does not match what setup_git_directory does, which
> prefers "foo/.git" to using "foo" as a bare repo. I think being
> consistent between all of the lookup points makes sense. The patch took
> the least-invasive approach and aligned clone and enter_repo with
> setup_git_directory.
>
> However, we could also tweak setup_git_directory to prefer bare repos
> over ".git" to keep things consistent. While it makes me feel good from
> a theoretical standpoint (because the rules above seem simple and
> intuitive to me), I'm not sure it's a good idea in practice.

Wait, don't these two functions serve two completely different purposes?

One is the implementation of (A):

	cd foo
	git rev-parse --git-dir

The other implements (B):

	git ls-remote foo

If "foo" is actually a bare repository that moonlights as a worktree for
a non-bare repository, then:

 1) Whoever set up these directories is completely insane[*].  Maybe we
    should emit a warning.

 2) As a naive user, I would expect (A) to give a different result
    from (B).

Hope that helps,
Jonathan

[*] ok, ok, they can be confused instead of insane:
http://bugs.debian.org/399041
