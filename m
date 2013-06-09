From: =?UTF-8?Q?Beno=C3=AEt_Person?= <benoit.person@ensimag.fr>
Subject: Re: [PATCH/RFC] git-remote-mediawiki: new tool to preview local
 changes without pushing
Date: Sun, 9 Jun 2013 14:18:58 +0200
Message-ID: <CAETqRCjO1Md1PFmFO46KQ6eaEHbHW+RA7+Fh8ku6s7UwfhrPvQ@mail.gmail.com>
References: <1370641831-9115-1-git-send-email-benoit.person@ensimag.fr>
	<20130609060807.GA8906@sigill.intra.peff.net>
	<vpq38srtun7.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	=?UTF-8?Q?C=C3=A9lestin_Matte?= <celestin.matte@ensimag.fr>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Sun Jun 09 14:19:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UleaN-0007x8-AS
	for gcvg-git-2@plane.gmane.org; Sun, 09 Jun 2013 14:19:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753811Ab3FIMS7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Jun 2013 08:18:59 -0400
Received: from mail-ie0-f173.google.com ([209.85.223.173]:49194 "EHLO
	mail-ie0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753370Ab3FIMS7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Jun 2013 08:18:59 -0400
Received: by mail-ie0-f173.google.com with SMTP id k5so7662863iea.4
        for <git@vger.kernel.org>; Sun, 09 Jun 2013 05:18:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=RUAtC6DGrgxZMeE4pdhJq9rpia6dX942zqHPe/MBZ+U=;
        b=dOORBJD+W4GskQvcjqsHCGB0bRJdDrxm9exFQCKpJhgoeOoKRlPrNqHlwU0qxnLkHC
         03dSgsOpkX8iQjOV9wLDh9KyFKCK8VnaWAxKXOJ7PoccDJSZvWMR1PZ2+u9hzmidEchR
         xwwib58SDuKVa0DGCwN6WzqKN8KLK4IiVPj2g0yXZuWI5ceSA2EIRmFbnqbZCMCZCkxz
         E5Ku41bAJBWE/rtQYJ5RGmzgziJ8toSvfBBuT9NJbVleJWntxf49plomsJhWb8Pw/bEP
         dIRz/+8PUF8uqhLiJ4B3GDQRCCwYnFwZTbtstK5dfZxVBFLAuPsiinp/eYnx5mcU0o+e
         N3kQ==
X-Received: by 10.50.107.6 with SMTP id gy6mr2208705igb.57.1370780338511; Sun,
 09 Jun 2013 05:18:58 -0700 (PDT)
Received: by 10.42.22.141 with HTTP; Sun, 9 Jun 2013 05:18:58 -0700 (PDT)
In-Reply-To: <vpq38srtun7.fsf@anie.imag.fr>
X-Google-Sender-Auth: Zxroz6O-f6Tp8fqL_9LbT-Pdjs4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226957>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:
> Same question here. I'd expect "git mw preview" in a mediawiki workflow
> to do what "pdflatex foo && evince foo.pdf" do in a latex workflow: see
> in rendered form what I've been doing.
>
> In a latex flow, if I want to see how my local changes merge with the
> remote ones, I do "git merge && pdflatex", and I'd do the same with "git
> mw".

In fact, I should not have used "merge" to describe how the two contents
(page template + new parsed content) are combined together. For
now, the code simply replaces the template page's text content (the one
retrieved from the remote) with the new one. It does not really care if
the remote has changes or not. (And, to be honest, I did not thought
about that issue ;) ).

But, like both of you said : in a typical workflow, the merging would be
left to the user so the current behavior is fine I think ?

>> I also wonder if it would be useful to be able to specify not only files
>> in the filesystem, but also arbitrary blobs. So in 4b above, you could
>> "git mw preview origin:page.mw" to see the rendered version of what
>> upstream has done.
> Next step could even be "git mw diff $from $to", using the wiki to
> render the diff. Not a priority, but could be funny.

I searched in the Mediawiki API if there was a way to diff from a stored
revision and raw text content but I've found nothing :/ . We could make
a little "hack" to do that by saving as a new revision the local content,
and use the "DeleteRevision"-thingy from Mediawiki [1] to hide this
useless revision but it would floods the remote DB and usually users
to not have the permission to use that tool. So, for now I would say
it's a no-go :/ .

[1] http://www.mediawiki.org/wiki/Manual:RevisionDelete

Benoit Person

> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
