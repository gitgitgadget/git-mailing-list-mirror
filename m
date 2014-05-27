From: =?UTF-8?B?SmFrdWIgTmFyxJlic2tp?= <jnareb@gmail.com>
Subject: [PATCH] gitweb: Harden UTF-8 handling in generated links
Date: Tue, 27 May 2014 16:22:42 +0200
Message-ID: <53849FB2.7000701@gmail.com>
References: <20140514184145.GA25699@localhost.localdomain> <xmqqd2fghvlf.fsf@gitster.dls.corp.google.com> <CANQwDwdh1qQkYi9sB=22wbNnb+g5qv5prCzj2aWhHBbTZhVhdg@mail.gmail.com> <20140515050820.GA30785@localhost.localdomain> <alpine.DEB.2.00.1405150957520.10221@ds9.cixit.se> <20140515184808.GA7964@localhost.localdomain> <CANQwDwe+GJ+yAYWdVfMaHq97zGXBoepCfUdLiaQD9LFoz3SiOA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Peter Krefting <peter@softwolves.pp.se>,
	Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>
To: Michael Wagner <accounts@mwagner.org>
X-From: git-owner@vger.kernel.org Tue May 27 16:23:01 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WpIHG-0005tU-Ub
	for gcvg-git-2@plane.gmane.org; Tue, 27 May 2014 16:22:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752834AbaE0OWv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 27 May 2014 10:22:51 -0400
Received: from mail-we0-f171.google.com ([74.125.82.171]:39583 "EHLO
	mail-we0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752831AbaE0OWu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 May 2014 10:22:50 -0400
Received: by mail-we0-f171.google.com with SMTP id w62so9721149wes.16
        for <git@vger.kernel.org>; Tue, 27 May 2014 07:22:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:newsgroups:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=Jf0xjhIor+f1jxzODFGF/nyUd/yVwD1NVkF+8tgvrp0=;
        b=rD00/bFjDS4eX8mOcKQ/Lvaj8s3xJTaQYrStWBd25xqZiuQUmVLo/2Y5hVx1Ps4fe+
         xH9ej28QSFpDv/hB3KFUQPw/nMm2JNRiQX8xFSn0kiOpeRTGGHkDdtLxJBV0v6I3S1x7
         0lS1v9T6Novohy5X+8+YuptAy+aBbUndPL9FlMwN66IDLy8BJw8dc0Xe9JxKFtFQoZ8M
         PvqqkSG8kceAZgXKrDCM093L2xfHg9R9OuOCWFkEFRbx34dbjOMPJpfRKN0JsfMCll+Y
         ZldJ0hc5HSr3420US47m3MZbxz3WwkS9cGy7U+36lGMZmxpvmBuz84tE5e6IowyasAOR
         6zVA==
X-Received: by 10.180.72.243 with SMTP id g19mr38764573wiv.44.1401200568963;
        Tue, 27 May 2014 07:22:48 -0700 (PDT)
Received: from [192.168.130.241] ([158.75.2.130])
        by mx.google.com with ESMTPSA id f6sm8719973wiy.19.2014.05.27.07.22.46
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 27 May 2014 07:22:47 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:24.0) Gecko/20100101 Thunderbird/24.5.0
Newsgroups: gmane.comp.version-control.git
In-Reply-To: <CANQwDwe+GJ+yAYWdVfMaHq97zGXBoepCfUdLiaQD9LFoz3SiOA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250171>

W dniu 2014-05-15 21:28, Jakub Nar=C4=99bski pisze:
> On Thu, May 15, 2014 at 8:48 PM, Michael Wagner <accounts@mwagner.org=
> wrote:
>> On Thu, May 15, 2014 at 10:04:24AM +0100, Peter Krefting wrote:
>>> Michael Wagner:

>> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
>> index a9f57d6..f1414e1 100755
>> --- a/gitweb/gitweb.perl
>> +++ b/gitweb/gitweb.perl
>> @@ -7138,7 +7138,7 @@ sub git_tree {
>>          my @entries =3D ();
>>          {
>>                  local $/ =3D "\0";
>> -               open my $fd, "-|", git_cmd(), "ls-tree", '-z',
>> +               open my $fd, "-|encoding(UTF-8)", git_cmd(), "ls-tre=
e", '-z',
>>                          ($show_sizes ? '-l' : ()), @extra_options, =
$hash
>>                          or die_error(500, "Open git-ls-tree failed"=
);
>=20
> Or put
>=20
>                     binmode $fd, ':utf8';
>=20
> like in the rest of the code.
>=20
>>                  @entries =3D map { chomp; $_ } <$fd>;
>>
>=20
> Even better solution would be to use
>=20
>      use open IN =3D> ':encoding(utf-8)';
>=20
> at the beginning of gitweb.perl, once and for all.

Or harden esc_param / esc_path_info the same way esc_html
is hardened against missing ':utf8' flag.

-- >8 --=20
Subject: [PATCH] gitweb: Harden UTF-8 handling in generated links

esc_html() ensures that its input is properly UTF-8 encoded and marked
as UTF-8 with to_utf8().  Make esc_param() (used for query parameters
in generated URLs), esc_path_info() (for escaping path_info
components) and esc_url() use it too.

This hardens gitweb against errors in UTF-8 handling; because
to_utf8() is idempotent it won't change correct output.

Reported-by: Michael Wagner <accounts@mwagner.org>
Signed-off-by: Jakub Nar=C4=99bski <jnareb@gmail.com>
---
 gitweb/gitweb.perl |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index a9f57d6..77e1312 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -1548,8 +1548,11 @@ sub to_utf8 {
 sub esc_param {
 	my $str =3D shift;
 	return undef unless defined $str;
+
+	$str =3D to_utf8($str);
 	$str =3D~ s/([^A-Za-z0-9\-_.~()\/:@ ]+)/CGI::escape($1)/eg;
 	$str =3D~ s/ /\+/g;
+
 	return $str;
 }
=20
@@ -1558,6 +1561,7 @@ sub esc_path_info {
 	my $str =3D shift;
 	return undef unless defined $str;
=20
+	$str =3D to_utf8($str);
 	# path_info doesn't treat '+' as space (specially), but '?' must be e=
scaped
 	$str =3D~ s/([^A-Za-z0-9\-_.~();\/;:@&=3D +]+)/CGI::escape($1)/eg;
=20
@@ -1568,8 +1572,11 @@ sub esc_path_info {
 sub esc_url {
 	my $str =3D shift;
 	return undef unless defined $str;
+
+	$str =3D to_utf8($str);
 	$str =3D~ s/([^A-Za-z0-9\-_.~();\/;?:@&=3D ]+)/CGI::escape($1)/eg;
 	$str =3D~ s/ /\+/g;
+
 	return $str;
 }
=20
--=20
1.7.1
