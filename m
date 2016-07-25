Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD,URIBL_RED shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 60D17203E2
	for <e@80x24.org>; Mon, 25 Jul 2016 17:42:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753247AbcGYRmO (ORCPT <rfc822;e@80x24.org>);
	Mon, 25 Jul 2016 13:42:14 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58988 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753090AbcGYRmM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jul 2016 13:42:12 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id B85C42D402;
	Mon, 25 Jul 2016 13:42:11 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=MySkgLhWSghRnHVJZ9Md23op7vs=; b=jcukjg
	EcVsCT/DdOEJ7mPTYcsvWbi74qOAcr/HJ/8ber2FFcfc18YszDJNPLv7Neqz09A/
	5H36VSoOjh59CZ3Ib1d8U2YHNZ9hm6RxjPbz0J/REXQjyFKZbuZsd+ZGXkPJiAZY
	5efH0o+Qn2J5W2D3wHVGxEcsZDITaSK2pwvOA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=W1MChqEHdZxMqkVo7iKX12QTiv8q0x4N
	7Uk0mqn0AP6xdm113gHhLeh6AnecJmfYhWZeXkx0aielWM/W4zI3IUtG4b39Oy/P
	CUBnVV+xWXNzRMPXV3UEbDoLMG3nk5GgbqUKaOlgELrwhkw0JNVbtKETTKTDUj30
	JcCEI51gq1o=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id AE7FA2D401;
	Mon, 25 Jul 2016 13:42:11 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 3BCF32D3FF;
	Mon, 25 Jul 2016 13:42:11 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Eric Wong <e@80x24.org>
Cc:	git@vger.kernel.org, Clemens Buchacher <drizzd@aon.at>,
	Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH 2/2] git svn: migrate tests to use lib-httpd
References: <20160723042608.27489-1-e@80x24.org>
	<20160723042608.27489-3-e@80x24.org>
Date:	Mon, 25 Jul 2016 10:42:09 -0700
In-Reply-To: <20160723042608.27489-3-e@80x24.org> (Eric Wong's message of
	"Sat, 23 Jul 2016 04:26:08 +0000")
Message-ID: <xmqqvazt62dq.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1DA5C8DC-528F-11E6-9ACC-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Eric Wong <e@80x24.org> writes:

> This allows us to use common test infrastructure and parallelize
> the tests.  For now, GIT_SVN_TEST_HTTPD=true needs to be set to
> enable the SVN HTTP tests because we reuse the same test cases
> for both file:// and http:// SVN repositories.  SVN_HTTPD_PORT
> is no longer honored.
>
> Tested under Apache 2.2 and 2.4 on Debian 7.x (wheezy) and
> 8.x (jessie), respectively.
>
> Cc: Clemens Buchacher <drizzd@aon.at>
> Cc: Michael J Gruber <git@drmicha.warpmail.net>
> Signed-off-by: Eric Wong <e@80x24.org>
> ---
>  t/lib-git-svn.sh                              | 91 +++++----------------------
>  t/lib-httpd.sh                                |  8 ++-
>  t/lib-httpd/apache.conf                       |  4 +-
>  t/t9115-git-svn-dcommit-funky-renames.sh      |  7 ++-
>  t/t9118-git-svn-funky-branch-names.sh         |  2 +-
>  t/t9120-git-svn-clone-with-percent-escapes.sh |  2 +-
>  t/t9142-git-svn-shallow-clone.sh              |  2 +-
>  7 files changed, 30 insertions(+), 86 deletions(-)

Nice code reduction ;-)

