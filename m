Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D740313699A
	for <git@vger.kernel.org>; Wed, 29 May 2024 12:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716985089; cv=none; b=XAn+YFkw3ODcHcckqRNPVuBngGJr9Dg1SqR+uETLFMx3aCFFqJf0lwkGxgWxFwNY0bNbKdsoDSfhZ5PO2ZMeOYAUz4lU2Opv2TIEVZxeI+g6j1k/PYeJhk0P4/LxUZqayjRFaAnflQGfgwHve8CKjJ09eLa86zd2+epm8gHKedQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716985089; c=relaxed/simple;
	bh=Jw3IZXnsLeaISNOglbUvTVshfDqWZGZlKXXbypOcHN0=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=emh/WMhJtmt6kUvTFkkIEKjutsI9QVXn+H5rkdUy2JMRAfOFp8DWuRMz/fNtWupiyRntG5ByeinE9ilBxaN0NF7Ttg6EXerVHTMxKx3BKFKqRiqEFSYUUVCzL1Yxg+f6bXRWySxnbRK/Haz6WEDTL15EpuGDUon4PynvDn41Bww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=kI3eX9f5; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="kI3eX9f5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1716985064; x=1717589864;
	i=johannes.schindelin@gmx.de;
	bh=JJQGTOQa9nWw1ADJ7WREga9bn3jf1K7YtO/ToatVAis=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=kI3eX9f5F+e/dcfP87BEkkKTVEr6qRuN0i0RLF9UmdvdzKnetH+M9V6Ku8yO90Tq
	 9YXQszJKrH1dLASwEaBmSgFZzU0PXxP89qw5eGYqTV7EDgFMkELDKgdT4VwZ/v+ZJ
	 Dfn3pGHWbsDwNKwUMn/lZrbqgRWhfJl/UgzBzkeu2kVBTEO2UTe4UQfkPio60KbdT
	 LxPO845flgkzt+DGlELx2TStkPoJgV99/KCN0Q7LyQ4A2xRNPfvxLtdQoebosE/yl
	 wHUSb83sgGXD9B+quQUdhQY0kFXZJxjxsqoOG6zfPGE3+s+oDJTplSrb16vYqDh6y
	 orsF1XZSQUMLhyP89A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([89.1.216.58]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MQvD5-1roQ750txn-00OrBO; Wed, 29
 May 2024 14:17:44 +0200
Date: Wed, 29 May 2024 14:17:41 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Jeff King <peff@peff.net>
cc: Joey Hess <id@joeyh.name>, 
    "brian m. carlson" <sandals@crustytoothpaste.net>, git@vger.kernel.org, 
    Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/2] Revert defense-in-depth patches breaking Git LFS
In-Reply-To: <20240529085401.GA1098944@coredump.intra.peff.net>
Message-ID: <1cbdeb41-2ad3-05e4-ab27-1f84086b7f43@gmx.de>
References: <20240514181641.150112-1-sandals@crustytoothpaste.net> <0f7597aa-6697-9a70-0405-3dcbb9649d68@gmx.de> <ZkO-b6Nswrn9H7Ed@tapette.crustytoothpaste.net> <Zk2_mJpE7tJgqxSp@kitenet.net> <fbb89826-0d83-d4f9-bab4-9fba69e0e22d@gmx.de> <ZlU94wcstaAHv_HZ@kitenet.net>
 <20240529085401.GA1098944@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:3ptmUyJdORxlH3zaKMZxeMaopGZQpOm6KxZDJ6MURxIeImHpZwi
 YAd35A2D5ISq4cs7qC3EAXfJ3A80EbpN0ZcAoXks1yrG+q0EXL5PRpqG19fNHNlq+Rk4krb
 AQdBIYafDEDjlPcZqUxvdES9JQaR9QV4fJGL04/ijnrznYeFLruXCTbkp3LUjg7FJzG3bla
 fYvA9cyBpOjVp2Pmjh2GQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:T2ZfgUz7XcY=;ioCUf0DFxTwFJX26RPpWk7ISY2n
 PM2R0OX6M0d2knjG+AAcEO0vRGWeiCKZTk0p42Ce3FFPhLk4d3qRfaVAqOC9jd/eK4EcpLRFF
 bMIFJB8MrqbvMuaImNE2bMM4SV4Q/nb6ihZLQeMTzmEHzb02JK19Rb+VUdro4pIp5eGuyHWR5
 lAlroxSmeVS1ZQg470/0scFUADnt+ec9EkBcnJgoWGnFkvR/lZa7BZ3iWos36eGujnbrdRVaJ
 VXmztgmh9SZUo34hblWJjp2QaRUcdwV/v0EltAqDEJVruhb/0F38U9B5RdBw03mR/iXpN2lhf
 73830kdZJnimMKJZUaE4RSerjscnEY0B/8oM7h+UEitmRZUEgybPQihFIGuyc4/JIML6CNfNR
 myxBvW+X5Nym336/g8u9W+VySw6ZNaN4ClNxDt5cSJTwXPwJs1YwqUHcmmixj1OKpQ/pRVv2q
 xY+PxVKnaXrV5+jJgq1Vtpo45fj96/Msl5/pzQNkCPacI8yU+AJmNI7FDKHXAEFixMEXoXpnA
 RgD+7GTA7iFWrhx4e14MQM6GB1DYw2zco9+mMh2vVVXLFmuq0kghWutYYZ3rWZ6pb7DY1i0xa
 YVser3SGtrHmsFW0v0SC2J33ki8goBl6NZFEyjrdejPUilR4+/kVfv/Vej/pNM6RRFIz3WvMN
 jPScAfSgebPA3KN3qe1uiNxHFnDcVzhNU3vbhMQlLL6ZLMJmCjgydkR8O59ARqyR/0iD3EJGl
 ERRgTGfqBoxtsuNE2D4WPo2hY5IFW8eGVMScebGYR57b4AIUTiKtVuXwE0tdbMroACGyU/5M3
 N4TQp/elUu9g3SDz4zDGYHlxNvBUfl4qT9lZGYdke08Bk=
