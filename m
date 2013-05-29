From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH v2 2/7] add tests for rebasing with patch-equivalence
 present
Date: Wed, 29 May 2013 09:09:06 +0200
Message-ID: <51A5A992.306@viscovery.net>
References: <1347949878-12578-1-git-send-email-martinvonz@gmail.com> <1369809572-24431-1-git-send-email-martinvonz@gmail.com> <1369809572-24431-3-git-send-email-martinvonz@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Chris Webb <chris@arachsys.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: Martin von Zweigbergk <martinvonz@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 29 09:09:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UhaVZ-0001f7-M9
	for gcvg-git-2@plane.gmane.org; Wed, 29 May 2013 09:09:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934167Ab3E2HJN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 May 2013 03:09:13 -0400
Received: from so.liwest.at ([212.33.55.13]:56121 "EHLO so.liwest.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759485Ab3E2HJM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 May 2013 03:09:12 -0400
Received: from [81.10.228.254] (helo=theia.linz.viscovery)
	by so.liwest.at with esmtpa (Exim 4.77)
	(envelope-from <j.sixt@viscovery.net>)
	id 1UhaVP-00067W-8o; Wed, 29 May 2013 09:09:07 +0200
Received: from [192.168.1.95] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 0307B1660F;
	Wed, 29 May 2013 09:09:06 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:17.0) Gecko/20130509 Thunderbird/17.0.6
In-Reply-To: <1369809572-24431-3-git-send-email-martinvonz@gmail.com>
X-Enigmail-Version: 1.5.1
X-Spam-Score: -1.0 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225764>

Am 5/29/2013 8:39, schrieb Martin von Zweigbergk:
> +#       f
> +#      /
> +# a---b---c---g---h
> +#      \
> +#       d---G---i
...
> +test_run_rebase () {
> +	result=$1
> +	shift
> +	test_expect_$result "rebase $* --onto drops patches in onto" "
> +		reset_rebase &&
> +		git rebase $* --onto h f i &&
> +		test_cmp_rev h HEAD~2 &&
> +		test_linear_range 'd i' h..

Isn't this expectation wrong? The upstream of the rebased branch is f, and
it does not contain G. Hence, G should be replayed. Since h is the
reversal of g, the state at h is the same as at c, and applying G should
succeed (it is the same change as g). Therefore, I think the correct
expectation is:

		test_linear_range 'd G i' h..

> +	"
> +}
> +test_run_rebase failure ''
> +test_run_rebase failure -m
> +test_run_rebase failure -i
> +test_run_rebase failure -p

-- Hannes
