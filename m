From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH 01/37] t3030: Add a testcase for resolvable rename/add
 conflict with symlinks
Date: Mon, 20 Sep 2010 11:15:22 +0200
Message-ID: <4C97262A.9030501@viscovery.net>
References: <1284971350-30590-1-git-send-email-newren@gmail.com> <1284971350-30590-2-git-send-email-newren@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Schalk, Ken" <ken.schalk@intel.com>
To: Elijah Newren <newren@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 20 11:15:39 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OxcTE-0000Mc-UU
	for gcvg-git-2@lo.gmane.org; Mon, 20 Sep 2010 11:15:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756045Ab0ITJP1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Sep 2010 05:15:27 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:23324 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752719Ab0ITJP1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Sep 2010 05:15:27 -0400
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1OxcT4-00088b-VF; Mon, 20 Sep 2010 11:15:23 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 989EC1660F;
	Mon, 20 Sep 2010 11:15:22 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.1.12) Gecko/20100914 Thunderbird/3.0.8
In-Reply-To: <1284971350-30590-2-git-send-email-newren@gmail.com>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156602>

Am 9/20/2010 10:28, schrieb Elijah Newren:
> @@ -255,7 +259,16 @@ test_expect_success 'setup 8' '
>  	git mv a e &&
>  	git add e &&
>  	test_tick &&
> -	git commit -m "rename a->e"
> +	git commit -m "rename a->e" &&
> +	if test_have_prereq SYMLINKS
> +	then
> +		git checkout rename-ln &&
> +		git mv a e &&
> +		ln -s e a &&
> +		git add a e &&
> +		test_tick &&
> +		git commit -m "rename a->e, symlink a->e"
> +	fi
>  '

You don't need the SYMLINKS prerequisite anywhere. Write this without ln -s:

	git commit -m "rename a->e" &&
	git checkout rename-ln &&
	git mv a e &&
	sha1e=$(printf e | git hash-object -w --stdin) &&
	git update-index --add --cacheinfo 120000 $sha1e a &&
	test_tick &&
	git commit -m "rename a->e, symlink a->e"

and the new test case passes even when SYMLINKS are not available!

-- Hannes
