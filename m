Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 145443B27CE
	for <git@vger.kernel.org>; Mon, 14 Sep 2026 07:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789370705; cv=none; b=ElFStIflVvcjaxJVNTo7UtJOVfaTy/ltgX8p6bbfx1yR4cjGgn/0fWhFSfUCb5N+b8OxiyO5aRGzBXQ5SOoGcPTxMDBtyqHGleCgW576/Fitlxm3verXbJ/fRHgSAg8MrNQhABkrS75jupkLOa1PqDKLDqgzwRwBKPipwz9F7IQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789370705; c=relaxed/simple;
	bh=r4Zrt5PqjRLePxPo2gcJhQaODlFWUMEVI0U/mZiRx0Y=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=TqJXlToINaFZ3P04PIQq093EAPvA19pR3BjLJ5JXICU9uLO4a4nu1DST2Z41kFfQl7TjXS3UdAVhqe3DjXJdx2+tOJKj4RDdUcyG45o7aspDvLrccFO4fZ3P5MSbABzkoBrnHcpmBU5ygGjwNkTlzvVjSMG2nAn/CXPObel+s1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ytausch.de; spf=pass smtp.mailfrom=ytausch.de; dkim=pass (2048-bit key) header.d=ytausch.de header.i=@ytausch.de header.b=CZqO6yQC; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ytausch.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ytausch.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ytausch.de header.i=@ytausch.de header.b="CZqO6yQC"
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4hjxVx6scNzKp2C;
	Mon, 14 Sep 2026 09:24:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ytausch.de; s=MBO0001;
	t=1789370698;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zT8vwujgYTLe0xSRWBCL479b4dOwID85SoDxE6okoW0=;
	b=CZqO6yQCa72iIPCWjFjy8f2NUhtne8V18+yAo6FHO46ZN5ZiN/kCOdbtF9zt3g6zEY75oH
	ol9EPAnSWGxpIh0JJw0iyR2eS4FdhdrKMz/Jv0lVWoEg5VrNlu2mecAjiNzrN2Jq/Zg1wb
	hkj+SKRoLdcR2iAGL1HX8QuPvejB1aEfKBdGMrovcmb2T8BKHs7WZh3hyYV+pLg67NPC7q
	s3Q/AVgx1XgJPV8n0zWBbpsSxl9E4J1eM2l6FQmrjQ/h13KTjlOlhqJFr/cLSDz42zDhFD
	Xg5jU61EhIiQ051vuwm0t0kthao4o+e7EamLEgmhdfzLnUOsBd8t9gCNA/+sig==
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=pass (outgoing_mbo_mout: domain of dev@ytausch.de designates 2001:67c:2050:b231:465::102 as permitted sender) smtp.mailfrom=dev@ytausch.de
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Subject: [PATCH v4 0/2] dir: fix pathspec prefixes with exclusions
From: Yannik Tausch <dev@ytausch.de>
In-Reply-To: <886A25E6-8854-4AF6-BF0B-CFB57B673026@ytausch.de>
Date: Mon, 14 Sep 2026 09:24:45 +0200
Cc: Junio C Hamano <gitster@pobox.com>,
 newren@gmail.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <7CB757FB-1F2D-4EE6-8C31-8C2CD6D42397@ytausch.de>
References: <AA085B7A-F528-458A-8AA9-7664480997AE@ytausch.de>
 <xmqqecfbk2eb.fsf@gitster.g>
 <81EC0E28-13E7-4D10-BD07-3601124CBD77@ytausch.de>
 <886A25E6-8854-4AF6-BF0B-CFB57B673026@ytausch.de>
To: git@vger.kernel.org
X-Rspamd-Queue-Id: 4hjxVx6scNzKp2C

Pathspec prefix optimization must account for exclude items separately.
The prefix is derived from non-exclude items, so applying it while
matching an exclude item can compare the wrong portions of the paths.
Conversely, an exclude item at the start of the pathspec currently
prevents finding a common prefix among the remaining items.

The first patch matches exclude items against the full pathname. The
second patch finds the common prefix starting with the first non-exclude
item and returns both the prefix length and the string from which it was
derived.

Changes since v3, which was withdrawn in favor of v2:

* Return to a two-patch series based on d66ac2af30, leaving Junio's
  preparatory const-correctness patch on its separately queued topic.
* Add the deterministic regression test suggested by Elijah, while
  retaining the shorter-pattern test for the out-of-bounds access.
* Explain the observable incorrect match in patch 1 and use consistent
  non-exclude/exclude terminology.
* Reword patch 2 to describe the directory-walk optimization it =
restores.

Yannik Tausch (2):
  dir: do not apply prefix to negative pathspecs
  dir: preserve pathspec prefix optimization with leading excludes

 dir.c                       | 39 +++++++++++++++++++++----------------
 t/t6132-pathspec-exclude.sh | 18 +++++++++++++++++
 t/unit-tests/u-dir.c        | 28 ++++++++++++++++++++++++++
 3 files changed, 68 insertions(+), 17 deletions(-)

Range-diff against v2:
1:  c8a2f1e22e ! 1:  adeb7f2fb6 dir: do not apply prefix to negative =
pathspecs
    @@ Metadata
      ## Commit message ##
         dir: do not apply prefix to negative pathspecs
    =20
    -    common_prefix_len() derives the common prefix solely from =
