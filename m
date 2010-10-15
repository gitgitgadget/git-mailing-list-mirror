From: Clemens Buchacher <drizzd@aon.at>
Subject: Re: [PATCH 5/5] do not overwrite files in leading path
Date: Fri, 15 Oct 2010 08:48:35 +0200
Message-ID: <20101015064835.GA12119@localhost>
References: <7v4oepaup7.fsf@alter.siamese.dyndns.org>
 <1286632380-7002-6-git-send-email-drizzd@aon.at>
 <7v1v7tkb6g.fsf@alter.siamese.dyndns.org>
 <20101013223425.GB2558@localhost>
Reply-To: Clemens Buchacher <drizzd@aon.at>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="uAKRQypu60I7Lcqm"
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Oct 15 18:02:31 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P6mjk-0006lz-FU
	for gcvg-git-2@lo.gmane.org; Fri, 15 Oct 2010 18:02:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756254Ab0JOQCW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Oct 2010 12:02:22 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:51810 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756095Ab0JOQCU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Oct 2010 12:02:20 -0400
Received: by fxm4 with SMTP id 4so550481fxm.19
        for <git@vger.kernel.org>; Fri, 15 Oct 2010 09:02:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:sender:received:date:from:to
         :cc:subject:message-id:reply-to:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        bh=Nj/CFpCGeaBqLPXfgCS3+YNyveyu5AXprJiEg9kAkIY=;
        b=lZn3AivVlEBnUTHpkksBnFZxOqrIm9ehu9oZDc1Jnl7ct5+AdMANLdOE/rZDBn6npG
         /hoiZRSRMFgH6V+lM2M9a5//6rljbaznT0mTkeKcMAZUhylP3/hI02SnDg9+zkhrxBvf
         3Rbtb6lHdCoZZM2HaGJgSJ4lCJoZDGl7sCBWE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=sender:date:from:to:cc:subject:message-id:reply-to:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        b=u7yoHwmAiqk3hn/IVYClQtqQHil5pGM7Hx0aeVHjFCvhwVJv64HCIlNM8kdZuAh6Gg
         BMkUCMjm/2LAlaGsRJbxXU9tIdw/qXlBXybtR0RWni+37MWPUqHmUlFizqHCboX9eYhU
         /zTK5mSdLCIVgZT5kOoTbGVSQuN4zCpXI0yY4=
Received: by 10.204.67.77 with SMTP id q13mr320163bki.214.1287125295300;
        Thu, 14 Oct 2010 23:48:15 -0700 (PDT)
Received: from darc.lan (p549A65BB.dip.t-dialin.net [84.154.101.187])
        by mx.google.com with ESMTPS id r21sm4327879bkj.22.2010.10.14.23.48.12
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 14 Oct 2010 23:48:13 -0700 (PDT)
Received: from drizzd by darc.lan with local (Exim 4.71)
	(envelope-from <drizzd@localhost>)
	id 1P6e5j-0003Cs-5D; Fri, 15 Oct 2010 08:48:35 +0200
Content-Disposition: inline
In-Reply-To: <20101013223425.GB2558@localhost>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159122>


--uAKRQypu60I7Lcqm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 14, 2010 at 12:34:25AM +0200, Clemens Buchacher wrote:
>=20
> If lstat returns with an error other than NOENT, or if
> check_ok_to_remove is called with anything other than a directory
> and cache_entry is NULL, we get a segmentation fault. Before, an
> error was simply ignored. I don't know which is worse.

I suppose we only need the following additional changes.

- die if lstat returns an error other than ENOENT.

- Rewrite verify_clean_subdirectory to not require a cache_entry.

- Expose lstat result and path cache to the caller of
  lstat_cache_matchlen() in verify_absent_1().

- rewrite check_leading_path (or 'verify_clean_path') to
  check the full path and return zero if
  + the leading path contains a symlink or
  + the leading path exists, but the full path does not
  and returns the path length of the offending entry otherwise.
 =20
I think that's manageable and much cleaner. I will start to work on
it as soon as possible.

Thank you for your review.

Clemens

--uAKRQypu60I7Lcqm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQEcBAEBAgAGBQJMt/lDAAoJELKdZexG8uqMnHIH/1Hv3iO7r3KxTV3kgSV1agAo
0cFeEr9ZZZFQClheuLQhEOapkNEjikh6iEX0d5zmnefHnKW2pGxcT9ZhKf0itBi5
vhjLeQyp2z54yiYnTBgmxUrFRkr/2mqyhF1e5dh/GjRcNJZ2IPfhfoCHHik99hMY
F5bNlaivWF4gVMhCIkO1oOq6OHVVUNfbeq3XnejFb0GyZZCP4l73uWC/rGKr951z
RM9QfazHPfppnRGhWp2MxRqzwynnHXGrwcEYdo7RirbYywAbxNprYIPlOxSExQnh
d0jJKfRx6FOnrHva/zMd09BBYK/D0TzqqiuS+h2Ydf0g+2AMrbihkwiDjbhJtkA=
=So6w
-----END PGP SIGNATURE-----

--uAKRQypu60I7Lcqm--
