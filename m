From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCHv7 5/9] gitweb: (gr)avatar support
Date: Sun, 28 Jun 2009 01:20:02 +0200
Message-ID: <200906280120.02475.jnareb@gmail.com>
References: <1246104305-15191-1-git-send-email-giuseppe.bilotta@gmail.com> <200906272145.46506.jnareb@gmail.com> <cb7bb73a0906271545h8033f63jf0198a2f9e187428@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 28 01:20:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MKhC1-0001v6-FH
	for gcvg-git-2@gmane.org; Sun, 28 Jun 2009 01:20:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752081AbZF0XUB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 27 Jun 2009 19:20:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752678AbZF0XUA
	(ORCPT <rfc822;git-outgoing>); Sat, 27 Jun 2009 19:20:00 -0400
Received: from fg-out-1718.google.com ([72.14.220.157]:58143 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751018AbZF0XT7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Jun 2009 19:19:59 -0400
Received: by fg-out-1718.google.com with SMTP id e12so243276fga.17
        for <git@vger.kernel.org>; Sat, 27 Jun 2009 16:20:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=iCko+BFQBhN3HfLFzZBtOp9XqV6PAjW0YA8DnXXd224=;
        b=iJz5zP6Udgq0FNz9Ba/8BLZZuquxLjesP8K1M73YE8dZn4mj/bMJb5S3Dtu6pbn1rT
         g1kzU3Dvyzz0Qq7ADxe/WhcPxwoVsExjwsoy6V3bRFpumMnu+y8OTBIujY0enep/XEdB
         gPs3tIVz6By6O6Kq1w/p/hJjzsMWhN5EYtHus=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=OEzV4hyWIz64E6/vOVtvkCfFBcuMDLnsowl8Wi2hkjVd4itYeVYYWTmFAWjae1SJQE
         DoWO6oi4cNzDhEmIW/Hgdvg4lvQTkXMFK2nkixcrD/p9mLHp5+/PCrjBzPgeV8XP2MT7
         yZCzDYhOR16oKiPzO9JlN25ZiuZQWmJgBMCDU=
Received: by 10.86.74.4 with SMTP id w4mr233463fga.65.1246144801665;
        Sat, 27 Jun 2009 16:20:01 -0700 (PDT)
Received: from ?192.168.1.13? (abwd106.neoplus.adsl.tpnet.pl [83.8.227.106])
        by mx.google.com with ESMTPS id d4sm3931173fga.28.2009.06.27.16.20.00
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 27 Jun 2009 16:20:01 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <cb7bb73a0906271545h8033f63jf0198a2f9e187428@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122391>

On Sun, 28 Jun 2009, Giuseppe Bilotta wrote:
> 2009/6/27 Jakub Narebski <jnareb@gmail.com>:

>>> + =A0 =A0 # Avatar support. When this feature is enabled, views suc=
h as
>>> + =A0 =A0 # shortlog or commit will display an avatar associated wi=
th
>>> + =A0 =A0 # the email of the committer(s) and/or author(s).
>>> +
>>> + =A0 =A0 # Currently only the gravatar provider is available, and =
it
>>> + =A0 =A0 # depends on Digest::MD5.
[...]

>> By the way, we might want to accept 'none' instead of empty value
>> or no value to turn off avatar support for specific project (if
>> avatars are turned on globally, and project specific override is on)=
=2E
>> We use this technique for 'snapshot' feature.
>>
>> But this isn't terribly important.
>=20
> Well, since 'none' is not a known provider, that trick should work
> correctly anyway.

Ah, I have forgot about this.  Perhaps it should be stated more=20
explicitly that unknown provider (type) =3D no avatar image?  Or do I
simply not see it?

>>> +our ($git_avatar) =3D gitweb_get_feature('avatar');
>>> +if ($git_avatar eq 'gravatar') {
>>> + =A0 =A0 $git_avatar =3D '' unless (eval { require Digest::MD5; 1;=
 });
>>> +} else {
>>> + =A0 =A0 $git_avatar =3D '';
>>> +}
>>
>> Thoughts for the future: this can lead to not very pretty if-elsif
>> chain. =A0We have replaces such chain for selecting action (for disp=
atch)
>> by using %actions hash of subroutine refs (as a kind of 'switch'/'gi=
ven'
>> statement). =A0We could do the same for avatar provider initializati=
on
>> and validation subroutines.
>>
>> But for now it is clear enough. =A0Don't worry about this issue now.
>=20
> I'm also not terribly sure about how to implement _this_ through hash
> calls. But I did consider the issue (how I wish Perl had an actual
> switch statement ...)

Perl 5.10, Perl 6, Switch.pm... but it isn't something that we can use
in gitweb.  Switch statement (spelled 'given / when') in Perl6 / Perl 5=
=2E10
is very, very powerfull (from what I have read).

But what I meant here is something like the following:

  our %avatar_providers =3D (
  	'gravatar' =3D> sub { eval { require Digest::MD5; 1; } },
  	'picon'    =3D> sub { 1; },
  );
  unless (defined $avatar_providers{$git_avatar} &&
          $avatar_providers{$git_avatar}->()) {
  	$git_avatar =3D '';
  }

Or something like that (we can use 'undef' for providers without need
for initialization).  But that can be improved later, "in tree".


On the other hand side this solution wouldn't I think be able to deal
with specifying fallbacks using e.g. 'gravatar+picon' (gravatar using
picon URL as fallback i.e. "default" argument), or two images side by
side like GMane uses (if there are two), e.g. 'gravatar picon' or=20
'gravatar, picon'.

=46ood for thought.  Not something to act on now.

>> Running t9500-gitweb-standalone-no-errors.sh with --debug option sho=
ws
>> failing of 15 among 87 tests, with error:
>>
>> =A0 gitweb.perl: Use of uninitialized value in hash element at gitwe=
b/gitweb.perl line 1524.
>>
>> which is the above line. =A0This line should read:
>>
>> =A0+ =A0 =A0 my $size =3D exists $opts{'size'}
>> =A0+ =A0 =A0 =A0 =A0 =A0 =A0 ? $avatar_size{$opts{'size'}} || $avata=
r_size{'default'}
>> =A0+ =A0 =A0 =A0 =A0 =A0 =A0 : $avatar_size{'default'};
>>
>> or something like that, e.g.:
>>
>> =A0+ =A0 =A0 my $size =3D $avatar_size{ defined $opts{'size'} ? $opt=
s{'size'} : 'default' }
>> =A0+ =A0 =A0 =A0 =A0 =A0 =A0 || $avatar_size{'default'};
>=20
> I did $opts{-size} ||=3D 'default'. Or is it bad form to modify the
> passed option hash?

No, it is O.K.  We do similar thing in href(), deleting keys from hash.

>>> + =A0 =A0 my $url =3D "";
>>> + =A0 =A0 if ($git_avatar eq 'gravatar') {
>>> + =A0 =A0 =A0 =A0 =A0 =A0 $url =3D "http://www.gravatar.com/avatar.=
php?gravatar_id=3D" .
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 Digest::MD5::md5_hex(lc $=
email) . "&amp;size=3D$size";
>>
>> Why not use the new API[1][2]?:
>=20
> Updated.

This affects also the next patch in series.

--=20
Jakub Narebski
Poland
