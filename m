Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CB24C4338F
	for <git@archiver.kernel.org>; Thu,  5 Aug 2021 15:08:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C54E60EEA
	for <git@archiver.kernel.org>; Thu,  5 Aug 2021 15:08:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241946AbhHEPIQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 5 Aug 2021 11:08:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241835AbhHEPID (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Aug 2021 11:08:03 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F56AC06179B
        for <git@vger.kernel.org>; Thu,  5 Aug 2021 08:07:48 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id z4so6990835wrv.11
        for <git@vger.kernel.org>; Thu, 05 Aug 2021 08:07:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Zq9yKr/AODn6tSpbrJc7ZIRaanX1FQvkpW61hm4i6HI=;
        b=BVHQZ+5BxLKwaapDL3qTsJLrZhqH+hUBjECglirzy3rW/qRUlokWJ4sZn/7aeEy+fo
         InfhvPkzfKRHs2rm9ZeRrkU6qLtfXjs3aSi2OVHl5uqNFbw/oU2pTQOy5vcYmHHBFiEk
         tAekcV2y1ZqY45C3o4e+W8YCiJHwQZhWJEcCxk9b0XMjqVtIgpOgkvnBZ0zkBouX7Coy
         CBvZLAjHb/Iq/CCHlbiYzJ/iBThrntz14RkucxTgphF5F6icZiZLyxk+NeJKT+cLa8Mf
         fAnxtbNjWSPB3hO9Q7PrZntiX3aLDPe4G9XGxuitSVACKJwA9wILdf/Wq72LUwhDLYqW
         gEaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Zq9yKr/AODn6tSpbrJc7ZIRaanX1FQvkpW61hm4i6HI=;
        b=beoeCI2Gn9dpEnqiyRfTh6fIytggD6qG4GJ7dgCgFooZSA4y7RdIEsVvCn4lN3NoJR
         v7MPSjGN6Ba3QOkOlIYZoeNIfrvp4XUmFfg51II2fH++FrZtXPu7W434viHyovnR0ixw
         Yk+5JSlIHyYmsmR4LpegJ7txHmoNB7z6879b9F1Fkh7HIqKbLIKDXZHgSDKph4Ghwl/w
         J9QQs/c6DVRhLuviDD9E5kr8mux6CwHM5WwnR2gvIybDd+sZjExbEoLhPBXBxxVrjiHD
         3ziTA/0KzJN4D5x26IBs6UJCLGRfDDp4f7+hWRoYxV4iBpNDK7FUFinoggM0TEQogwoU
         EmvA==
X-Gm-Message-State: AOAM532M79Q8IyL7E+4tBzfEqL7sJ+uE6ct4LCXAHw6tORF9sh/AUWzp
        sBz1Hum4iCia4svnDbFUnPJcNWRFfZJY4g==
X-Google-Smtp-Source: ABdhPJxsl9vxNwtmVQLR8UVlIRSliaUiaejmDAqkWhuIpJekIaxlhK+gP5dgjp1XzGe4axvS0CO9eg==
X-Received: by 2002:adf:dfcb:: with SMTP id q11mr5896514wrn.16.1628176066612;
        Thu, 05 Aug 2021 08:07:46 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id w4sm6856340wrm.24.2021.08.05.08.07.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Aug 2021 08:07:46 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Patrick Steinhardt <ps@pks.im>,
        Christian Couder <christian.couder@gmail.com>,
        Albert Cui <albertqcui@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [RFC PATCH 13/13] bundle-uri docs: add design notes
Date:   Thu,  5 Aug 2021 17:07:29 +0200
Message-Id: <RFC-patch-13.13-1e657ed27a-20210805T150534Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.rc0.646.g585563e77f
In-Reply-To: <RFC-cover-00.13-0000000000-20210805T150534Z-avarab@gmail.com>
References: <RFC-cover-00.13-0000000000-20210805T150534Z-avarab@gmail.com>
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
index 0000000000..5ae9a15eaf
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
index d10d5e9ef6..5536ea4b7e 100644
--- a/Documentation/technical/protocol-v2.txt
+++ b/Documentation/technical/protocol-v2.txt
@@ -696,3 +696,8 @@ intended to support future features such as:
    they've got that OID already (for multi-tips the client would need
    to fetch the bundle, or do e.g. HTTP range requests to get its
    header).
+
+bundle-uri SEE ALSO
+^^^^^^^^^^^^^^^^^^^
+
+See the link:bundle-uri.html[Bundle URI Design Notes] for more.
-- 
2.33.0.rc0.646.g585563e77f

