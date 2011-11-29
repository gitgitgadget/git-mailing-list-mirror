From: =?UTF-8?Q?J=C3=BCrgen_Kreileder?= <jk@blackdown.de>
Subject: Re: [PATCH] gitweb: Call to_utf8() on input string in chop_and_escape_str()
Date: Tue, 29 Nov 2011 23:14:34 +0100
Message-ID: <CAKD0Uuw64bRryYpVbp0G7HNjZHgHUsnSMH3g3gWF-Jv9dWA04Q@mail.gmail.com>
References: <CAKD0Uuy8y7Dc6gfvYVe-FJ=Reiu0M3wOY4r4VVPtEYmahZcdwA@mail.gmail.com>
 <201111292250.04800.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 29 23:15:03 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RVVx7-0000BH-Fb
	for gcvg-git-2@lo.gmane.org; Tue, 29 Nov 2011 23:15:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756834Ab1K2WO5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 29 Nov 2011 17:14:57 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:60744 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751706Ab1K2WO4 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 29 Nov 2011 17:14:56 -0500
Received: by faaq16 with SMTP id q16so181672faa.19
        for <git@vger.kernel.org>; Tue, 29 Nov 2011 14:14:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackdown.de; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :content-type:content-transfer-encoding;
        bh=B7AeVHfK1ZqeB3d/xWD0xv7m2QNn6KPrQyoWl30C+1o=;
        b=DEVXqv8csZkethiozm9OHhRhtM8Prlhh1StvQhP0+3mgdE/54GC6Ky8pClqyWV0eoN
         B0DDGHsZt7rjnLaHA+NKPc1V1rXNeOlJxN8oo1T/TGE+alcI/2AC9q+O7118Yttnzpdj
         mzM/jaVlkdia0jQafCwCDe5GWi0MI78U1g3PI=
Received: by 10.180.24.65 with SMTP id s1mr49436018wif.59.1322604895245; Tue,
 29 Nov 2011 14:14:55 -0800 (PST)
Received: by 10.180.87.37 with HTTP; Tue, 29 Nov 2011 14:14:34 -0800 (PST)
In-Reply-To: <201111292250.04800.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186094>

On Tue, Nov 29, 2011 at 22:50, Jakub Narebski <jnareb@gmail.com> wrote:
> J=C3=BCrgen Kreileder wrote:
>
>> a) To fix the comparison with the chopped string
>> b) To give the title attribute correct encoding
>>
>> Signed-off-by: J=C3=BCrgen Kreileder <jk@blackdown.de>
>> ---
>> =C2=A0gitweb/gitweb.perl | =C2=A0 =C2=A04 ++--
>> =C2=A01 files changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
>> index 4f0c3bd..4237ea6 100755
>> --- a/gitweb/gitweb.perl
>> +++ b/gitweb/gitweb.perl
>> @@ -1695,11 +1695,11 @@ sub chop_and_escape_str {
>> =C2=A0 =C2=A0 =C2=A0 my ($str) =3D @_;
>
> Why not simply
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0my $str =3D to_utf8(shift);
>

Good question.  Because I thought it broke something when I tested it.
I can't reproduce that now, though.  Might have been something unrelate=
d.
So:

-- >8 --
Subject: [PATCH] gitweb: Call to_utf8() on input string in
 chop_and_escape_str()

a) To fix the comparison with the chopped string
b) To give the title attribute correct encoding

Signed-off-by: J=C3=BCrgen Kreileder <jk@blackdown.de>
---
 gitweb/gitweb.perl |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index bfada0e..036ae46 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -1699,6 +1699,7 @@ sub chop_and_escape_str {
 	my ($str) =3D @_;

 	my $chopped =3D chop_str(@_);
+	$str =3D to_utf8($str);
 	if ($chopped eq $str) {
 		return esc_html($chopped);
 	} else {
--=20
1.7.5.4
