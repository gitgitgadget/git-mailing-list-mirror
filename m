Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 948EE2018E
	for <e@80x24.org>; Wed, 24 Aug 2016 15:50:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755504AbcHXPuw (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Aug 2016 11:50:52 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60822 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754639AbcHXPuv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Aug 2016 11:50:51 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1808D34B23;
        Wed, 24 Aug 2016 11:48:05 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=wb31qo070FWztwUwDm7lHfyYnU8=; b=drdekd
        l3MFDXoxlZxMz3s2X7gXCQqxVxdzU1YwpE4ylb7HySnxQHNFHBkJ1/AWyKC/QNBw
        orrqVa4s88MN9ZMCLlkuIcGOACOUILzgdDxYI+6cw/g68GHp2hyxdizmn+x/zoiH
        SYaxgf8/HD01TYuuMzVp6rSyfMIqRmNoEkg1A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Z7tg5a/WF72AJNSP3iWy5AvLgRpywE+w
        /uhTRv0MhSUAd7/8yQAZrpfU4Dql4iUaOs2yrh+eAafY1HEYdF2Pf59k1G0atKNi
        ckeqd6YCOgCWS+mMbPkx7lxGLeS5LbjcINmeCpcBEZnee1nidjejs2v5OAnPJlwl
        5jLosq8wO1w=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0D74E34B21;
        Wed, 24 Aug 2016 11:48:05 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 8FAB334B1E;
        Wed, 24 Aug 2016 11:48:04 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jean-Noel Avila <jn.avila@free.fr>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 3/3] i18n: simplify numeric error reporting
References: <xmqqy43rxqqz.fsf@gitster.mtv.corp.google.com>
        <20160821145039.12121-1-jn.avila@free.fr>
        <20160821145039.12121-3-jn.avila@free.fr>
Date:   Wed, 24 Aug 2016 08:48:02 -0700
In-Reply-To: <20160821145039.12121-3-jn.avila@free.fr> (Jean-Noel Avila's
        message of "Sun, 21 Aug 2016 16:50:39 +0200")
Message-ID: <xmqqoa4irwwd.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 251D2D68-6A12-11E6-A639-FCB17B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I'll squash this in to avoid compilation breakage.  We do not allow
decl-after-stmt.

Thanks.

 config.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/config.c b/config.c
index e33c703..0dfed68 100644
--- a/config.c
+++ b/config.c
@@ -652,10 +652,11 @@ int git_parse_ulong(const char *value, unsigned long *ret)
 NORETURN
 static void die_bad_number(const char *name, const char *value)
 {
+	const char * error_type = (errno == ERANGE)? _("out of range"):_("invalid unit");
+
 	if (!value)
 		value = "";
 
-	const char * error_type = (errno == ERANGE)? _("out of range"):_("invalid unit");
 	if (!(cf && cf->name))
 		die(_("bad numeric config value '%s' for '%s': %s"),
 		    value, name, error_type);
