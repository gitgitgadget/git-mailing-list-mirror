Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0A66C433EF
	for <git@archiver.kernel.org>; Mon, 18 Apr 2022 17:26:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347157AbiDRR3E (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 Apr 2022 13:29:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347066AbiDRR1R (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Apr 2022 13:27:17 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5265C34662
        for <git@vger.kernel.org>; Mon, 18 Apr 2022 10:24:37 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id v64-20020a1cac43000000b0038cfd1b3a6dso12137849wme.5
        for <git@vger.kernel.org>; Mon, 18 Apr 2022 10:24:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/WdN7Z8+qMpKJJhIVHokR1wNKXm5kmWSXrJ5SGrj0uc=;
        b=Ak4s2usT1W9q0lfGjxQpAzfYscGyv5TzkMOIc/ZMzJ/g1CAxBK6f39QZvflMvzueW4
         sota6kHuIqetAJrwzmBYHywekK/Nl7KM1tq54mljNSqqQ3ff4luZdaGQMRaeIkWvaRa/
         +WMFGdvk+AkwVm/zJJRhpZJj/V86LWeNNjCzq1kYpnjq9adgXCXPBNdnk24BUBw7TN8/
         BzKTYO+U6AF+JmCbUsxmy2+wQXOEAm/PV4TK1Jw1ckihIT0E1b35+N2Xuvovu27gUeaH
         9VdSfUpxwizSvLOvFEM4O8LRvombxICgagKv1F+J4/h5+fDN2hXMyQrzKtm6PexsUTfm
         5hUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/WdN7Z8+qMpKJJhIVHokR1wNKXm5kmWSXrJ5SGrj0uc=;
        b=R5giX0t+nSGvMcRIb5E2fMVBJxm0JKWqMmVqJqDfDeHeFS/KCKL1HxqOgYIBnLENBb
         niJsDrPiSB9y8pRSvT2R2pIPcCV5DLuBuA6jd1P5jY6+1ybHMijnuxxlw0CIDHUrLWlO
         kfuGYvtbs+QeDE4h63j6qmu0Y0F1pC3BSWYFl/btXJL5Di6+4/MALDftJEqFQwg8UOsU
         Sc893cfimgBPsqnK+rNGjP5pL9CnLvt6NueNqVYZp7OShHiZ9dfAj/p4wOAWdVWqRsgn
         JwAkTZJQcg8OhFYnlxrdKIxRq5aUm0UhoyH9XvDPY9SLCKRSJiJ15uzfrPgp/rjSynpY
         gnRQ==
X-Gm-Message-State: AOAM531QhU7n6TO1+GzKL6IU7rdFR8NikBRPRaw4noeZ5BJSjA/AVsQK
        WLD6QJUyppPJJ+YbOD1RAt8xbXANAfPb+g==
X-Google-Smtp-Source: ABdhPJw4hddbSWe5KDI1ISBhyK1tY2/ppJ++Tq0x0w+jL8O1c3Cs2/JqpoStP7bwdO5rZJIvE0mvpw==
X-Received: by 2002:a05:600c:3b8b:b0:392:9897:1edf with SMTP id n11-20020a05600c3b8b00b0039298971edfmr4349987wms.108.1650302675562;
        Mon, 18 Apr 2022 10:24:35 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id m20-20020a05600c3b1400b0038ebbbb2ad2sm16803066wms.44.2022.04.18.10.24.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Apr 2022 10:24:34 -0700 (PDT)
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
Subject: [RFC PATCH v2 35/36] bundle-uri docs: add design notes
Date:   Mon, 18 Apr 2022 19:23:52 +0200
Message-Id: <RFC-patch-v2-35.36-cfda9323aaa-20220418T165545Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.0.rc2.902.g60576bbc845
In-Reply-To: <RFC-cover-v2-00.36-00000000000-20220418T165545Z-avarab@gmail.com>
References: <RFC-cover-v2-00.13-00000000000-20220311T155841Z-avarab@gmail.com> <RFC-cover-v2-00.36-00000000000-20220418T165545Z-avarab@gmail.com>
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
2.36.0.rc2.902.g60576bbc845

