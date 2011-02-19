From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH v2 2/3] gitweb/gitweb.perl: remove use of qw(...) as parentheses
Date: Sat, 19 Feb 2011 17:06:20 +0100
Message-ID: <AANLkTi==3c4ZLckUPE6NUt-sqWBsywQh3Gu+4B5vOBpj@mail.gmail.com>
References: <1298124654-12051-1-git-send-email-avarab@gmail.com>
	<1298129262-10468-3-git-send-email-avarab@gmail.com>
	<201102191654.41601.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 19 17:06:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PqpKF-000159-D1
	for gcvg-git-2@lo.gmane.org; Sat, 19 Feb 2011 17:06:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752866Ab1BSQGX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 19 Feb 2011 11:06:23 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:36763 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751013Ab1BSQGW convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 19 Feb 2011 11:06:22 -0500
Received: by fxm17 with SMTP id 17so194280fxm.19
        for <git@vger.kernel.org>; Sat, 19 Feb 2011 08:06:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=eFrWRmBLGFKSal3H7zkf/Ff0I+AWv99BGfOnmlV1k60=;
        b=dNJr12G5/iePmyt1nTEDHqat3JcFi/bvJ1ufFiGjeJtJ4WR/E8KR91U1FBfg4/keSt
         EmSx7tf9AQTViuOKwGXwXJio7RZ0jxmB62fRO6GsVJ1gCYmB5mNLNq6Rs2XeJ/F/QqJV
         EC1GGY66HQjqmL0IRom0B15SHZbtzQNv5kVMI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=hnJeHTHj2mB2ob6BkA2owQAXhJ7dvI/EzK/IC8hNK8uxemyVWQMbCQB2TUw9NVZdAn
         m7cJLXH0/CMfC8Mdl2X1yc2ywapgQenK89ZnraO5XfdTB19lRnAdeXVYJqICu1vvtH0Z
         uc9ijDiKXhETtbS6AOjs/Xi3HO2uInpImQVtE=
Received: by 10.223.113.73 with SMTP id z9mr2637664fap.41.1298131580950; Sat,
 19 Feb 2011 08:06:20 -0800 (PST)
Received: by 10.223.2.201 with HTTP; Sat, 19 Feb 2011 08:06:20 -0800 (PST)
In-Reply-To: <201102191654.41601.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167297>

On Sat, Feb 19, 2011 at 16:54, Jakub Narebski <jnareb@gmail.com> wrote:
> On Sat, 19 Feb 2011, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>
>> Using the qw(...) construct as implicit parentheses was deprecated i=
n
>> perl 5.13.5. Change the relevant code in gitweb to not use the
>> deprecated construct. The offending code was introduced in 3562198b =
by
>> Jakub Narebski.
>
> It is strange that Perl introduces such backwards incompatibile chang=
e
> (well, actually will introduce, as 5.13.x is development branch leadi=
ng
> to future Perl version 5.14).
>
> qw{} is described in perlop(1) as "word list" operator, so one would
> suppose that it generates a list.

It does, but it wasn't supposed to generate parens for you.

>> The issue is that perl will now warn about this:
>>
>> =C2=A0 =C2=A0 $ perl -wE 'for my $i qw(a b) { say $i }'
>> =C2=A0 =C2=A0 Use of qw(...) as parentheses is deprecated at -e line=
 1.
>> =C2=A0 =C2=A0 a
>> =C2=A0 =C2=A0 b
>
> Hmmm... does it affect only foreach loop, or dows it affect also othe=
r
> places, like
>
> =C2=A0 =C2=A0 =C2=A0use POSIX qw( setlocale localeconv )
> =C2=A0 =C2=A0 =C2=A0@EXPORT =3D qw( foo bar baz );
>
> Both of those forms are used by gitweb:
>
> =C2=A0 =C2=A0 =C2=A0use CGI qw(:standard :escapeHTML -nosticky);
>
> =C2=A0 =C2=A0 =C2=A0map { $_ =3D> 'sh' =C2=A0} qw(bash zsh ksh)
> =C2=A0 =C2=A0 =C2=A0my @navs =3D qw(summary shortlog log commit commi=
tdiff tree);

No. This is being deprecated because qw(foo bar) is supposed to mean
"foo, "bar", not ("foo", "bar"). I.e. this doesn't compile:

    for my $i "a", "b", "c" { }

So neither should this:

    for my $i qw(a b c) {}

But these both work:

    for my $i ("a", "b", "c") { }
    for my $i (qw(a b c)) {}

All of your other examples could have used a list without implicit
parens. So this is the only change that's needed in gitweb.
