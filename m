From: Clemens Buchacher <drizzd@aon.at>
Subject: Re: Question about 'branch -d' safety
Date: Sat, 17 Jul 2010 11:30:06 +0200
Message-ID: <20100717093006.GA11452@localhost>
References: <20091230065442.6117@nanako3.lavabit.com>
 <m3lj9jknlr.fsf@localhost.localdomain>
 <20100711065505.GA19606@localhost>
 <201007110916.29567.jnareb@gmail.com>
 <20100711133730.GA10338@localhost>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="uAKRQypu60I7Lcqm"
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Nicolas Sebrecht <nicolas.s.dev@gmx.fr>,
	Nanako Shiraishi <nanako3@lavabit.com>,
	Junio C Hamano <gitster@pobox.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jul 17 11:30:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oa3j8-0008GZ-3k
	for gcvg-git-2@lo.gmane.org; Sat, 17 Jul 2010 11:30:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759716Ab0GQJaQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Jul 2010 05:30:16 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:58851 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755319Ab0GQJaO (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Jul 2010 05:30:14 -0400
Received: by fxm14 with SMTP id 14so1466084fxm.19
        for <git@vger.kernel.org>; Sat, 17 Jul 2010 02:30:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:sender:received:date:from:to
         :cc:subject:message-id:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        bh=lIuXZEHXazJAg6JJVNWaclxYEAj0dumJOGAe1+CEun4=;
        b=EJRA9f+51AXc5EMXHTOSRIQpzMUvv4LfGB6VUOHH4OG+XLpUZ/uKtVMnUr7VuODi+R
         t6aT0T+eeIHDymFVUbYt/10QtsjFAM1viOhMCk+C+p5uLvgLBp/n2d7Eo5KSE1kEZI1G
         rx5L5heywr1VfB0A9HXW61PkblE9R5e/2Cs3A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=sender:date:from:to:cc:bcc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        b=UseBZ961MwX6zqZNBZfULQ46T/XtOXOnosU/uId9QLgWeumhtpbtoWYK0AhheM+a1w
         VwqUBMRQYOeb2C/HZJEkv1gU4iZybxWIIMOOUv1CgADLptRWjWlAArPSg8jC9BmGhYi6
         H1mL2uywcfYPDPXrGifzCpsMapuMQMKc8RjvA=
Received: by 10.223.115.201 with SMTP id j9mr1517541faq.48.1279359013080;
        Sat, 17 Jul 2010 02:30:13 -0700 (PDT)
Received: from darc.lan (p549A69C7.dip.t-dialin.net [84.154.105.199])
        by mx.google.com with ESMTPS id a26sm1110082fak.43.2010.07.17.02.30.10
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 17 Jul 2010 02:30:11 -0700 (PDT)
Received: from drizzd by darc.lan with local (Exim 4.71)
	(envelope-from <drizzd@localhost>)
	id 1Oa3ig-0003aR-3j; Sat, 17 Jul 2010 11:30:06 +0200
Content-Disposition: inline
In-Reply-To: <20100711133730.GA10338@localhost>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151182>


--uAKRQypu60I7Lcqm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

I am not sure how to proceed with this. It seems like there are
many arguments against it, and few for it. So in order to get a
better idea where we stand, I have summarized the arguments so far
below.=20

I do not know which solution would make everyone happy. But I think
there are a few advantages to be considered, and the remaining
issues are not insurmountable.

Clemens
---

Pros and cons for "undeleting branches":

+ safety net

It should not be easy to lose information with git. In most cases
branches can be restored from the HEAD reflog, but it can be
complicated if the branch has never been checked out. Even the
trivial case is not as obvious as searching for a "Branch deleted"
entry in the reflog.

+ less dependant on git branch -d

Since git branch -d deletes branches which have been merged to a
remote tracking branch, it does no longer guarantee that the branch
is still available in history locally, and if the branch is also
deleted remotely, running git remote prune removes it entirely. In
that sense, it cannot be considered safe any more. Being able to
restore deleted branches would make this a non-issue.

+ automatically prune remote tracking branches

Once it is easy to restore deleted branches, there is no need to
keep around remote tracking branches which have been deleted on the
remote. They can be pruned automatically on git fetch.

- only a convenience

Considering the many potential issues for this corner case, why
bother implementing it? Deleted branches can be restored from the
HEAD reflog anyways.

- implementation complexity

Due to the possibility of D/F conflicts, "deleted reflogs" have to
be renamed internally. This makes the reflog implementation more
complex.

- user interface complexity

How to prune deleted branches? Currently, it is enough to do "git
branch -D branch; git gc --prune" in order to get rid of the branch
objects, at least if the HEAD reflog does not contain it or has
expired. Consider for example adding a remote, and removing it
again. This operation would leave a bunch of deleted branches,
which potentially occupy a lot of disk space.

How to find and restore deleted branches? If the reflog is used to
record deleted branches, and a new branch of the same name is
created, the reflog contains entries from unrelated branches. [1]
If the deleted reflogs are stored in an attic, how do we reference
those?

[1] Also, what happens if that new branch is renamed?

--uAKRQypu60I7Lcqm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQEcBAEBAgAGBQJMQXgaAAoJELKdZexG8uqMH5QH/3irIenjQn1SxOC04stjzR0m
PfTTRfsn00U2R36nfCsZe6ai3n8AUGN+Y5Sq3b3CDNnj+Sx7TdTlRrIPgRyjc96A
Xz9sm/RY8mIjTTDk+1T7gp4cCtBHJP7ePwWMvDOe51iZknF3VlMVoaTNx9Dsy7wj
PNvaqHQre1MIiqi0U3K+xzM5YL739J3jiAzjaCOOxhXMK3aIFEdQDs/2hd9R2T++
hsyauIPgRaE3xT10Bl8h68ytx+S/SODRdNPdooLzBBW76FqW2Sl3ezMCKqsW+1vB
u3Der41aWuojAXuivXl0CzxX0XiCnTZWviOa2b7yuHe7PTIzruiE4Dk+Rhzun0k=
=xaZb
-----END PGP SIGNATURE-----

--uAKRQypu60I7Lcqm--
