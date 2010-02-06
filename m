From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: Re: [PATCH 4/4] gitweb: show notes in commit(diff) view
Date: Sat, 6 Feb 2010 15:15:39 +0100
Message-ID: <cb7bb73a1002060615o261d974cnf347ba5af5ae324b@mail.gmail.com>
References: <1265300338-25021-1-git-send-email-giuseppe.bilotta@gmail.com> 
	<1265300338-25021-5-git-send-email-giuseppe.bilotta@gmail.com> 
	<201002061416.29481.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johan Herland <johan@herland.net>,
	Junio C Hamano <gitster@pobox.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 06 15:16:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NdlSI-0003RU-EV
	for gcvg-git-2@lo.gmane.org; Sat, 06 Feb 2010 15:16:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750992Ab0BFOQF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 6 Feb 2010 09:16:05 -0500
Received: from ey-out-2122.google.com ([74.125.78.24]:13443 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750796Ab0BFOQB convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 6 Feb 2010 09:16:01 -0500
Received: by ey-out-2122.google.com with SMTP id d26so1036037eyd.19
        for <git@vger.kernel.org>; Sat, 06 Feb 2010 06:16:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=K5Tk4GhBaKqr6Uy8wDCMvfhBHv0fUWCm5RZtmmNLXaE=;
        b=WAmXQoVrflESSHA5nu5GaoqN6oRsJ9bENSxOG18OSbLgr7Rid5L7lDJYKDpSNy3GiS
         CKyRC+tIoihWyWt9kxLfQh08bD/UmCmWyu5HDtipVi8erLhil0YadeSQr3ecTKEPYJTj
         nXJYOa272jWNxmzkOxHkxVZPQ9PsEIgxqC/6o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=E1qUh1FjIIEzGu912O7p+tkC+IznBETCdpnFjbzrxct6h0qLr1lUv0R9E1pNXReOE6
         WWxTRssZqDpH85X4E6UON2A0f2ROTnb0a5vqQMr8TI7NqNZjWxHNkPsy25ta+bfcD2YN
         k+jXaFRSTodiauVYzt+lh9v+A0RcJNY9E0Wx8=
Received: by 10.213.100.68 with SMTP id x4mr1836847ebn.33.1265465759116; Sat, 
	06 Feb 2010 06:15:59 -0800 (PST)
In-Reply-To: <201002061416.29481.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139169>

2010/2/6 Jakub Narebski <jnareb@gmail.com>:
> On Thu, 4 Jan 2010, Giuseppe Bilotta wrote:
>
>> The notes are shown side-by-side along the bottom of the commit
>> message.
>
> The same question apply as for previous commit.
>
> What happens if screen size is too small to contain both commit messa=
ge
> and notes? =A0Does it do the sensible thing of putting notes _below_
> commit message in such situation? =A0I do not know CSS+HTML enogh to
> answer this question myself.

In this view the notes are printed side-by-side to each other, but at
the end of the commit message, so there's no interference at all.

>> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
>> index 0d0877e..0d03026 100755
>> --- a/gitweb/gitweb.perl
>> +++ b/gitweb/gitweb.perl
>> @@ -2837,12 +2837,31 @@ sub parse_commit {
>> =A0 =A0 =A0 %co =3D parse_commit_text(<$fd>, 1);
>> =A0 =A0 =A0 close $fd;
>>
>> + =A0 =A0 my %notes =3D ();
>> + =A0 =A0 foreach my $note_ref (get_note_refs()) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 my $obj =3D "$note_ref:$co{'id'}";
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (open my $fd, '-|', git_cmd(), 'rev-par=
se',
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 '--verify', '-q', $obj) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 my $exists =3D <$fd>;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 close $fd;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (defined $exists) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (open $=
fd, '-|', git_cmd(), 'show', $obj) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 $notes{$note_ref} =3D scalar <$fd>;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 close $fd;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 }
>> + =A0 =A0 $co{'notes'} =3D \%notes;
>> +
>> =A0 =A0 =A0 return %co;
>> =A0}
>
> Duplicated code. =A0Please put this code in a separate subroutine, to=
 be
> called in those two places.

Yup, definitely a good idea.

>> =A0# return all refs matching refs/notes/<globspecs> where the globs=
pecs
>> =A0# are taken from the notes feature content.
>> =A0sub get_note_refs {
>> + =A0 =A0 local $/ =3D "";
>> +
>
> Why it is needed here? =A0Why you want to use empty lines as terminat=
or
> (which means reading whole paragraphs), while treating two or more
> consecutive empty lines as a single empty line (according to
> perlvar(1))?
>
> If you want to slurp whole file, this should be
>
> =A0 =A0 =A0 =A0local $/;
>
> or more explicit
>
> =A0 =A0 =A0 =A0local $/ =3D undef;

Ah, sorry, for some reason I thought "" was the default.


--=20
Giuseppe "Oblomov" Bilotta
