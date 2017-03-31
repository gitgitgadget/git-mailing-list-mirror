Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9F3DC1FAFB
	for <e@80x24.org>; Fri, 31 Mar 2017 19:10:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753627AbdCaTKr (ORCPT <rfc822;e@80x24.org>);
        Fri, 31 Mar 2017 15:10:47 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59317 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750707AbdCaTKq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Mar 2017 15:10:46 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9B1E97CFA5;
        Fri, 31 Mar 2017 15:10:44 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Wv37RjPMnYYjvhj03yfagvIKMMI=; b=RY8yWq
        ICm9KcD2vK3AVWAfqZt2Z3DxFLLNVHPc+JWsQshXmic5lkuwornhZbopdhXTKaeN
        j7wVVqAN8b0srqoSkBy02xjmfaxchl8RMeBtM9K56KM7thv44mSmyTTYRxbm5iaK
        hMG9OadeaoARS3PqgaffqzQy13xEtO3bUFqrA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=u0BZhQin7edVZNGYiaQgKjk/xmbZcb3+
        FqOXWhM344zws0aYXBfwJzaOthdhz93s1qXJyP9ZbG7HKqMWKJl3j3oVNlBWMuT5
        HU7Z69MchbMzkI2ySgWTaSmQLjopMSqaMMdskpA8Z7ee78SeDKMG7oEnF0gj//lj
        h4cDAolKkr0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 928857CFA4;
        Fri, 31 Mar 2017 15:10:44 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E82667CFA3;
        Fri, 31 Mar 2017 15:10:43 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Michael J Gruber <git@grubix.eu>
Cc:     git@vger.kernel.org, Lars Schneider <larsxschneider@gmail.com>,
        Luke Diamand <luke@diamand.org>
Subject: Re: [PATCH v3 3/4] name-rev: provide debug output
References: <xmqqinmq65at.fsf@gitster.mtv.corp.google.com>
        <cover.1490967948.git.git@grubix.eu>
        <21cf9d6f55d17463ab6eccdd78d57cf4a1b8e9e1.1490967948.git.git@grubix.eu>
        <xmqqtw69z8vz.fsf@gitster.mtv.corp.google.com>
        <14D0E7F4-0DC7-42ED-8DEE-B0338ECBA80D@grubix.eu>
Date:   Fri, 31 Mar 2017 12:10:42 -0700
In-Reply-To: <14D0E7F4-0DC7-42ED-8DEE-B0338ECBA80D@grubix.eu> (Michael
        J. Gruber's message of "Fri, 31 Mar 2017 20:02:57 +0200")
Message-ID: <xmqqshltxnwt.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BD1FEC06-1645-11E7-B348-97B1B46B9B0B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Michael J Gruber <git@grubix.eu> writes:

>>What problem are you solving?  
>
> Sorry, I forgot about that change and failed to mention it.
>
> It makes no difference in the non-debug case which cares about the
> Boolean only. In the debug case, I want to distinguish between
> annotated and lightweight tags, just like describe --debug
> does. By adding 1 via deref and passing this down, I know that an
> annotated tag gets the value 2, a lightweight tag 1 and everything
> else 0, just like describe --tags.

If you want to only affect debug display, perhaps you should start
with a patch like the attached, before adding any debug code as a
preparatory step.  Then add your debugging thing, _WITHOUT_ the
increment in name_rev(), that uses from_tag to choose between
lightweight and annotated as a separate step.

When we decide that it would make sense to give precedence to
annotated ones over lightweight ones in is_better_name(), the
comparison can be further tweaked to actually compare values of the
from_tag thing in *name and the current candidate.  That would have
to be a separate step, as it changes the semantics (I suspect it
would be a better change but it may not be).

How does that sound?

-- >8 --
Subject: name-rev: allow to tell annotated and lightweight tags apart

We do not use this feature yet, but from_tag that is passed around
and kept in the rev_name structure now takes three values, instead
of a boolean "did this come from refs/tags/ hierarchy?".  A new
value '2' is "this is an annotated tag that came from refs/tags/
hierarchy".

---
 builtin/name-rev.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/builtin/name-rev.c b/builtin/name-rev.c
index bf7ed015ae..fe2d306e7c 100644
--- a/builtin/name-rev.c
+++ b/builtin/name-rev.c
@@ -41,7 +41,7 @@ static int is_better_name(struct rev_name *name,
 	 * We know that at least one of them is a non-tag at this point.
 	 * favor a tag over a non-tag.
 	 */
-	if (name->from_tag != from_tag)
+	if (!!name->from_tag != !!from_tag)
 		return from_tag;
 
 	/*
@@ -247,8 +247,11 @@ static int name_ref(const char *path, const struct object_id *oid, int flags, vo
 	}
 	if (o && o->type == OBJ_COMMIT) {
 		struct commit *commit = (struct commit *)o;
-		int from_tag = starts_with(path, "refs/tags/");
-
+		int from_tag;
+		if (starts_with(path, "refs/tags/"))
+			from_tag = 1 + deref;
+		else
+			from_tag = 0;
 		if (taggerdate == ULONG_MAX)
 			taggerdate = ((struct commit *)o)->date;
 		path = name_ref_abbrev(path, can_abbreviate_output);
