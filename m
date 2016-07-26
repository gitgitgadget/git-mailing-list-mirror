Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E77B6203E3
	for <e@80x24.org>; Tue, 26 Jul 2016 19:59:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753714AbcGZT7J (ORCPT <rfc822;e@80x24.org>);
	Tue, 26 Jul 2016 15:59:09 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:65389 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752782AbcGZT7I (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jul 2016 15:59:08 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 6519E2F347;
	Tue, 26 Jul 2016 15:59:07 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=+JB9DO15JudTLArJfcCRBo1Jd3Q=; b=wYm0N5
	I1fGVeaGytbVd24ollM9P2zGhvf0eLCcrAxzykVjw+TDXB7Esrn1GaOcIlzw+NUa
	2Ahb/HgqMui/W0epQl0LLvrdU+VK9+BrQUOcR7WDffDR13UkPaQS6c99lug4I0hN
	sBP4qxH7+CX/3yX+rtZH4PQDdmBSboLHlRvOk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Bq/e3+mLBxMoHlV5gHIvo7DhYb6X5tlw
	W9POfm3EJ3AyTkqP/pgRaPXRBAqi8BQm//HKzhfEHovRn706ePjtsuQgmZvxky3P
	mJizG9lpoP/Dv1mx8U0y1vIsARD662eo7xxhGIqxMzKZrDz3bENU0IEbuPWgaGU3
	jRxRh15Y2TU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 5DAAA2F346;
	Tue, 26 Jul 2016 15:59:07 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id DE91E2F345;
	Tue, 26 Jul 2016 15:59:06 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	John Keeping <john@keeping.me.uk>
Cc:	git@vger.kernel.org
Subject: Re: [PATCH v2 2/3] push: add shorthand for --force-with-lease branch creation
References: <cover.1469483499.git.john@keeping.me.uk>
	<4e07ff23715b53fcd29564be1c74a9f66dd74e1e.1469483499.git.john@keeping.me.uk>
	<xmqqpoq12w93.fsf@gitster.mtv.corp.google.com>
	<20160726080309.pr46bbtzdvnr7fd3@john.keeping.me.uk>
Date:	Tue, 26 Jul 2016 12:59:04 -0700
In-Reply-To: <20160726080309.pr46bbtzdvnr7fd3@john.keeping.me.uk> (John
	Keeping's message of "Tue, 26 Jul 2016 09:03:09 +0100")
Message-ID: <xmqqwpk8yxvb.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 68FA37FA-536B-11E6-88B6-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

John Keeping <john@keeping.me.uk> writes:

>> > @@ -2294,6 +2294,8 @@ int parse_push_cas_option(struct push_cas_option *cas, const char *arg, int unse
>> >  	entry = add_cas_entry(cas, arg, colon - arg);
>> >  	if (!*colon)
>> >  		entry->use_tracking = 1;
>> > +	else if (!colon[1])
>> > +		memset(entry->expect, 0, sizeof(entry->expect));
>> 
>> hashclr()?
>
> Yes (and in the following patch as well).  I hadn't realised that
> function exists.

Thanks; I've locally tweaked these two patches; the interdiff looks
like this.

 remote.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/remote.c b/remote.c
index e8b7bac..7eaf3c8 100644
--- a/remote.c
+++ b/remote.c
@@ -2304,7 +2304,7 @@ int parse_push_cas_option(struct push_cas_option *cas, const char *arg, int unse
 	if (!*colon)
 		entry->use_tracking = 1;
 	else if (!colon[1])
-		memset(entry->expect, 0, sizeof(entry->expect));
+		hashclr(entry->expect);
 	else if (get_sha1(colon + 1, entry->expect))
 		return error("cannot parse expected object name '%s'", colon + 1);
 	return 0;
@@ -2354,7 +2354,7 @@ static void apply_cas(struct push_cas_option *cas,
 		if (!entry->use_tracking)
 			hashcpy(ref->old_oid_expect.hash, cas->entry[i].expect);
 		else if (remote_tracking(remote, ref->name, &ref->old_oid_expect))
-			memset(&ref->old_oid_expect, 0, sizeof(ref->old_oid_expect));
+			hashclr(ref->old_oid_expect.hash);
 		return;
 	}
 
@@ -2364,7 +2364,7 @@ static void apply_cas(struct push_cas_option *cas,
 
 	ref->expect_old_sha1 = 1;
 	if (remote_tracking(remote, ref->name, &ref->old_oid_expect))
-		memset(&ref->old_oid_expect, 0, sizeof(ref->old_oid_expect));
+		hashclr(ref->old_oid_expect.hash);
 }
 
 void apply_push_cas(struct push_cas_option *cas,
