From: Kevin Cernekee <cernekee@gmail.com>
Subject: Re: [PATCH v4 2/2] gitweb: introduce localtime feature
Date: Sat, 19 Mar 2011 12:49:07 -0700
Message-ID: <AANLkTimssscn+STEPyM7NbXF5ddFApPBsgXfqz-9SSNs@mail.gmail.com>
References: <ab54ba2199cc7487e383a31e3aa65885@localhost>
	<dab08d0ff27b0f571a17ed4f1ab0f39b@localhost>
	<7v39mjro38.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Mar 19 20:49:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q129C-0000nl-Ll
	for gcvg-git-2@lo.gmane.org; Sat, 19 Mar 2011 20:49:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757331Ab1CSTtJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 19 Mar 2011 15:49:09 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:39274 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757225Ab1CSTtI convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 19 Mar 2011 15:49:08 -0400
Received: by fxm17 with SMTP id 17so4566502fxm.19
        for <git@vger.kernel.org>; Sat, 19 Mar 2011 12:49:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=hDOtHVGEQsvF+LBVO7b5NYJdMsZI3xltv2aHbqnTT7s=;
        b=k0jDUj9L3TpabT6fqGSU6RNWi4tWiKtsxFDcUeX8MfKJUmR7/L7b/k2/J0F/vl2j4v
         Sn3C08TFpemWh/0AzoElKElYD6JpljDgagmSP4A/eYTU39UJf5hW/vc11w8Li3iVZowh
         VJ4CXeODBjR63BawGBkY0Y6lB/JjHbrng2HGo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=mslVjYQ/tjYL5GzLBtzUUNRY1fRQpyu3gUDIxjzsnTjiJ2DQxpfnkpxC9EEZFA0HS+
         eyOhwzVHAri24OyRs2d9Tjf5mW60UVWiSFSvHNYl63lERZGEZKLT7Aje/k2PGECd7iKY
         /do4Iex2p2uJbfo4IEshgljZPCrjUBR7/g5d8=
Received: by 10.223.102.129 with SMTP id g1mr2955872fao.3.1300564147145; Sat,
 19 Mar 2011 12:49:07 -0700 (PDT)
Received: by 10.223.61.83 with HTTP; Sat, 19 Mar 2011 12:49:07 -0700 (PDT)
In-Reply-To: <7v39mjro38.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169459>

On Sat, Mar 19, 2011 at 10:56 AM, Junio C Hamano <gitster@pobox.com> wr=
ote:
> Looks like we used to only paint HH:MM part but...
> ... we now paint the whole line, which I personally think is a friend=
ly
> move for color challenged people (me included---a larger span of text
> painted in different colors tends to help you still notice it better =
using
> value/brightness difference, even if your hue perception is weaker th=
an
> other people). But it is a change from the old behaviour and might be
> worth stating in the log message.

=46or the $feature{'localtime'} disabled case, the coloring is the same=
 as before.

I will paint the whole line in the next spin, and mention it in the
commit message.

>
>> - =C2=A0 =C2=A0 return $localtime;
>> + =C2=A0 =C2=A0 if ($use_localtime) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 $timestamp .=3D $alt_tim=
e;
>> + =C2=A0 =C2=A0 }
>
> You kept -localtime nobody uses?

> While I don't agree with Jakub about the presense / absence of "[]" a=
round
> it (that is not a part of "timestamp", but is how the caller wants to
> prepare the space to plug a timestamp string in), I do agree that the
> second parameter "use-localtime" looks funny, not because it is an un=
named
> parameter (which I personally think is fine) but because it isn't abo=
ut
> the localness of the displayed time anymore. =C2=A0Your 'localtime' f=
eature
> alone controls in which timezone the timestamp is shown, and this onl=
y
> controls the use of 'atnight' highlighting. The parameter needs to be
> renamed, and perhaps you may clarify it further by making it a keywor=
d
> argument as Jakub suggests.

$use_localtime indicates whether or not to add the " (hh:mm -zzzz)" at
the end.  This also enables the atnight coloring.

This argument name was suggested in an earlier post and I guess I took
it a little too literally...

Do you think it would be a good idea to take two separate options:
-atnight for the variable coloring, and -alt_time (or some other name)
to show " (hh:mm -zzzz)" after the RFC 2822 string?

Or maybe take one option, named something like "-commitpage", to
indicate that it is a format specific to that view?  If it is not
specified, the caller gets back an uncolored RFC 2822 date.

Also, is there a cleaner way of writing this?

sub timestamp_html {
    my %date =3D %{$_[0]};
    shift;
    my %opts =3D @_;

Or should I pass in the options as a hash reference, more like $cgi->a(=
):

sub timestamp_html {
    my %date =3D %{$_[0]};
    my %opts =3D %{$_[1]};

Thanks.
