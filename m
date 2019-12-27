Return-Path: <SRS0=DNff=2R=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58ED6C2D0C6
	for <git@archiver.kernel.org>; Fri, 27 Dec 2019 13:56:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E89C20740
	for <git@archiver.kernel.org>; Fri, 27 Dec 2019 13:56:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dyntopia-com.20150623.gappssmtp.com header.i=@dyntopia-com.20150623.gappssmtp.com header.b="aYg9d08O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726607AbfL0N4K (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 27 Dec 2019 08:56:10 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:37640 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726279AbfL0N4J (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Dec 2019 08:56:09 -0500
Received: by mail-pg1-f196.google.com with SMTP id q127so14499231pga.4
        for <git@vger.kernel.org>; Fri, 27 Dec 2019 05:56:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dyntopia-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qNyeyGWq/jcNKOLG+ge1ZQhAvS2aFPXuJqzPsa8jk0Q=;
        b=aYg9d08OLtb/mf2xGgo7ngEQg96aap1xDahTspKjawsttNVGzUE4j7iz/wOW4cSMmm
         QHEVwcqJ0M/mz/85b4h09KyRFx10AQ4NUraGk/Bim/YaCuCFE6m1z2Zm0iWZmbYsL5ip
         r3ByDrN0HSop0geFS0yNoB/UMmBDw/oP17vE0tktIphpnS1UqBIeL3Wrtcc5XcP3r2YJ
         ldWrgnYzD/gbYo63tKDwgckVLTR3FnZBRoG5Z2fyNfHm56ewNXFt2NBejd+ZdrguZ7LS
         IHPKzuSd4vJrcXPGlw4tEwI37zbE1xeRCQZRsMtnKJdfvJybCLJPHihlBxBRgdp6lGNy
         Ghcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qNyeyGWq/jcNKOLG+ge1ZQhAvS2aFPXuJqzPsa8jk0Q=;
        b=Xr7scpbxZueQKd2X9nd9vHfhl9jGIYkO3JjLuHXFYAYp0VpxQ/J+zC8mFX4pntzxzr
         fMayAa0yqn51bks7BGR1Q8LjCawAeSokK2fTcG3oIrB1mRGyB7CIKRaqVy5YGZBcggdN
         bQQNPYZ9TrtT5Xi9eiNYqTaFattinPtq3dwUHKdm2jJJqL+1VWeORKBwvfCPEuR2jMbp
         1aGFoGauRLQxbJaUDqdr4F0VEKIxi2shcYUooXNjIQhIQ8z68Mi0amER8csXRLXfAW/K
         exw2ne9X45+O/9cYxQS4yikd907yS5l4gzMCuFWzH4wFUEOjhaP0BzCs3anZ6KAFQCFD
         DamA==
X-Gm-Message-State: APjAAAWgu3qOLacp3NUnifOuttdGSreRec/jUc9QvxKtbjFT2WuzstSR
        PBsBoBpASFHRVcRNHIlLSkFJlVTKuyI=
X-Google-Smtp-Source: APXvYqw5YnwcHO3Db8EBgYjP/NFnfqFIcKtL5/bY2sQkQip9qyKy/5kcGSjiZk32kzXsfSjyBBzJ8A==
X-Received: by 2002:aa7:8299:: with SMTP id s25mr53106491pfm.261.1577454968744;
        Fri, 27 Dec 2019 05:56:08 -0800 (PST)
Received: from localhost ([27.109.113.235])
        by smtp.gmail.com with ESMTPSA id v4sm25649376pfn.181.2019.12.27.05.56.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Dec 2019 05:56:08 -0800 (PST)
From:   Hans Jerry Illikainen <hji@dyntopia.com>
To:     git@vger.kernel.org
Cc:     Hans Jerry Illikainen <hji@dyntopia.com>
Subject: [PATCH v3 0/1] gpg-interface: add minTrustLevel as a configuration option
Date:   Fri, 27 Dec 2019 13:55:56 +0000
Message-Id: <20191227135557.31437-1-hji@dyntopia.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191222003123.10555-1-hji@dyntopia.com>
References: <20191222003123.10555-1-hji@dyntopia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Previously, signature verification for merge and pull operations checked
if the key had a trust-level of either TRUST_NEVER or TRUST_UNDEFINED in
verify_merge_signature().  If that was the case, the process die()d.

The other code paths that did signature verification relied entirely on
the return code from check_commit_signature().  And signatures made with
a good key, irregardless of its trust level, was considered valid by
check_commit_signature().

This difference in behavior might induce users to erroneously assume
that the trust level of a key in their keyring is always considered by
Git, even for operations where it is not (e.g. during a verify-commit or
verify-tag).

The way it worked was by gpg-interface.c storing the result from the
key/signature status *and* the lowest-two trust levels in the `result`
member of the signature_check structure (the last of these status lines
that were encountered got written to `result`).  These are documented in
GPG under the subsection `General status codes` and `Key related`,
respectively [1].

