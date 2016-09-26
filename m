Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 32C64207EC
	for <e@80x24.org>; Mon, 26 Sep 2016 21:56:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1034361AbcIZV4O (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Sep 2016 17:56:14 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51359 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S965529AbcIZV4N (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Sep 2016 17:56:13 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id DAFC142A44;
        Mon, 26 Sep 2016 17:56:11 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=vSXemKVLcJYJ50ii0mtJcTlHFMY=; b=dgc4hn
        Pdt4Q45dPZrH3VMWzRgfhCKoD6eCWN2zVv5GGqcgqTAgg+t2A6zPfv+g4jnN9hhR
        ivSeFGBw62ThkSbpchnS6SaHbpTi+nNYjNRoDZrAai6nNg7sHbV8pObmVIuOEPyB
        ngv5ZNctGHyhoL8JBOzbSsOLooCcxONhdsbo8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=w5nhWOMOzFz/HnZiAKoxufOKqQoPySAp
        eEfR/GsXYn51XNYyXI038bcaxAxamcJboTg9365OuDCA0fn3ZjEX8TmaAIkIluFZ
        0hKzvWBNw5GxjHKH9BRGhSSeGR4y6K3xU7G0T7wVPf1ZOksfKXDDIcF6I6b1cgf9
        803u0aa2sE4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D087B42A43;
        Mon, 26 Sep 2016 17:56:11 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id F0EE442A3F;
        Mon, 26 Sep 2016 17:56:03 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Vegard Nossum <vegard.nossum@oracle.com>
Cc:     git@vger.kernel.org,
        Santi =?utf-8?Q?B=C3=A9jar?= <sbejar@gmail.com>,
        Kevin Bracey <kevin@bracey.fi>,
        Philip Oakley <philipoakley@iee.org>,
        Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>
Subject: Re: [RFC PATCH v4] revision: new rev^-n shorthand for rev^n..rev
References: <20160926204959.26007-1-vegard.nossum@oracle.com>
        <xmqqr386pd7d.fsf@gitster.mtv.corp.google.com>
Date:   Mon, 26 Sep 2016 14:55:45 -0700
In-Reply-To: <xmqqr386pd7d.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Mon, 26 Sep 2016 14:23:50 -0700")
Message-ID: <xmqqh992pbq6.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 062C4CF4-8434-11E6-8972-C26412518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Micronit.  When splitting "for (init; fini; cont)" into multiple
> lines, it is often easier to read to make that into three lines:
>
> 	for (parent_number = 1, parents = commit->parents;
> 	     parents;
> 	     parents = parents->next, parent_number++) {
>
>> +		if (exclude_parent && parent_number != exclude_parent)
>> +			continue;
>> +
>> +		show_rev(include_parents ? NORMAL : REVERSED,
>> +			 parents->item->object.oid.hash, arg);
>> +	}
>
> It is very clear to see what is going on.  Good job.
>
>>  	*dotdot = '^';
>> +	if (exclude_parent >= parent_number)
>> +		return 0;
>
> This is not quite nice.  You've already called show_rev() number of
> times, and it is too late to signal an error here.  I think you
> would need to count the number of parents much earlier when
> exclude_parent option is in effect and error out before making any
> call to show_rev().
> ...
> Likewise.  It is way too late to say "Nah, this wasn't a valid rev^-
> notation after all" to the caller after calling add_rev_cmdline()
> and add_pending_object() in the above loop.

Taking these two together, perhaps squashing this in may be
sufficient.

Please do not use --no-prefix when sending a patch to this list, by
the way.

 builtin/rev-parse.c | 18 +++++++++++++++---
 revision.c          | 17 ++++++++++++++++-
 2 files changed, 31 insertions(+), 4 deletions(-)

diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
index 2c3da19..9474c37 100644
--- a/builtin/rev-parse.c
+++ b/builtin/rev-parse.c
@@ -333,8 +333,22 @@ static int try_parent_shorthands(const char *arg)
 	if (include_rev)
 		show_rev(NORMAL, sha1, arg);
 	commit = lookup_commit_reference(sha1);
+
+	if (exclude_parent) {
+		/* do we have enough parents? */
+		for (parent_number = 0, parents = commit->parents;
+		     parents;
+		     parents = parents->next)
+			parent_number++;
+		if (parent_number < exclude_parent) {
+			*dotdot = '^';
+			return 0;
+		}
+	}
+
 	for (parent_number = 1, parents = commit->parents;
-	     parents; parents = parents->next, parent_number++) {
+	     parents;
+	     parents = parents->next, parent_number++) {
 		if (exclude_parent && parent_number != exclude_parent)
 			continue;
 
@@ -343,8 +357,6 @@ static int try_parent_shorthands(const char *arg)
 	}
 
 	*dotdot = '^';
-	if (exclude_parent >= parent_number)
-		return 0;
 	return 1;
 }
 
diff --git a/revision.c b/revision.c
index 511e1ed..09da7f4 100644
--- a/revision.c
+++ b/revision.c
@@ -1318,8 +1318,23 @@ static int add_parents_only(struct rev_info *revs, const char *arg_, int flags,
 	if (it->type != OBJ_COMMIT)
 		return 0;
 	commit = (struct commit *)it;
+
+	if (exclude_parent) {
+		struct commit_list *parents;
+		int parent_number;
+
+		/* do we have enough parents? */
+		for (parent_number = 0, parents = commit->parents;
+		     parents;
+		     parents = parents->next)
+			parent_number++;
+		if (parent_number < exclude_parent)
+			return 0;
+	}
+
 	for (parent_number = 1, parents = commit->parents;
-	     parents; parents = parents->next, parent_number++) {
+	     parents;
+	     parents = parents->next, parent_number++) {
 		if (exclude_parent && parent_number != exclude_parent)
 			continue;
 
