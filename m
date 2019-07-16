Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9521A1F461
	for <e@80x24.org>; Tue, 16 Jul 2019 20:28:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729076AbfGPU2Z (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 Jul 2019 16:28:25 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51395 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728575AbfGPU2Z (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Jul 2019 16:28:25 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2BB0316EF94;
        Tue, 16 Jul 2019 16:28:23 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=I8n9/Gk8r3BCTTEUuqZ5/EiNym0=; b=wn6Swh
        Pu9ff76aYSzCPwfqUv9HbFjAkw1yqEQ5y0VdPMqg6Gt913aBSt/JvmlrIyNtjEZs
        VayyXwhjarvp3gew6XJeN4+nU7j0K863haSHeAMCoZNwEwbpYMHVsZPU/lVIF1Nt
        RmAzwGP6dIa/+xf2mYCtCvY8WLIO0Fy1ktiWI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=EztrKkUQjzVDvLZFC3mahr5zuP4ymjKX
        Az+0+OnKxfK48Vl269iZiAeVysLVz25XF7n93XstQYG5lJNgXf4qukY/AoCrLv1M
        yp3OdCEoHbwwR4h7BCLvrp4eQUzt5tKEGwNgP8vVG8JEhcwg+M6HtR42o5IU6O80
        /185OwN+KJk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2245C16EF93;
        Tue, 16 Jul 2019 16:28:23 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 844A516EF92;
        Tue, 16 Jul 2019 16:28:22 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     Carlo Arenas <carenas@gmail.com>, git@vger.kernel.org
Subject: [PATCH] transport-helper: avoid var decl in for () loop control
References: <20190702005340.66615-1-emilyshaffer@google.com>
        <20190709211043.48597-1-emilyshaffer@google.com>
        <CAPUEspgjSAqHUP2vsCCjqG8b0QkWdgoAByh4XdqsThQMt=V38w@mail.gmail.com>
        <xmqq8ssx53a0.fsf@gitster-ct.c.googlers.com>
Date:   Tue, 16 Jul 2019 13:28:21 -0700
In-Reply-To: <xmqq8ssx53a0.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Tue, 16 Jul 2019 09:53:59 -0700")
Message-ID: <xmqq36j53esa.fsf_-_@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 419D81EA-A808-11E9-8971-46F8B7964D18-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We do allow a few selected C99 constructs in our codebase these
days, but this is not among them (yet).

Reported-by: Carlo Arenas <carenas@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 transport.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/transport.c b/transport.c
index d768bc275e..453de8f704 100644
--- a/transport.c
+++ b/transport.c
@@ -1227,7 +1227,8 @@ int transport_push(struct repository *r,
 		ret = push_ret | err;
 
 		if ((flags & TRANSPORT_PUSH_ATOMIC) && err) {
-			for (struct ref *it = remote_refs; it; it = it->next)
+			struct ref *it;
+			for (it = remote_refs; it; it = it->next)
 				switch (it->status) {
 				case REF_STATUS_NONE:
 				case REF_STATUS_UPTODATE:
