From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t5801: properly test the test shell
Date: Thu, 25 Apr 2013 09:22:08 -0700
Message-ID: <7vli8660nj.fsf@alter.siamese.dyndns.org>
References: <ff7ccf22012f069ceca054d90aa0f72666cc11c2.1366884583.git.git@drmicha.warpmail.net>
	<51790C9D.8080901@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael J Gruber <git@drmicha.warpmail.net>, git@vger.kernel.org,
	Felipe Contreras <felipe.contreras@gmail.com>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Thu Apr 25 18:22:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UVOw5-0004Re-Lq
	for gcvg-git-2@plane.gmane.org; Thu, 25 Apr 2013 18:22:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758862Ab3DYQWN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Apr 2013 12:22:13 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55739 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758855Ab3DYQWM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Apr 2013 12:22:12 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A0DB6179B5;
	Thu, 25 Apr 2013 16:22:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Nmj/UmkbPPd8270Nw4TtVdivTrw=; b=FDz9D2
	0OcE+7igdL/1IIMqXo59twXNJRPskAsjcOfriCnwbDn2p4TxKD97bHDSScX3dPOv
	S3InLw9H3kpS1rFJ6DWpe7GUaTUTInQ/03NzPQpw6eGQG/vOMyxrcm1gs+odk+uZ
	TPWgfe6HCPtEIUT+carRlnQXiN+ZFAeNyNugs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=dJHDGGZkabWe3yfClP0l/mEph7vhjbMe
	vYW0ZYgt8UOvOtREb5Vga8VicmuWhbv+tcfnrJEVCnoIWXHQ9npKhZQzEaDNp48s
	jE/qBPklhhDdWxa2+Q+BbjLweEicS4mKUzB4TX3Tj4Lp9tV8ikwRks2M58Z7PQTH
	8g7cZ/YhmOc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9797A179B4;
	Thu, 25 Apr 2013 16:22:10 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CEFE3179AE;
	Thu, 25 Apr 2013 16:22:09 +0000 (UTC)
In-Reply-To: <51790C9D.8080901@viscovery.net> (Johannes Sixt's message of
	"Thu, 25 Apr 2013 12:59:41 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 47747E74-ADC4-11E2-A238-BCFF4146488D-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222389>

Johannes Sixt <j.sixt@viscovery.net> writes:

> Am 4/25/2013 12:09, schrieb Michael J Gruber:
>> fc407f9 (Add new simplified git-remote-testgit, 2012-11-28) introduced a
>> test which was meant to skip the test unless the test shell is bash.
>> Unfortunately, it tests for the availability of bash only. But users can
>> opt to use a different shell (using SHELL_PATH) for the tests even though
>> bash is available.
>
> After my patch this morning ("avoid process substitution"), there is not
> much bashism left in git-remote-testgit:

Not much, or no more?  I think the latter is a very worthy goal.

Even if it is only a test helper, we would prefer to have a portable
one.

> diff --git a/git-remote-testgit b/git-remote-testgit
> index e99d5fa..178d030 100755
> --- a/git-remote-testgit
> +++ b/git-remote-testgit
> @@ -1,4 +1,4 @@
> -#!/usr/bin/env bash
> +#!/bin/sh
>  # Copyright (c) 2012 Felipe Contreras
>  
>  alias=$1
> @@ -23,7 +23,6 @@ then
>  	testgitmarks="$dir/testgit.marks"
>  	test -e "$gitmarks" || >"$gitmarks"
>  	test -e "$testgitmarks" || >"$testgitmarks"
> -	testgitmarks_args=( "--"{import,export}"-marks=$testgitmarks" )
>  fi
>  
>  while read line
> @@ -70,7 +69,10 @@ do
>  		fi
>  
>  		echo "feature done"
> -		git fast-export "${testgitmarks_args[@]}" $refs |
> +		git fast-export \
> +			${testgitmarks:+"--import-marks=$testgitmarks"} \
> +			${testgitmarks:+"--export-marks=$testgitmarks"} \
> +			$refs |
>  		sed -e "s#refs/heads/#${prefix}/heads/#g"
>  		echo "done"
>  		;;
> @@ -89,7 +91,10 @@ do
>  
>  		before=$(git for-each-ref --format='%(refname) %(objectname)')
>  
> -		git fast-import "${testgitmarks_args[@]}" --quiet
> +		git fast-import \
> +			${testgitmarks:+"--import-marks=$testgitmarks"} \
> +			${testgitmarks:+"--export-marks=$testgitmarks"} \
> +			--quiet
>  
>  		# figure out which refs were updated
>  		git for-each-ref --format='%(refname) %(objectname)' |
>
> What's left is to take care of the shbang line, remove the bash
> check from t5801, make a proper commit from this patch. But I leave
> that to the interested reader. :-)
>
> -- Hannes
