From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH] pathspec: rename per-item field has_wildcard to use_wildcard
Date: Thu, 7 Apr 2011 19:51:34 +0700
Message-ID: <BANLkTi=sjhWdav6QLguUnr6HE3Roc0NM4Q@mail.gmail.com>
References: <7vr59gl581.fsf@alter.siamese.dyndns.org> <BANLkTikJ3=H_OgcNueMjnwwQ2W-2kamf=w@mail.gmail.com>
 <7vfwpvjobl.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Michael J Gruber <git@drmicha.warpmail.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 07 14:54:53 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q7ojc-0002OU-7w
	for gcvg-git-2@lo.gmane.org; Thu, 07 Apr 2011 14:54:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751948Ab1DGMyr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 7 Apr 2011 08:54:47 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:62324 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751848Ab1DGMyq convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 7 Apr 2011 08:54:46 -0400
Received: by bwz15 with SMTP id 15so1970990bwz.19
        for <git@vger.kernel.org>; Thu, 07 Apr 2011 05:54:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=if4YR60BXk2jjdpq8YVscebGvR2JC9xvhgS9u/np4A8=;
        b=Y2b/g9yjX88FeF66oHk6oVsdTfKOyeMj8QJWDXbvxXSlNiXvEPxW8jxFxj8kWKnZf3
         7mqv2TN0v26FIgdMxVFlQNT+sCPEP99IQ7NsEcPXP5B/Wa1sa61bTCg85p1kjLLNWcMm
         IukwMCoKvUyRgh7yqGk03wXCrrh/nfhs+rRDI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=Q652dbFoyIbYQgnT3dxMGgEVSOzYQzugjFGVws80/kKl67gqmlMt9S7E69eNXFc/BS
         XsnN32JBvR3BbhNBxjEw8JzvivMBa6xqoiVxguA7N6qSax3jm+e1EG/dzh2aZswbdxoc
         hS+UC4JEeLdneFhn9V205u1E5cF2bb2Yl770M=
Received: by 10.204.81.224 with SMTP id y32mr714703bkk.152.1302180724124; Thu,
 07 Apr 2011 05:52:04 -0700 (PDT)
Received: by 10.204.37.195 with HTTP; Thu, 7 Apr 2011 05:51:34 -0700 (PDT)
In-Reply-To: <7vfwpvjobl.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171055>

On Thu, Apr 7, 2011 at 12:13 AM, Junio C Hamano <gitster@pobox.com> wro=
te:
> The extensible syntax I have in mind (we only parse in get_pathspec()=
 in
> such a tentative version but anything other than the :/ will error ou=
t) is
> to use:
>
> =C2=A0(1) Colon, a run of selected non-alpha (i.e. magic signature), =
an
> =C2=A0 =C2=A0 optional colon to terminate the magic signature, follow=
ed by the
> =C2=A0 =C2=A0 path, e.g.
>
> =C2=A0 =C2=A0 - ":/hello.c" is a path from the top.
>
> =C2=A0 =C2=A0 - ":!/hello.c" is path from the top but no globbing.
>
> =C2=A0 =C2=A0 - ":/!hello.c" is the same as above.
>
> =C2=A0 =C2=A0 - ":/::hello.c" is ":hello.c" from the top, the second =
colon
> =C2=A0 =C2=A0 =C2=A0 terminates the magic signature and allows the fu=
nny file with a
> =C2=A0 =C2=A0 =C2=A0 leading colon to be named.
>
> =C2=A0 =C2=A0 - "::hello.c" does not have any magic, is the same as "=
hello.c".

What about ":hello.c", same as "hello.c"? I think we need to reserve
some more characters for future extension. The selected set of magic
in your patch misses my favourite negate magic :)

By the way, I think we should use a better term than "magic". Pathspec =
modifier?

> =C2=A0(2) Colon, open parenthesis, a comma separated list of words to=
 name
> =C2=A0 =C2=A0 magic, close parenthesis, followed by the path, e.g. th=
ese are the
> =C2=A0 =C2=A0 long-hand counterparts to the examples in (1)
>
> =C2=A0 =C2=A0 - ":(top)hello.c"
> =C2=A0 =C2=A0 - ":(top,noglob)hello.c"
> =C2=A0 =C2=A0 - ":(noglob,top)hello.c"
> =C2=A0 =C2=A0 - ":(noglob,top):hello.c"
> =C2=A0 =C2=A0 - ":()hello.c"
>

Can we mix short and long magic? It seems impossible in your patch. I
don't know if that's the intention.

> At this point, I am not interested in building the repertoire of magi=
c
> yet, but would want to nail a syntax that is
>
> =C2=A0- concise in common cases (e.g. "from the top, not a funny name=
" is ':/'
> =C2=A0 followed by the name);
> =C2=A0- is extensible in the future; and
> =C2=A0- easy to parse and error out on magic we do not understand.
--=20
Duy