positive
    -    pathspecs, skipping those marked with PATHSPEC_EXCLUDE. =
However,
    -    match_pathspec_with_flags() also passes that prefix when =
matching the
    -    negative pathspecs.
    +    common_prefix_len() derives the common prefix solely from =
non-exclude
    +    pathspec items. However, match_pathspec_with_flags() also =
passes that
    +    prefix when matching exclude items.
    =20
    -    A negative pathspec may be shorter than the prefix. In that =
case,
    -    match_pathspec_item() advances item->match beyond its =
allocation and
    -    subtracts the prefix from item->len, producing a negative =
matchlen. It
    -    then dereferences the out-of-bounds pointer. If the resulting =
byte is
    -    not NUL, matchlen is converted to size_t when passed to =
ps_strncmp(),
    -    which may cause a much larger out-of-bounds read.
    +    This can produce incorrect results because that prefix does not
    +    necessarily match an exclude item. For example, given =
non-exclude items
    +    "a/b" and "a/c" and an exclude item "x/b", stripping the =
two-byte
    +    prefix from both the pathname "a/b/m" and pattern "x/b" makes =
the
    +    remaining strings match and incorrectly excludes the pathname.
    =20
    -    The problem can be reproduced with AddressSanitizer:
    +    If an exclude item is shorter than the prefix, =
match_pathspec_item()
    +    instead advances item->match beyond its allocation and =
subtracts the
    +    prefix from item->len, producing a negative matchlen. It then
    +    dereferences the out-of-bounds pointer. If the resulting byte =
is not
    +    NUL, matchlen is converted to size_t when passed to =
ps_strncmp(), which
    +    may cause a much larger out-of-bounds read.
    +
    +    The out-of-bounds access can be reproduced with =
AddressSanitizer:
    =20
             make SANITIZE=3Daddress CFLAGS=3D"-g -O0" git
             git init test &&
    @@ Commit message
             git commit -m test &&
             ../git ls-files -- "$DIR/" ":(exclude)xy"
    =20
    -    This reports a heap-buffer-overflow. Without AddressSanitizer, =
the
    -    output may depend on the contents of memory following the =
negative
    -    pathspec.
    -
    -    Fix the bug by using a zero prefix when matching negative =
pathspecs.
    -    Add a regression test that combines a positive pathspec with a =
longer
    -    common prefix and a shorter, unrelated negative pathspec.
    +    Fix the bug by using a zero prefix when matching exclude items. =
Add
    +    regression tests for both the deterministic incorrect match and =
the
    +    shorter exclude item that causes the out-of-bounds access.
    =20
         Signed-off-by: Yannik Tausch <dev@ytausch.de>
    =20
    @@ t/t6132-pathspec-exclude.sh: EOF
     +	EOF
     +	test_cmp expect actual
     +'
    ++
    ++test_expect_success 'exclude is matched against the full path' '
    ++	git ls-files -- sub/sub/ ":(exclude)zzzzzzz" >actual &&
    ++	cat <<-\EOF >expect &&
    ++	sub/sub/file
    ++	sub/sub/sub/file
    ++	EOF
    ++	test_cmp expect actual
    ++'
     +
      test_expect_success 'multiple exclusions' '
      	git ls-files -- ":^*/file2" ":^sub2" >actual &&
2:  d0e08fdb96 ! 2:  e8f72cab9c dir: find common prefix among =
non-exclude pathspec items
    @@ Metadata
     Author: Yannik Tausch <dev@ytausch.de>
    =20
      ## Commit message ##
    -    dir: find common prefix among non-exclude pathspec items
    +    dir: preserve pathspec prefix optimization with leading =
excludes
    =20
    -    common_prefix_len() skips exclude pathspec items, but uses n =3D=3D=
 0 to
    -    identify the initial item and items[0] as the comparison =
source. When
    -    an exclude item comes first, the function returns zero even =
when all
    -    remaining items share a directory.
    +    Directory walks use the common directory prefix of non-exclude
    +    pathspec items to avoid scanning unrelated portions of the =
working
    +    tree or index. Exclude items only remove paths from that =
candidate
    +    set, so they do not need to widen the traversal.
    =20
    -    Track the first non-exclude item explicitly. Return its match =
through
    -    an output parameter so that common_prefix() and =
fill_directory() use
    -    the correct string. Add a unit test with an unrelated exclude =
item
    -    before two non-exclude items that share a directory.
    +    When an exclude item is the first pathspec item, =
common_prefix_len()
    +    fails to establish a comparison base and returns a zero-length =
prefix.
    +    The result is correct, but Git unnecessarily traverses from a =
broader
    +    starting point even when all non-exclude items share a =
directory.
    +
    +    Use the first non-exclude item as the comparison base and =
return its
    +    string together with the prefix length, allowing callers to =
start from
    +    the recovered directory prefix. Exclude matching continues to =
use full
    +    paths, so this restores the optimization without changing which =
paths
    +    are selected. Add a unit test covering an exclude item before =
two
    +    non-exclude items with a common directory.
    =20
         Signed-off-by: Yannik Tausch <dev@ytausch.de>
    =20

base-commit: d66ac2af300f33bd9e8558c5645f2a808cc01f89
--=20
2.55.0

