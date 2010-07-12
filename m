From: Clemens Buchacher <drizzd@aon.at>
Subject: Re: Question about 'branch -d' safety
Date: Mon, 12 Jul 2010 20:47:55 +0200
Message-ID: <20100712184754.GA18429@localhost>
References: <20091230065442.6117@nanako3.lavabit.com>
 <m3lj9jknlr.fsf@localhost.localdomain>
 <20100711065505.GA19606@localhost>
 <201007110916.29567.jnareb@gmail.com>
 <20100711133730.GA10338@localhost>
 <7v1vb9hnd9.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3V7upXqbjpZ4EhLz"
Cc: Jakub Narebski <jnareb@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Nicolas Sebrecht <nicolas.s.dev@gmx.fr>,
	Nanako Shiraishi <nanako3@lavabit.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 12 20:49:46 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OYO4S-0004tY-QP
	for gcvg-git-2@lo.gmane.org; Mon, 12 Jul 2010 20:49:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755934Ab0GLStg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Jul 2010 14:49:36 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:39214 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751425Ab0GLStf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Jul 2010 14:49:35 -0400
Received: by bwz1 with SMTP id 1so2539605bwz.19
        for <git@vger.kernel.org>; Mon, 12 Jul 2010 11:49:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:sender:received:date:from:to
         :cc:subject:message-id:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        bh=8VSj1EvExWOLCxww8EQ30pTR8KtKpQSOm59SqEJ/ARg=;
        b=taiHqPODYf8uQFTNcOUynMUOujieWfx+CgNezfr1degkX4td29Vgh3s+O+AMnV64vn
         5BRSEr79vIGif811p4ZOv1F8mf1mGDfBxwK9j/FJdvo4AfOX+rlU73180iSpKxWxUZ7+
         9NAvANWsLsSOnQmXQP82Imvb5C7KJCGvjXvyU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=sender:date:from:to:cc:bcc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        b=NGMSNrbs3AZBertQHRRzpWu08lj1Mcb+R+wsI/bI1MM4ctznsygrcKEveDrY2NoEtE
         cXQnTHC8iWkPrkvqLWqkHxK3iCcc+zEMZ+80mVN7syP1Jak6TaH5rxPZpBFBPCPxn98s
         NhTfJhVtLh4rol1fwRUYA8JQW8LLezabeRyQE=
Received: by 10.204.62.12 with SMTP id v12mr9212396bkh.33.1278960572870;
        Mon, 12 Jul 2010 11:49:32 -0700 (PDT)
Received: from darc.lan (p549A42F6.dip.t-dialin.net [84.154.66.246])
        by mx.google.com with ESMTPS id y27sm19717498bkw.14.2010.07.12.11.49.29
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 12 Jul 2010 11:49:31 -0700 (PDT)
Received: from drizzd by darc.lan with local (Exim 4.71)
	(envelope-from <drizzd@localhost>)
	id 1OYO2l-00059e-9f; Mon, 12 Jul 2010 20:47:55 +0200
Content-Disposition: inline
In-Reply-To: <7v1vb9hnd9.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150841>


--3V7upXqbjpZ4EhLz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 11, 2010 at 11:41:54AM -0700, Junio C Hamano wrote:
>=20
>  - It is no longer possible to get rid of objects associated with the
>    history of a branch by deleting the branch and then running gc.

Yes, this should be fixed in the final implementation. The reflog
should be accessible as usual, and should expire normally, even if
the branch has been deleted.

>  - It is no longer possible to trust git that you would start a history of
>    a branch afresh when you create one.  If you happened to have an
>    unrelated branch with the same name in the past, the new branch
>    inherits reflog entries when it shouldn't.

The reflog does not guarantee any such relatedness with previous
entries anyways. Doing "git reset --hard <unrelated-branch>" is not
much different from deleting the branch and creating a new
unrelated branch of the same name.

And if it's really an issue, we can always make the reflog stop
listing entries at the latest branch creation entry, and make
listing beyound that optional. (I actually had to change the reflog
walker to make it continue beyound branch creation.)

> What problem are you guys really trying to solve?

The reflog protects you from almost all involuntary loss of
information. Except for recovery after git branch -D and even git
branch -d, as per the scenario I described in the original posting
of this thread.

Clemens

--3V7upXqbjpZ4EhLz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQEcBAEBAgAGBQJMO2NXAAoJELKdZexG8uqMPJIH/Ra9nDhWeU69fy7qoY4WYlnd
+0DgeCpGmFs9yPaTQcsOXB/8EvAjMF9/IH96OV6cPr/fJmS15G+hWIGYjvUJC0km
tq6+pg8PoPy+xs4Snq2dXUoN5nBsuXgBlAlM1lK4LQxUzvFccRhIIRyJf8BmDcRk
Y11e+TQzNBstR5l4WYQaoxdVYM5C4HYsxw1zw8CxbaLeAlnpOxj/qrzX7xuPmgGn
3r828CM1jE3ob5//BnOEXWQ6/1PdWmVLd92BWe8Dsjtvy8t4ULl1wErZA0FeR9kS
agjSSgU1bi0tD9+VZwTcttjDCGrAD8NGYf6Fx0OqB1ym9XmDVOsb6ZR3vnuIbGQ=
=+4Sg
-----END PGP SIGNATURE-----

--3V7upXqbjpZ4EhLz--
