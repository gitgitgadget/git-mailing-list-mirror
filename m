From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH 02/12] git-grep: support --no-external-grep
Date: Thu, 24 Jul 2008 22:26:34 +0200
Message-ID: <20080724202634.GB3760@blimp.local>
References: <20080723145549.GA29067@laptop>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 24 22:27:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KM7PU-0006FD-LI
	for gcvg-git-2@gmane.org; Thu, 24 Jul 2008 22:27:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751631AbYGXU0h convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 24 Jul 2008 16:26:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751783AbYGXU0h
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Jul 2008 16:26:37 -0400
Received: from mo-p05-ob.rzone.de ([81.169.146.182]:43485 "EHLO
	mo-p05-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751631AbYGXU0g (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jul 2008 16:26:36 -0400
X-RZG-CLASS-ID: mo05
X-RZG-AUTH: :YSxENQjhO8RswxTRIGdg20pf40K7
Received: from tigra.home (Fac14.f.strato-dslnet.de [195.4.172.20])
	by post.webmailer.de (klopstock mo9) (RZmta 16.47)
	with ESMTP id m03c2dk6OJQqsV ; Thu, 24 Jul 2008 22:26:34 +0200 (MEST)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from blimp (unknown [192.168.0.8])
	by tigra.home (Postfix) with ESMTP id 6221B277BD;
	Thu, 24 Jul 2008 22:26:34 +0200 (CEST)
Received: by blimp (Postfix, from userid 1000)
	id 3D8FB36D18; Thu, 24 Jul 2008 22:26:34 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20080723145549.GA29067@laptop>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89957>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy, Wed, Jul 23, 2008 16:55:49 +=
0200:
> =20
> +static int no_external_grep;
> +

If you have used direct logic instead of negative, your patch would
have been simplier and the code would be easier to understand. I.e.:

+static int external_grep =3D 1;

> @@ -386,7 +388,7 @@ static int grep_cache(struct grep_opt *opt, const=
 char **paths, int cached)
>  	 * we grep through the checked-out files. It tends to
>  	 * be a lot more optimized
>  	 */
> -	if (!cached) {
> +	if (!cached && !no_external_grep) {

+	if (!cached && external_grep) {

> @@ -544,6 +546,10 @@ int cmd_grep(int argc, const char **argv, const =
char *prefix)
>  			cached =3D 1;
>  			continue;
>  		}
> +		if (!strcmp("--no-external-grep", arg)) {
> +			no_external_grep =3D 1;
> +			continue;
> +		}

+		if (!strcmp("--no-external-grep", arg)) {
+			external_grep =3D 0;
+			continue;
+		}

BTW, how about a config option for this? And maybe --external-grep=3D{y=
es|no}
