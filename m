From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: Re: [PATCH] read_cache: cast types from stat to ce_cache
Date: Fri, 11 Jun 2010 16:15:16 +0200
Message-ID: <AANLkTimC9RAD0OGArk3JAIAnDHNskJRgX1nBlcrhc7vX@mail.gmail.com>
References: <a06cc84698f174d914350d6fd6e6b4739d22aa45.1276161176.git.git@drmicha.warpmail.net>
	<7vmxv2nar5.fsf@alter.siamese.dyndns.org>
	<4C123AD4.6070606@drmicha.warpmail.net>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Fri Jun 11 16:21:46 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ON57B-00007j-Eu
	for gcvg-git-2@lo.gmane.org; Fri, 11 Jun 2010 16:21:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756453Ab0FKOVk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 11 Jun 2010 10:21:40 -0400
Received: from mail-yw0-f204.google.com ([209.85.211.204]:43356 "EHLO
	mail-yw0-f204.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756353Ab0FKOVj convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 11 Jun 2010 10:21:39 -0400
Received: by ywh42 with SMTP id 42so1117319ywh.15
        for <git@vger.kernel.org>; Fri, 11 Jun 2010 07:21:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:reply-to
         :in-reply-to:references:date:message-id:subject:from:to:cc
         :content-type:content-transfer-encoding;
        bh=WX0+Pxpow2H1M3y/TN5FP29v6zCxOCu/Vq/pQHUTCgk=;
        b=WprGleX5lQ0VQDy+qSfDK2P/mj1dXwjTPKvPy1JJEl9SuCtAtJp/YF3eZF7so81Kbz
         9HCIH5tBQGMqh+ZxdHNQyyIWDgNPZjpPXVasAFL/WkG7hfn8lKiawGrQxTw5akkARDGN
         irWwLtYhllD+vc/HhPdD65+UrNcavigO/2k9M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type:content-transfer-encoding;
        b=m1e5EOcSvtR23UfREq41zPEbJJCKCb+g26f9rCFdCS0AH4X5hEAgsZsvFSx6dUGK0I
         9TkNEAD/JyvrVMnp3oQ/BETfa7tZntIikyNbF0vouCAPPuXgKeftDHV6iNFpxzeH0UYE
         p4TGIdU5CMGKTfWXVQSaBF7s4vn/JmiyjFQBw=
Received: by 10.216.160.70 with SMTP id t48mr2013571wek.82.1276265716893; Fri, 
	11 Jun 2010 07:15:16 -0700 (PDT)
Received: by 10.216.53.132 with HTTP; Fri, 11 Jun 2010 07:15:16 -0700 (PDT)
In-Reply-To: <4C123AD4.6070606@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148948>

On Fri, Jun 11, 2010 at 3:32 PM, Michael J Gruber
<git@drmicha.warpmail.net> wrote:
> Junio C Hamano venit, vidit, dixit 10.06.2010 17:54:
>> Michael J Gruber <git@drmicha.warpmail.net> writes:
>>
>>> - =A0 =A0ce->ce_dev =3D st->st_dev;
>>> - =A0 =A0ce->ce_ino =3D st->st_ino;
>>> - =A0 =A0ce->ce_uid =3D st->st_uid;
>>> - =A0 =A0ce->ce_gid =3D st->st_gid;
>>> - =A0 =A0ce->ce_size =3D st->st_size;
>>> + =A0 =A0ce->ce_dev =3D (unsigned int)st->st_dev;
>>> + =A0 =A0ce->ce_ino =3D (unsigned int)st->st_ino;
>>> + =A0 =A0ce->ce_uid =3D (unsigned int)st->st_uid;
>>> + =A0 =A0ce->ce_gid =3D (unsigned int)st->st_gid;
>>> + =A0 =A0ce->ce_size =3D (unsigned int)st->st_size;
>>
>> I haven't had my morning coffee yet, but wouldn't the conversion be
>> automatic by assignment anyway?
>
> Well, we do cast from dev_t etc. to unsigned int in all other places =
in
> read_cache.c.
>

The only cases where we cast anything to unsigned in on assignment in
read-cache.h is where we assign the second-part of the ce_ctime and
ce_mtime members:
	ce->ce_ctime.sec =3D (unsigned int)st->st_ctime;
	ce->ce_mtime.sec =3D (unsigned int)st->st_mtime;

These are indeed superfluous (as yours are) as far as I can tell.
There's also some casts on comparison, and I think they also are
superfluous. The current casts originate from commits fba2f38a,
5bcf109c, e1afca4f and 7a51ed66.

They don't do any harm though, so I don't think it makes much sense to
remove them.

--=20
Erik "kusma" Faye-Lund
