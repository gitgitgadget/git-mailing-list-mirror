From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH v2 5/7] add tests for rebasing merged history
Date: Wed, 29 May 2013 09:57:21 +0200
Message-ID: <51A5B4E1.3070205@viscovery.net>
References: <1347949878-12578-1-git-send-email-martinvonz@gmail.com> <1369809572-24431-1-git-send-email-martinvonz@gmail.com> <1369809572-24431-6-git-send-email-martinvonz@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Chris Webb <chris@arachsys.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: Martin von Zweigbergk <martinvonz@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 29 09:57:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UhbGE-0008Lp-QT
	for gcvg-git-2@plane.gmane.org; Wed, 29 May 2013 09:57:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965004Ab3E2H51 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 May 2013 03:57:27 -0400
Received: from so.liwest.at ([212.33.55.13]:33875 "EHLO so.liwest.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964850Ab3E2H50 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 May 2013 03:57:26 -0400
Received: from [81.10.228.254] (helo=theia.linz.viscovery)
	by so.liwest.at with esmtpa (Exim 4.77)
	(envelope-from <j.sixt@viscovery.net>)
	id 1UhbG6-0000v2-G0; Wed, 29 May 2013 09:57:22 +0200
Received: from [192.168.1.95] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 40F471660F;
	Wed, 29 May 2013 09:57:22 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:17.0) Gecko/20130509 Thunderbird/17.0.6
In-Reply-To: <1369809572-24431-6-git-send-email-martinvonz@gmail.com>
X-Enigmail-Version: 1.5.1
X-Spam-Score: -1.0 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225771>

Am 5/29/2013 8:39, schrieb Martin von Zweigbergk:
> +# a---b-----------c
> +#      \           \
> +#       d-------e   \
> +#        \       \   \
> +#         n---o---w---v
> +#              \
> +#               z

> +#TODO: make all flavors of rebase use --topo-order
> +test_run_rebase success 'e n o' ''
> +test_run_rebase success 'e n o' -m
> +test_run_rebase success 'n o e' -i

As test_commit offers predictable timestamps, I think you can work around
this discrepancy by generating commits n and o before e. (That is not a
solution--just a workaround that depends on the current
implementation--because the order in which parents of a merge are listed
is unspecified.)

> +test_expect_success "rebase -p re-creates internal merge" "
> +	reset_rebase &&
> +	git rebase -p c w &&
> +	test_revision_subjects 'c d n e o w' HEAD~4 HEAD~3 HEAD~2 HEAD^2 HEAD^ HEAD

Shouldn't this better be

	test_cmp_rev c HEAD~4 &&
	test_revision_subjects 'd n e o w' HEAD~3 HEAD~2 HEAD^2 HEAD^ HEAD

to ensure that c is not a rewritten commit?

> +"
> +
> +test_expect_success "rebase -p can re-create two branches on onto" "
> +	reset_rebase &&
> +	git rebase -p --onto c d w &&
> +	test_revision_subjects 'c n e o w' HEAD~3 HEAD~2 HEAD^2 HEAD^ HEAD
> +"

Same here.

Time is fleeting. I have to stop here.

-- Hannes
