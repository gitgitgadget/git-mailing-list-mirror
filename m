From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: [PATCH] Fix 'git cvsexportcommit -w $cvsdir ...' when used with relative $GIT_DIR
Date: Mon, 11 Feb 2008 21:58:16 +0100
Message-ID: <200802112158.16830.robin.rosenberg.lists@dewire.com>
References: <200802110228.05233.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Tue Feb 12 00:14:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JOhqp-0007Xp-32
	for gcvg-git-2@gmane.org; Tue, 12 Feb 2008 00:14:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753778AbYBKXNa convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 11 Feb 2008 18:13:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751459AbYBKXNa
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Feb 2008 18:13:30 -0500
Received: from [83.140.172.130] ([83.140.172.130]:25482 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1753765AbYBKXN2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Feb 2008 18:13:28 -0500
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 15E9F8006B4;
	Tue, 12 Feb 2008 00:13:24 +0100 (CET)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id aaIJIoDv+UFv; Tue, 12 Feb 2008 00:13:23 +0100 (CET)
Received: from [10.9.0.4] (unknown [10.9.0.4])
	by dewire.com (Postfix) with ESMTP id F3B228006AA;
	Tue, 12 Feb 2008 00:13:20 +0100 (CET)
User-Agent: KMail/1.9.6 (enterprise 0.20071123.740460)
In-Reply-To: <200802110228.05233.johan@herland.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73604>

m=C3=A5ndagen den 11 februari 2008 skrev Johan Herland:
> When using the '-w $cvsdir' option to cvsexportcommit, it will chdir =
into
> $cvsdir before executing several other git commands. If $GIT_DIR is s=
et to
> a relative path (e.g. '.'), the git commands executed by cvsexportcom=
mit
> will naturally fail with "fatal: Not a git repository".
[...]

>  die "Need at least one commit identifier!" unless @ARGV;
> =20
>  if ($opt_w) {
> +	# Remember where GIT_DIR is before changing to CVS checkout
>  	unless ($ENV{GIT_DIR}) {
> -		# Remember where our GIT_DIR is before changing to CVS checkout
> +		# Oops no GIT_DIR set. Figure out for ourselves

That's not an "Oops". It's perfectly normal not to have GIT_DIR set.

>  		my $gd =3D`git-rev-parse --git-dir`;
>  		chomp($gd);
> -		if ($gd eq '.git') {
> -			my $wd =3D `pwd`;Kopia
> -			chomp($wd);
> -			$gd =3D $wd."/.git"	;
> -		}
> +		$ENV{GIT_DIR} =3D $gd;
> +	}
> +	unless ($ENV{GIT_DIR} =3D~ m[^/]) {
> +		# GIT_DIR is relative. Prepend $PWD
Hmm. C:/foo? You should probably use rel2abs in the File::Spec
module.

-- robin
