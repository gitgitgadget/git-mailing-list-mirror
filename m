Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C29F7202A0
	for <e@80x24.org>; Fri, 27 Oct 2017 06:13:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751530AbdJ0GN5 (ORCPT <rfc822;e@80x24.org>);
        Fri, 27 Oct 2017 02:13:57 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51938 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751072AbdJ0GN4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Oct 2017 02:13:56 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6816EB1BD3;
        Fri, 27 Oct 2017 02:13:55 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Q79aH9w76ZplzxPQDIDfjnndjaw=; b=BUOCzI
        0T1cXAm+Tlg1t5mW+QS556Rj8CyltIqCjYl8R69UmfdK6qI1uXGqEL5dTBo0UlLZ
        2lwrc0VgEwYVyFji/WF9jJWYpm6OveBKecb9urHoELaUWhQEWwEzIAv8lmAPJ5jt
        gS2c1scH7/LnSpYhk4kf8bLJK8gIamYuwErqk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=guT7vK76PxzRVEiJrzfBuHn9awW6zGUH
        WmISJBoCrqYK2CwPb7d/gvQFtVoOcyYXtj0MuKgRc/kPnpBb6hkVBlxa0TNt19j6
        V9ZaB2Z5AJnI3/ozoJC1nWL/KWY8WFuhOehIQOwHO0lsPCBcmwMAEQZIt2PAIVRC
        sNqdJnAqr5I=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5FBA9B1BD1;
        Fri, 27 Oct 2017 02:13:55 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id C6D21B1BD0;
        Fri, 27 Oct 2017 02:13:54 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        git <git@vger.kernel.org>,
        Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re* Consequences of CRLF in index?
References: <D0A67AD8-2D63-4683-9F2A-20B0E8E65D4B@gmail.com>
        <20171024181415.3tvmc36aqi335v66@aiede.mtv.corp.google.com>
        <xmqq4lqoj8pe.fsf@gitster.mtv.corp.google.com>
        <xmqqshe7j0af.fsf@gitster.mtv.corp.google.com>
        <CAGZ79kbgjgOhQuK0-zF7oTvuM_gWKF25+uAf-hsHK2Xg4yshhA@mail.gmail.com>
        <xmqqy3nye9n8.fsf@gitster.mtv.corp.google.com>
Date:   Fri, 27 Oct 2017 15:13:53 +0900
In-Reply-To: <xmqqy3nye9n8.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Thu, 26 Oct 2017 14:54:51 +0900")
Message-ID: <xmqqinf1ce3i.fsf_-_@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 02B3D70E-BADE-11E7-90AB-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Stefan Beller <sbeller@google.com> writes:
>
>> (1<<5) is taken twice now.
>
> Good eyes.  I think we use bits #1-#8 now (bit #0 is vacant, so are
> #9-#31).

Let's do this bit-shuffling as a preliminary clean-up.

-- >8 --
Subject: [PATCH] xdiff: reassign xpparm_t.flags bits

We have packed the bits too tightly in such a way that it is not
easy to add a new type of whitespace ignoring option, a new type
of LCS algorithm, or a new type of post-cleanup heuristics.

Reorder bits a bit to give room for these three classes of options
to grow.

While at it, add a comment in front of the bit definitions to
clarify in which structure these defined bits may appear.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 xdiff/xdiff.h | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/xdiff/xdiff.h b/xdiff/xdiff.h
index b090ad8eac..457cac32d8 100644
--- a/xdiff/xdiff.h
+++ b/xdiff/xdiff.h
@@ -27,22 +27,24 @@
 extern "C" {
 #endif /* #ifdef __cplusplus */
 
+/* xpparm_t.flags */
+#define XDF_NEED_MINIMAL (1 << 0)
 
-#define XDF_NEED_MINIMAL (1 << 1)
 #define XDF_IGNORE_WHITESPACE (1 << 2)
 #define XDF_IGNORE_WHITESPACE_CHANGE (1 << 3)
 #define XDF_IGNORE_WHITESPACE_AT_EOL (1 << 4)
 #define XDF_WHITESPACE_FLAGS (XDF_IGNORE_WHITESPACE | XDF_IGNORE_WHITESPACE_CHANGE | XDF_IGNORE_WHITESPACE_AT_EOL)
 
-#define XDF_PATIENCE_DIFF (1 << 5)
-#define XDF_HISTOGRAM_DIFF (1 << 6)
+#define XDF_IGNORE_BLANK_LINES (1 << 7)
+
+#define XDF_PATIENCE_DIFF (1 << 14)
+#define XDF_HISTOGRAM_DIFF (1 << 15)
 #define XDF_DIFF_ALGORITHM_MASK (XDF_PATIENCE_DIFF | XDF_HISTOGRAM_DIFF)
 #define XDF_DIFF_ALG(x) ((x) & XDF_DIFF_ALGORITHM_MASK)
 
-#define XDF_IGNORE_BLANK_LINES (1 << 7)
-
-#define XDF_INDENT_HEURISTIC (1 << 8)
+#define XDF_INDENT_HEURISTIC (1 << 23)
 
+/* xdemitconf_t.flags */
 #define XDL_EMIT_FUNCNAMES (1 << 0)
 #define XDL_EMIT_FUNCCONTEXT (1 << 2)
 
-- 
2.15.0-rc2-266-g8f92d095f4

