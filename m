Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ACCCC61DA4
	for <git@archiver.kernel.org>; Thu,  2 Feb 2023 09:33:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232190AbjBBJdB (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Feb 2023 04:33:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231718AbjBBJcw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Feb 2023 04:32:52 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB4057640D
        for <git@vger.kernel.org>; Thu,  2 Feb 2023 01:32:49 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id m5-20020a05600c4f4500b003db03b2559eso847574wmq.5
        for <git@vger.kernel.org>; Thu, 02 Feb 2023 01:32:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MUh03QpswINkXXr7X0GLdDUu5VKOJburhspjvva+Cv4=;
        b=YtGCGh6oiOniD3aMRr7nkIn8bxlX8/l29xw9kCrvdbPhtiEZk70nSt2srXHY9QTxEx
         ljfl2QQ6jkexIZ41otdMroMmp+zjRZPKW1CuWlYlrD19P8rdVoXU/t5IQ8e5B+YVT35l
         i9IVWgM/7GSgBM8z1KbaPJzDXM4qZJkE3k0TmQpPESYLiYtzSgZ75jfkzLRO9eNq+g7O
         qGr3it5PfKkREy0f1P4iVtdWbu0Vgbf4bqlQKYHjaBFwT51fPOl4KxGMmurOE2X33tCU
         sIJZHtguGRxJWBYbHCPoT7uYYAUb3x08bQ1e4lYrKX4qRjcJRUmYimqT0l6HdjP8XuMB
         556w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MUh03QpswINkXXr7X0GLdDUu5VKOJburhspjvva+Cv4=;
        b=yADcM9Vrmu7DeuT3iY33VQmUywyYbrBad/GaBflUInELxF9yyDrNlJRjd2mBxWoJWY
         m2V3mf3itijSKg9M6cn1wyqA1nBD7pherogsCJayyHJBtGdds/oKDrL+Ob287pNqSnyQ
         jDbEwe83QIfswofqwfV4mxKArXrOfdRKgdTIfgFS2qKn4Z/FftpoeRSH+A8CwsKhsPlh
         KOYwDwl2g+z6ng7QtwkVnJkdewv6nlwmKT4zILcnKKaGGUNlyXsC63zzrCviN2ZXzneB
         ZlAnbWXFi/IaogScSZe2RunMiV9/ZSTlaDzOOLAyTexsRWaefA3GsFWRH4E7bpBfiAD4
         tUIQ==
X-Gm-Message-State: AO0yUKU8WX4i5GXqqtnwpPpX4dEmEI66vMNN+slhQvz/hQAj8XAti5Oh
        CagJm4spmUQreIVNE1DC+OGcBoPDRbHqxvmo
X-Google-Smtp-Source: AK7set9euMg7JbyUvM6WubRoukLbu7KyspeKdqqGpWcmhNcJ6hZwxdksHl73nMNIWTGmc0FGFEpExg==
X-Received: by 2002:a1c:4b15:0:b0:3dd:1b6f:4f30 with SMTP id y21-20020a1c4b15000000b003dd1b6f4f30mr5798113wma.3.1675330368792;
        Thu, 02 Feb 2023 01:32:48 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id l19-20020a05600c2cd300b003cf71b1f66csm4238753wmc.0.2023.02.02.01.32.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Feb 2023 01:32:48 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Eli Schwartz <eschwartz93@gmail.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        =?UTF-8?q?Michal=20Such=C3=A1nek?= <msuchanek@suse.de>,
        "Raymond E . Pasco" <ray@ameretat.dev>,
        demerphq <demerphq@gmail.com>, Theodore Ts'o <tytso@mit.edu>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 9/9] git archive docs: document output non-stability
Date:   Thu,  2 Feb 2023 10:32:29 +0100
Message-Id: <patch-9.9-b40833b2168-20230202T093212Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.1.1392.g63e6d408230
In-Reply-To: <cover-0.9-00000000000-20230202T093212Z-avarab@gmail.com>
References: <230131.86357rrtsg.gmgdl@evledraar.gmail.com> <cover-0.9-00000000000-20230202T093212Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There's an ongoing discussion about the output stability of "git
archive"[1] as a follow-up to the incident GitHub experienced when
upgrading to v2.38.0[2].

In a preceding commit we reverted the immediate cause of that
incident, which was that we'd moved away from "gzip -cn" as the
default compression method in favor of the internal "git archive gzip"
in [3].

Let's follow that up by documenting the non-promises we've always
maintained with regards to "git archive"'s output stability. We may
want to make stronger promises in this area, but this change avoids
addressing that question.

Instead we're discussing that we've changed this in the past, aren't
changing it willy-nilly, but it may change again in the future. The
only new promise here that we haven't explicitly maintained
historically is that we're promising to forever shell out to the
system's "gzip" by default. Whether it produces stable output once
that happens we leave up to the "gzip" tool.

We're also discussing the caveats & differences in output with with
SHA-1 and SHA-256 repositories, and trying to steer users towards more
stable alternatives. First by using "git verify-tag" and the like to
verify releases, and if they really must checksum generated output, to
encourage them to at least checksum the "tar" output contained within
the compressed output, not the compressed output itself.

1. https://lore.kernel.org/git/a812a664-67ea-c0ba-599f-cb79e2d96694@gmail.com/
2. https://github.com/orgs/community/discussions/45830
3. 4f4be00d302 (archive-tar: use internal gzip by default, 2022-06-15)

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/git-archive.txt | 70 ++++++++++++++++++++++++++++++++++-
 1 file changed, 69 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-archive.txt b/Documentation/git-archive.txt
index 268e797f03a..78f1b033cb7 100644
--- a/Documentation/git-archive.txt
+++ b/Documentation/git-archive.txt
@@ -14,6 +14,7 @@ SYNOPSIS
 	      [--remote=<repo> [--exec=<git-upload-archive>]] <tree-ish>
 	      [<path>...]
 
+[[DESCRIPTION]]
 DESCRIPTION
 -----------
 Creates an archive of the specified format containing the tree
@@ -28,7 +29,7 @@ case the commit time as recorded in the referenced commit object is
 used instead.  Additionally the commit ID is stored in a global
 extended pax header if the tar format is used; it can be extracted
 using 'git get-tar-commit-id'. In ZIP files it is stored as a file
-comment.
+comment. See the <<STABILITY,OUTPUT STABILITY>> section below.
 
 OPTIONS
 -------
@@ -202,6 +203,73 @@ EXAMPLES
 	You can use it specifying `--format=tar.xz`, or by creating an
 	output file like `-o foo.tar.xz`.
 
+[[STABILITY]]
+OUTPUT STABILITY
+----------------
+
+The output of 'git archive' is not guaranteed to be stable, and may
+change between versions.
+
+There are many valid ways to encode the same data in the tar format
+itself. For non-`tar` arguments to the `--format` option we rely on
+external tools (or libraries) for compressing the output we generate.
+
+The `tar` format contains the commit ID in the pax header (see the
+<<DESCRIPTION>> section above). A repository that's been migrated from
+SHA-1 to SHA-256 will therefore have different `tar` output for the
+"same" commit. See `extension.objectFormat` in linkgit:git-config[1].
+
+Instead of relying on the output of `git archive`, you should prefer
+to stick to git's own transport protocols, and e.g. validate releases
+with linkgit:git-tag[1]'s `--verify` option.
+
+Despite the output of `git archive` having never been promised to be
+stable, various users in the wild have come to rely on that being the
+case.
+
+Most notably, large hosting providers provide a way to download a
+given tagged release as a `git archive`. Some downstream tools then
+expect the content of that archive to be stable. When that's changed
+widespread breakage has been observed, see
+https://github.com/orgs/community/discussions/45830 for one such case.
+
+While we won't promise that the output won't change in the future, we
+are aware of these users, and will try to avoid changing it
+willy-nilly. Furthermore, we make the following promises:
+
+* The default gzip compression tool will continue to be gzip(1). If
+  you rely on this being e.g. GNU gzip for the purposes of stability,
+  it's up to you to ensure that its output is stable across
+  versions.
++
+
+We in turn promise to not e.g. make the internal "git archive gzip"
+implementation the default, as it produces different ouput than
+gzip(1) in some case.
+
+* We will do our best not to change the "tar" output itself, but won't
+  promise that we're never going to change it.
++
+If you must avoid using "git" itself for the tree validation, you
+should be checksumming the uncompressed "tar" output, not e.g. the
+compressed "tgz" output.
++
+
+This ensures that you're only relying on the output emitted by git
+itself, and avoiding the additional dependency on external
+compression.
++
+See
+https://git.kernel.org/pub/scm/linux/kernel/git/mricon/korg-helpers.git/tree/get-verified-tarball
+for an implementation of that workflow.
+
+* We promise that a given version of git will emit stable "tar" output
+  for the same tree ID (but not commit ID, see the discussion in the
+  <<DESCRIPTION>> section above).
++
+While you shouldn't assume that different versions of git will emit
+the same output, you can assume (e.g. for the purposes of caching)
+that a given version's output is stable.
 
 SEE ALSO
 --------
-- 
2.39.1.1392.g63e6d408230

