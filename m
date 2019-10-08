Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 18C7E1F4BD
	for <e@80x24.org>; Tue,  8 Oct 2019 04:18:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729860AbfJHES2 (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 Oct 2019 00:18:28 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55221 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725858AbfJHES2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Oct 2019 00:18:28 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E941B2D25D;
        Tue,  8 Oct 2019 00:18:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Qhpoy3mo28RwpBTIaM/kGj86z6I=; b=gr1U2w
        mlUgASSZLgL11SwWRE5CcLsdqiXcM7z71rE0BbJBPsp0auiJ1PHGov6PY+DjWUkP
        4ra7bVFQNYdlkJXu4jn0ZizYMwGlLcq6YOBlmT6lYtaTBZ2R033VurOtLQgIZjM+
        e3awSiU+GnutAApXDf4Tpx7Obn01z2k2+fZXw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=p1H4U6ZRDwN6ZlJoq5pS1Y/NZqMQFcPl
        Jc57s6I9E+BDNUBbRb+K10dGIcj5RcSznpshwUXxRDHMg14MGpxytB4jVwiS9yCu
        ymxQRn4s/lfSxeF4lFqQe4Jw8ekNPMCQUedH4X6S7H/0yeZDcCacldb83T7Mr5Mb
        jKsaEMCRwoc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E19412D25C;
        Tue,  8 Oct 2019 00:18:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 42DFB2D25B;
        Tue,  8 Oct 2019 00:18:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Josh Steadmon <steadmon@google.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org
Subject: Re: [PATCH 0/2] add trace2 regions to fetch & push
References: <cover.1570059953.git.steadmon@google.com>
        <20191007214644.236055-1-jonathantanmy@google.com>
        <20191007223644.GA8397@google.com>
        <xmqq4l0jopu6.fsf@gitster-ct.c.googlers.com>
Date:   Tue, 08 Oct 2019 13:18:24 +0900
In-Reply-To: <xmqq4l0jopu6.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Tue, 08 Oct 2019 12:53:21 +0900")
Message-ID: <xmqqr23nna3z.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: AC0B0514-E982-11E9-836D-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Yuck.  It's already in 'next', isn't it?

Yuck, indeed.  Here is your v2 in an incremental form to be queued
on top.

Thanks.

-- >8 --
Subject: [PATCH 3/2] transport: push codepath can take arbitrary repository

The previous step added annotations with "the_repository" to various
functions in the push codepath in the transport layer, but they all
can take arbitrary repository pointer, and may be working on a
repository that is not the_repository.  Fix them.

Signed-off-by: Josh Steadmon <steadmon@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 transport.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/transport.c b/transport.c
index f313f288de..83379a037d 100644
--- a/transport.c
+++ b/transport.c
@@ -1145,10 +1145,10 @@ int transport_push(struct repository *r,
 
 		refspec_ref_prefixes(rs, &ref_prefixes);
 
-		trace2_region_enter("transport_push", "get_refs_list", the_repository);
+		trace2_region_enter("transport_push", "get_refs_list", r);
 		remote_refs = transport->vtable->get_refs_list(transport, 1,
 							       &ref_prefixes);
-		trace2_region_leave("transport_push", "get_refs_list", the_repository);
+		trace2_region_leave("transport_push", "get_refs_list", r);
 
 		argv_array_clear(&ref_prefixes);
 
@@ -1184,7 +1184,7 @@ int transport_push(struct repository *r,
 			struct ref *ref = remote_refs;
 			struct oid_array commits = OID_ARRAY_INIT;
 
-			trace2_region_enter("transport_push", "push_submodules", the_repository);
+			trace2_region_enter("transport_push", "push_submodules", r);
 			for (; ref; ref = ref->next)
 				if (!is_null_oid(&ref->new_oid))
 					oid_array_append(&commits,
@@ -1197,11 +1197,11 @@ int transport_push(struct repository *r,
 						      transport->push_options,
 						      pretend)) {
 				oid_array_clear(&commits);
-				trace2_region_leave("transport_push", "push_submodules", the_repository);
+				trace2_region_leave("transport_push", "push_submodules", r);
 				die(_("failed to push all needed submodules"));
 			}
 			oid_array_clear(&commits);
-			trace2_region_leave("transport_push", "push_submodules", the_repository);
+			trace2_region_leave("transport_push", "push_submodules", r);
 		}
 
 		if (((flags & TRANSPORT_RECURSE_SUBMODULES_CHECK) ||
@@ -1212,7 +1212,7 @@ int transport_push(struct repository *r,
 			struct string_list needs_pushing = STRING_LIST_INIT_DUP;
 			struct oid_array commits = OID_ARRAY_INIT;
 
-			trace2_region_enter("transport_push", "check_submodules", the_repository);
+			trace2_region_enter("transport_push", "check_submodules", r);
 			for (; ref; ref = ref->next)
 				if (!is_null_oid(&ref->new_oid))
 					oid_array_append(&commits,
@@ -1223,18 +1223,18 @@ int transport_push(struct repository *r,
 						     transport->remote->name,
 						     &needs_pushing)) {
 				oid_array_clear(&commits);
-				trace2_region_leave("transport_push", "check_submodules", the_repository);
+				trace2_region_leave("transport_push", "check_submodules", r);
 				die_with_unpushed_submodules(&needs_pushing);
 			}
 			string_list_clear(&needs_pushing, 0);
 			oid_array_clear(&commits);
-			trace2_region_leave("transport_push", "check_submodules", the_repository);
+			trace2_region_leave("transport_push", "check_submodules", r);
 		}
 
 		if (!(flags & TRANSPORT_RECURSE_SUBMODULES_ONLY)) {
-			trace2_region_enter("transport_push", "push_refs", the_repository);
+			trace2_region_enter("transport_push", "push_refs", r);
 			push_ret = transport->vtable->push_refs(transport, remote_refs, flags);
-			trace2_region_leave("transport_push", "push_refs", the_repository);
+			trace2_region_leave("transport_push", "push_refs", r);
 		} else
 			push_ret = 0;
 		err = push_had_errors(remote_refs);
