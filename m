Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C53F7C433DB
	for <git@archiver.kernel.org>; Fri, 15 Jan 2021 22:06:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 95D3B239EE
	for <git@archiver.kernel.org>; Fri, 15 Jan 2021 22:06:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727697AbhAOWFo (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 Jan 2021 17:05:44 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53433 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726811AbhAOWFo (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Jan 2021 17:05:44 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 95924A8256;
        Fri, 15 Jan 2021 17:04:57 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=FG2e1xqKtCog+If+FMF/uCzi9rg=; b=oMtBu6
        ev30C8exzVsz4NmIY7F5qdWwxY0U82eBlSXnMGWjjbalJ0iplxJ9LyFtovM6GgI+
        0Xoyn7cTMYLW4K0cRb1iF1+Jcs/dKRhV/UY3EjRYgLLGrcTlPOJBXrPlF8BvgcZp
        UrIvSnLQyLRYQQhZvIHLEpVEWewtYVdH54WGo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=szm4Ess0r4bx4QH0+t4rxvhs9Eh8AloZ
        bjw+V5pWTvzcignAVQ2T/0ebJNKgA5WoCIM0Eaj9Ez3ZcoeF7hXPmhk8eu+JBjCJ
        308lupLyOD2rkh5OQKWV0x/5iF+v/A1+qN8KfkrIZlSP61BskX4vC7KWIhQUvPmC
        J/OJIvhYfx4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8B699A8255;
        Fri, 15 Jan 2021 17:04:57 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 1750EA8254;
        Fri, 15 Jan 2021 17:04:57 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Phil Hord <phil.hord@gmail.com>, Git <git@vger.kernel.org>,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>
Subject: Re: [PATCH v2] use delete_refs when deleting tags or branches
References: <20190814024927.13167-1-phil.hord@gmail.com>
        <CABURp0rtkmo7MSSCVrdNXT0UzV9XqV_kXOGkC23C+_vMENNJUg@mail.gmail.com>
        <CABPp-BEUPH5Yc08uDehAXNQ5-3fJ9YeW0xscVBR45hniDe+HEg@mail.gmail.com>
Date:   Fri, 15 Jan 2021 14:04:56 -0800
In-Reply-To: <CABPp-BEUPH5Yc08uDehAXNQ5-3fJ9YeW0xscVBR45hniDe+HEg@mail.gmail.com>
        (Elijah Newren's message of "Fri, 15 Jan 2021 10:43:07 -0800")
Message-ID: <xmqqmtx9rh4n.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B439DDA4-577D-11EB-9270-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

>>>                 /* For subsequent UI messages */
>>>                 remote_branch = 1;
>>>                 allowed_interpret = INTERPRET_BRANCH_REMOTE;
>>> -
>>> +               refname_pos = 13;
>>>                 force = 1;
>>>                 break;
>>>         case FILTER_REFS_BRANCHES:
>>>                 fmt = "refs/heads/%s";
>>>                 allowed_interpret = INTERPRET_BRANCH_LOCAL;
>>> +               refname_pos = 11;
>>>                 break;

Hmph, I can tell 11 is strlen("refs/heads/") and 13 is probably for
"refs/remotes/", but can't we do better?

		switch (kinds) {
		case ...:
			fmt = "refs/remotes/%s";
			...
		}
		refname_skip_bytes = strcspn(fmt, "%");

or something like that?

I think refname_pos is a misleading variable name.  The refname is
the whole thing, so it would always be 0.  What we are looking for
is the position at which we find human readable "branch name"
begins, or, the number of bytes to skip to get there from the
beginning (the latter is where 'refname_skip_bytes' come from).

I am also OK with 'branch_name_pos'.

>>> +       delete_refs(NULL, &refs_to_delete, REF_NO_DEREF);

Earlier in a separate message, I wondered where the branches that
are not merged are rejected; it seems that the code reuses the
original code that jumps to the end of the loop and refrains from
placing such a branch to the refs_to_delete list, so from the point
of view of "correctness", the patch would not make it "all or none",
which is good.

The order in which the failures are reported will change, though.

In the original code, we got errors in the order we iterate through
the branches.  With the patch, we'll see all the "not merged and can
not delete" first from A to Z, and then "we tried to delete but this
exists after that" in a separate batch from A to Z (we won't report
for the same ref twice).  I think it probably is OK and not worth
refactoring the error reporting mechanism of check_branch_commit()
just in order to restore the order of the error messages, but I am
pointing it out just for completeness.

>>> +       for_each_string_list_item(item, &refs_to_delete) {
>>> +               char * describe_ref = item->util;
>>> +               char * name = item->string;

Style.  The asterisk sticks to the identifier, i.e.

		char *name = item->string;

>>> +               if (ref_exists(name))
>>> +                       ret = 1;
>
> Now it sets the return code if the branch still exists after trying to
> delete.  I thought that was subtly different...but I tried doing a
> branch deletion of a non-existent branch since I thought that would be
> the only difference -- however, that errors out earlier in the
> codepath before even getting to the stage of deleting refs.  So I
> think these are effectively the same.

It checks if the branch exists after it tried to delete.  A branch
may exist because delete_refs() failed to delete, or it may exist
because somebody created it anew after delete_refs() returned.  The
original reported if a deletion was successful or not by checking
the status returned by delete_ref().

We may want to introduce a variant of delete_refs() that reports
which ones it failed to delete to the caller if we really want to
report the errors properly.  I dunno.

>>> diff --git a/builtin/tag.c b/builtin/tag.c
>>> ...
>>> +static int collect_tags(const char *name, const char *ref,
>>> +                       const struct object_id *oid, void *cb_data)
>>>  {
>>> -       if (delete_ref(NULL, ref, oid, 0))
>>> -               return 1;
>
> This used to return 1 if it failed to delete a ref.
>
>>> -       printf(_("Deleted tag '%s' (was %s)\n"), name,
>>> -              find_unique_abbrev(oid, DEFAULT_ABBREV));
>>> +       struct string_list *ref_list = cb_data;
>>> +
>>> +       string_list_append(ref_list, ref);
>>> +       ref_list->items[ref_list->nr - 1].util = oiddup(oid);
>>>         return 0;
>
> Now it unconditionally returns 0.

But this is just "collect what to delete" phase, and the return
value is to be consumed by for_each_tag_name() as the callback, no?

I do not see a problem here.

>>>  }
>>>
>>> +static int delete_tags(const char **argv)
>>> +{
>>> +       int result;
>>> +       struct string_list refs_to_delete = STRING_LIST_INIT_DUP;
>>> +       struct string_list_item *item;
>>> +
>>> +       result = for_each_tag_name(argv, collect_tags, (void *)&refs_to_delete);
>>> +       delete_refs(NULL, &refs_to_delete, REF_NO_DEREF);
>
> You now only look at the result of collecting the tags, and ignore the
> result of trying to delete them...

That is a bigger problem, and is shared by the branch side, too.

I do think delete_refs() API is misdesigned in that it is not
equipped to report what happened to individual refs.  It only
says "we saw an error" when there is even a single ref that
encounters a trouble.

If we fix that, I suspect that this patch will become much simpler.

Another thing that I think is a misdesign of delete_refs() actually
can work for us here.  The list of refnames to be deleted is passed
as a "struct string_list" (which is not the most natural way to pass
bunch of strings, which is why I consider it a misdesign), and for
each ref, there is a place for the delete_refs() and its internal
helpers to store some piece of info, i.e. string_list_item.util.

Not even compile tested, but we could stuff NULL/non-NULL to the
.util member so that we can report per-ref status from the API,
perhaps like this:

diff --git i/refs/files-backend.c w/refs/files-backend.c
index 04e85e7002..bdc17f55ef 100644
--- i/refs/files-backend.c
+++ w/refs/files-backend.c
@@ -1224,8 +1224,12 @@ static int files_delete_refs(struct ref_store *ref_store, const char *msg,
 	for (i = 0; i < refnames->nr; i++) {
 		const char *refname = refnames->items[i].string;
 
-		if (refs_delete_ref(&refs->base, msg, refname, NULL, flags))
-			result |= error(_("could not remove reference %s"), refname);
+		if (!refs_delete_ref(&refs->base, msg, refname, NULL, flags)) {
+			refnames->items[i].util = NULL;
+			continue;
+		}
+		result |= error(_("could not remove reference %s"), refname);
+		refnames->items[i].util = "error";
 	}
 
 	strbuf_release(&err);
diff --git i/refs/packed-backend.c w/refs/packed-backend.c
index b912f2505f..a5b5071511 100644
--- i/refs/packed-backend.c
+++ w/refs/packed-backend.c
@@ -1541,7 +1541,10 @@ static int packed_delete_refs(struct ref_store *ref_store, const char *msg,
 					   flags, msg, &err)) {
 			warning(_("could not delete reference %s: %s"),
 				item->string, err.buf);
+			item->util = "error";
 			strbuf_reset(&err);
+		} else {
+			item->util = NULL;
 		}
 	}
 
