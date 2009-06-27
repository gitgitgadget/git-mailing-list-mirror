From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: Re: [PATCHv7 5/9] gitweb: (gr)avatar support
Date: Sun, 28 Jun 2009 00:45:00 +0200
Message-ID: <cb7bb73a0906271545h8033f63jf0198a2f9e187428@mail.gmail.com>
References: <1246104305-15191-1-git-send-email-giuseppe.bilotta@gmail.com>
	 <1246104305-15191-5-git-send-email-giuseppe.bilotta@gmail.com>
	 <1246104305-15191-6-git-send-email-giuseppe.bilotta@gmail.com>
	 <200906272145.46506.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 28 00:45:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MKge7-0001hZ-C0
	for gcvg-git-2@gmane.org; Sun, 28 Jun 2009 00:45:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752364AbZF0WpA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 27 Jun 2009 18:45:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751670AbZF0Wo7
	(ORCPT <rfc822;git-outgoing>); Sat, 27 Jun 2009 18:44:59 -0400
Received: from mail-bw0-f213.google.com ([209.85.218.213]:63749 "EHLO
	mail-bw0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751327AbZF0Wo6 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 27 Jun 2009 18:44:58 -0400
Received: by bwz9 with SMTP id 9so2625450bwz.37
        for <git@vger.kernel.org>; Sat, 27 Jun 2009 15:45:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=oqP3Zjgr6a1SHuSLV7DErNYWq5jm3UbmotR7eAONRNo=;
        b=kQaY1o5kERG0qkLnKaT7tRu6EFrhI4ZEregJBic1oejW6ucXr3urNhFDvmPGlKh9f8
         ZUK/4WpHRYMKasj6fEzy6PTCfhkk1pp0RqOd4C+4ZVBNUPPncn/5n1t/i4EjEBoSlUx+
         pGTDsRfzg5rWbuVcdEX4WUvDSb40gmbxgV4Dw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=DLGwrK4ZFuUWphtNkudiaIvHivqV6gh7H4QkF+XNXeFIUyMfy6pASqQaihHZwcLtKy
         nhR0pn1E45ZCovJ2lSFLY0pIDQDXmZu491ZjafqMInX4lKxISDcNFxdaIqBf44wV3Q/V
         fxfnxU9PUIl/XqdkuVna29L8WjFEgdpzN0NPk=
Received: by 10.204.116.8 with SMTP id k8mr5272612bkq.110.1246142700330; Sat, 
	27 Jun 2009 15:45:00 -0700 (PDT)
In-Reply-To: <200906272145.46506.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122390>

2009/6/27 Jakub Narebski <jnareb@gmail.com>:
>
> This is well written commit message. =A0Good work!

Thanks 8-)

>> + =A0 =A0 # Avatar support. When this feature is enabled, views such=
 as
>> + =A0 =A0 # shortlog or commit will display an avatar associated wit=
h
>> + =A0 =A0 # the email of the committer(s) and/or author(s).
>> +
>> + =A0 =A0 # Currently only the gravatar provider is available, and i=
t
>> + =A0 =A0 # depends on Digest::MD5.
>> +
>> + =A0 =A0 # To enable system wide have in $GITWEB_CONFIG
>> + =A0 =A0 # $feature{'avatar'}{'default'} =3D ['gravatar'];
>> + =A0 =A0 # To have project specific config enable override in $GITW=
EB_CONFIG
>> + =A0 =A0 # $feature{'avatar'}{'override'} =3D 1;
>> + =A0 =A0 # and in project config gitweb.avatar =3D gravatar;
>> + =A0 =A0 'avatar' =3D> {
>> + =A0 =A0 =A0 =A0 =A0 =A0 'sub' =3D> \&feature_avatar,
>> + =A0 =A0 =A0 =A0 =A0 =A0 'override' =3D> 0,
>> + =A0 =A0 =A0 =A0 =A0 =A0 'default' =3D> ['']},
>> =A0);
>
> So you have chosen [''] and not [] as "no avatar" value, to simplify
> later code. =A0All right.
>
>>
>> =A0sub gitweb_get_feature {
>> @@ -433,6 +458,16 @@ sub feature_patches {
>> =A0 =A0 =A0 return ($_[0]);
>> =A0}
>>
>> +sub feature_avatar {
>> + =A0 =A0 my @val =3D (git_get_project_config('avatar'));
>> +
>> + =A0 =A0 if (@val) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 return @val;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 return @_;
>> +}
>
> Hmmm... why not simply
>
> =A0+ =A0 =A0 return @val ? @val : @_;

Right. Why not?

> By the way, we might want to accept 'none' instead of empty value
> or no value to turn off avatar support for specific project (if
> avatars are turned on globally, and project specific override is on).
> We use this technique for 'snapshot' feature.
>
> But this isn't terribly important.

Well, since 'none' is not a known provider, that trick should work
correctly anyway.

>> +our ($git_avatar) =3D gitweb_get_feature('avatar');
>> +if ($git_avatar eq 'gravatar') {
>> + =A0 =A0 $git_avatar =3D '' unless (eval { require Digest::MD5; 1; =
});
>> +} else {
>> + =A0 =A0 $git_avatar =3D '';
>> +}
>
> Thoughts for the future: this can lead to not very pretty if-elsif
> chain. =A0We have replaces such chain for selecting action (for dispa=
tch)
> by using %actions hash of subroutine refs (as a kind of 'switch'/'giv=
en'
> statement). =A0We could do the same for avatar provider initializatio=
n
> and validation subroutines.
>
> But for now it is clear enough. =A0Don't worry about this issue now.

I'm also not terribly sure about how to implement _this_ through hash
calls. But I did consider the issue (how I wish Perl had an actual
switch statement ...)

> Running t9500-gitweb-standalone-no-errors.sh with --debug option show=
s
> failing of 15 among 87 tests, with error:
>
> =A0 gitweb.perl: Use of uninitialized value in hash element at gitweb=
/gitweb.perl line 1524.
>
> which is the above line. =A0This line should read:
>
> =A0+ =A0 =A0 my $size =3D exists $opts{'size'}
> =A0+ =A0 =A0 =A0 =A0 =A0 =A0 ? $avatar_size{$opts{'size'}} || $avatar=
_size{'default'}
> =A0+ =A0 =A0 =A0 =A0 =A0 =A0 : $avatar_size{'default'};
>
> or something like that, e.g.:
>
> =A0+ =A0 =A0 my $size =3D $avatar_size{ defined $opts{'size'} ? $opts=
{'size'} : 'default' }
> =A0+ =A0 =A0 =A0 =A0 =A0 =A0 || $avatar_size{'default'};

I did $opts{-size} ||=3D 'default'. Or is it bad form to modify the
passed option hash?

> BTW. didn't we agree on '-size' and '-pad_before' convention?

Yes we did. I don't know why it went back to 'size' etc. Must have
messed up something with the patchsets.

>> + =A0 =A0 my $url =3D "";
>> + =A0 =A0 if ($git_avatar eq 'gravatar') {
>> + =A0 =A0 =A0 =A0 =A0 =A0 $url =3D "http://www.gravatar.com/avatar.p=
hp?gravatar_id=3D" .
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 Digest::MD5::md5_hex(lc $e=
mail) . "&amp;size=3D$size";
>
> Why not use the new API[1][2]?:

Updated.

--=20
Giuseppe "Oblomov" Bilotta
