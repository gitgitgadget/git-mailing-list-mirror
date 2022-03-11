Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ADC5C433F5
	for <git@archiver.kernel.org>; Fri, 11 Mar 2022 16:24:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350287AbiCKQZs (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Mar 2022 11:25:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350242AbiCKQZi (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Mar 2022 11:25:38 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F840107D9F
        for <git@vger.kernel.org>; Fri, 11 Mar 2022 08:24:34 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id j26so13748125wrb.1
        for <git@vger.kernel.org>; Fri, 11 Mar 2022 08:24:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hW5j2D8aiAs8OcWGVTQCf1AGBhVI0YUZtaUfyCwlOGE=;
        b=knnh7oJW46wlGOjU0LrsvEPHDuplgz/qxBPQGHW7nafC1Duj3cpJQkOrlxDf56ITGs
         8GNq7gjWyMt0NHEEkQkgqsB0nCY2/cEHQD483PySigorB4PRVWIj/741M/Qu3gNZQORK
         4pS4OAvKAJ8ccFTp/Uy7Pr9NHsjLPwPMT/jW9cgcmyJeJkYqEy+wkfP0M2a6Bt5DH6wW
         kxyFk/UE6K/YoEhGNSnnwXQ6qZZLxXdnjlXgZ680VTp8eD9VNITUEedZQLAu3KlzJ08c
         PJr+m6GFwm7dZcxc/CeGdctHZWZNc52lLmGk9FlPnV9AXyucRIKRP7MI5HH7WUDXLINT
         5bmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hW5j2D8aiAs8OcWGVTQCf1AGBhVI0YUZtaUfyCwlOGE=;
        b=FtDaNaJK0HuTQF8OUxwz8+dv80r0yXwbSM+ZgmPrS6q+Vz1s+mUAi1tSO3B/H1Di2W
         I+cmqtwssSTkIL9VGgorgVxoHJM9fVFlhqi8oRmUR0nF5XAVXSC3adeWKRYQtdTjLS4Q
         vyh14yFvYeaUtyTfqbNEZC545JMVCkJMW/uw+Cx64QARl/Ai10h6ZPaJuKzm2pka1/wU
         sUkKDd7cY3Rdb/MWMCGaovX3R+Nss+Z9gyQ0L35HrpamoXEAtZExabs2lYZo0w7I6gfa
         EMJTx/z9WBCPregLtu+rJX0dv9nCWQ8DFeh7RdrZkhXZ2ODVC4UsUUalb4IJvkHHuqWO
         3wUQ==
X-Gm-Message-State: AOAM531CDxzzTzXvWPt0wO8NXr+W7SZi515LCZV7excw9dC7AW0G3Q1A
        u+HPg0yTGxYMbHqGhAESY00h8JX/XSOsBA==
X-Google-Smtp-Source: ABdhPJwtwbrlkXbsV2Ae2rgOoWD7KUJ3KiZxthQr9X8xkaZPXE/SaOt3GAlY6JeefRq7Es66iNQTLA==
X-Received: by 2002:a5d:598b:0:b0:203:95c0:7b72 with SMTP id n11-20020a5d598b000000b0020395c07b72mr3292580wri.172.1647015872225;
        Fri, 11 Mar 2022 08:24:32 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id f22-20020a1cc916000000b00380d3e49e89sm7318667wmb.22.2022.03.11.08.24.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Mar 2022 08:24:31 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Albert Cui <albertqcui@gmail.com>,
        "Robin H . Johnson" <robbat2@gentoo.org>,
        Teng Long <dyroneteng@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [RFC PATCH v2 02/13] bundle-uri docs: add design notes
Date:   Fri, 11 Mar 2022 17:24:14 +0100
Message-Id: <RFC-patch-v2-02.13-84c4036a510-20220311T155841Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1337.g7e32d794afe
In-Reply-To: <RFC-cover-v2-00.13-00000000000-20220311T155841Z-avarab@gmail.com>
References: <cover-0.3-00000000000-20211025T211159Z-avarab@gmail.com> <RFC-cover-v2-00.13-00000000000-20220311T155841Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a design doc for the bundle-uri protocol extension to go along
with the packfile-uri extension added in cd8402e0fd8 (Documentation:
add Packfile URIs design doc, 2020-06-10).

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/technical/bundle-uri.txt  | 119 ++++++++++++++++++++++++
 Documentation/technical/protocol-v2.txt |   5 +
 2 files changed, 124 insertions(+)
 create mode 100644 Documentation/technical/bundle-uri.txt

diff --git a/Documentation/technical/bundle-uri.txt b/Documentation/technical/bundle-uri.txt
new file mode 100644
index 00000000000..5ae9a15eafe
--- /dev/null
+++ b/Documentation/technical/bundle-uri.txt
@@ -0,0 +1,119 @@
+Bundle URI Design Notes
+=======================
+
+Protocol
+--------
+
+See `bundle-uri` in the link:protocol-v2.html[protocol-v2]
+documentation for a discussion of the bundle-uri command, and the
+expectations of clients and servers.
+
+This document is a a more general discussion of how the `bundle-uri`
+command fits in with the rest of the git ecosystem, its design goals
+and non-goals, comparison to alternatives etc.
+
+Comparison with Packfile URIs
+-----------------------------
+
+There is a similar "Packfile URIs" facility, see the
+link:packfile-uri.html[packfile-uri] documentation for details.
+
+The Packfile URIs facility requires a much closer cooperation between
+CDN and server than the bundle URI facility.
+
+I.e. the server MUST know what objects exist in the packfile URI it's
+pointing to, as well as its pack checksum. Failure to do so will not
+only result in a client error (the packfile hash won't match), but
+even if it got past that would likely result in a corrupt repository
+with tips pointing to unreachable objects.
+
+By comparison the bundle URIs are meant to be a "dumb" solution
+friendly to e.g. having a weekly cronjob take a snapshot of a git
+repository, that snapshot being uploaded to a network of FTP mirrors
+(which may be inconsistent or out of date).
+
+The server does not need to know what state the side-channel download
+is at, because the client will first validate it, and then optionally
+negotiate with the server using what it discovers there.
+
+Using the local `transfer.injectBundleURI` configuration variable (see
+linkgit:git-config[1]) the `bundle-uri` mechanism doesn't even need
+the server to support it.
+
+Security
+--------
+
+The omission of something equivalent to the packfile <OID> in the
+Packfile URIs protocol is intentional, as having it would require
+closer server and CDN cooperation than some server operators are
+comfortable with.
+
+Furthermore, it is not needed for security. The server doesn't need to
+trust its CDN. If the server were to attempt to send harmful content
+to the client, the result would not validate against the server's
+provided ref tips gotten from ls-refs.
+
+The lack of a such a hash does leave room open to a malicious CDN
+operation to be annoying however. E.g. they could inject irrelevant
+objects into the bundles, which would enlarge the downloaded
+repository until a "gc" would eventually throw them away.
+
+In practice the lack of a hash is considered to be a non-issue. Anyone
+concerned about such security problems between their server and their
+CDN is going to be pointing to a "https" URL under their control. For
+a client the "threat" is the same as without bundle-uri, i.e. a server
+is free to be annoying today and send you garbage in the PACK that you
+won't need.
+
+Security issues peculiar to bundle-uri
+--------------------------------------
+
+Both packfile-uri and bundle-uri use the `fetch.uriProtocols`
+configuration variable (see linkgit:git-config[1]) to configure which
+protocols they support.
+
+By default this is set to "http,https" for both, but bundle-uri
+supports adding "file" to that list. The server can thus point to
+"file://" URIs it expects the client to have access to.
+
+This is primarily intended for use with the `transfer.injectBundleURI`
+mechanism, but can also be useful e.g. in a centralized environment
+where a server might point to a "file:///mnt/bundles/big-repo.bdl" it
+knows to be mounted on the local machine (e.g. a racked server),
+points to it in its "bundle-uri" response.
+
+The client can then add "file" to the `fetch.uriProtocols` list to
+obey such responses. That does mean that a malicious server can point
+to any arbitrary file on the local machine. The threat of this is
+considered minimal, since anyone adding `file` to `fetch.uriProtocols`
+likely knows what they're doing and controls both ands, and the worst
+they can do is make a curl(1) pipe garbage into "index-pack" (which
+will likely promptly die on the non-PACK-file).
+
+Security comparison with packfile-uri
+-------------------------------------
+
+The initial implementation of packfile-uri needed special adjusting to
+run "git fsck" on incoming .gitmodules files, this was to deal with a
+general security issue in git, See CVE-2018-17456.
+
+The current packfile-uri mechanism requires special handling around
+"fsck" to do such cross-PACK fsck's, this is because it first indexes
+the "incremental" PACK, and then any PACK(s) provided via
+packfile-uri, before finally doing a full connectivity check.
+
+This is effect doing the fsck one might do via "clone" and "fetch" in
+reverse, or the equivalent of starting with the incremental "fetch",
+followed by the "clone".
+
+Since the packfile-uri mechanism can result in the .gitmodules blob
+referenced by such a "fetch" to be in the pack for the "clone" the
+fetch-pack process needs to keep state between the indexing of
+multiple packs, to remember to fsck the blob (via the "clone") later
+after seeing it in a tree (from the "fetch).
+
+There are no known security issues with the way packfile-uri does
+this, but since bundle-uri effectively emulates what a which doesn't
+support either "bundle-uri" or "packfile-uri" would do on clone/fetch,
+any future security issues peculiar to the packfile-uri approach are
+unlikely to be shared by it.
diff --git a/Documentation/technical/protocol-v2.txt b/Documentation/technical/protocol-v2.txt
index 3ea96add398..3a51492049f 100644
--- a/Documentation/technical/protocol-v2.txt
+++ b/Documentation/technical/protocol-v2.txt
@@ -775,3 +775,8 @@ A client receiving such a a response MAY assume that they can skip
 retrieving the header from a bundle at the indicated URI, and thus
 save themselves and the server(s) the request(s) needed to inspect the
 headers of that bundle or bundles.
+
+bundle-uri SEE ALSO
+^^^^^^^^^^^^^^^^^^^
+
+See the link:bundle-uri.html[Bundle URI Design Notes] for more.
-- 
2.35.1.1337.g7e32d794afe

