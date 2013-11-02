From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: Question on merge order
Date: Sat, 2 Nov 2013 02:22:29 +0000
Message-ID: <20131102022229.GH41460@vauxhall.crustytoothpaste.net>
References: <CAM3f4mDXwXTJ5Kq3sgyK7yDLsBTdxSJXkZdE-SBe2LqfM3fccw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="CNK/L7dwKXQ4Ub8J"
Cc: git@vger.kernel.org
To: Gerasimos Dimitriadis <gedimitr@gmail.com>
X-From: git-owner@vger.kernel.org Sat Nov 02 03:22:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VcQrX-0008L6-LP
	for gcvg-git-2@plane.gmane.org; Sat, 02 Nov 2013 03:22:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753112Ab3KBCWg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Nov 2013 22:22:36 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:33491 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752689Ab3KBCWg (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 1 Nov 2013 22:22:36 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [IPv6:2001:470:1f05:79:21a5:310a:1a75:4292])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 57EB82807C;
	Sat,  2 Nov 2013 02:22:33 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <CAM3f4mDXwXTJ5Kq3sgyK7yDLsBTdxSJXkZdE-SBe2LqfM3fccw@mail.gmail.com>
X-Machine: Running on vauxhall using GNU/Linux on x86_64 (Linux kernel
 3.11-1-amd64)
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237234>


--CNK/L7dwKXQ4Ub8J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 02, 2013 at 03:11:55AM +0200, Gerasimos Dimitriadis wrote:
> Hi,
>=20
> I have a question on the order with which commits are applied on a merge.
>=20
> I am merging two branches that have changes on the same text file and
> I'd like to ask you about the merge result.
>=20
> The following output is provided on the two branches to be merged, by
> the command:
> git show-branch --date-order branchA branchB
>=20
> ! [branchA] file.txt got form A
>  * [branchB] file.txt got form B
> --
> +  [branchA] file.txt got form A
>  * [branchB] file.txt got form B
> +  [branchA^] file.txt got form B
> +* [branchA~2] First version of file.txt (form A)
>=20
> Now, this text file alternates between the following contents:
>=20
> According to form A, file.txt contains only one line of text:
> Gerasimos
>=20
> According to form B, file.txt contains three lines of text:
> PL-3
> PL-4
> PL-5
>=20
> The merge is done with the following commands:
> git checkout branchA
> git merge branchB
>=20
> Now, the result of the merge gets file.txt to form B, i.e. it contains
> the above 3 lines of text.
> My question is, why does the merge have the file resolve to form B and
> not to form A ?
> Theoretically, the merge could resolve to either A or B form. If the
> date is taken into account, maybe the A
> could even appear to be a better result.

I'm going to try to explain this, but I might be wrong, and I'm sure
someone will correct me if I am.  git computes a merge base from the two
branches, and that commit is branchA~2.  Now, the net change in branchA
is nothing; that is, the file is exactly the same at the merge base as
it is at the final commit of branchA.  branchB, on the other hand, has
made a change, to form B.

git only considers three points here: the merge base and the two
branches being merged.  So since there is a change on branchB, but no
change on branchA, git applies the changes introduced by branchB, and
you get form B, since a merge applies the changes in both branches.  The
trivial case where a change has been made in one branch but not the
other means that change is applied.  git doesn't care about intermediate
changes here, since it doesn't consider them.

In some cases, git can consider multiple common ancestors when using the
default recursive strategy, but that doesn't apply here.

--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | http://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: RSA v4 4096b: 88AC E9B2 9196 305B A994 7552 F1BA 225C 0223 B187

--CNK/L7dwKXQ4Ub8J
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBCgAGBQJSdGHlAAoJEL9TXYEfUvaLf/4P/0wK2ee0uc7hzxh0X9sHMQI1
Cg7LCE23pIptWn3MtNRlinLypy2b0BzYqNPksBWOu90YoNA5CMryxXfQmPYVArFT
MVeRJUSp5YJKKS3ijuP1Ys3MdgAIaXEWcCS2OsqCrbdKNZZC8FR0Jv51UTqpUCrr
9B+QA9wObwl/M47yNpWOq1qY48xAxVLdZfPlYCbk6P/MHKe8SI5LX+l24NaEheLs
6o3BLQJxiKtTnFkYJ9+9lmxcVEe656x5Z+70W1Y+powzgAreChUG/yFx1gcXRr/S
C55Jck7oCooCYPx7H72UZmGjqnakBTwIxy99lLiktqQq0aSpkdkVr3kV6CzhzAqX
027WaxddH4XiA0Zr01CAZh5IpS8+NNcC2wIbLTqike/sr5TSy/G46jBEvJ4x1ARI
kEzv0UpOb0T/icRTUU6seD7VA6OcXy3xsN/oKnerWQ2p9FVGDCgfRWPfLb/K6G2G
fnyvmYbrnvGKQU4BdoXD7qBve9YSPBl88wPhNa2LEsInA4LB3Wdf5uq2clicbiou
ASfnPNDzDUh/dC/Z7Tb1ioLxb4c0Hc9O6NsgLnb0UJrD0/ac3I/qG77kundMLYKl
hGylXP9Hh8JoVe8/vXKOC1kKdFOax42/Er4M1/qsQQ6qq78ok81f/6U2Tshf1kf3
RKR1q5RlXjQAgoKsku0V
=R2if
-----END PGP SIGNATURE-----

--CNK/L7dwKXQ4Ub8J--
