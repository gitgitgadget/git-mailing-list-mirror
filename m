From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH] cherry-pick/revert: transparently refresh index
Date: Wed, 3 Nov 2010 21:33:23 +0100
Message-ID: <201011032133.23448.j6t@kdbg.org>
References: <20101031174430.GA30236@arf.padd.com> <201011010909.15198.j6t@kdbg.org> <7v4obyxqkb.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Jonathan Nieder <jrnieder@gmail.com>, Pete Wyckoff <pw@padd.com>,
	git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 03 21:33:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PDk1W-0008ES-AV
	for gcvg-git-2@lo.gmane.org; Wed, 03 Nov 2010 21:33:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755936Ab0KCUd3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Nov 2010 16:33:29 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:29641 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753985Ab0KCUd1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Nov 2010 16:33:27 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id CC41F10018;
	Wed,  3 Nov 2010 21:33:23 +0100 (CET)
Received: from localhost (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id 8B33A19F5C8;
	Wed,  3 Nov 2010 21:33:23 +0100 (CET)
User-Agent: KMail/1.9.10
In-Reply-To: <7v4obyxqkb.fsf@alter.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160638>

On Mittwoch, 3. November 2010, Junio C Hamano wrote:
> Johannes Sixt <j6t@kdbg.org> writes:
> > On Windows, this doesn't test what it should test because we do not look
> > at the inode number (currently). Please use test-chmtime to change stat
> > information.
>
> Like this, perhaps?
>
> diff --git a/t/t3501-revert-cherry-pick.sh b/t/t3501-revert-cherry-pick.sh
> index b210188..a5b963a 100755
> --- a/t/t3501-revert-cherry-pick.sh
> +++ b/t/t3501-revert-cherry-pick.sh
> @@ -81,15 +81,12 @@ test_expect_success 'revert after renaming branch' '
>
>  '
>
> -test_expect_success 'revert on stat-dirty working tree' '
> -	git clone . repo &&
> -	(
> -		cd repo &&
> -		git checkout initial
> -	) &&
> -	cp -R repo copy &&
> +test_expect_success 'cherry-pick on stat-dirty working tree' '
> +	git clone . copy
>  	(
>  		cd copy &&
> +		git checkout initial &&
> +		test-chmtime +40 oops &&
>  		git cherry-pick added
>  	)
>  '

Yes, makes sense.

-- Hannes
