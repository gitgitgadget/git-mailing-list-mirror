From: =?UTF-8?B?SmFrdWIgTmFyxJlic2tp?= <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: Harden UTF-8 handling in generated links
Date: Wed, 04 Jun 2014 20:47:54 +0200
Message-ID: <538F69DA.9010201@gmail.com>
References: <20140514184145.GA25699@localhost.localdomain> <xmqqd2fghvlf.fsf@gitster.dls.corp.google.com> <CANQwDwdh1qQkYi9sB=22wbNnb+g5qv5prCzj2aWhHBbTZhVhdg@mail.gmail.com> <20140515050820.GA30785@localhost.localdomain> <alpine.DEB.2.00.1405150957520.10221@ds9.cixit.se> <20140515184808.GA7964@localhost.localdomain> <CANQwDwe+GJ+yAYWdVfMaHq97zGXBoepCfUdLiaQD9LFoz3SiOA@mail.gmail.com> <53849FB2.7000701@gmail.com> <20140604154128.GA28549@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Peter Krefting <peter@softwolves.pp.se>,
	Junio C Hamano <gitster@pobox.com>
To: Michael Wagner <mail@mwagner.org>
X-From: git-owner@vger.kernel.org Wed Jun 04 20:48:23 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WsGES-0000iO-UW
	for gcvg-git-2@plane.gmane.org; Wed, 04 Jun 2014 20:48:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751651AbaFDSsG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 4 Jun 2014 14:48:06 -0400
Received: from mail-we0-f171.google.com ([74.125.82.171]:40135 "EHLO
	mail-we0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751209AbaFDSsE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Jun 2014 14:48:04 -0400
Received: by mail-we0-f171.google.com with SMTP id w62so9105192wes.30
        for <git@vger.kernel.org>; Wed, 04 Jun 2014 11:48:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=kiNhKWzw5hcYahT8LEYZ/XWNyj4yRCrxGoja59/wNtk=;
        b=K4POsRAZSoq9HDU9tsHACLO1tEJhsK6WTpXcT4uVqYzWrPz75oshBC3VkISMKL/j1N
         XU/ZAmZzfiEFHrI1WT/9S3UQCHnbYE8+ePRSyiswIRcE6p9XKGHffyXRNOyDqsyeK/iB
         qTqjTuDl+C467GLif1GMibdJpQ/Ia++oBDMIrhwASuKaoyaliMydZuIGhd73nudjijje
         nrcCCFcZSZ2SPPLRhGi8XXUcdWbPdVjRyzJL4e0Z198foGnJKsAwaLij/0Dbpmyx8l4V
         oGM6WdjGNEPD5mKaQcZV4+v0dpQJASH39iHELIu/H2cACfTIeR+hYN/gQMsyOP7vbOZQ
         R0RA==
X-Received: by 10.15.35.137 with SMTP id g9mr3205406eev.73.1401907683545;
        Wed, 04 Jun 2014 11:48:03 -0700 (PDT)
Received: from [192.168.130.241] ([158.75.2.130])
        by mx.google.com with ESMTPSA id l48sm7832721eey.15.2014.06.04.11.48.01
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 04 Jun 2014 11:48:02 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:24.0) Gecko/20100101 Thunderbird/24.5.0
In-Reply-To: <20140604154128.GA28549@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250758>

Michael Wagner wrote:
> On Tue, May 27, 2014 at 04:22:42PM +0200, Jakub Nar=C4=99bski wrote:

>> Subject: [PATCH] gitweb: Harden UTF-8 handling in generated links
>>
>> esc_html() ensures that its input is properly UTF-8 encoded and mark=
ed
>> as UTF-8 with to_utf8().  Make esc_param() (used for query parameter=
s
>> in generated URLs), esc_path_info() (for escaping path_info
>> components) and esc_url() use it too.
>>
>> This hardens gitweb against errors in UTF-8 handling; because
>> to_utf8() is idempotent it won't change correct output.
[...]
>>   sub esc_param {
>>   	my $str =3D shift;
>>   	return undef unless defined $str;
>> +
>> +	$str =3D to_utf8($str);
>>   	$str =3D~ s/([^A-Za-z0-9\-_.~()\/:@ ]+)/CGI::escape($1)/eg;
>>   	$str =3D~ s/ /\+/g;
>> +
>>   	return $str;
>>   }  =20
=20
> While trying to view a "blob_plain" of "G=C3=BCtekritierien.txt", a 4=
04 error
> occured. "git_get_hash_by_path" tries to resolve the hash with the wr=
ong
> filename (git ls-tree -z HEAD -- G=C3=83=C2=BCtekriterien.txt) and fa=
ils.
>=20
> The filename needs the correct encoding. Something like this is proba=
bly
> needed for all filenames and should be done at a prior stage:

True.

=46irst, I wonder why the tests I did for this situation didn't
show any errors even before the "harden href()" patch. What
is different in your config that you see those errors?

> ---
>   gitweb/gitweb.perl |    2 +-
>   1 files changed, 1 insertions(+), 1 deletions(-)
>=20
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index 77e1312..e4a50e7 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -4725,7 +4725,7 @@ sub git_print_tree_entry {
>                  }
>                  print " | " .
>                          $cgi->a({-href =3D> href(action=3D>"blob_pla=
in", hash_base=3D>$hash_base,
> -                                              file_name=3D>"$basedir=
$t->{'name'}")},
> +                                              file_name=3D>"$basedir=
" . to_utf8($t->{'name'}))},

Second, my "harder href()" patch does not work for this because
concatenation of non-UFT8 with UTF8 string screws up Perl
knowledge what is and isn't UTF8.  So to_utf8() after concat
doesn't help.


>                                  "raw");
>                  print "</td>\n";
>=20
