From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH 4/4] t4200: avoid passing a non-newline terminated file
 to sed
Date: Thu, 07 May 2009 09:26:28 +0200
Message-ID: <4A028D24.9@viscovery.net>
References: <-ElxRhvpfY_jx1Ps8nJ42rHdrKbR03T1y96WpGK19gM@cipher.nrlssc.navy.mil> <IHOAO7NDkb8K9nkprnkd2cQW6duDZ3aYmQzpqboBi5HibQoO83nGG2Z4562gIb22HVW3ho6Z250@cipher.nrlssc.navy.mil> <IHOAO7NDkb8K9nkprnkd2TGjPUHc5N7wdnoXRYKelDZEem1S0tynQeYlVheR46_5TDmYxS1O9i4@cipher.nrlssc.navy.mil> <IHOAO7NDkb8K9nkprnkd2QibZp-GnWBSpcJ8fxO9NTUsmXbuv4_2x5S6YNLzUogav4gLkrx9ClI@cipher.nrlssc.navy.mil> <IHOAO7NDkb8K9nkprnkd2ZsdySdVG_ssYL84wqJwNHZYBqMWRKBIa_Ni6jJRHumlZvrQcXOEMhQ@cipher.nrlssc.navy.mil> <IHOAO7NDkb8K9nkprnkd2ep5vFgQr-bAuDGJW-OdtSbS6WmpSHl041GRSXpP3OcDP4_PsYKsQDU@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: pclouds@gmail.com, git@vger.kernel.org
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Thu May 07 09:26:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M1y0A-00081q-RV
	for gcvg-git-2@gmane.org; Thu, 07 May 2009 09:26:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754139AbZEGH0g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 May 2009 03:26:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754492AbZEGH0g
	(ORCPT <rfc822;git-outgoing>); Thu, 7 May 2009 03:26:36 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:62348 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751171AbZEGH0f (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 May 2009 03:26:35 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1M1xzx-0005WU-7Q; Thu, 07 May 2009 09:26:32 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.96])
	by linz.eudaptics.com (Postfix) with ESMTP
	id F3B5654D; Thu,  7 May 2009 09:26:28 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.21 (Windows/20090302)
In-Reply-To: <IHOAO7NDkb8K9nkprnkd2ep5vFgQr-bAuDGJW-OdtSbS6WmpSHl041GRSXpP3OcDP4_PsYKsQDU@cipher.nrlssc.navy.mil>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118436>

Brandon Casey schrieb:
> Some versions of sed exit non-zero if the file they are supplied is not
> newline terminated.  Solaris's /usr/xpg4/bin/sed is one such sed.  So
> rework this test to avoid doing so.
> ---
>  t/t4200-rerere.sh |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/t/t4200-rerere.sh b/t/t4200-rerere.sh
> index b68ab11..48dbd8e 100755
> --- a/t/t4200-rerere.sh
> +++ b/t/t4200-rerere.sh
> @@ -190,7 +190,7 @@ test_expect_success 'file2 added differently in two branches' '
>  	git add file2 &&
>  	git commit -m version2 &&
>  	test_must_fail git merge fourth &&
> -	sha1=$(sed -e "s/	.*//" .git/MERGE_RR) &&
> +	sha1=$({ cat .git/MERGE_RR; echo; } | sed -e "s/	.*//") &&

Couldn't that line become

	sha1=$(cat .git/MERGE_RR) &&
	sha1=%{sha1%%	*} &&

(a literal tab before the '*')?

-- Hannes
