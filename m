From: Thomas Rast <tr@thomasrast.ch>
Subject: Re: [RFH/PATCH] graph: give an extra gap after showing root commit
Date: Fri, 03 Jan 2014 21:16:03 +0100
Message-ID: <87sit4rfcs.fsf@thomasrast.ch>
References: <1382717268-21884-1-git-send-email-milton.soares.filho@gmail.com>
	<xmqqeh79jmtr.fsf@gitster.dls.corp.google.com>
	<CAPNngRMP29s9gZg9R987yRd2qJ=UuaMWnFphtQdGDRgG_SCxsQ@mail.gmail.com>
	<87mwlwn4e0.fsf@gmail.com>
	<xmqqeh75h087.fsf@gitster.dls.corp.google.com>
	<CAPNngRMprE3QwDn3y74QqitAs+-DCBm1oO33uKRHsn9jLrNSnA@mail.gmail.com>
	<xmqqsivlfg6z.fsf@gitster.dls.corp.google.com>
	<xmqqbo0be0hc.fsf_-_@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Keshav Kini <keshav.kini@gmail.com>,
	Milton Soares Filho <milton.soares.filho@gmail.com>,
	Adam Simpkins <simpkins@facebook.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 03 21:16:24 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VzBAK-0006lr-LQ
	for gcvg-git-2@plane.gmane.org; Fri, 03 Jan 2014 21:16:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753419AbaACUQQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Jan 2014 15:16:16 -0500
Received: from ip1.thgersdorf.net ([148.251.9.194]:53565 "EHLO mail.psioc.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752988AbaACUQP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Jan 2014 15:16:15 -0500
Received: from localhost (localhost [127.0.0.1])
	by localhost.psioc.net (Postfix) with ESMTP id 75F244D6594;
	Fri,  3 Jan 2014 21:16:14 +0100 (CET)
X-Virus-Scanned: amavisd-new at psioc.net
Received: from mail.psioc.net ([127.0.0.1])
	by localhost (mail.psioc.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 6M5vZQsYY7WA; Fri,  3 Jan 2014 21:16:04 +0100 (CET)
Received: from linux-1gf2.thomasrast.ch (84-73-49-17.dclient.hispeed.ch [84.73.49.17])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(Client did not present a certificate)
	by mail.psioc.net (Postfix) with ESMTPSA id 310DD4D656D;
	Fri,  3 Jan 2014 21:16:04 +0100 (CET)
In-Reply-To: <xmqqbo0be0hc.fsf_-_@gitster.dls.corp.google.com> (Junio
	C. Hamano's message of "Fri, 20 Dec 2013 12:22:39 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239936>

Hi Junio,

I briefly looked at d84a3da (jc/graph-post-root-gap) in pu, and have
this nit:

> diff --git a/t/t6016-rev-list-graph-simplify-history.sh b/t/t6016-rev-list-graph-simplify-history.sh
> [...]
> +one_independent_branch () {
> +	git checkout --orphan root$1 A1 &&
> +	test_commit root_$1 &&

The naming of root0 etc. makes the test below rather confusing to read,
because test_commit root_0 also creates a tag called root_0.  So you set
up history that has a tag root_0 that points *only* at the root, and a
branch root0 that includes two more commits.

> +test_expect_failure 'multi-root does show necessary post-root gap' '
> +	sed -e "s/ #$/ /" >expect <<-\EOF &&
> +	* further_2
> +	* then_2
> +	* root_2
> +	  * further_1
> +	  * then_1
> +	  * root_1
> +	* further_0
> +	* then_0
> +	* root_0
> +	EOF
> +	git log --graph --format=%s root0 root1 root2 >actual &&
> +	test_cmp expect actual
> +'

-- 
Thomas Rast
tr@thomasrast.ch
