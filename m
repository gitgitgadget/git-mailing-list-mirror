From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] filter-branch: Fix renaming a directory in the   tree-filter
Date: Mon, 31 Mar 2008 10:47:31 +0200
Message-ID: <47F0A523.80906@viscovery.net>
References: <C46D6D0D-44E1-4976-8956-1D84B6351535@yahoo.ca> <1206947655-20272-1-git-send-email-johannes.sixt@telecom.at> <1206947655-20272-2-git-send-email-johannes.sixt@telecom.at> <7v3aq7mgly.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: =?ISO-8859-1?Q?Jean-Fran=E7ois_Veillette?= 
	<jean_francois_veillette@yahoo.ca>, Git <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 31 10:48:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JgFgj-0004We-6h
	for gcvg-git-2@gmane.org; Mon, 31 Mar 2008 10:48:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753776AbYCaIrh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Mar 2008 04:47:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753589AbYCaIrh
	(ORCPT <rfc822;git-outgoing>); Mon, 31 Mar 2008 04:47:37 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:13967 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753217AbYCaIrg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Mar 2008 04:47:36 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1JgFf0-0002Ih-Lr; Mon, 31 Mar 2008 10:46:35 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id DC18C6B7; Mon, 31 Mar 2008 10:47:31 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <7v3aq7mgly.fsf@gitster.siamese.dyndns.org>
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78572>

Junio C Hamano schrieb:
> For example, if you make it the invariant that $T contains the tree that
> matches the contents of the "$tempdir/t" work tree left in the previous
> round of filter-tree (and obviously you would want to do this only
> filter_tree is in effect), the "checkout-index + clean" would become a
> proper "branch switching".
> 
> This is obviously untested, and you would need to prime $T with an empty
> tree before entering the loop (but you could cheat by initializing T with
> an empty string), but it might make the code a bit more readable than the
> current mess.  I dunno.
> 
> 	if [ "$filter_tree" ]; then
> -		git checkout-index -f -u -a ||
> -			die "Could not checkout the index"
> -		# files that $commit removed are now still in the working tree;
> -		# remove them, else they would be added again
> -		git clean -d -q -f -x
> +		git read-tree -m -u $T $commit
> 		eval "$filter_tree" < /dev/null ||
> 			die "tree filter failed: $filter_tree"
> 
> -		(
> -			git diff-index -r --name-only $commit
> -			git ls-files --others
> -		) |
> -		git update-index --add --replace --remove --stdin
> +		git add -u && git add . && T=$(git write-tree)
> 	fi

Yes. But, ... uhm ..., I'm not that deep into these plumbings; I leave it
to Dscho to comment on this.

-- Hannes
