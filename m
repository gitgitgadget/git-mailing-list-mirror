From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 1/2] remote-helpers: tests: use python directly
Date: Sun, 19 May 2013 03:25:02 -0500
Message-ID: <51988c5e6cefb_76e0f31e20808a6@nysa.mail>
References: <1368825008-2815-1-git-send-email-felipe.contreras@gmail.com>
 <1368825008-2815-2-git-send-email-felipe.contreras@gmail.com>
 <7vwqqxujby.fsf@alter.siamese.dyndns.org>
 <CAJDDKr6Qnx5ddBn=6reNOY44CxaDgD254H7M3K2mb8bbd8jpmA@mail.gmail.com>
 <7v4ndz1o8q.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Jeff King <peff@peff.net>,
	=?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
To: Junio C Hamano <gitster@pobox.com>,
	David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 19 10:30:08 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Udz0K-0005sd-D2
	for gcvg-git-2@plane.gmane.org; Sun, 19 May 2013 10:30:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753889Ab3ESIaC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 May 2013 04:30:02 -0400
Received: from mail-ob0-f176.google.com ([209.85.214.176]:51047 "EHLO
	mail-ob0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753808Ab3ESI37 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 May 2013 04:29:59 -0400
Received: by mail-ob0-f176.google.com with SMTP id wp18so6076000obc.35
        for <git@vger.kernel.org>; Sun, 19 May 2013 01:29:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:message-id:in-reply-to:references
         :subject:mime-version:content-type:content-transfer-encoding;
        bh=Ky0feuEQ93b4AOKRGVMwFVzyFKB3nNsZtZ90B4mgcDc=;
        b=bbftGKB/7ZSH3atcAn5e3qUaWhmHK2mJ/fOCagn28wZzYtgRN+eu7/liADEoftMeWY
         BDoOEaJbAigNcVGTgVkc1bvLb5Wxjf7E7ZSfRtpiQmX6IPUsjhEg1kP0bsMcDcWZlwwm
         dIVxkpdPSMCp7O1oLb5FobF3Vl7bDVSHEZVEedCrL636vOJZv20S1B76n1yksZ8EqGtL
         T3GRShrN85fJPQmjc48+8Ncowlmr+Od4fyBfqgkejGfc4Djk56ZgLq78blsvANBSM3XS
         k4ddqpJEDea6tj9bQtQOFrv9z1iiMo2H5RJzNkTfgHobjt8LUeF9U3tEUbTQilgm5Lpq
         yoNw==
X-Received: by 10.182.240.136 with SMTP id wa8mr25100143obc.2.1368952198261;
        Sun, 19 May 2013 01:29:58 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id yx4sm15103649obb.11.2013.05.19.01.29.56
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sun, 19 May 2013 01:29:57 -0700 (PDT)
In-Reply-To: <7v4ndz1o8q.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224831>

Junio C Hamano wrote:
> David Aguilar <davvid@gmail.com> writes:
> 
> > On Fri, May 17, 2013 at 7:12 PM, Junio C Hamano <gitster@pobox.com> wrote:
> >
> >> So it is a right thing to do in that sense.
> >>
> >> I however am having this nagging feeling that I may be missing
> >> something subtle here.  Comments from others are very much welcome.
> >
> > Yes, this is correct.  Another way to skin this cat would be to do
> > search/replace in a Makefile to burn in the PYTHON_PATH similar to how
> > we do for the .sh scripts and other .py files in the main Makefile.
> > The remote helpers are in contrib/ so they do not go through the main
> > Makefile, which is the root cause.
> >
> > Longer-term, it would be good to treat these uniformly, but this is no
> > worse for now.
> 
> Ahh, so my "nagging feeling" was that remote-helpers could in theory
> be updated to follow the PYTHON_PATH like the rest of the system and
> matching these two in that direction is the better longer-term fix?

Indeed, and I already have patches for that. FTR, the Makefile does loop
through the main Makefile, which is what made implementing this so easy.

> I somehow thought that there were valid reasons that we could not do
> so for some technical reason (e.g. the instalation of python used to
> run hg and/or bzr via these remote helpers and the installation of
> python we use may need to be different?).  As long as the right
> longer-term direction is not "we cannot fundamentally unify them",
> then I am very happy.

I didn't think of that, and it might actually be a problem: I don't think
Mercurial works with python 3, and Bazaar probably never will.

But I don't think the current situation of always using 'python' helps either
way.

Cheers.

-- 
Felipe Contreras
