Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21FCAC38A2D
	for <git@archiver.kernel.org>; Tue, 25 Oct 2022 04:31:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230078AbiJYEa5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Oct 2022 00:30:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230516AbiJYEav (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Oct 2022 00:30:51 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F4B53C8DA
        for <git@vger.kernel.org>; Mon, 24 Oct 2022 21:30:42 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id BE9EF143AC6;
        Tue, 25 Oct 2022 00:30:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=rtHor4j5qLXvH9fto0sTQsvtFQltVOkVFuBr5Y
        +nKno=; b=OZb4MB13BhgWDHsExJeU6JZq0r7OCIYT6ifPgLDa9uz6oBVZqUi0va
        91USob23DJsdwwvhkUPMP8LH2kw5e/BJd8MMfbM+R9EXxX/sLzlfQv1vF6BN5T3q
        k6TeGeoudw7FzwbihCrC5xEbLVlX0fnpGCFmKPbITmUofzHK2RNzE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B5BA9143AC4;
        Tue, 25 Oct 2022 00:30:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 30514143AC3;
        Tue, 25 Oct 2022 00:30:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, John Cai <johncai86@gmail.com>
Subject: Re: [PATCH v2 0/2] Document fsck msg ids
References: <pull.1369.git.git.1666623639.gitgitgadget@gmail.com>
        <pull.1369.v2.git.git.1666667864.gitgitgadget@gmail.com>
Date:   Mon, 24 Oct 2022 21:30:38 -0700
In-Reply-To: <pull.1369.v2.git.git.1666667864.gitgitgadget@gmail.com> (John
        Cai via GitGitGadget's message of "Tue, 25 Oct 2022 03:17:42 +0000")
Message-ID: <xmqqwn8oplsh.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C741F8FC-541D-11ED-9BCF-307A8E0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"John Cai via GitGitGadget" <gitgitgadget@gmail.com> writes:

> Patch [1/2] removes an unused msg-id BAD_TAG_OBJECT Patch [2/2] adds a
> fsck-msgids.txt that lists msg-ids that fsck checks for
>
> Since v1:
>
>  * provided a full list of error messages along with corresponding default
>    severity
>  * no longer including the whole list in git-config
>  * add a comment in fsck.h to remind developers to keep the documentation
>    accurate when making changes to the list of error messages

Thanks.  I did a bit of sanity checking and it made my earlier
suspicion stronger.  We MUST have at least an automated checker to
check the doc against the fsck.h header, if not an automated
generator of the doc from the fsck.h header.

 * Just like your [1/2] pointed out an error type that is no longer
   in use, MISSING_TREE_OBJECT is not used.  It seems that this was
   never used since it was introduced at 159e7b08 (fsck: detect
   gitmodules files, 2018-05-02)

 * A few items were misspelled.

 * A handful items were missing.

The latter two are shown in the attached, which I am tempted to just
squash into your 2/2.  I think the MISSING_TREE_OBJECT one deserves
a separate commit between 1/2 and 2/2.

 Documentation/fsck-msgids.txt | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git c/Documentation/fsck-msgids.txt w/Documentation/fsck-msgids.txt
index 08e19bac8a..7af76ff99a 100644
--- c/Documentation/fsck-msgids.txt
+++ w/Documentation/fsck-msgids.txt
@@ -43,10 +43,10 @@
 `extraHeaderEntry`::
 	(IGNORE) Extra headers found after `tagger`.
 
-`fullPathName`::
+`fullPathname`::
 	(WARN) A path contains the full path starting with "/".
 
-`gitAttributesSymlink`::
+`gitattributesSymlink`::
 	(INFO) `.gitattributes` is a symlink.
 
 `gitignoreSymlink`::
@@ -55,6 +55,9 @@
 `gitmodulesBlob`::
 	(ERROR) A non-blob found at `.gitmodules`.
 
+`gitmodulesLarge`::
+	(ERROR) The `.gitmodules` file is too large to parse.
+
 `gitmodulesMissing`::
 	(ERROR) Unable to read `.gitmodules` blob.
 
@@ -118,6 +121,15 @@
 `missingTagEntry`::
 	(ERROR) Missing `tag` line in a tag object.
 
+`missingTaggerEntry`::
+	(INFO) Missing `tagger` line in a tag object.
+
+`missingTree`::
+	(ERROR) Missing `tree` line in a commit object.
+
+`missingType`::
+	(ERROR) Invalid type value on the `type` line in a tag object.
+
 `missingTypeEntry`::
 	(ERROR) Missing `type` line in a tag object.
 
@@ -130,7 +142,7 @@
 `nulInHeader`::
 	(FATAL) NUL byte exists in the object header.
 
-`nulInSha1`::
+`nullSha1`::
 	(WARN) Tree contains entries pointing to a null sha1.
 
 `treeNotSorted`::
@@ -142,7 +154,7 @@
 `unterminatedHeader`::
 	(FATAL) Missing end-of-line in the object header.
 
-`zeroPaddingDate`::
+`zeroPaddedDate`::
 	(ERROR) Found a zero padded date in an author/commiter line.
 
 `zeroPaddedFilemode`::
