From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH v2 5/7] add tests for rebasing merged history
Date: Wed, 29 May 2013 12:33:45 +0200
Message-ID: <51A5D989.90009@viscovery.net>
References: <1347949878-12578-1-git-send-email-martinvonz@gmail.com> <1369809572-24431-1-git-send-email-martinvonz@gmail.com> <1369809572-24431-6-git-send-email-martinvonz@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Chris Webb <chris@arachsys.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: Martin von Zweigbergk <martinvonz@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 29 12:33:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uhdha-0002xl-Jz
	for gcvg-git-2@plane.gmane.org; Wed, 29 May 2013 12:33:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965577Ab3E2Kdu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 May 2013 06:33:50 -0400
Received: from so.liwest.at ([212.33.55.13]:54538 "EHLO so.liwest.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965542Ab3E2Kdu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 May 2013 06:33:50 -0400
Received: from [81.10.228.254] (helo=theia.linz.viscovery)
	by so.liwest.at with esmtpa (Exim 4.77)
	(envelope-from <j.sixt@viscovery.net>)
	id 1UhdhR-0005Ha-3g; Wed, 29 May 2013 12:33:45 +0200
Received: from [192.168.1.95] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id CB6121660F;
	Wed, 29 May 2013 12:33:44 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:17.0) Gecko/20130509 Thunderbird/17.0.6
In-Reply-To: <1369809572-24431-6-git-send-email-martinvonz@gmail.com>
X-Enigmail-Version: 1.5.1
X-Spam-Score: -1.0 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225783>

Am 5/29/2013 8:39, schrieb Martin von Zweigbergk:
> +#       f
> +#      /
> +# a---b---c---g---h
> +#      \
> +#       d---G---i
> +#        \       \
> +#         e-------u
> +#
> +# uppercase = cherry-picked
> +# h = reverted g

> +test_expect_failure "rebase -p --onto in merged history does not lose patches in upstream" "
> +	reset_rebase &&
> +	git rebase -p --onto f h u &&
> +	test_cmp_rev f HEAD~3 &&
> +	test_revision_subjects 'd G i e u' HEAD~2 HEAD^2^ HEAD^2 HEAD^ HEAD
> +"

My expectations are different: When a patch is in upstream, then it is not
to be rebased, even --onto somewhere else than upstream.

But take this with a grain of salt, as I never encounter(ed) this use-case
in practice.

> +test_expect_success "rebase -p --onto in merged history drops patches in onto" "
> +	reset_rebase &&
> +	git rebase -p --onto h f u &&
> +	test_cmp_rev h HEAD~3 &&
> +	test_revision_subjects 'd i e u' HEAD~2 HEAD^2 HEAD^ HEAD
> +"

And this is just the opposite case, where I think the patch should be kept.

> +# a---b---c
> +#      \
> +#       d---e
> +#        \   \
> +#         n---r
> +#          \
> +#           o
> +#
> +# r = tree-same with n
> +# uppercace = cherry-picked

I do not see any upper-cased letters in this graph. ;)

> +test_expect_success "rebase -p re-creates empty internal merge commit" "
> +	reset_rebase &&
> +	git rebase -p c r &&
> +	test_revision_subjects 'c d e n r' HEAD~3 HEAD~2 HEAD^2 HEAD^ HEAD

Again, check c with test_cmp_rev.

-- Hannes
