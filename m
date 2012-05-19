From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: git-completion with bash alias
Date: Sat, 19 May 2012 04:28:53 +0200
Message-ID: <CAMP44s3DzJFoXTbUKEKUKcSs1TRWGW+2Ze+zMA1ch2eVgtu9bA@mail.gmail.com>
References: <CACY+Hvqd6L7gWgDBvjPmLPsfA2o1CVKuqkDZ_j7XYf=WjuwvKQ@mail.gmail.com>
	<20120519004147.GE765@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Carsten Mattner <carstenmattner@googlemail.com>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat May 19 04:29:02 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SVZPg-0000dc-LG
	for gcvg-git-2@plane.gmane.org; Sat, 19 May 2012 04:29:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S968287Ab2ESC2z convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 18 May 2012 22:28:55 -0400
Received: from mail-wg0-f44.google.com ([74.125.82.44]:44894 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753692Ab2ESC2y convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 18 May 2012 22:28:54 -0400
Received: by wgbdr13 with SMTP id dr13so3275970wgb.1
        for <git@vger.kernel.org>; Fri, 18 May 2012 19:28:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=f50uCB7tWyWQjCr2qmN3Pz144K5GumJiwxLjt/2gX+o=;
        b=PHtXU7AKFcwA+8NN939q3xN4LWCgXdoW6rB94uBaPtLxoY0V4RFMARSbG/frXyZia7
         STxK+WGybpZisfDNyuQU5qblOcea48LkCM/Nvi1iLOUOvXlsi+AwJbzRCBCNS3JavwIL
         YyuHCo+7ih4CWlMsSrXkTzMMauZFJYHDDgoizqIifrV0ZAzYOz9kcimq0Hxv0r07h0h1
         lekHg7jBgqi8K7QtXGFCbCH8AdkOepH/EZp42rk5aDT6FbMwlnikDEfPpK4yLeQ4oLrP
         qvhojquKbdX7czBemwCTyKZOMWgD1penJjhOp2ATU8kxHDEzcJpqTfvIh6REXKyzsp9H
         JUCA==
Received: by 10.180.85.129 with SMTP id h1mr6808327wiz.2.1337394533479; Fri,
 18 May 2012 19:28:53 -0700 (PDT)
Received: by 10.216.124.197 with HTTP; Fri, 18 May 2012 19:28:53 -0700 (PDT)
In-Reply-To: <20120519004147.GE765@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198004>

On Sat, May 19, 2012 at 2:41 AM, Jeff King <peff@peff.net> wrote:
> On Fri, May 18, 2012 at 01:35:24PM +0200, Carsten Mattner wrote:
>
>> Completion works when used as "git checkout foo" but fails with
>> "bash: [: 1: unary operator expected" when trying to complete
>> via a single character shell alias like "alias g=3Dgit" as in
>> "g checkout foo".
>>
>> git version 1.7.10.2.548.g9de9681
>
> Hmm. Are you invoking the completion like:
>
> =C2=A0complete -F _git g

s/_git/__git_wrap_git/

> ? That used to work, but was broken by the recent 6b179ad (completion=
:
> add new __git_complete helper, 2012-05-14).
>
> The "new" way seems to be:
>
> =C2=A0__git_complete g _git
>
> but that function is explicitly labeled as "not public". It looks lik=
e
> there was a follow-on patch that was discussed to make a public versi=
on,
> but it got dropped.

Well, _git was probably not public either.

> I'm not sure if this regression is intentional, or if the "old" way e=
ven
> worked reliably (I seem to recall people running into issues with
> _get_comp_words_by_ref not being called properly sometimes, but I don=
't
> remember the details). So it's not clear to me if the right way forwa=
rd
> is fixing "complete -F _git" to work again, or if that way is just
> broken, and a public version of __git_complete is the right path.
>
> Felipe, can you comment?

The problem is with certain functions (e.g. _git_fetch), which are
broken not only for aliases: try 'git --git-dir=3D$PWD fetch <tab>'.

Should be easy to provide backward compatibility though.

I'll send a patch soon.

--=20
=46elipe Contreras
