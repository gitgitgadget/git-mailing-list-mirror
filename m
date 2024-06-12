Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B7B93209
	for <git@vger.kernel.org>; Wed, 12 Jun 2024 18:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718217336; cv=none; b=FX9Vn1AD6+R5Dvf/7E8/rXFMvy/Yf8/7N/JUlnSKv++1rFZ5tY3gOxA86azN+G85/EErR4V9kJn4i7PPoqF6fSGakbpn8+pznADV2E83pe3SS8zYyFXPxZ0cPGA9sPcFTXxxQSmEKI55QpNSxs5dYqSijw3l7Sh7mbLahW3eGGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718217336; c=relaxed/simple;
	bh=Nz8F82wq7ylEef+4wdgAlY4ZT3mrQ891S0RbkWFrBPg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bmo+NdxYBv1W+JppnhBa+zsNuizIRT9y8lH4TtvoUvHods05j1asrC0uYL8xjag72tZDNsrYVnfd2OkVyjs+Bs3Gll26918jfa953YRm3tsR5uj+HpEMFNy7cl6ncBd044NrolF2Kxeve5KXyDge8NC+GwziMYfyoLTGpa2IwJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=ofTLImBE; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ofTLImBE"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id A418121722;
	Wed, 12 Jun 2024 14:35:34 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=Nz8F82wq7ylEef+4wdgAlY4ZT3mrQ891S0RbkW
	FrBPg=; b=ofTLImBEYtQ1npRCDuU3bFclxetsWsPGU08JegnETRZhUAMzELn2qJ
	4oxV6rr51I+UPEFRWkLwuiNh7TH/kf0SsLs2RqYKyyx08XTc9l2Mvx/vGpImwPKm
	7APlX4ahJk2Ofvy6t5UTi/cgqr++74ZO37IQjNq8mEQ0+yI9usZGY=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 9D52B21721;
	Wed, 12 Jun 2024 14:35:34 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.204.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 3EC7D21720;
	Wed, 12 Jun 2024 14:35:31 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Victoria Dye <vdye@github.com>
Subject: Re: [PATCH 07/16] mktree: use read_index_info to read stdin lines
In-Reply-To: <ZmltEti7TRpaiCD-@tanuki> (Patrick Steinhardt's message of "Wed,
	12 Jun 2024 11:40:34 +0200")
References: <pull.1746.git.1718130288.gitgitgadget@gmail.com>
	<8d1e1eaa70b96779416f2f48a862d31a730c4521.1718130288.git.gitgitgadget@gmail.com>
	<ZmltEti7TRpaiCD-@tanuki>
Date: Wed, 12 Jun 2024 11:35:29 -0700
Message-ID: <xmqqle3aovpq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 8C476DE2-28EA-11EF-9C0B-DFF1FEA446E2-77302942!pb-smtp21.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> It makes perfect sense to not single out git-ls-tree(1) anymore. But I
> think we should help the reader a bit by continuing to point out which
> commands can be used as input here. That can be either here in the
> description, further down in the new "INPUT FORMAT" section, or in both
> places.

Here is a way to do so, which I alluded to earlier.  The original
text is too specific to "update-index" in that it talked about
"stuffing them into the index", which does not apply in the context
of "mktree".

And then it made me realize that "ls-files -s" output has the stage
information, which of course is needed for "update-index" to be able
to recreate the index state from a textual dump, but "mktree" should
reject if given a higher stage entry.

It seems that the code after applying all these 16 patches does not
diagnose it as an error if you feed a non-zero stage.  The callback
starts like so.

    static int mktree_line(unsigned int mode, struct object_id *oid,
                           enum object_type obj_type, int stage UNUSED,
                           const char *path, void *cbdata)
    {
    
I _think_ it should be made an error if the input has non-zero
stage, which would be a sign that it was taken from "ls-files -s"
(or even "ls-files -u"), out of which "git write-tree" will REFUSE
to create a tree object.  "mktree" should behave the same way, no?

In any case, here is the documentation split/refactor.

 Documentation/git-mktree.txt         |  4 +++-
 Documentation/git-update-index.txt   | 14 +-------------
 Documentation/index-info-formats.txt | 13 +++++++++++++
 3 files changed, 17 insertions(+), 14 deletions(-)

diff --git c/Documentation/git-mktree.txt w/Documentation/git-mktree.txt
index a660438c67..fefaa83d29 100644
--- c/Documentation/git-mktree.txt
+++ w/Documentation/git-mktree.txt
@@ -48,7 +48,9 @@ OPTIONS
 INPUT FORMAT
 ------------
 Tree entries may be specified in any of the formats compatible with the
-`--index-info` option to linkgit:git-update-index[1].
+`--index-info` option to linkgit:git-update-index[1].  That is:
+
+include::index-info-formats.txt[]
 
 Entries may use full pathnames containing directory separators to specify
 entries nested within one or more directories. These entries are inserted into
diff --git c/Documentation/git-update-index.txt w/Documentation/git-update-index.txt
index 7128aed540..2287a5d4be 100644
--- c/Documentation/git-update-index.txt
+++ w/Documentation/git-update-index.txt
@@ -280,19 +280,7 @@ USING --INDEX-INFO
 multiple entry definitions from the standard input, and designed
 specifically for scripts.  It can take inputs of three formats:
 
-    . mode SP type SP sha1          TAB path
-+
-This format is to stuff `git ls-tree` output into the index.
-
-    . mode         SP sha1 SP stage TAB path
-+
-This format is to put higher order stages into the
-index file and matches 'git ls-files --stage' output.
-
-    . mode         SP sha1          TAB path
-+
-This format is no longer produced by any Git command, but is
-and will continue to be supported by `update-index --index-info`.
+include::index-info-formats.txt[]
 
 To place a higher stage entry to the index, the path should
 first be removed by feeding a mode=0 entry for the path, and
diff --git c/Documentation/index-info-formats.txt w/Documentation/index-info-formats.txt
new file mode 100644
index 0000000000..037ebd2432
--- /dev/null
+++ w/Documentation/index-info-formats.txt
@@ -0,0 +1,13 @@
+    . mode SP type SP sha1          TAB path
++
+This format is to use `git ls-tree` output.
+
+    . mode         SP sha1 SP stage TAB path
++
+This format allows higher order stages to appear and
+matches 'git ls-files --stage' output.
+
+    . mode         SP sha1          TAB path
++
+This format is no longer produced by any Git command, but is
+and will continue to be supported.
