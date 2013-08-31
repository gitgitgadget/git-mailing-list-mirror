From: =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: Fix the author initials in blame for non-ASCII names
Date: Sat, 31 Aug 2013 18:42:36 +0200
Message-ID: <CANQwDwdrmyMLZ299t4T-o6uGmfbHL_A83R37_zy0-jyFXEq1+A@mail.gmail.com>
References: <20130829163935.GA9689@ruderich.org> <1377851821-5412-1-git-send-email-avarab@gmail.com>
 <xmqqppsvyrzj.fsf@gitster.dls.corp.google.com> <xmqqhae7yrls.fsf@gitster.dls.corp.google.com>
 <74435A51-B404-4EC8-8CF8-6289F49E6DBD@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Simon Ruderich <simon@ruderich.org>
To: "Kyle J. McKay" <mackyle@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 31 18:43:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VFoGN-0003Fs-0h
	for gcvg-git-2@plane.gmane.org; Sat, 31 Aug 2013 18:43:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754854Ab3HaQm6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 31 Aug 2013 12:42:58 -0400
Received: from mail-qe0-f42.google.com ([209.85.128.42]:55545 "EHLO
	mail-qe0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754764Ab3HaQm5 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 31 Aug 2013 12:42:57 -0400
Received: by mail-qe0-f42.google.com with SMTP id w7so1591218qeb.1
        for <git@vger.kernel.org>; Sat, 31 Aug 2013 09:42:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=k3ticqWCspUMi1Suoz39qRNpjEK3wGKsx2MjRns4jDs=;
        b=HJFveOf7IE014Ow5544VvZkaToFBbGVs8HNaYgRtVHv9f8wGfMoVrJJ76gyXc4Dnpm
         d+FRao5JeviUSFpv3VK+UfkarHCpUC7pJcIC6uDqjIGtWb0QBPKD6i8GSmYdI70A0LGf
         4T065OaI6lTAs543TWaQOuT+a2EQkgTVLT7+4cTGgVS7X2n8njmLIHKrCMNap6bjmRfs
         6eCIEBy9G+bZukJWPC5WyilBx2hw4xTn68FHCbyZcLe04XMrcsAwLFlyInvFwOmQlWKp
         I+UZYy8vKG51qG66XSaqhf2MnQdtZn+4i7H18q6UMCnCnIPaqRloW8tRJLNQEcE7nnyz
         J8eA==
X-Received: by 10.49.50.232 with SMTP id f8mr18363092qeo.63.1377967376055;
 Sat, 31 Aug 2013 09:42:56 -0700 (PDT)
Received: by 10.49.83.134 with HTTP; Sat, 31 Aug 2013 09:42:36 -0700 (PDT)
In-Reply-To: <74435A51-B404-4EC8-8CF8-6289F49E6DBD@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233522>

On Fri, Aug 30, 2013 at 11:39 PM, Kyle J. McKay <mackyle@gmail.com> wro=
te:
> On Aug 30, 2013, at 11:13, Junio C Hamano wrote:
>> Junio C Hamano <gitster@pobox.com> writes:
>>> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

>>>> +       binmode $fh, ':utf8';

> What happens if the author name is written in ISO-8859-1 instead of U=
TF-8 in
> the actual commit object itself?
>
> I'm pretty sure I've seen this where older commits have a ISO-8859-1 =
author
> name and then newer commits have a UTF-8 version of the same author's=
 name.
>
> In fact, in the git repository itself, look at commit 0cb3f80d (UTF-8=
) and
> commit 7eb93c89 (ISO-8859-1) to see this in action.

Well, then you have a problem, though it is only with old history (befo=
re
introduction of "encoding" header in commit object).

Better and more complete solution would be to use to_utf8() function
instead of 'utf8' layer, which when finding invalid UTF-8 sequence uses
$fallback_encoding (by default "latin1", i.e. ISO-8859-1) instead.


In my TODO list is creating PerlIO layer ':utf8-with-fallback' which wo=
uld
replace all those to_utf8() calls...

--=20
Jakub Narebski
