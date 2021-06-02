Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF60AC47080
	for <git@archiver.kernel.org>; Wed,  2 Jun 2021 01:16:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B01B66102A
	for <git@archiver.kernel.org>; Wed,  2 Jun 2021 01:16:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229849AbhFBBR7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Jun 2021 21:17:59 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:57472 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229687AbhFBBR7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Jun 2021 21:17:59 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id D4E1A140B1A;
        Tue,  1 Jun 2021 21:16:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=R3eqxCyB02ocLAs2KMtmropLfcj4AljyQKrNJt
        80BdM=; b=AaKRAsoIq/OHIHoba2zwTIyzSf0GAQvA1iyRIf6zpEsusKjo+PGTXW
        cl9i3EDr1GDnV5L377qkz9LaOkFoBGbMBrQZu34yIM7iab6tfmyFILK1CW7xk7ul
        HE/NdE+MIOnVulj+9WS26Bhr4dXtVfsL4Bsd8p9i2wFGWEgy5sM5w=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id CBFB6140B19;
        Tue,  1 Jun 2021 21:16:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.73.10.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 1EDC8140B18;
        Tue,  1 Jun 2021 21:16:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
        Brandon Williams <bwilliams.eng@gmail.com>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Subject: Re: [PATCH v2 00/13] push: revamp push.default
References: <20210531193237.216726-1-felipe.contreras@gmail.com>
        <20210531195124.218325-1-felipe.contreras@gmail.com>
Date:   Wed, 02 Jun 2021 10:16:12 +0900
In-Reply-To: <20210531195124.218325-1-felipe.contreras@gmail.com> (Felipe
        Contreras's message of "Mon, 31 May 2021 14:51:11 -0500")
Message-ID: <xmqqr1hlqd5v.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1FA907C6-C340-11EB-BCFB-FA9E2DDBB1FC-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Felipe Contreras <felipe.contreras@gmail.com> writes:

> The end result is almost identical to v1, only the way we get there
> changes (plus there's an extra cosmetic break).

Good.  The endpoint matches exactly to what was queued, with the
SQUASH??? fix for the "break" thing, which is necessary to make
"make sparse" happy (so it is not just "cosmetic").

IOW, this series allows us to drop the following.

commit c1964311c404afaadffd57d14d769a4051281c2b
Author: Junio C Hamano <gitster@pobox.com>
Date:   Mon May 31 12:41:06 2021 +0900

    SQUASH??? fix compilation breakage
    
    make sparse found these:
    
    builtin/push.c:221:9: error: Expected ; at end of statement
    builtin/push.c:221:9: error: got }

diff --git a/builtin/push.c b/builtin/push.c
index f1ac531252..e8b10a9b7e 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -218,6 +218,7 @@ static void setup_default_push_refspecs(struct remote *remote)
 		    "push.default is \"nothing\"."));
 		return;
 	default:
+		break;
 	}
 
 	branch = branch_get(NULL);
