Return-Path: <SRS0=W4Po=BO=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57D59C433DF
	for <git@archiver.kernel.org>; Tue,  4 Aug 2020 23:49:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3577B2177B
	for <git@archiver.kernel.org>; Tue,  4 Aug 2020 23:49:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Hn1Y1WKK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727782AbgHDXtn (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Aug 2020 19:49:43 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:56303 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727055AbgHDXtm (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Aug 2020 19:49:42 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id F3FE5DEB0B;
        Tue,  4 Aug 2020 19:49:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=VrciGvou7z5L5WgI71k0YGqhvA8=; b=Hn1Y1W
        KKlFBQuPMJzmu01grIRGPovcLyiE0OoTCl8SuBJaD4s8C6VHWsiCFxJ4NNioaa32
        LwyHDHqtFPR5dzEB6MzK4PRwYRNQI44uZT0UPn6ZcQQRFq7YZBPy+JOuczw7mlHH
        n42em6FfjMvSegMIHKCiekwASZgH/fn4tgWo8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=mCcxXiEqMmg7oMeIfneRTliRxV31bRR8
        fAeZPx1SPC1sRXko06P9+kM5JtgN2mkok0z02wSQ8a5/Px+2pdiQbfs1IgakCSVZ
        I5glWaN48nvx8Jt2hZZ4i65QOY4L3FhsxvyQ1kMZH6IAH1e0am/PGzx8v1sxlkZF
        nAJSaxauZbQ=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id ECAC6DEB0A;
        Tue,  4 Aug 2020 19:49:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 3C330DEB09;
        Tue,  4 Aug 2020 19:49:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Raymond E. Pasco" <ray@ameretat.dev>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2] apply: allow "new file" patches on i-t-a entries
References: <xmqqlfiuryym.fsf@gitster.c.googlers.com>
        <20200804223155.7727-1-ray@ameretat.dev>
Date:   Tue, 04 Aug 2020 16:49:36 -0700
In-Reply-To: <20200804223155.7727-1-ray@ameretat.dev> (Raymond E. Pasco's
        message of "Tue, 4 Aug 2020 18:31:55 -0400")
Message-ID: <xmqqeeomq8dr.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2855649E-D6AD-11EA-9953-843F439F7C89-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Raymond E. Pasco" <ray@ameretat.dev> writes:

> diff-files recently changed to treat "intent to add" entries as new file
> diffs rather than diffs from the empty blob. However, apply refuses to
> apply new file diffs on top of existing index entries, except in the
> case of renames. This causes "git add -p", which uses apply, to fail
> when attempting to stage hunks from a file when intent to add has been
> recorded.

As this is supposed to be a "bugfix", there shouldn't be any need to
update documentation (otherwise, we are either fixing documentation
in addition to the bug, or we are changing the documented behaviour
in the name of bugfix---which we need to be very careful to see if
we are not breaking existing users).  But we do need to document
what behaviour we want with tests, which will also serve as a way to
protect the current behaviour from future bugs.

So I started writing the attached, but I have strong doubts about
the updated behaviour.

 - The first one (setup).  We create a sample file and keep it as
   the master copy, and express our intention to add test-file with
   its contents sometime in the future.  And then we take a patch
   out of the index.  We make sure that the produced patch is a
   creation patch.

   This should be straight-forward and uncontroversial.


 - The second one.  We make sure that we have i-t-a and not real
   entry for test-file in the index.  We try to apply the patch we
   took in the first test to (and only to) the index.  This must
   succeed, thanks to your fix---the i-t-a entry in the index should
   not prevent "new file mode 100644" from created at test-file.  We
   make sure what is in the index matches the master copy.

   This should be straight-forward and uncontroversial.


 - The third one.  We do the same set-up as the previous one, but in
   addition, we remove the working tree copy before attempting to
   apply the patch both to the index and to the working tree.  That
   way, "when creating a new file, it must not exist yet" rule on
   the working tree side would not trigger.

   This I find troublesome.  The real use case you had trouble with
   (i.e. "git add -p") would not remove any working tree files
   before attempting to apply any patch, I would imagine.  Are we
   expecting the right behaviour with this test?  I cannot tell.  

   It feels like it is even pointless to allow i-t-a entry to exist
   in the index for the path, if we MUST remove the path from the
   working tree anyway, to be able to apply.


 - The fourth one.  If we have test-file on the working tree, "when
   creating a new file, it must not exist yet" rule on the working
   tree side should trigger and prevent the operation.  I think this
   is a reasonable expectation.


What I am wondering primarily is if we should actually FAIL the
third one.  The patch tries to create a path, for which there is an
i-t-a entry in the index.  But a path with i-t-a entry in the index
means the user at least must have had a file on the working tree to
register that intent-to-add the path.  Removed working tree file
would then mean that the path _has_ a local modification, so "git
apply --index" should *not* succeed for the usual reasons of having
differences between the index and the working tree.

And without your "fix" to apply.c, "git apply" in the the third test
fails, so we may need a bit more work to make sure it keeps failing.

I dunno.  It almost feels that this approach to fix "git add -p"
might be barking up a wrong tree.  After all, the user, by having an
i-t-a entry for the path in the index, expressed the desire to add
real contents later to the path, so being able to use "git apply"
with either "--cached" or "--index" options to clobber the path with
a creation patch feels wrong _unless_ the user then rescinded the
previous intent to add to the path (with "git rm --cached" or an
equivalent).

How exactly does "git add -p" fail for such a patch?  What operation
does it exactly want to do ("apply --cached"???) and is it "apply"
that is wrong, or is it "git add -p" that fails to remove the i-t-a
entry from the index before running "git apply" that is at fault?

Thanks.

 apply.c              | 11 +++++++----
 t/t4140-apply-ita.sh | 51 +++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 58 insertions(+), 4 deletions(-)

diff --git a/apply.c b/apply.c
index 8bff604dbe..4cba4ce71a 100644
--- a/apply.c
+++ b/apply.c
@@ -3747,10 +3747,13 @@ static int check_to_create(struct apply_state *state,
 {
 	struct stat nst;
 
-	if (state->check_index &&
-	    index_name_pos(state->repo->index, new_name, strlen(new_name)) >= 0 &&
-	    !ok_if_exists)
-		return EXISTS_IN_INDEX;
+	if (state->check_index && !ok_if_exists) {
+		int pos = index_name_pos(state->repo->index, new_name, strlen(new_name));
+		if (pos >= 0 &&
+		    !(state->repo->index->cache[pos]->ce_flags & CE_INTENT_TO_ADD))
+			return EXISTS_IN_INDEX;
+	}
+
 	if (state->cached)
 		return 0;
 
diff --git a/t/t4140-apply-ita.sh b/t/t4140-apply-ita.sh
new file mode 100755
index 0000000000..e9f3749e65
--- /dev/null
+++ b/t/t4140-apply-ita.sh
@@ -0,0 +1,51 @@
+#!/bin/sh
+#
+# Copyright 2020 Google LLC
+#
+
+test_description='git apply of i-t-a file'
+
+. ./test-lib.sh
+
+test_expect_success setup '
+	test_write_lines 1 2 3 4 5 >blueprint &&
+
+	cat blueprint >test-file &&
+	git add -N test-file &&
+	git diff >creation-patch &&
+	grep "new file mode 100644" creation-patch
+'
+
+test_expect_success 'apply creation patch to ita path (--cached)' '
+	git rm -f test-file &&
+	cat blueprint >test-file &&
+	git add -N test-file &&
+
+	git apply --cached creation-patch &&
+	git cat-file blob :test-file >actual &&
+	test_cmp blueprint actual
+'
+
+test_expect_success 'apply creation patch to ita path (--index)' '
+	git rm -f test-file &&
+	cat blueprint >test-file &&
+	git add -N test-file &&
+	rm -f test-file &&
+
+	# NEEDSWORK: this should fail as test-file does not
+	# agree between index and the working tree, no?????
+	git apply --index creation-patch &&
+	git cat-file blob :test-file >actual &&
+	test_cmp blueprint actual &&
+	test_cmp blueprint test-file
+'
+
+test_expect_success 'apply creation patch to ita path (--index)' '
+	git rm -f test-file &&
+	cat blueprint >test-file &&
+	git add -N test-file &&
+
+	test_must_fail git apply --index creation-patch
+'
+
+test_done
