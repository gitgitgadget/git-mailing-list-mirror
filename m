Return-Path: <SRS0=QcP8=4I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C796C11D0C
	for <git@archiver.kernel.org>; Thu, 20 Feb 2020 17:34:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6EF22467A
	for <git@archiver.kernel.org>; Thu, 20 Feb 2020 17:34:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Z3X+1W2A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728409AbgBTRep (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Feb 2020 12:34:45 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56737 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728173AbgBTReo (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Feb 2020 12:34:44 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 73D4E4FA93;
        Thu, 20 Feb 2020 12:34:38 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=u0zs00bp/hAPIfTzeQMyoTv/Z/E=; b=Z3X+1W
        2A3S8mhXQFJqajlPD8LQd9HWTmRjtYhglL2l852eNgL6rn125ltCzkc18dwDp1tr
        yiaKBvIX+Vk53Y8NKr+F7HRWY8GtRegTSrf4CQ+8OCMKyQKyFxsI9b4UpIJB8eur
        62Ldd3xyer5dcJwY39Q5Mtmh2F55iZml3ENWg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=u24iSurUcgujnRGatPTLIsxHMJUGYpL6
        Jt445N615IaB0QpdwlbS6hQDtMbfCVc2mQ1lGAS4w3eieE/w0oB02GZwv2kLnDFx
        RJ8n9eiI6IbRazzePQIQoM8jr1ddToGzyQ228nyT9Vmugj1xAD2Uwx59frksoWuV
        EAIQeJgXMbg=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6BD664FA92;
        Thu, 20 Feb 2020 12:34:38 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id CD0244FA91;
        Thu, 20 Feb 2020 12:34:37 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Matheus Tavares <matheus.bernardino@usp.br>, git@vger.kernel.org,
        rhi@pengutronix.de
Subject: Re: [PATCH] describe: output tag's ref instead of embedded name
References: <fcf19a46b80322c5579142efe4ec681a4dcbdd28.1581802264.git.matheus.bernardino@usp.br>
        <20200216065101.GA2937208@coredump.intra.peff.net>
        <xmqqd0abk7zc.fsf@gitster-ct.c.googlers.com>
        <20200218195402.GA21586@coredump.intra.peff.net>
        <xmqq4kvnijim.fsf@gitster-ct.c.googlers.com>
        <xmqqzhdfh3vr.fsf@gitster-ct.c.googlers.com>
        <20200219015733.GA81560@coredump.intra.peff.net>
        <xmqqr1yrgt2d.fsf@gitster-ct.c.googlers.com>
        <20200219035650.GA84414@coredump.intra.peff.net>
        <xmqqftf6hlrt.fsf@gitster-ct.c.googlers.com>
        <20200220112539.GB1252160@coredump.intra.peff.net>
Date:   Thu, 20 Feb 2020 09:34:36 -0800
In-Reply-To: <20200220112539.GB1252160@coredump.intra.peff.net> (Jeff King's
        message of "Thu, 20 Feb 2020 06:25:39 -0500")
Message-ID: <xmqq4kvlcgcz.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 447AA59A-5407-11EA-951A-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Wed, Feb 19, 2020 at 03:14:14AM -0800, Junio C Hamano wrote:
>
>> To continue playing devil's advocate and to step back a bit,
>> 
>>  - The "git describe" command finds that the given commit is
>>    "closest" to that tag Bob called "v1.0".
>> 
>>  - But if it outputs "v1.0" like the current code does, it cannot be
>>    fed back to get_oid() to name the right object, if the given commit
>>    is "at" the tag (i.e. there is no "-$number-g$objectname" suffix),
>>    which is a problem.  We want "git describe" to give an output
>>    usable with get_oid() and the name must refer to the correct
>>    object (i.e. the one given to "git describe" as an input).
>> 
>> There are multiple approaches to make it possible to feed the output
>> back to get_oid() to obtain correct result:
>> [...]
>
> Thanks for clearly laying out your thinking. All of what you wrote makes
> sense to me and I'd be OK with any of the options you described.
>
> The "-g$objectname" one is kind of clever, and definitely not something
> I had thought of. We already have "--long", and of course we'd show the
> long version for any name that isn't an exact match anyway. So as an
> added bonus, it seems unlikely to surprise anybody who is expecting the
> current "show the tag, not the refname" output (though again, this is
> rare enough that I think people simply expect them to be the same ;) ).

There is one thing you may have brought up in the discussion but I
did not touch.  Using v1.0-0-g0123456, based on tagname "v1.0" Bob
gave to it would still describe the right object, but if the user
forced "--no-long", it becomes unclear what we should do.

Saying "v1.0" like the current code does would re-introduce the
"output cannot be fed back to get_oid()" when refs/tags/v1.0 does
not exist, and when it does, get_oid() would yield a wrong object.

Another thing that is not satisfying is what should happen in "all"
mode.  We add "tags/" prefix so in the case we've been discussing,
the output would be "tags/v1.0-0-g0123456", but the whole reason why
we add the prefix is to say that the early part of the name, "v1.0",
is a tag, and it would be natural to associate it with refs/tags/v1.0
that is *not* Bob's tag.

Having said all that, here is what I have at this moment.

-- >8 --
Subject: describe: force long format for a name based on a mislocated tag

An annotated tag has two names: where it sits in the refs/tags
hierarchy and the tagname recorded in the "tag" field in the object
itself.  They usually should match.

Since 212945d4 ("Teach git-describe to verify annotated tag names
before output", 2008-02-28), a commit described using an annotated
tag bases its name on the tagname from the object.  While this was a
deliberate design decision to make it easier to converse about tags
with others, even if the tags happen to be fetched to a different
name than it was given by its creator, it had one downside.

The output from "git describe", at least in the modern Git, should
be usable as an object name to name the exact commit given to the
"git describe" command.  Using the tagname, when two names differ,
breaks this property, when describing a commit that is directly
pointed at by such a tag.  An annotated tag Bob made as "v1.0" may
sit at "refs/tags/v1.0-bob" in the ref hierarchy, and output from
"git describe v1.0-bob^0" would say "v1.0", but there may not be
any tag at "refs/tags/v1.0" locally or there may be another tag that
points at a different object.  

Note that this won't be a problem if a commit being described is not
directly pointed at by such a mislocated tag.  In the example in the
previous paragraph, "git describe v1.0-bob~1" would result in "v1.0"
(i.e. the tagname taken from the tag object) followed by "-1-gXXXXX"
where XXXXX is the abbreviated object name, and a string that ends
with "-g" followed by a hexadecimal string is an object name for the
object whose name begins with hexadecimal string (as long as it is
unique), so it does not matter if the leading part is "v1.0" or
"v1.0-bob".

Show the name in the long format, i.e. with "-0-gXXXXX" suffix, when
the name we give is based on a mislocated annotated tag to ensure
that the output can be used as the object name for the object
originally given to the command to fix the issue.

While at it, remove an overly cautious dead code to protect against
an annotated tag object without the tagname.  Such a tag is filtered
out much earlier in the codeflow, and will not reach this part of
the code.

Helped-by: Matheus Tavares <matheus.bernardino@usp.br>
Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/describe.c  | 13 ++++++++-----
 t/t6120-describe.sh | 10 +++++++++-
 2 files changed, 17 insertions(+), 6 deletions(-)

diff --git a/builtin/describe.c b/builtin/describe.c
index b6df81d8d0..5e8484f654 100644
--- a/builtin/describe.c
+++ b/builtin/describe.c
@@ -54,6 +54,7 @@ struct commit_name {
 	struct tag *tag;
 	unsigned prio:2; /* annotated tag = 2, tag = 1, head = 0 */
 	unsigned name_checked:1;
+	unsigned misnamed:1;
 	struct object_id oid;
 	char *path;
 };
@@ -132,6 +133,7 @@ static void add_to_known_names(const char *path,
 		e->tag = tag;
 		e->prio = prio;
 		e->name_checked = 0;
+		e->misnamed = 0;
 		oidcpy(&e->oid, oid);
 		free(e->path);
 		e->path = xstrdup(path);
@@ -275,10 +277,11 @@ static void append_name(struct commit_name *n, struct strbuf *dst)
 			die(_("annotated tag %s not available"), n->path);
 	}
 	if (n->tag && !n->name_checked) {
-		if (!n->tag->tag)
-			die(_("annotated tag %s has no embedded name"), n->path);
-		if (strcmp(n->tag->tag, all ? n->path + 5 : n->path))
-			warning(_("tag '%s' is really '%s' here"), n->tag->tag, n->path);
+		if (strcmp(n->tag->tag, all ? n->path + 5 : n->path)) {
+			warning(_("tag '%s' is externally known as '%s'"),
+				n->path, n->tag->tag);
+			n->misnamed = 1;
+		}
 		n->name_checked = 1;
 	}
 
@@ -314,7 +317,7 @@ static void describe_commit(struct object_id *oid, struct strbuf *dst)
 		 * Exact match to an existing ref.
 		 */
 		append_name(n, dst);
-		if (longformat)
+		if (n->misnamed || longformat)
 			append_suffix(0, n->tag ? get_tagged_oid(n->tag) : oid, dst);
 		if (suffix)
 			strbuf_addstr(dst, suffix);
diff --git a/t/t6120-describe.sh b/t/t6120-describe.sh
index 45047d0a72..16a261c45d 100755
--- a/t/t6120-describe.sh
+++ b/t/t6120-describe.sh
@@ -130,12 +130,20 @@ test_expect_success 'rename tag A to Q locally' '
 	mv .git/refs/tags/A .git/refs/tags/Q
 '
 cat - >err.expect <<EOF
-warning: tag 'A' is really 'Q' here
+warning: tag 'Q' is externally known as 'A'
 EOF
 check_describe A-* HEAD
 test_expect_success 'warning was displayed for Q' '
 	test_i18ncmp err.expect err.actual
 '
+test_expect_success 'misnamed annotated tag forces long output' '
+	description=$(git describe --no-long Q^0) &&
+	expr "$description" : "A-0-g[0-9a-f]*$" &&
+	git rev-parse --verify "$description" >actual &&
+	git rev-parse --verify Q^0 >expect &&
+	test_cmp expect actual
+'
+
 test_expect_success 'rename tag Q back to A' '
 	mv .git/refs/tags/Q .git/refs/tags/A
 '

