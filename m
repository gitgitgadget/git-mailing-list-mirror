From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 1/4] gitweb: notes feature
Date: Fri, 5 Feb 2010 00:20:53 +0100
Message-ID: <201002050020.56643.jnareb@gmail.com>
References: <1265300338-25021-1-git-send-email-giuseppe.bilotta@gmail.com> <201002041821.22864.jnareb@gmail.com> <7vwrys7lrm.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johan Herland <johan@herland.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 05 00:17:59 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NdAxQ-0006J0-3L
	for gcvg-git-2@lo.gmane.org; Fri, 05 Feb 2010 00:17:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758382Ab0BDXRv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 4 Feb 2010 18:17:51 -0500
Received: from mail-fx0-f220.google.com ([209.85.220.220]:53212 "EHLO
	mail-fx0-f220.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756249Ab0BDXRu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Feb 2010 18:17:50 -0500
Received: by fxm20 with SMTP id 20so3228675fxm.1
        for <git@vger.kernel.org>; Thu, 04 Feb 2010 15:17:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=r+F0IpAqmCbTGUlV2zqZNZqLoPs8cgVhiEJiQ1VveuA=;
        b=jF4FfaOw6DajJrUEHeqgQTVeZ3fxyKVTMWN9fdJO5WbrxUEJlP/RfDpNywymLzZSqc
         QBIME0t0GzI3h/Vn9WOAa0/hcBo1Q8ucC4AULdHGrhIdB6B4vWF8HJX/oJM/5BGCC1hc
         uLWz0UJ1KQaL3iHQ/hB8hMxFIV1RSl3ujCoOs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=rIUBl7LLD6M7bBPPKGL244tJxF3Aq/ZWmA2k+duz1QAqR2yEybQme/b2B83vrV9wTP
         VKpoRUyX2YYm+DKJ985sLCHMilHJX381/8c1ToPw0irYcyGg+I/NQY/4kqaAS0nys2Kn
         rqutgGT6PWduVzdZq3R3NRRSLxheI1hsJxWUU=
Received: by 10.223.95.74 with SMTP id c10mr1983129fan.82.1265325468348;
        Thu, 04 Feb 2010 15:17:48 -0800 (PST)
Received: from ?192.168.1.13? (abrz208.neoplus.adsl.tpnet.pl [83.8.119.208])
        by mx.google.com with ESMTPS id 16sm339502fxm.4.2010.02.04.15.17.40
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 04 Feb 2010 15:17:45 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <7vwrys7lrm.fsf@alter.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139010>

Dnia czwartek 4. lutego 2010 22:07, Junio C Hamano napisa=B3:
> Jakub Narebski <jnareb@gmail.com> writes:
>=20
>>> IOW, the code should be reading output from:
>>>=20
>>>     GIT_NOTES_REF=3D$note_ref git show -s --format=3D%N $co{'id'}
>>>=20
>>> as the notes tree may not be storing notes in a flat one-level name=
space
>>> like you are assuming.
>>
>> First, for some mechanism of deployment (IIRC Apache's mod_perl) cha=
nges
>> to environment variables from CGI script are not passed to invoked
>> commands (I guess for security reasons).
>=20
> I do not believe you are unable to spawn
>=20
> 	open $fd, '-|' 'sh', '-c', "GIT_NOTES_REF=3D$note_ref git show ..."=20
>=20
> and read from it ;-).

You meant here

	my $git_command =3D quote_command(git_cmd(), 'show', ...);
	open my $fd, '-|', 'sh', '-c', "GIT_NOTES_REF=3D$note_ref $git_command=
"=20

So you need to take care to quote parameters ($note_ref fortunately=20
doesn't need to be quoted)... and you have one more process (shell)
spawned.


Therefore I think it would be nice to have --notes-ref option to git=20
wrapper,... especially that it should be easy to set it up in such way
that it would be possible to pass --notes-ref multiple times, e.g.:

	git --notes-ref=3Dcommits --notes-ref=3Dgit-svn show ...

--=20
Jakub Narebski
Poland
