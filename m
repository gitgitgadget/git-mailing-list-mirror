From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH 1/2] git-svn: Fix the commit-url config to be the base
	url, just like the url config
Date: Mon, 4 Apr 2011 14:52:27 -0700
Message-ID: <20110404215227.GA4224@dcvr.yhbt.net>
References: <1301944148-7950-1-git-send-email-asedeno@mit.edu> <1301944148-7950-2-git-send-email-asedeno@mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Alejandro =?utf-8?Q?R=2E_Sede=C3=B1o?= <asedeno@mit.edu>,
	James Y Knight <jknight@itasoftware.com>
X-From: git-owner@vger.kernel.org Mon Apr 04 23:52:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q6rhN-0002Ys-C2
	for gcvg-git-2@lo.gmane.org; Mon, 04 Apr 2011 23:52:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753331Ab1DDVwc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 4 Apr 2011 17:52:32 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:53883 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751016Ab1DDVwb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Apr 2011 17:52:31 -0400
Received: from localhost (unknown [127.0.2.5])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8FD201F749;
	Mon,  4 Apr 2011 21:52:31 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1301944148-7950-2-git-send-email-asedeno@mit.edu>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170840>

"Alejandro R. Sede=C3=B1o" <asedeno@mit.edu> wrote:
> From: James Y Knight <jknight@itasoftware.com>
>=20
> This is necessary if you want to be able to commit to multiple branch=
es.

I'm not sure I understand the need for this patch, see below.

> @@ -523,12 +523,14 @@ sub cmd_dcommit {
>  	}
> =20
>  	if (defined $_commit_url) {
> -		$url =3D $_commit_url;
> +		$url =3D $_commit_url . (length $gs->{path} ? '/' . $gs->{path} : =
'');

$_commit_url is a user-specified parameter from the --commit-url switch=
=2E
If they want to override it it's the user's perogative.  It's not the
default and not commonly used.

>  	} else {
>  		$url =3D eval { command_oneline('config', '--get',
>  			      "svn-remote.$gs->{repo_id}.commiturl") };
>  		if (!$url) {
>  			$url =3D $gs->full_url

If unspecified, we always fall back to the gs->full_url case anyways
which just duplicates the logic you've added.  Again, commitUrl usually
does not need to be specified since it is autodetected.

> +		} else {
> +			$url =3D $url . (length $gs->{path} ? '/' . $gs->{path} : '');
>  		}
>  	}

--=20
Eric Wong
