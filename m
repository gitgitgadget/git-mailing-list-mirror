From: Eric Wong <normalperson@yhbt.net>
Subject: Re: git-svn: Fails to drop leading path from empty dir name
Date: Sun, 22 Nov 2009 15:25:04 -0800
Message-ID: <20091122232504.GA28127@dcvr.yhbt.net>
References: <20091122134638.GA12233@atjola.homenet>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
X-From: git-owner@vger.kernel.org Mon Nov 23 00:25:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NCLo6-0002jF-K5
	for gcvg-git-2@lo.gmane.org; Mon, 23 Nov 2009 00:25:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754181AbZKVXY7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 22 Nov 2009 18:24:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753968AbZKVXY7
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Nov 2009 18:24:59 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:59522 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753918AbZKVXY6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Nov 2009 18:24:58 -0500
Received: from localhost (unknown [127.0.2.5])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3A2101F605;
	Sun, 22 Nov 2009 23:25:05 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20091122134638.GA12233@atjola.homenet>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133462>

Bj=F6rn Steinbrink <B.Steinbrink@gmx.de> wrote:
> Hi Eric,
>=20
> the stuff to create empty directories fails to strip leading path
> components, e.g. when using
> "git svn clone -s svn://whatever/project/trunk".
>=20
> Instead of creating the empty directory "foo" in the repo root, it
> creates "project/trunk/foo".
>=20
> Ad hoc patch for the test case below.
>=20
> Bj=F6rn
>=20
> diff --git a/t/t9146-git-svn-empty-dirs.sh b/t/t9146-git-svn-empty-di=
rs.sh
> index 5948544..9e22089 100755
> --- a/t/t9146-git-svn-empty-dirs.sh
> +++ b/t/t9146-git-svn-empty-dirs.sh
> @@ -82,4 +82,27 @@ test_expect_success 'git svn mkdirs -r works' '
>  	)
>  '
> =20
> +test_expect_success 'initialize trunk' '
> +	for i in trunk trunk/a trunk/"weird file name"
> +	do
> +		svn_cmd mkdir -m "mkdir $i" "$svnrepo"/"$i"
> +	done
> +'
> +

Hi Bj=F6rn,

I'm having a bit of trouble figuring out exactly what you mean
here, can you double check your tests?  Annotations below, thanks

> +test_expect_success 'clone trunk' 'git svn clone -s "$svnrepo" trunk=
'
                                                    ^^            ^^^^^
                                                           Huh?

> +test_expect_success 'empty directories in trunk exist' '
> +	(
> +		cd cloned &&
                   ^^^^^^ - ?

> +		for i in trunk/a trunk/"weird file name"
> +		do
> +			if ! test -d "$i"
> +			then
> +				echo >&2 "$i does not exist"
> +				exit 1
> +			fi
> +		done

--=20
Eric Wong
