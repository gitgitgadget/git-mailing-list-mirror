Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DF2D6202A0
	for <e@80x24.org>; Mon, 30 Oct 2017 00:40:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751673AbdJ3Akt (ORCPT <rfc822;e@80x24.org>);
        Sun, 29 Oct 2017 20:40:49 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59341 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751310AbdJ3Aks (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 29 Oct 2017 20:40:48 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id CE47FBAD45;
        Sun, 29 Oct 2017 20:40:47 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Zq82Kq6sJjlNLdyil+kxzSjRXXM=; b=sUwppP
        wBAFJ0qo3U6M/B+wxtJ2H/XJ8x6zKdK4P+qSk4pw5yMQhvwYGz/EdhzYGhGQ2Fdd
        NgMghIwmRlZSgF155lpqQSoZnxb203TXzO6Se4uB5J9L18VAI8kaaxHQ4cdKDd3h
        zpVjTe+TO0afiAK+sF0YYcBrFmKemmOCdqz+Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=WjEEQLdTkM41mgSd4BxAAOgs6msOg9ce
        NDHiIhOqQYz5e0HU1V2KpE8cVXCZ3/t/oEgHvAJTDWNXWJDBSjb/VL8YkmqnPrl4
        xy/OLRVlaZxyyu3rFt4rGIYk7zPn0hI/ZgsLW/IBlownDQbmfuHxPBzEp+lpZX+g
        PozLT9qGDHg=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C62E5BAD44;
        Sun, 29 Oct 2017 20:40:47 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 34A7EBAD43;
        Sun, 29 Oct 2017 20:40:47 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Stefan Beller <sbeller@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Brandon Williams <bmwill@google.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>,
        Bryan Turner <bturner@atlassian.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jeff King <peff@peff.net>, William Yan <wyan@google.com>
Subject: Re: [PATCH 3/5] ssh: 'auto' variant to select between 'ssh' and 'simple'
References: <20170926235627.79606-1-bmwill@google.com>
        <20171003201507.3589-1-bmwill@google.com>
        <20171003201507.3589-11-bmwill@google.com>
        <20171003214206.GY19555@aiede.mtv.corp.google.com>
        <20171016171812.GA4487@google.com>
        <20171023212740.qodxzsq5w7rn2r6y@aiede.mtv.corp.google.com>
        <20171023213159.eitrjrqrh277advm@aiede.mtv.corp.google.com>
        <alpine.DEB.2.21.1.1710251437090.6482@virtualbox>
        <CAGZ79kYTYg09A7UbhvyiT0QmRQG5ZJV6v1iaQBNCZY8RTj300A@mail.gmail.com>
        <20171025163243.xmm7szrkwgblpgcc@aiede.mtv.corp.google.com>
Date:   Mon, 30 Oct 2017 09:40:46 +0900
In-Reply-To: <20171025163243.xmm7szrkwgblpgcc@aiede.mtv.corp.google.com>
        (Jonathan Nieder's message of "Wed, 25 Oct 2017 09:32:43 -0700")
Message-ID: <xmqqo9op8o35.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F86855F2-BD0A-11E7-BAE2-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder <jrnieder@gmail.com> writes:

> I have other changes to make when rerolling anyway (from Junio's
> review), so no need for a followup patch.  Will fix this in the
> reroll today.
>
> Thanks for catching and diagnosing this, Dscho!

In the meantime, I've queued this from Dscho; please take it into
consideration when you reroll.

Thanks.

-- >8 --
From: Johannes Schindelin <johannes.schindelin@gmx.de>
Date: Sun, 29 Oct 2017 16:12:46 +0100
Subject: [PATCH] fixup! ssh: 'auto' variant to select between 'ssh' and 'simple'

This is needed because on Windows, if `uplink.exe` exists, the MSYS2
Bash will overwrite that when redirecting via `>uplink`.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t5601-clone.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/t/t5601-clone.sh b/t/t5601-clone.sh
index f9a2ae84c7..534eb21915 100755
--- a/t/t5601-clone.sh
+++ b/t/t5601-clone.sh
@@ -391,6 +391,7 @@ test_expect_success 'simple does not support port' '
 
 test_expect_success 'uplink is treated as simple' '
 	copy_ssh_wrapper_as "$TRASH_DIRECTORY/uplink" &&
+	test_when_finished "rm \"$TRASH_DIRECTORY/uplink$X\"" &&
 	test_must_fail git clone "[myhost:123]:src" ssh-bracket-clone-uplink &&
 	git clone "myhost:src" ssh-clone-uplink &&
 	expect_ssh myhost src
-- 
2.15.0-rc2-267-g7d3ed0014a

