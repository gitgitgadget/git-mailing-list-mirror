Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D710FC433FE
	for <git@archiver.kernel.org>; Mon, 18 Apr 2022 17:26:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347196AbiDRR3G (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 Apr 2022 13:29:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347112AbiDRR1V (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Apr 2022 13:27:21 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C0FA34663
        for <git@vger.kernel.org>; Mon, 18 Apr 2022 10:24:38 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id m15-20020a7bca4f000000b0038fdc1394b1so8635504wml.2
        for <git@vger.kernel.org>; Mon, 18 Apr 2022 10:24:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=89VhNkxyyTW94cxi5WwI/FkTyfxliROiEXZnvIQXXNU=;
        b=I3H4TvQHKwkNE3Hbja6wbdposMMUhdivlElgW3EeUjn1IBnywMMWtFA5bNhMz1AFsx
         b+MjeFwgkpbl4juTnySkt5TwnW8xy79KTETCOkX43ju1NZ7NEI3S7AArcaoGnuxEpcwl
         J7Ye/x8RrW+VFBhHutpgonwdoM/NDiPOonUCrMBs6kd1ynxb6QibRMgBpxnvr/RPKKSX
         v14Diymq96fPYRgNd8P9vl+i4lGtlijhRAWZcTWt0FSPE8TQ3YqsejlqG6gwN3qidvrc
         ok2ZQcntbCj7bfppU15ecB1PYjNcXA1VvmS8tEBkFV0xueBB9guC8MGjB/i2uM6OVvZj
         3Qrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=89VhNkxyyTW94cxi5WwI/FkTyfxliROiEXZnvIQXXNU=;
        b=0PEgPm7g3fmF734Vyc+Il+Vsud85Ub2e3NiFd/bwM7NUcQc4hQhkhm8uNLIxCBcTYg
         VEDDqeFXe+T+q3W3iMhzEBdntBFHrcqBKc106JmsYdinopUvbbB2ectVWgyR3kBb/KQ5
         y7CB9ekEowMmyKwCSbmlF/Y2VLuwdKIZaWNjyeDoxjCriDGxAc6OTLc4bmhwi8PiTx7m
         +pfvttKk3jQxGEsGxqKBcO4qjGI4kJ7bnfQPrxc32t7Hutk/ePSA2xMSkC1oteysQSG/
         phOXxWzjTMg+Rn4ETfPtDkSOfQLJhHcdWa+LhHPi9UCiVeJMBq1A0kd4NvkT3vmmCcjI
         68qA==
X-Gm-Message-State: AOAM530bIdqsjXhxVtVo0YZlcZvhxjqmMjbuMi9qucawGESvY2u6m8W1
        tVmYkYdLse4IMlOU/zjzULy/urTT63sMrw==
X-Google-Smtp-Source: ABdhPJyp6N9aB6IOTq5V4gRRYWNTwW4DbWynw1psjRckNerfuBvtKaqqELEv3YqctZ/CCXNT+2pXBQ==
X-Received: by 2002:a7b:c016:0:b0:38f:53c2:b8b3 with SMTP id c22-20020a7bc016000000b0038f53c2b8b3mr15870974wmb.13.1650302676436;
        Mon, 18 Apr 2022 10:24:36 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id m20-20020a05600c3b1400b0038ebbbb2ad2sm16803066wms.44.2022.04.18.10.24.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Apr 2022 10:24:35 -0700 (PDT)
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
Subject: [RFC PATCH v2 36/36] docs: document bundle URI standard
Date:   Mon, 18 Apr 2022 19:23:53 +0200
Message-Id: <RFC-patch-v2-36.36-764f82a0c0a-20220418T165545Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.0.rc2.902.g60576bbc845
In-Reply-To: <RFC-cover-v2-00.36-00000000000-20220418T165545Z-avarab@gmail.com>
References: <RFC-cover-v2-00.13-00000000000-20220311T155841Z-avarab@gmail.com> <RFC-cover-v2-00.36-00000000000-20220418T165545Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

Introduce the idea of bundle URIs to the Git codebase through an
aspirational design document. This document includes the full design
intended to include the feature in its fully-implemented form. This will
take several steps as detailed in the Implementation Plan section.

By committing this document now, it can be used to motivate changes
necessary to reach these final goals. The design can still be altered as
new information is discovered.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/technical/bundle-uri-TOC.txt | 404 +++++++++++++++++++++
 1 file changed, 404 insertions(+)
 create mode 100644 Documentation/technical/bundle-uri-TOC.txt

diff --git a/Documentation/technical/bundle-uri-TOC.txt b/Documentation/technical/bundle-uri-TOC.txt
new file mode 100644
index 00000000000..4763449e88b
--- /dev/null
+++ b/Documentation/technical/bundle-uri-TOC.txt
@@ -0,0 +1,404 @@
+Bundle URIs
+===========
+
+Bundle URIs are locations where Git can download one or more bundles in
+order to bootstrap the object database in advance of fetching the remaining
+objects from a remote.
+
+One goal is to speed up clones and fetches for users with poor network
+connectivity to the origin server. Another benefit is to allow heavy users,
+such as CI build farms, to use local resources for the majority of Git data
+and thereby reducing the load on the origin server.
+
+To enable the bundle URI feature, users can specify a bundle URI using
+command-line options or the origin server can advertise one or more URIs
+via a protocol v2 capability.
+
+Server requirements
+-------------------
+
+To provide a server-side implementation of bundle servers, no other parts
+of the Git protocol are required. This allows server maintainers to use
+static content solutions such as CDNs in order to serve the bundle files.
+
+At the current scope of the bundle URI feature, all URIs are expected to
+be HTTP(S) URLs where content is downloaded to a local file using a `GET`
+request to that URL. The server could include authentication requirements
+to those requests with the aim of triggering the configured credential
+helper for secure access.
+
+Assuming a `200 OK` response from the server, the content at the URL is
+expected to be of one of two forms:
+
+1. Bundle: A Git bundle file of version 2 or higher.
+
+2. Table of Contents: A plain-text file that is parsable using Git's
+   config file parser. This file describes one or more bundles that are
+   accessible from other URIs.
+
+Any other data provided by the server is considered erroneous.
+
+Table of Contents Format
+------------------------
+
+If the content at a bundle URI is not a bundle, then it is expected to be
+a plaintext file that is parseable using Git's config parser. This file
+can contain any list of key/value pairs, but only a fixed set will be
+considered by Git.
+
+bundle.tableOfContents.version::
+	This value provides a version number for the table of contents. If
+	a future Git change enables a feature that needs the Git client to
+	react to a new key in the table of contents file, then this version
+	will increment. The only current version number is 1, and if any
+	other value is specified then Git will fail to use this file.
+
+bundle.tableOfContents.forFetch::
+	This boolean value is a signal to the Git client that the bundle
+	server has designed its bundle organization to assist `git fetch`
+	commands in addition to `git clone` commands. If this is missing,
+	Git should not use this table of contents for `git fetch` as it
+	may lead to excess data downloads.
+
+The remaining keys include an `<id>` segment which is a server-designated
+name for each available bundle.
+
+bundle.<id>.uri::
+	This string value is the URI for downloading bundle `<id>`. If
+	the URI begins with a protocol (`http://` or `https://`) then the
+	URI is absolute. Otherwise, the URI is interpreted as relative to
+	the URI used for the table of contents. If the URI begins with `/`,
+	then that relative path is relative to the domain name used for
+	the table of contents. (This use of relative paths is intended to
+	make it easier to distribute a set of bundles across a large
+	number of servers or CDNs with different domain names.)
+
+bundle.<id>.timestamp::
+	(Optional) This value is the number of seconds since Unix epoch
+	(UTC) that this bundle was created. This is used as an approximation
+	of a point in time that the bundle matches the data available at
+	the origin server.
+
+bundle.<id>.requires::
+	(Optional) This string value represents the ID of another bundle.
+	When present, the server is indicating that this bundle contains a
+	thin packfile. If the client does not have all necessary objects
+	to unbundle this packfile, then the client can download the bundle
+	with the `requires` ID and try again. (Note: it may be beneficial
+	to allow the server to specify multiple `requires` bundles.)
+
+bundle.<id>.filter::
+	(Optional) This string value represents an object filter that
+	should also appear in the header of this bundle. The server uses
+	this value to differentiate different kinds of bundles from which
+	the client can choose those that match their object filters.
+
+Here is an example table of contents:
+
+```
+[bundle "tableofcontents"]
+	version = 1
+	forFetch = true
+
+[bundle "2022-02-09-1644442601-daily"]
+	uri = https://gitbundleserver.z13.web.core.windows.net/git/git/2022-02-09-1644442601-daily.bundle
+	timestamp = 1644442601
+	requires = 2022-02-02-1643842562
+
+[bundle "2022-02-02-1643842562"]
+	uri = https://gitbundleserver.z13.web.core.windows.net/git/git/2022-02-02-1643842562.bundle
+	timestamp = 1643842562
+
+[bundle "2022-02-09-1644442631-daily-blobless"]
+	uri = 2022-02-09-1644442631-daily-blobless.bundle
+	timestamp = 1644442631
+	requires = 2022-02-02-1643842568-blobless
+	filter = blob:none
+
+[bundle "2022-02-02-1643842568-blobless"]
+	uri = /git/git/2022-02-02-1643842568-blobless.bundle
+	timestamp = 1643842568
+	filter = blob:none
+```
+
+This example uses all of the keys in the specification. Suppose that the
+table of contents was found at the URI
+`https://gitbundleserver.z13.web.core.windows.net/git/git/` and so the
+two blobless bundles have the following fully-expanded URIs:
+
+* `https://gitbundleserver.z13.web.core.windows.net/git/git/2022-02-09-1644442631-daily-blobless.bundle`
+* `https://gitbundleserver.z13.web.core.windows.net/git/git/2022-02-02-1643842568-blobless.bundle`
+
+Advertising Bundle URIs
+-----------------------
+
+If a user knows a bundle URI for the repository they are cloning, then they
+can specify that URI manually through a command-line option. However, a
+Git host may want to advertise bundle URIs during the clone operation,
+helping users unaware of the feature.
+
+Note: The exact details of this section are not final. This is a possible
+way that Git could auto-discover bundle URIs, but is not a committed
+direction until that feature is implemented.
+
+The only thing required for this feature is that the server can advertise
+one or more bundle URIs. One way to implement this is to create a new
+protocol v2 capability that advertises recommended features, including
+bundle URIs.
+
+The client could choose an arbitrary bundle URI as an option _or_ select
+the URI with lowest latency by some exploratory checks. It is up to the
+server operator to decide if having multiple URIs is preferable to a
+single URI that is geodistributed through server-side infrastructure.
+
+Cloning with Bundle URIs
+------------------------
+
+The primary need for bundle URIs is to speed up clones. The Git client
+will interact with bundle URIs according to the following flow:
+
+1. The user specifies a bundle URI with the `--bundle-uri` command-line
+   option _or_ the client discovers a bundle URI that was advertised by
+   the remote server.
+
+2. The client downloads the file at the bundle URI. If it is a bundle, then
+   it is unbundled with the refs being stored in `refs/bundle/*`.
+
+3. If the file is instead a table of contents, then the bundles with
+   matching `filter` settings are sorted by `timestamp` (if present),
+   and the most-recent bundle is downloaded.
+
+4. If the current bundle header mentions negative commid OIDs that are not
+   in the object database, then download the `requires` bundle and try
+   again.
+
+5. After inspecting a bundle with no negative commit OIDs (or all OIDs are
+   already in the object database somehow), then unbundle all of the
+   bundles in reverse order, placing references within `refs/bundle/*`.
+
+6. The client performs a fetch negotiation with the origin server, using
+   the `refs/bundle/*` references as `have`s and the server's ref
+   advertisement as `want`s. This results in a pack-file containing the
+   remaining objects requested by the clone but not in the bundles.
+
+Note that during a clone we expect that all bundles will be required. The
+client could be extended to download all bundles in parallel, though they
+need to be unbundled in the correct order.
+
+If a table of contents is used and it contains
+`bundle.tableOfContents.forFetch = true`, then the client can store a
+config value indicating to reuse this URI for later `git fetch` commands.
+In this case, the client will also want to store the maximum timestamp of
+a downloaded bundle.
+
+Fetching with Bundle URIs
+-------------------------
+
+When the client fetches new data, it can decide to fetch from bundle
+servers before fetching from the origin remote. This could be done via
+a command-line option, but it is more likely useful to use a config value
+such as the one specified during the clone.
+
+The fetch operation follows the same procedure to download bundles from a
+table of contents (although we do _not_ want to use parallel downloads
+here). We expect that the process will end because all negative commit
+OIDs in a thin bundle are already in the object database.
+
+A further optimization is that the client can avoid downloading any
+bundles if their timestamps are not larger than the stored timestamp.
+After fetching new bundles, this local timestamp value is updated.
+
+Choices for Bundle Server Organization
+--------------------------------------
+
+With this standard, there are many options available to the bundle server
+in how it organizes Git data into bundles.
+
+* Bundles can have whatever name the server desires. This name could refer
+  to immutable data by using a hash of the bundle contents. However, this
+  means that a new URI will be needed after every update of the content.
+  This might be acceptable if the server is advertising the URI (and the
+  server is aware of new bundles being generated) but would not be
+  ergonomic for users using the command line option.
+
+* If the server intends to only serve full clones, then the advertised URI
+  could be a bundle file without a filter that is updated at some cadence.
+
+* If the server intends to serve clones, but wants clients to choose full
+  or blobless partial clones, then the server can use a table of contents
+  that lists two non-thin bundles and the client chooses between them only
+  by the `bundle.<id>.filter` values.
+
+* If the server intends to improve clones with parallel downloads, then it
+  can use a table of contents and split the repository into time intervals
+  of approximately similar-sized bundles. Using `bundle.<id>.timestamp`
+  and `bundle.<id>.requires` values helps the client decide the order to
+  unbundle the bundles.
+
+* If the server intends to serve fetches, then it can use a table of
+  contents to advertise a list of bundles that are updated regularly. The
+  most recent bundles could be generated on short intervals, such as hourly.
+  These small bundles could be merged together at some rate, such as 24
+  hourly bundles merging into a single daily bundle. At some point, it may
+  be beneficial to create a bundle that stores the majority of the history,
+  such as all data older than 30 days.
+
+These recommendations are intended only as suggestions. Each repository is
+different and every Git server has different needs. Hopefully the bundle
+URI feature and its table of contents is flexible enough to satisfy all
+needs. If not, then the format can be extended.
+
+Error Conditions
+----------------
+
+If the Git client discovers something unexpected while downloading
+information according to a bundle URI or the table of contents found at
+that location, then Git can ignore that data and continue as if it was not
+given a bundle URI. The remote Git server is the ultimate source of truth,
+not the bundle URI.
+
+Here are a few example error conditions:
+
+* The client fails to connect with a server at the given URI or a connection
+  is lost without any chance to recover.
+
+* The client receives a response other than `200 OK` (such as `404 Not Found`,
+  `401 Not Authorized`, or `500 Internal Server Error`).
+
+* The client receives data that is not parsable as a bundle or table of
+  contents.
+
+* The table of contents describes a directed cycle in the
+  `bundle.<id>.requires` links.
+
+* A bundle includes a filter that does not match expectations.
+
+* The client cannot unbundle the bundles because the negative commit OIDs
+  are not in the object database and there are no more
+  `bundle.<id>.requires` links to follow.
+
+There are also situations that could be seen as wasteful, but are not
+error conditions:
+
+* The downloaded bundles contain more information than is requested by
+  the clone or fetch request. A primary example is if the user requests
+  a clone with `--single-branch` but downloads bundles that store every
+  reachable commit from all `refs/heads/*` references. This might be
+  initially wasteful, but perhaps these objects will become reachable by
+  a later ref update that the client cares about.
+
+* A bundle download during a `git fetch` contains objects already in the
+  object database. This is probably unavoidable if we are using bundles
+  for fetches, since the client will almost always be slightly ahead of
+  the bundle servers after performing its "catch-up" fetch to the remote
+  server. This extra work is most wasteful when the client is fetching
+  much more frequently than the server is computing bundles, such as if
+  the client is using hourly prefetches with background maintenance, but
+  the server is computing bundles weekly. For this reason, the client
+  should not use bundle URIs for fetch unless the server has explicitly
+  recommended it through the `bundle.tableOfContents.forFetch = true`
+  value.
+
+Implementation Plan
+-------------------
+
+This design document is being submitted on its own as an aspirational
+document, with the goal of implementing all of the mentioned client
+features over the course of several patch series. Here is a potential
+outline for submitting these features for full review:
+
+1. Update the `git bundle create` command to take a `--filter` option,
+   allowing bundles to store packfiles restricted to an object filter.
+   This is necessary for using bundle URIs to benefit partial clones.
+
+2. Integrate bundle URIs into `git clone` with a `--bundle-uri` option.
+   This will include the full understanding of a table of contents, but
+   will not integrate with `git fetch` or allow the server to advertise
+   URIs.
+
+3. Integrate bundle URIs into `git fetch`, triggered by config values that
+   are set during `git clone` if the server indicates that the bundle
+   strategy works for fetches.
+
+4. Create a new "recommended features" capability in protocol v2 where the
+   server can recommend features such as bundle URIs, partial clone, and
+   sparse-checkout. These features will be extremely limited in scope and
+   blocked by opt-in config options. The design for this portion could be
+   replaced by a "bundle-uri" capability that only advertises bundle URIs
+   and no other information.
+
+Related Work: Packfile URIs
+---------------------------
+
+The Git protocol already has a capability where the Git server can list
+a set of URLs along with the packfile response when serving a client
+request. The client is then expected to download the packfiles at those
+locations in order to have a complete understanding of the response.
+
+This mechanism is used by the Gerrit server (implemented with JGit) and
+has been effective at reducing CPU load and improving user performance for
+clones.
+
+A major downside to this mechanism is that the origin server needs to know
+_exactly_ what is in those packfiles, and the packfiles need to be available
+to the user for some time after the server has responded. This coupling
+between the origin and the packfile data is difficult to manage.
+
+Further, this implementation is extremely hard to make work with fetches.
+
+Related Work: GVFS Cache Servers
+--------------------------------
+
+The GVFS Protocol [2] is a set of HTTP endpoints designed independently of
+the Git project before Git's partial clone was created. One feature of this
+protocol is the idea of a "cache server" which can be colocated with build
+machines or developer offices to transfer Git data without overloading the
+central server.
+
+The endpoint that VFS for Git is famous for is the `GET /gvfs/objects/{oid}`
+endpoint, which allows downloading an object on-demand. This is a critical
+piece of the filesystem virtualization of that product.
+
+However, a more subtle need is the `GET /gvfs/prefetch?lastPackTimestamp=<t>`
+endpoint. Given an optional timestamp, the cache server responds with a list
+of precomputed packfiles containing the commits and trees that were introduced
+in those time intervals.
+
+The cache server computes these "prefetch" packfiles using the following
+strategy:
+
+1. Every hour, an "hourly" pack is generated with a given timestamp.
+2. Nightly, the previous 24 hourly packs are rolled up into a "daily" pack.
+3. Nightly, all prefetch packs more than 30 days old are rolled up into
+   one pack.
+
+When a user runs `gvfs clone` or `scalar clone` against a repo with cache
+servers, the client requests all prefetch packfiles, which is at most
+`24 + 30 + 1` packfiles downloading only commits and trees. The client
+then follows with a request to the origin server for the references, and
+attempts to checkout that tip reference. (There is an extra endpoint that
+helps get all reachable trees from a given commit, in case that commit
+was not already in a prefetch packfile.)
+
+During a `git fetch`, a hook requests the prefetch endpoint using the
+most-recent timestamp from a previously-downloaded prefetch packfile.
+Only the list of packfiles with later timestamps are downloaded. Most
+users fetch hourly, so they get at most one hourly prefetch pack. Users
+whose machines have been off or otherwise have not fetched in over 30 days
+might redownload all prefetch packfiles. This is rare.
+
+It is important to note that the clients always contact the origin server
+for the refs advertisement, so the refs are frequently "ahead" of the
+prefetched pack data. The missing objects are downloaded on-demand using
+the `GET gvfs/objects/{oid}` requests, when needed by a command such as
+`git checkout` or `git log`. Some Git optimizations disable checks that
+would cause these on-demand downloads to be too aggressive.
+
+See Also
+--------
+
+[1] https://lore.kernel.org/git/RFC-cover-00.13-0000000000-20210805T150534Z-avarab@gmail.com/
+    An earlier RFC for a bundle URI feature.
+
+[2] https://github.com/microsoft/VFSForGit/blob/master/Protocol.md
+    The GVFS Protocol
-- 
2.36.0.rc2.902.g60576bbc845

