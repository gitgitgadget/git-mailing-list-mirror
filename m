From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2] wt-status: Show ignored files in untracked dirs
Date: Sat, 29 Dec 2012 02:22:49 -0500
Message-ID: <20121229072249.GB15408@sigill.intra.peff.net>
References: <1356516985-31068-1-git-send-email-apelisse@gmail.com>
 <1356528674-2730-1-git-send-email-apelisse@gmail.com>
 <7vip7omd8c.fsf@alter.siamese.dyndns.org>
 <20121227034859.GA20817@sigill.intra.peff.net>
 <7va9t0m69o.fsf@alter.siamese.dyndns.org>
 <CALWbr2wFg_9oDoZ_BUQwAzVV+UJSqBQRrMYmt6fv=fo02RL7Zg@mail.gmail.com>
 <20121227161920.GA28162@sigill.intra.peff.net>
 <CALWbr2xmtvchR4G37-FzzgScKe4p4RjLc7=Pg8d4K6SWO7tGAQ@mail.gmail.com>
 <CALWbr2yNR=K3MqBVe=sfSxPaJ+-A8utHBqoiHPHPLxr_9e9SVQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>
To: Antoine Pelisse <apelisse@gmail.com>
X-From: git-owner@vger.kernel.org Sat Dec 29 08:23:12 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ToqlD-0001cz-Ma
	for gcvg-git-2@plane.gmane.org; Sat, 29 Dec 2012 08:23:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752035Ab2L2HWy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 Dec 2012 02:22:54 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:38573 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751930Ab2L2HWw (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Dec 2012 02:22:52 -0500
Received: (qmail 27533 invoked by uid 107); 29 Dec 2012 07:24:01 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 29 Dec 2012 02:24:01 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 29 Dec 2012 02:22:49 -0500
Content-Disposition: inline
In-Reply-To: <CALWbr2yNR=K3MqBVe=sfSxPaJ+-A8utHBqoiHPHPLxr_9e9SVQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212296>

On Fri, Dec 28, 2012 at 03:05:30PM +0100, Antoine Pelisse wrote:

> Using the example from Michael's mail, I end up having this:
> $ git status --porcelain --ignored
> ?? .gitignore
> ?? x
> ?? y/
> !! x.ignore-me
> !! y/
> 
> y/ is referred as untracked, because it contains untracked files, and
> then as ignored because it
> contains ignored files.
> 
> Showing it twice doesn't feel right though, so I guess we should only
> show "?? y/" with untracked=normal,
> and "!! y/foo.ignore-me" when using untracked=all
> 
> What do you think ?

Good catch. I agree that showing just "?? y/" in the untracked=normal
case makes sense. It makes the definition of "!!" to mean "all untracked
files in this path are ignored". IOW, showing "??" means there are one
or more untracked, unignored files. There may _also_ be ignored files,
but we do not say (nor we even necessarily need to bother checking).

In retrospect, I think it might have made more sense to use the second
character of an untracked line to represent "ignored". That is, the
output:

  ?? .gitignore
  ?? x
  ?! y/
  !! x.ignore-me

would make sense to me. But that would be a backwards-incompatible
change at this point, and I don't think it's worth it.

-Peff
