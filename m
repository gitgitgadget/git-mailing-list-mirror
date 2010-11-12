From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v4 1/3] fetch/pull: Add the --recurse-submodules option
Date: Fri, 12 Nov 2010 13:54:53 -0600
Message-ID: <20101112195453.GA25248@burratino>
References: <4CDB3063.5010801@web.de>
 <20101111000538.GB14189@burratino>
 <4CDD391C.2000905@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	Kevin Ballard <kevin@sb.org>,
	Jon Seymour <jon.seymour@gmail.com>,
	Chris Packham <judge.packham@gmail.com>,
	Marc Branchaud <marcnarc@xiplink.com>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Fri Nov 12 20:55:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PGzid-0003Wk-Qh
	for gcvg-git-2@lo.gmane.org; Fri, 12 Nov 2010 20:55:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932197Ab0KLTz1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Nov 2010 14:55:27 -0500
Received: from mail-wy0-f174.google.com ([74.125.82.174]:34596 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751558Ab0KLTz0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Nov 2010 14:55:26 -0500
Received: by wyb28 with SMTP id 28so2279106wyb.19
        for <git@vger.kernel.org>; Fri, 12 Nov 2010 11:55:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=M1WFRYGvpWdgE/TTC3JiXDskeT0WaS4iPgXpYBsUESg=;
        b=G+hKTMBkYINQre9K++FpKyrPb+LUMAJSLh68m8dcRQDCVUTBVrPqxnvLqzNHaNusUX
         1VxAI3rGGHiOhS/Y+i8avzL5MlUtmGVbflzaM0XlA2uM7WYBqkNbbyBM4y2ceoKbUcrF
         Wx4t9J+ID2gUfR4h2ggf3R4dPMHMQhwoK9bo8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=Ladnrdn/lt/LA0ZhiEZexIxFBaRNVsdhucvzldJIcYow43wuM2iOwsEe1ihIm4Y5/q
         6RKk2GxUWuOkcPgfrC264NQjkJgKlmgaDtbTdzlv1wtQCJQ+jny6vEezEaAQfePEJlgW
         +xKe0aBayW4xFt/2ZOMU4GUFCgOuwDZTS7HhU=
Received: by 10.216.56.65 with SMTP id l43mr3754930wec.113.1289591724175;
        Fri, 12 Nov 2010 11:55:24 -0800 (PST)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.ameritech.net [68.255.106.176])
        by mx.google.com with ESMTPS id l14sm2369845weq.35.2010.11.12.11.55.21
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 12 Nov 2010 11:55:22 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <4CDD391C.2000905@web.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161358>

Jens Lehmann wrote:

> Ok, here is the updated version of patch 1/3 making "--submodule-prefix" a
> hidden option which is not documented in Documentation/fetch-options.txt .

Oh, I missed that you were proposing leaving it undocumented.  On one hand,
it is nice when debugging if all options are documented; but on the other
hand, there is precedent in --rebasing for hiding implementation details
like this.  Unlike -h output, the manual is not so space-constrainted, so...

> --- /dev/null
> +++ b/t/t5526-fetch-submodules.sh
> @@ -0,0 +1,109 @@
> +#!/bin/sh
> +# Copyright (c) 2010, Jens Lehmann
> +
> +test_description='Recursive "git fetch" for submodules'
> +
> +. ./test-lib.sh
> +
> +pwd=$(pwd)
> +
> +add_upstream_commit() {
> +	(
> +		cd submodule &&
> +		head1=$(git rev-parse --short HEAD) &&
> +		echo new >> subfile &&
> +		test_tick &&
> +		git add subfile &&
> +		git commit -m new subfile &&
> +		head2=$(git rev-parse --short HEAD) &&
> +		echo "From $pwd/submodule" > ../expect.err &&
> +		echo "   $head1..$head2  master     -> origin/master" >> ../expect.err
> +	)
> +	(

Missing &&?

Hope that helps.  These are just tiny nitpicks; I am happy with the patch
with or without them.

diff --git a/Documentation/fetch-options.txt b/Documentation/fetch-options.txt
index 594f7ce..a9cb8ab 100644
--- a/Documentation/fetch-options.txt
+++ b/Documentation/fetch-options.txt
@@ -67,6 +67,13 @@ endif::git-pull[]
 --recurse-submodules::
 	Use this option to fetch new commits of all populated submodules too.
 
+ifndef::git-pull[]
+--submodule-prefix=<path>::
+	Prepend <path> to paths printed in informative messages
+	such as "Fetching submodule foo".  This option is used
+	internally when recursing over submodules.
+endif::git-pull[]
+
 -u::
 --update-head-ok::
 	By default 'git fetch' refuses to update the head which
diff --git a/t/t5526-fetch-submodules.sh b/t/t5526-fetch-submodules.sh
index 107317a..9c1d3a0 100755
--- a/t/t5526-fetch-submodules.sh
+++ b/t/t5526-fetch-submodules.sh
@@ -18,7 +18,7 @@ add_upstream_commit() {
 		head2=$(git rev-parse --short HEAD) &&
 		echo "From $pwd/submodule" > ../expect.err &&
 		echo "   $head1..$head2  master     -> origin/master" >> ../expect.err
-	)
+	) &&
 	(
 		cd deepsubmodule &&
 		head1=$(git rev-parse --short HEAD) &&
