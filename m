From: =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
Subject: Re: [PATCH/RFC] Gitweb: Convert UTF-8 encoded file names
Date: Thu, 15 May 2014 21:28:02 +0200
Message-ID: <CANQwDwe+GJ+yAYWdVfMaHq97zGXBoepCfUdLiaQD9LFoz3SiOA@mail.gmail.com>
References: <20140514184145.GA25699@localhost.localdomain> <xmqqd2fghvlf.fsf@gitster.dls.corp.google.com>
 <CANQwDwdh1qQkYi9sB=22wbNnb+g5qv5prCzj2aWhHBbTZhVhdg@mail.gmail.com>
 <20140515050820.GA30785@localhost.localdomain> <alpine.DEB.2.00.1405150957520.10221@ds9.cixit.se>
 <20140515184808.GA7964@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Peter Krefting <peter@softwolves.pp.se>,
	Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>
To: Michael Wagner <accounts@mwagner.org>
X-From: git-owner@vger.kernel.org Thu May 15 21:28:50 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wl1Kj-0006gQ-HI
	for gcvg-git-2@plane.gmane.org; Thu, 15 May 2014 21:28:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755786AbaEOT2p convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 15 May 2014 15:28:45 -0400
Received: from mail-ob0-f173.google.com ([209.85.214.173]:42700 "EHLO
	mail-ob0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752333AbaEOT2n convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 15 May 2014 15:28:43 -0400
Received: by mail-ob0-f173.google.com with SMTP id wm4so1800461obc.32
        for <git@vger.kernel.org>; Thu, 15 May 2014 12:28:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=NjdL0l+vOB/IDWvsn+VMtN+L+AFt8tjJq0uhfyPoJNw=;
        b=bV/08N0C+DeNUhNX2Vw+xOGGCCu52SnXmCXnYDgL0WRXab+KI2YJ9POrfZu4MwjRG4
         yT2W44CkpRekK6vXaZ6oyUJvkJIjyXoB3wF7OQHjOP1bUCr8+WvJJkrdkYZdHnYfF4Ig
         SXnYjuMDqwaCkKXkbWiibO6XFeVRQr29EdSleoV6aDbIdW7Lq4c72zvAK66iUjbMSpMm
         gnOo1aGuQLJRQPQx0czTKRk6OZrCyYG+UBBCbsIxJARZCnENZr75JFGPkyLVbRutTIJr
         GgAemlXfPlEvqRVXDOlJEyZsjKwtL8lzf7cnqJeeAY5VN4iskl1CLILC+jRRutgy4kPs
         TFfw==
X-Received: by 10.182.66.202 with SMTP id h10mr12318031obt.38.1400182123011;
 Thu, 15 May 2014 12:28:43 -0700 (PDT)
Received: by 10.76.132.4 with HTTP; Thu, 15 May 2014 12:28:02 -0700 (PDT)
In-Reply-To: <20140515184808.GA7964@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249190>

On Thu, May 15, 2014 at 8:48 PM, Michael Wagner <accounts@mwagner.org> =
wrote:
> On Thu, May 15, 2014 at 10:04:24AM +0100, Peter Krefting wrote:
>> Michael Wagner:
>>
>>>Decoding the UTF-8 encoded file name (again with an additional print
>>>statement):
>>>
>>>$ REQUEST_METHOD=3DGET QUERY_STRING=3D'p=3Dnotes.git;a=3Dblob_plain;=
f=3Dwork/G%C3%83%C2%BCtekriterien.txt;hb=3DHEAD' ./gitweb.cgi
>>>
>>>work/G=C3=BCtekriterien.txt
>>>Content-disposition: inline; filename=3D"work/G=C3=BCtekriterien.txt=
"
>>
>> You should fix the code path that created that URI, though, as it is=
 not
>> what you expected.
>>
>> %C3%83 decodes to U+00C3 Latin Capital Letter A With Tilde
>> %C2%BC decodes to U+00BC Vulgar Graction One Quarter
>>
>> The proper UTF-8 encoding for =C3=BC (U+00FC) is, as you can probabl=
y guess from
>> looking at which two characters the sequence above yielded, C3 BC, w=
hich in
>> a URI is represented as %C3%BC.
>>
>> Your QUERY_STRING should thus be
>>
>>   p=3Dnotes.git;a=3Dblob_plain;f=3Dwork/G%C3%BCtekriterien.txt;hb=3D=
HEAD
>>
>> which probably works as expected.
>>
>> What is happening is that whatever is generating the URI us UTF-8-en=
coding
>> the string twice (i.e., it generates a string with the proper C3 BC =
in it,
>> and then interprets it as iso-8859-1 data and runs that through a UT=
=46-8
>> encoder again, yielding the C3 83 C2 BC sequence you see above).
>
> The subroutine "git tree" generates the tree view. It stores the outp=
ut
> of "git ls-tree -z ..." in an array named "@entries". Printing the co=
ntent
> of this array yields the following result:
>
> 00644 blob 6419cd06a9461c38d4f94d9705d97eaaa887156a     520 G=C3=83=C2=
=BCtekriterien.txt
>
> This leads to the "doubled" encoding. Declaring the encoding in the c=
all
> to open yields the following result:
>
> 100644 blob 6419cd06a9461c38d4f94d9705d97eaaa887156a     520 G=C3=BCt=
ekriterien.txt

Good catch.

Writing test for this would not be easy, and require some HTML
parser (WWW::Mechanize, Web::Scraper, HTML::Query, pQuery,
=2E.. or low level HTML::TreeBuilder, or other low level parser).

> ---
>
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index a9f57d6..f1414e1 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -7138,7 +7138,7 @@ sub git_tree {
>         my @entries =3D ();
>         {
>                 local $/ =3D "\0";
> -               open my $fd, "-|", git_cmd(), "ls-tree", '-z',
> +               open my $fd, "-|encoding(UTF-8)", git_cmd(), "ls-tree=
", '-z',
>                         ($show_sizes ? '-l' : ()), @extra_options, $h=
ash
>                         or die_error(500, "Open git-ls-tree failed");

Or put

                   binmode $fd, ':utf8';

like in the rest of the code.

>                 @entries =3D map { chomp; $_ } <$fd>;
>

Even better solution would be to use

    use open IN =3D> ':encoding(utf-8)';

at the beginning of gitweb.perl, once and for all.

Unfortunately the output equivalent requires creating Perl
module for gitweb, to be able to use

    use open OUT =3D> ':encoding(utf-8-with-fallback)';

--=20
Jakub Narebski
