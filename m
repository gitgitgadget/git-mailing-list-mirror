From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH/RFC] fmt-merge-msg: add a blank line after people info
Date: Fri, 11 May 2012 16:20:05 -0700
Message-ID: <CA+55aFyNqncpHydQJYjLu5d2y+gGLVQVV8zk=2ckZ-LLgRRNWA@mail.gmail.com>
References: <7vvcmj68iz.fsf@alter.siamese.dyndns.org> <CA+55aFzQ3+EFBVyE9PWOyH0XEC_oW+kUaBTYfixmi2wgMmiZvw@mail.gmail.com>
 <7vipii27ka.fsf@alter.siamese.dyndns.org> <CA+55aFw-sS_p7JXNXbSbpiwh9_bZhSrTtC3is4NtLa_n9Hzk5A@mail.gmail.com>
 <7vmx7uzq8h.fsf_-_@alter.siamese.dyndns.org> <20120312071121.GA17269@burratino>
 <7vipi9mfhx.fsf@alter.siamese.dyndns.org> <20120511103122.GA19573@burratino> <7vipg2jpzp.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat May 12 01:20:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SSz8T-0002qk-Cq
	for gcvg-git-2@plane.gmane.org; Sat, 12 May 2012 01:20:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755653Ab2EKXU2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 May 2012 19:20:28 -0400
Received: from mail-wg0-f44.google.com ([74.125.82.44]:55492 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752911Ab2EKXU1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 May 2012 19:20:27 -0400
Received: by wgbdr13 with SMTP id dr13so2925105wgb.1
        for <git@vger.kernel.org>; Fri, 11 May 2012 16:20:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type;
        bh=mFrF8hzAigCBFB2Cb6S5XYivf2HQNR38vvMGahLpp+k=;
        b=C56Fb+3e/hs+FEiHDjM3INlo55aOMqdLsHmsuGVuk4vewBfJTdmAOux8gvkC0NFNCZ
         bWkPTIi8sm8A+r76dMAVlcbVFExaSXgLzIkewd9yGuz3Jp62JT0PLXMGX7oAzk8S4jYA
         T71pz9n25HXxnVd+q9qvxbkk5M5j3zFd2ExFMCSN0uU9fjW8rKMgf30LDDCvXBte3guq
         txiwunV94PIUuVPdnfqV/kqfztThHdjQOlqsRzM0+j8uUHgIKwVB/FtvL6b39drZLCEH
         /afxonhjqC2o4KCxHrn5nhCKmfKOTfzpzVqf6bHi42jel3L46CPbEKJ1GwQ1QjHBj55W
         qvuQ==
Received: by 10.216.208.151 with SMTP id q23mr4881weo.20.1336778425578; Fri,
 11 May 2012 16:20:25 -0700 (PDT)
Received: by 10.216.188.149 with HTTP; Fri, 11 May 2012 16:20:05 -0700 (PDT)
In-Reply-To: <7vipg2jpzp.fsf@alter.siamese.dyndns.org>
X-Google-Sender-Auth: F6BmFt4FzVogQwO1xiEeMXodeJQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197706>

On Fri, May 11, 2012 at 3:46 PM, Junio C Hamano <gitster@pobox.com> wrote:
>
> But I do not know if it is an improvement from the current output before
> your patch, or if it is just wasting vertical space.

So I tend to edit out the "By Xyzzy" and "via So-and-so" lines,
although I do find them useful for actually writing the message.

However, if I were to keep them, I think I'd prefer the extra line
that Jonathan added.

What I *would* like, though, is that the "via So-and-so" shows up on
the same line as the "By Xyzzy", probably together with appropriate
word-wrapping (using strbuf_add_wrapped_text()?)

Btw, the counting of commits is broken for the merge people. Do this
in the kernel tree, just to see an example of the breakage:

    git checkout -b test-merges 59068e369b6a
    git merge e9e7183fd267

and see the suggested people counts:

    By Mark Brown (2) and others
    via Takashi Iwai (3) and Liam Girdwood (1)

and those "via" numbers make very little sense.

So the "By" number makes sense (counting non-merges). But the "via"
numbers are just odd. Seven of the commits were committed by Mark
Brown, but he's not mentioned in "via". Presumably because he's
already mentioned in the "By" line. But Mark was actually *more* of a
"via" person than Liam was, although Takashi is perhaps the most
important one because he's the "latest" one things flowed through.

I dunno. But it looks odd, and the above is not the only example of
"those counts don't make sense".

Anyway, I think the "via" line is odd the way it is. Lower-case "via"
implies that it's a continuation of the "By" sentence, but then it's
given a line of its own. Hmm?

                   Linus


                       Linus