Content-Transfer-Encoding: quoted-printable

Hi Jeff,

On Wed, 29 May 2024, Jeff King wrote:

> [...] But of course most sites just use the defaults, so all warnings
> are effectively errors.

I wish that had been pointed out on the git-security mailing list when I
offered this patch up for review.

> In the meantime, we also have an "INFO" severity which gets reported but
> not upgraded via strict. It sounds like that's what was intended here.

Precisely.

So this is what the fix-up patch would look like to make the code match my
intention:

=2D- snipsnap --
Subject: [PATCH] fsck: demote the newly-introduced symlink issues from WAR=
N -> IGNORE

The idea of the symlink check to prevent overly-long symlink targets and
targets inside the `.git/` directory was to _warn_, but not to prevent
any operation.

However, that's not how Git works, I was confused by the label `WARN`.
What we need instead is the `IGNORE` label, which still warns
(confusingly so ;-)), but does not prevent any operations from
continuing.

Adjust t1450 accordingly, documenting that `git fsck` unfortunately no
longer warns about these issues by default.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
=2D--
 Documentation/fsck-msgids.txt |  4 ++--
 fsck.h                        |  4 ++--
 t/t1450-fsck.sh               | 13 ++++++++++++-
 3 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/Documentation/fsck-msgids.txt b/Documentation/fsck-msgids.txt
index b06ec385aff..f5016ecda6a 100644
=2D-- a/Documentation/fsck-msgids.txt
+++ b/Documentation/fsck-msgids.txt
@@ -158,13 +158,13 @@
 	(WARN) Tree contains entries pointing to a null sha1.

 `symlinkPointsToGitDir`::
-	(WARN) Symbolic link points inside a gitdir.
+	(INFO) Symbolic link points inside a gitdir.

 `symlinkTargetBlob`::
 	(ERROR) A non-blob found instead of a symbolic link's target.

 `symlinkTargetLength`::
-	(WARN) Symbolic link target longer than maximum path length.
+	(INFO) Symbolic link target longer than maximum path length.

 `symlinkTargetMissing`::
 	(ERROR) Unable to read symbolic link target's blob.
diff --git a/fsck.h b/fsck.h
index 130fa8d8f91..d41ec98064b 100644
=2D-- a/fsck.h
+++ b/fsck.h
@@ -74,8 +74,6 @@ enum fsck_msg_type {
 	FUNC(NULL_SHA1, WARN) \
 	FUNC(ZERO_PADDED_FILEMODE, WARN) \
 	FUNC(NUL_IN_COMMIT, WARN) \
-	FUNC(SYMLINK_TARGET_LENGTH, WARN) \
-	FUNC(SYMLINK_POINTS_TO_GIT_DIR, WARN) \
 	/* infos (reported as warnings, but ignored by default) */ \
 	FUNC(BAD_FILEMODE, INFO) \
 	FUNC(GITMODULES_PARSE, INFO) \
@@ -84,6 +82,8 @@ enum fsck_msg_type {
 	FUNC(MAILMAP_SYMLINK, INFO) \
 	FUNC(BAD_TAG_NAME, INFO) \
 	FUNC(MISSING_TAGGER_ENTRY, INFO) \
+	FUNC(SYMLINK_TARGET_LENGTH, INFO) \
+	FUNC(SYMLINK_POINTS_TO_GIT_DIR, INFO) \
 	/* ignored (elevated when requested) */ \
 	FUNC(EXTRA_HEADER_ENTRY, IGNORE)

diff --git a/t/t1450-fsck.sh b/t/t1450-fsck.sh
index 5669872bc80..8339e60efb2 100755
=2D-- a/t/t1450-fsck.sh
+++ b/t/t1450-fsck.sh
@@ -1032,7 +1032,18 @@ test_expect_success 'fsck warning on symlink target=
 with excessive length' '
 	warning in blob $symlink_target: symlinkTargetLength: symlink target too=
 long
 	EOF
 	git fsck --no-dangling >actual 2>&1 &&
-	test_cmp expected actual
+	test_cmp expected actual &&
+
+	test_when_finished "git tag -d symlink-target-length" &&
+	git tag symlink-target-length $tree &&
+	test_when_finished "rm -rf throwaway.git" &&
+	git init --bare throwaway.git &&
+	git --git-dir=3Dthrowaway.git config receive.fsckObjects true &&
+	git --git-dir=3Dthrowaway.git config receive.fsck.symlinkTargetLength er=
ror &&
+	test_must_fail git push throwaway.git symlink-target-length &&
+	git --git-dir=3Dthrowaway.git config --unset receive.fsck.symlinkTargetL=
ength &&
+	git push throwaway.git symlink-target-length 2>err &&
+	grep "warning.*symlinkTargetLength" err
 '

 test_expect_success 'fsck warning on symlink target pointing inside git d=
ir' '
