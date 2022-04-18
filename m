Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58CFFC433F5
	for <git@archiver.kernel.org>; Mon, 18 Apr 2022 17:26:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347111AbiDRR3C (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 Apr 2022 13:29:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347065AbiDRR1Q (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Apr 2022 13:27:16 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91EA4344F1
        for <git@vger.kernel.org>; Mon, 18 Apr 2022 10:24:36 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id p189so9107622wmp.3
        for <git@vger.kernel.org>; Mon, 18 Apr 2022 10:24:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xDYqEqHxyEyGILxOcoZHSKFD1owA4ymJAbaaxnEUKEE=;
        b=Foi4A1Z6y2D2fzIKtqyhkgEgUuF2cK3q1x4B1lNKOkYUWZWvSaolBIedF7AFDZiGCw
         cqFYADWvspTMoK23plPm6X3JVABvI7kPuQe7LOhvraJVrdRtI3DV+2x30Un9ssy187P+
         EdGKQtLU0tTvWYLkQTQn/NgWkEmlg1F5ietE+/mpIr+UA0sPqeLyaNYJmEthDYZUcKpu
         17GmRPeKSFm9y1ZVNlUOltqp777cjj8If2YsMj+32TFrRJuuj9XuzpP+GqR+OP+8+PPJ
         C9lq0Volw0Q/aNquKe7HgHOOLPCn0Ki9ZowdUEnIg3Y/c59Ung5DytH5YqWxebGF2cNV
         j6yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xDYqEqHxyEyGILxOcoZHSKFD1owA4ymJAbaaxnEUKEE=;
        b=NIx+usOsnfpH+9OTDozDhz6dzUxU80uh4KuL23vaJawmG1lHqJcvkhXj3nNpB15mYb
         Wi57yaV5MOi/5h3EppImnS223gl1CFfFNmphmRd3SlGBF/qqs9tVPo8SvNCchW4A4yVv
         UThAtayf0f5zAle6QcLfOTRo5/FiNafE/fgnoaUNXn7nrmuAZwyJAdMQgyJjNwUHxRQr
         8r2foxKSEK9Wd0TWxQgGSWeRDyFanHPnWK44ZiAzBJg7zmee7R8BWX8W/3n7I7IdgRgv
         bkMRtGUmvn62AndSwv2ch/lKvE6j4SUxeCWoGOkfxISmXY9kzoTIWsCpr3YhYMu55Rx4
         ALqQ==
X-Gm-Message-State: AOAM531g6xtHz7OMTd/wOvkfYr9V89Axld7VvTSct4gL+2ROOb/4unGI
        J6sw3f5QQBqX8KjRxAxraxkYS4zYywQBZA==
X-Google-Smtp-Source: ABdhPJwCULvlXHGnjsRZtQq+DCoCbHW2vY7BzrwU9DMpRjYx3xE5/5CDl/Z3IO4t436zjn9trMZQmQ==
X-Received: by 2002:a1c:7408:0:b0:38e:b7af:c503 with SMTP id p8-20020a1c7408000000b0038eb7afc503mr16234512wmc.58.1650302674662;
        Mon, 18 Apr 2022 10:24:34 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id m20-20020a05600c3b1400b0038ebbbb2ad2sm16803066wms.44.2022.04.18.10.24.33
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
Subject: [RFC PATCH v2 34/36] protocol v2: add server-side "bundle-uri" skeleton (docs)
Date:   Mon, 18 Apr 2022 19:23:51 +0200
Message-Id: <RFC-patch-v2-34.36-f872793cac2-20220418T165545Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.0.rc2.902.g60576bbc845
In-Reply-To: <RFC-cover-v2-00.36-00000000000-20220418T165545Z-avarab@gmail.com>
References: <RFC-cover-v2-00.13-00000000000-20220311T155841Z-avarab@gmail.com> <RFC-cover-v2-00.36-00000000000-20220418T165545Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/technical/protocol-v2.txt | 209 ++++++++++++++++++++++++
 1 file changed, 209 insertions(+)

diff --git a/Documentation/technical/protocol-v2.txt b/Documentation/technical/protocol-v2.txt
index 8a877d27e23..3ea96add398 100644
--- a/Documentation/technical/protocol-v2.txt
+++ b/Documentation/technical/protocol-v2.txt
@@ -566,3 +566,212 @@ and associated requested information, each separated by a single space.
 	attr = "size"
 
 	obj-info = obj-id SP obj-size
+
+bundle-uri
+~~~~~~~~~~
+
+If the 'bundle-uri' capability is advertised, the server supports the
+`bundle-uri' command.
+
+The capability is currently advertised with no value (i.e. not
+"bundle-uri=somevalue"), a value may be added in the future for
+supporting command-wide extensions. Clients MUST ignore any unknown
+capability values and proceed with the 'bundle-uri` dialog they
+support.
+
+The 'bundle-uri' command is intended to be issued before `fetch` to
+get URIs to bundle files (see linkgit:git-bundle[1]) to "seed" and
+inform the subsequent `fetch` command.
+
+The client CAN issue `bundle-uri` before or after any other valid
+command. To be useful to clients it's expected that it'll be issued
+after an `ls-refs` and before `fetch`, but CAN be issued at any time
+in the dialog.
+
+DISCUSSION of bundle-uri
+^^^^^^^^^^^^^^^^^^^^^^^^
+
+The intent of the feature is optimize for server resource consumption
+in the common case by changing the common case of fetching a very
+large PACK during linkgit:git-clone[1] into a smaller incremental
+fetch.
+
+It also allows servers to achieve better caching in combination with
+an `uploadpack.packObjectsHook` (see linkgit:git-config[1]).
+
+By having new clones or fetches be a more predictable and common
+negotiation against the tips of recently produces *.bundle file(s).
+Servers might even pre-generate the results of such negotiations for
+the `uploadpack.packObjectsHook` as new pushes come in.
+
+I.e. the server would anticipate that fresh clones will download a
+known bundle, followed by catching up to the current state of the
+repository using ref tips found in that bundle (or bundles).
+
+PROTOCOL for bundle-uri
+^^^^^^^^^^^^^^^^^^^^^^^
+
+A `bundle-uri` request takes no arguments, and as noted above does not
+currently advertise a capability value. Both may be added in the
+future.
+
+When the client issues a `command=bundle-uri` the response is a list
+of URIs the server would like the client to fetch out-of-bounds before
+proceeding with the `fetch` request in this format:
+
+	output = bundle-uri-line
+		 bundle-uri-line* flush-pkt
+
+	bundle-uri-line = PKT-LINE(bundle-uri)
+			  *(SP bundle-feature-key *(=bundle-feature-val))
+			  LF
+
+	bundle-uri = A URI such as a https://, ssh:// etc. URI
+
+	bundle-feature-key = Any printable ASCII characters except SP or "="
+	bundle-feature-val = Any printable ASCII characters except SP or "="
+
+No `bundle-feature-key`=`bundle-feature-value` fields are currently
+defined. See the discussion of features below.
+
+Clients are still expected to fully parse the line according to the
+above format, lines that do not conform to the format SHOULD be
+discarded. The user MAY be warned in such a case.
+
+bundle-uri CLIENT AND SERVER EXPECTATIONS
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+".bundle" FORMAT
+++++++++++++++++
+
+The advertised bundle(s) MUST be in a format that "git bundle verify"
+would accept. I.e. they MUST contain one or more reference tips for
+use by the client, MUST indicate prerequisites (in any) with standard
+"-" prefixes, and MUST indicate their "object-format", if
+applicable. Create "*.bundle" files with "git bundle create".
+
+bundle-uri CLIENT ERROR RECOVERY
+++++++++++++++++++++++++++++++++
+
+A client MUST above all gracefully degrade on errors, whether that
+error is because of bad missing/data in the bundle URI(s), because
+that client is too dumb to e.g. understand and fully parse out bundle
+headers and their prerequisite relationships, or something else.
+
+Server operators should feel confident in turning on "bundle-uri" and
+not worry if e.g. their CDN goes down that clones or fetches will run
+into hard failures. Even if the server bundle bundle(s) are
+incomplete, or bad in some way the client should still end up with a
+functioning repository, just as if it had chosen not to use this
+protocol extension.
+
+All subsequent discussion on client and server interaction MUST keep
+this in mind.
+
+bundle-uri SERVER TO CLIENT
++++++++++++++++++++++++++++
+
+The ordering of the returned bundle uris is not significant. Clients
+MUST parse their headers to discover their contained OIDS and
+prerequisites. A client MUST consider the content of the bundle(s)
+themselves and their header as the ultimate source of truth.
+
+A server MAY even return bundle(s) that don't have any direct
+relationship to the repository being cloned (either through accident,
+or intentional "clever" configuration), and expect a client to sort
+out what data they'd like from the bundle(s), if any.
+
+bundle-uri CLIENT TO SERVER
++++++++++++++++++++++++++++
+
+The client SHOULD provide reference tips found in the bundle header(s)
+as 'have' lines in any subsequent `fetch` request. A client MAY also
+ignore the bundle(s) entirely if doing so is deemed worse for some
+reason, e.g. if the bundles can't be downloaded, it doesn't like the
+tips it finds etc.
+
+WHEN ADVERTISED BUNDLE(S) REQUIRE NO FURTHER NEGOTIATION
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++
+
+If after issuing `bundle-uri` and `ls-refs`, and getting the header(s)
+of the bundle(s) the client finds that the ref tips it wants can be
+retrieved entirety from advertised bundle(s), it MAY disconnect. The
+results of such a 'clone' or 'fetch' should be indistinguishable from
+the state attained without using bundle-uri.
+
+EARLY CLIENT DISCONNECTIONS AND ERROR RECOVERY
+++++++++++++++++++++++++++++++++++++++++++++++
+
+A client MAY perform an early disconnect while still downloading the
+bundle(s) (having streamed and parsed their headers). In such a case
+the client MUST gracefully recover from any errors related to
+finishing the download and validation of the bundle(s).
+
+I.e. a client might need to re-connect and issue a 'fetch' command,
+and possibly fall back to not making use of 'bundle-uri' at all.
+
+This "MAY" behavior is specified as such (and not a "SHOULD") on the
+assumption that a server advertising bundle uris is more likely than
+not to be serving up a relatively large repository, and to be pointing
+to URIs that have a good chance of being in working order. A client
+MAY e.g. look at the payload size of the bundles as a heuristic to see
+if an early disconnect is worth it, should falling back on a full
+"fetch" dialog be necessary.
+
+WHEN ADVERTISED BUNDLE(S) REQUIRE FURTHER NEGOTIATION
++++++++++++++++++++++++++++++++++++++++++++++++++++++
+
+A client SHOULD commence a negotiation of a PACK from the server via
+the "fetch" command using the OID tips found in advertised bundles,
+even if's still in the process of downloading those bundle(s).
+
+This allows for aggressive early disconnects from any interactive
+server dialog. The client blindly trusts that the advertised OID tips
+are relevant, and issues them as 'have' lines, it then requests any
+tips it would like (usually from the "ls-refs" advertisement) via
+'want' lines. The server will then compute a (hopefully small) PACK
+with the expected difference between the tips from the bundle(s) and
+the data requested.
+
+The only connection the client then needs to keep active is to the
+concurrently downloading static bundle(s), when those and the
+incremental PACK are retrieved they should be inflated and
+validated. Any errors at this point should be gracefully recovered
+from, see above.
+
+bundle-uri PROTOCOL FEATURES
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+As noted above no `bundle-feature-key`=`bundle-feature-value` fields
+are currently defined.
+
+They are intended for future per-URI metadata which older clients MUST
+ignore and gracefully degrade on. Any fields they do recognize they
+CAN also ignore.
+
+Any backwards-incompatible addition of pre-URI key-value will be
+guarded by a new value or values in 'bundle-uri' capability
+advertisement itself, and/or by new future `bundle-uri` request
+arguments.
+
+While no per-URI key-value are currently supported currently they're
+intended to support future features such as:
+
+ * Add a "hash=<val>" or "size=<bytes>" advertise the expected hash or
+   size of the bundle file.
+
+ * Advertise that one or more bundle files are the same (to e.g. have
+   clients round-robin or otherwise choose one of N possible files).
+
+ * A "oid=<OID>" shortcut and "prerequisite=<OID>" shortcut. For
+   expressing the common case of a bundle with one tip and no
+   prerequisites, or one tip and one prerequisite.
++
+This would allow for optimizing the common case of servers who'd like
+to provide one "big bundle" containing only their "main" branch,
+and/or incremental updates thereof.
++
+A client receiving such a a response MAY assume that they can skip
+retrieving the header from a bundle at the indicated URI, and thus
+save themselves and the server(s) the request(s) needed to inspect the
+headers of that bundle or bundles.
-- 
2.36.0.rc2.902.g60576bbc845