The GPG documentation says the following on the TRUST_ status codes [1]:

    """
    These are several similar status codes:

    - TRUST_UNDEFINED <error_token>
    - TRUST_NEVER     <error_token>
    - TRUST_MARGINAL  [0  [<validation_model>]]
    - TRUST_FULLY     [0  [<validation_model>]]
    - TRUST_ULTIMATE  [0  [<validation_model>]]

    For good signatures one of these status lines are emitted to
    indicate the validity of the key used to create the signature.
    The error token values are currently only emitted by gpgsm.
    """

My interpretation is that the trust level is conceptionally different
from the validity of the key and/or signature.  That seems to also have
been the assumption of the old code in check_signature() where a result
of 'G' (as in GOODSIG) and 'U' (as in TRUST_NEVER or TRUST_UNDEFINED)
were both considered a success.

The two cases where a result of 'U' had special meaning were in
verify_merge_signature() (where this caused git to die()) and in
format_commit_one() (where it affected the output of the %G? format
specifier).

I think it makes sense to refactor the processing of TRUST_ status lines
such that users can configure a minimum trust level that is enforced
globally, rather than have individual parts of git (e.g. merge) do it
themselves (except for a grace period with backward compatibility).

I also think it makes sense to not store the trust level in the same
struct member as the key/signature status.  While the presence of a
TRUST_ status code does imply that the signature is good (see the first
paragraph in the included snippet above), as far as I can tell, the
order of the status lines from GPG isn't well-defined; thus it would
seem plausible that the trust level could be overwritten with the
key/signature status if they were stored in the same member of the
signature_check structure.

This patch introduces a new configuration option: gpg.minTrustLevel.  It
consolidates trust-level verification to gpg-interface.c and adds a new
`trust_level` member to the signature_check structure.

Backward-compatibility is maintained by introducing a special case in
verify_merge_signature() such that if no user-configurable
gpg.minTrustLevel is set, then the old behavior of rejecting
TRUST_UNDEFINED and TRUST_NEVER is enforced.  If, on the other hand,
gpg.minTrustLevel is set, then that value overrides the old behavior.

Similarly, the %G? format specifier will continue show 'U' for
signatures made with a key that has a trust level of TRUST_UNDEFINED or
TRUST_NEVER, even though the 'U' character no longer exist in the
`result` member of the signature_check structure.  A new format
specifier, %GT, is also introduced for users that want to show all
possible trust levels for a signature.

Another approach would have been to simply drop the trust-level
requirement in verify_merge_signature().  This would also have made the
behavior consistent with other parts of git that perform signature
verification.  However, requiring a minimum trust level for signing keys
does seem to have a real-world use-case.  For example, the build system
used by the Qubes OS project currently parses the raw output from
verify-tag in order to assert a minimum trust level for keys used to
sign git tags [2].


Changes since v0:
* Added backward-compatibility with the old behavior of
  verify_merge_signature().  The old behavior is overridden if a user
  has configured gpg.minTrustLevel.  My approach is kind of ugly because
  now all users of verify_merge_signature() has to be aware of
  gpg.minTrustLevel to know if it should override the default behavior.
  An alternative might be to have a configurable per-operation trust
  level (e.g. merge.minTrustLevel), but I'm not sure how sensible that
  is either.
* Added backward-compatiblity with the old behavior of %G?.

Changes since v1:
* Fixed compatibility with gpg1 in parse_gpg_output().  One significant
  difference between gpg1 and gpg2 is that the trust levels above
  TRUST_NEVER are written without any additional space-separated
  information in gpg1 [3].  This broke the logic in the previous
  iterations, because the end of the TRUST_ string were searched for by
  looking for a space character.  Now a new-line is used as a fallback.

Changes since v2:
* Replaced strstr() + strchrnul() with strcspn().


[1] https://git.gnupg.org/cgi-bin/gitweb.cgi?p=gnupg.git;a=blob;f=doc/doc/DETAILS;h=bd00006e933ac56719b1edd2478ecd79273eae72;hb=refs/heads/master
[2] https://github.com/QubesOS/qubes-builder/blob/9674c1991deef45b1a1b1c71fddfab14ba50dccf/scripts/verify-git-tag#L43
[3] https://git.gnupg.org/cgi-bin/gitweb.cgi?p=gnupg.git;a=blob;f=doc/DETAILS;h=de0f21ccba60c3037c2a155156202df1cd098507;hb=refs/heads/STABLE-BRANCH-1-4#l286

Hans Jerry Illikainen (1):
  gpg-interface: add minTrustLevel as a configuration option

 Documentation/config/gpg.txt       | 15 +++++
 Documentation/pretty-formats.txt   |  1 +
 builtin/merge.c                    |  9 ++-
 builtin/pull.c                     | 13 ++++-
 commit.c                           | 12 ++--
 commit.h                           | 12 +++-
 gpg-interface.c                    | 91 ++++++++++++++++++++++++++----
 gpg-interface.h                    | 10 +++-
 pretty.c                           | 30 +++++++++-
 t/t5573-pull-verify-signatures.sh  | 64 +++++++++++++++++++++
 t/t7030-verify-tag.sh              | 24 ++++++++
 t/t7510-signed-commit.sh           | 39 +++++++++++++
 t/t7612-merge-verify-signatures.sh | 22 ++++++++
 13 files changed, 319 insertions(+), 23 deletions(-)

--
2.24.1.591.g64816733a6
