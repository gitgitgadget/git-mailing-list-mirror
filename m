Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D9E6C1F71B
	for <e@80x24.org>; Tue,  2 Aug 2016 18:10:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754999AbcHBSJ7 (ORCPT <rfc822;e@80x24.org>);
	Tue, 2 Aug 2016 14:09:59 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63973 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1030461AbcHBSJv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Aug 2016 14:09:51 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E3BDB33260;
	Tue,  2 Aug 2016 14:04:07 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=rwYPvV2VWF8RyS+s/BgY0Y5XpwQ=; b=hzHmbu
	n9JbLvFfCXd3K7KyxNSt42YQR280KGUMq+SImDcn/YAk6nYa1m8sNTLtLeaCitSb
	xx4sJ3/LoU5MIDWiaUfmKTrwOQ5INkQ6KmaJopJnqAyOD0fy5SwevfdZlX7YPleM
	eLhEI+WX8bY+9kY5HwYFnfl26Ess0oVL2f8rk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ciuQlBnG+Zv3jdp+fYmv2IR1A5BW/jW2
	fQRcLP7kSuRjBs+/p3zAgJ9Na9LRRMKIR6XMF1+bhC1Z/EoZq8TvK0/K9MOai0jE
	wuVawIg9EABnpy4dnaUFAoH0JZt4fG+09MEyD/K6IooMG/f/SLgkHkiuHOT/yAV+
	ELbs7nc+5wo=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id DBA0E3325F;
	Tue,  2 Aug 2016 14:04:07 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 62DD63325E;
	Tue,  2 Aug 2016 14:04:07 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:	Kevin Willford <kcwillford@gmail.com>, git@vger.kernel.org,
	Kevin Willford <kewillf@microsoft.com>
Subject: Re: [[PATCH v2] 1/4] patch-ids: stop using a hand-rolled hashmap implementation
References: <20160729161920.3792-1-kcwillford@gmail.com>
	<20160729161920.3792-2-kcwillford@gmail.com>
	<xmqqoa5gmas6.fsf@gitster.mtv.corp.google.com>
	<alpine.DEB.2.20.1607301056120.11824@virtualbox>
	<xmqqy44gi7bp.fsf@gitster.mtv.corp.google.com>
	<alpine.DEB.2.20.1608021013010.79248@virtualbox>
	<xmqqshunf6lm.fsf@gitster.mtv.corp.google.com>
Date:	Tue, 02 Aug 2016 11:04:05 -0700
In-Reply-To: <xmqqshunf6lm.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Tue, 02 Aug 2016 10:01:09 -0700")
Message-ID: <xmqqtwf3dp4a.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 81719F1A-58DB-11E6-B265-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
>> Oh, we are already safely in Unrelated Tangent Land for a while, I would
>> think. Nothing of what we are discussing in this thread has anything to do
>> with Kevin's patch series,...
>
> Oh, no question about that.  Go back to my review, to which your
> message I am responding to is a reply to.  What you wrote are all
> about things after "This is a tangent, but this made me wonder if it
> is safe to simply free(3) the result...", which pointed out rough
> points in the hashmap API from the API user's point of view and
> suggested a few possible improvement opportunities.

In other words, I'd be happy with a patch like this, outside the
scope of and independent from this series.

When the hashmap_entry structure does acquire references to external
resources (which I wouldn't judge the likelihood of), this paragraph
will become stale, but that is exactly the point at which _clear()
function needs to be added to the API and described here, replacing
this paragraph.

I do not mind having an empty _clear() before that happens, but I do
not think it adds much safety.  A disciplined user of the API may
call that empty _clear() to make her code future-proof, but we know
there are undisciplined developers and reviewers and there will be
codepaths that call _init() without calling the empty _clear(), and
we won't notice it.  Whoever is adding the real need for _clear()
must audit the codebase at that point _anyway_, and that is why I
think having an empty _clear() before would not buy us much.

 Documentation/technical/api-hashmap.txt | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/technical/api-hashmap.txt b/Documentation/technical/api-hashmap.txt
index ad7a5bd..1dcec3d 100644
--- a/Documentation/technical/api-hashmap.txt
+++ b/Documentation/technical/api-hashmap.txt
@@ -104,6 +104,11 @@ If `free_entries` is true, each hashmap_entry in the map is freed as well
 `entry` points to the entry to initialize.
 +
 `hash` is the hash code of the entry.
++
+The hashmap_entry structure does not hold references to external resources,
+and it is safe to just discard it once you are done with it (i.e. if
+your structure was allocated with xmalloc(), you can just free(3) it,
+and if it is on stack, you can just let it go out of scope).
 
 `void *hashmap_get(const struct hashmap *map, const void *key, const void *keydata)`::
 
