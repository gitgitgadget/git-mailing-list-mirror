Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 65BC120229
	for <e@80x24.org>; Fri, 21 Oct 2016 22:39:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935495AbcJUWji (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Oct 2016 18:39:38 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59752 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S935125AbcJUWjg (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Oct 2016 18:39:36 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4028D48603;
        Fri, 21 Oct 2016 18:39:30 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:in-reply-to:references; s=sasl; bh=q6tV
        95VJuMMHvlJZHxYJfCy2WgQ=; b=Ea5wMO4BYMic3rF8EMnjOo3zF8qic5nruzII
        /MplaHLtUG4O7IYTgSdcr6kF9cqS1kgvnuC3BD4V8i0deyvxohVRoAoY3L3QnVR3
        kOqMlyyOmIZUd3EuPY/4t2L+9jLol+Tj83rOhZ5/mGxHrrcKq38kN0LbAOTrUMVu
        03Jvh54=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
        :date:message-id:in-reply-to:references; q=dns; s=sasl; b=nLz2J0
        d9dWVSMHG4xXAAHcose4915m7D0Dz4OQR/86laeclG//FjX1FhkZIZs3Z+nHfFWH
        V/6Z90RpygzcZB79huRefjPmYoyIgsZ84zDIhE7dukIhFraK80SB0J8S/IB0FZ/B
        1CrHFFoKn0c3/WMs+rZDWOQcHpX9/LnH3kmfc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3766A48602;
        Fri, 21 Oct 2016 18:39:30 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id AB0E648601;
        Fri, 21 Oct 2016 18:39:29 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: [PATCH 0/3] fetch output is ugly in 'next'
Date:   Fri, 21 Oct 2016 15:39:24 -0700
Message-Id: <20161021223927.26364-1-gitster@pobox.com>
X-Mailer: git-send-email 2.10.1-723-g2384e83bc3
In-Reply-To: <xmqqa8dxbb9r.fsf@gitster.mtv.corp.google.com>
References: <xmqqa8dxbb9r.fsf@gitster.mtv.corp.google.com>
X-Pobox-Relay-ID: 3A8C2DB6-97DF-11E6-9A48-3AB77A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It turns out that there are three codepaths, all of which have a set
of refs that they want to show them using TRANSPORT_SUMMARY_WIDTH
constant.  The two preparatory steps turn the constant used at the
leaf level into a parameter that is passed down through these
callchains, and the last step introduces a helper function that can
be used to compute the appropriate width to be fed to these
callchains.

Junio C Hamano (3):
  transport: pass summary_width down the callchain
  fetch: pass summary_width down the callchain
  transport: allow summary-width to be computed dynamically

 builtin/fetch.c | 37 +++++++++++++++++--------------
 transport.c     | 68 ++++++++++++++++++++++++++++++++++++---------------------
 transport.h     |  2 +-
 3 files changed, 65 insertions(+), 42 deletions(-)

-- 
2.10.1-723-g2384e83bc3

