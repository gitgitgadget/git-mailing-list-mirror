Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B9F3C433FE
	for <git@archiver.kernel.org>; Fri, 11 Mar 2022 16:24:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350251AbiCKQZi (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Mar 2022 11:25:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349035AbiCKQZg (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Mar 2022 11:25:36 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A478E107AA6
        for <git@vger.kernel.org>; Fri, 11 Mar 2022 08:24:32 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id j17so13796141wrc.0
        for <git@vger.kernel.org>; Fri, 11 Mar 2022 08:24:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Vaa2Oc9THTowLzlXjkxFcuH86ZCUa/Dp/qmcBKXCPXc=;
        b=M0xXecdf7rMFBjsxIAEht3blFgisoojsRq8wm6hbqSiHRnpRJk2BbykJiP7eTGXMQJ
         AHwjsWEewDJ4hfYl6ds4QSLNknEuOg4dNqykG6DrX/9Bx/s+5YP3dcAqjZO5OHtKjKFY
         KQnkuXfsvOKhtBbovSuQ1026dOxlk3cg6fOZ2fDXvoBCNhAxqSL1sV78Bns5bVLBiWRj
         5C+WBOG5t/8Z6d3kYygnFmRIHhgj2n2rtn+yQTqBrgf/9PcXxGbKRBrGE87ORQ3+eYRD
         BChgmoRAyNZBNZyUOUCXsfF1NAC/c/38QZiR+vy86RUBVakB3z8+GOJFA1UKb2z2zo6N
         9Auw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Vaa2Oc9THTowLzlXjkxFcuH86ZCUa/Dp/qmcBKXCPXc=;
        b=pmt8QhszI0cLZAJhyGBN4p2p73idiFRny+nUwv4NW4Tch97lKgF9WZ5VGKH/4bOEil
         0ZsBY7FB/BVsNbOsr+UqGUuBYlI9RdhVCk7fIqRm9Y+4EH45zh5OLFXn5OiD+yGBMTJn
         ysfHPkuWgsU7YwLGRAKsyZMoSyru4Wl/WpySuweNSAGDXxyfaOrsBiwjvUa8nchKtWRQ
         w34/42o+MHCkX4qaWJ1FKlVtWYqk7lyGSP3pv96VVxwQRvFtBHYNKj0JzBTRLQpfSJw9
         lOWCXLQNeME3TQ/9/0gpVVe+UXjNWe2iKs19tWSHqilLH8FJtaxuTq/FGAM74qdydqlU
         72aQ==
X-Gm-Message-State: AOAM531NeTxyUkr3weanKpk/nEX8eblqn4kRX79YZawrq16M01nPhhQD
        RLuNVnu8c7v9KGCe//p8HCuWBQ81vftyZg==
X-Google-Smtp-Source: ABdhPJzRrdfj1h4r2fHqH/2GyByczeDTuWctVSzytl/9bQd2N4mevZaf5qOBsxuol8klhFxlsprtpw==
X-Received: by 2002:a5d:624c:0:b0:1f7:4b77:becb with SMTP id m12-20020a5d624c000000b001f74b77becbmr7959322wrv.594.1647015870515;
        Fri, 11 Mar 2022 08:24:30 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id f22-20020a1cc916000000b00380d3e49e89sm7318667wmb.22.2022.03.11.08.24.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Mar 2022 08:24:29 -0800 (PST)
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
Subject: [RFC PATCH v2 00/13] bundle-uri: a "dumb CDN" for git
Date:   Fri, 11 Mar 2022 17:24:12 +0100
Message-Id: <RFC-cover-v2-00.13-00000000000-20220311T155841Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1337.g7e32d794afe
In-Reply-To: <cover-0.3-00000000000-20211025T211159Z-avarab@gmail.com>
References: <cover-0.3-00000000000-20211025T211159Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Per recent discussion[1] this is my not-quite-feature-complete version
of the bundle-uri capability.  This was sent to the list in some form
beforfe in [2] and [3].

Recently Derrick Stolee has sent an alternate implementation of some
of the same ideas in [4]. Per [1] we're planning to work together on
getting a version of this into git that makes everyone happy, sending
what I've got here is the first step in that.

A high-level summary of the important differences in my approach &
Derrick's (which I hope I'm summarizing fairly here) is that his
approach optionally adds a bundle TOC format, that format allows you
to define topology relationships between bundles to guide a
(returning) client in what it needs to fetch.

Whereas the idea in this series is to lean entirely on the client
downloading bundles & inferring what needs to be done via the
tip/prereqs listed in the header format of the (existing, not changed
here) bundle format.

Both have pros & cons, I started trying to summarize those, but let's
leave that for later.

There's also some high-level "journey" differences in the
two. E.g. Derrick implemented the ability to have "git bundle" itself
fetch bundles remotely, I don't have that and instead lean entirely on
the protocol and "fetch". Those differences really aren't important,
and we can have our cake & eat it too on that front. I.e. end up with
some sensible intersection (or union) of the tooling.

I ran out of time to finish up some of what I had on this topic this
week, but figured (especially since I'd promised to get it done this
week) to send what I have now for discussion.

Things missing & reader's notes:

 * I had some amendmends to the protocol I meant to distill further
   into the protocol docs at [5]. Basically omitting the ability to
   transmit key-values and to have it just be a list of URIs with an
   optional <header> for each one, which is purely a server-to-client
   aid (i.e. those headers will be what you'll find in the pointed-to
   bundles).

* This series goes up to "clone", but I also have incremental fetch
  patches. I ran into an (easily solvable bug) in that & thought it
  was best to omit it for now. It'll be here soon.

  Basically for incremental fetch we'll in parallel get the headers
  for remote bundles, and then do an early abort of those downloads
  that we deem that we don't need.

  Clever (but all standard & boring) use of HTTP caching headers
  between client & servers then allows the client to not request the
  same thing again and again. I.e. want less server load on your CDN?
  Just have the bundles be unique URLs and set appropriate caching
  headers.

* 13/13 demonstrates some of those ideas at a high level.

* A problem with this implementation (and Derrick's, I believe) is
  that it keeps a server waiting while we twiddle our thumbs and wget
  (or equivalent) the bundle(s) locally. If you e.g. clone
  "chromium.git" the server will get tired of waiting, drop the
  connection, and unless the bundle is 100% up-to-date the "clone"
  will fail.

  The solution to this is to get the bundle headers in parallel, and
  as soon as we've got them present the OIDs in the headers as "HAVE"
  to the server, which'll then send us an incremental PACK (and even
  possibly a packfile-uri) for the difference between those bundle(s)
  and what its tips are.

  We can then simply disconnect, download/index-pack everything, and
  do a connectivity checkat the end.

  This requires some careful error handling, e.g. if the resulting
  repo isn't valid we'll need to retry, and the current negotiation
  API isn't very happy to negotiate on the basis of OIDs we don't have
  in the object store (but the protocol handles it just fine).

  So while I have local patches for (some of) that I opted to leave it
  out for now. Once we have incremental fetch it's *mostly* an
  optimization anyway (except in cases of e.g. chromium.git), so for
  the initial protocol etc. discussion it's probably best to leave it
  out.

 * This currently fails CI on Windows & 32 bit Linux for the most
   trivial of reasons, need to adjust printf formats to use PRIuMAX
   etc., but I ran out of time, sorry.

1. https://lore.kernel.org/git/ddebc223-1e13-e758-f9b1-d3f23961e459@github.com/
2. https://lore.kernel.org/git/patch-3.3-64224ec2cba-20211025T211159Z-avarab@gmail.com/
3. https://lore.kernel.org/git/RFC-cover-00.13-0000000000-20210805T150534Z-avarab@gmail.com/
4. https://lore.kernel.org/git/pull.1160.git.1645641063.gitgitgadget@gmail.com/
5. https://lore.kernel.org/git/211027.86ilxixoxz.gmgdl@evledraar.gmail.com/

Ævar Arnfjörð Bjarmason (13):
  protocol v2: add server-side "bundle-uri" skeleton
  bundle-uri docs: add design notes
  bundle-uri client: add "bundle-uri" parsing + tests
  connect.c: refactor sending of agent & object-format
  bundle-uri client: add minimal NOOP client
  bundle-uri client: add "git ls-remote-bundle-uri"
  bundle-uri client: add transfer.injectBundleURI support
  bundle-uri client: add boolean transfer.bundleURI setting
  fetch-pack: add a deref_without_lazy_fetch_extended()
  fetch-pack: move --keep=* option filling to a function
  bundle.h: make "fd" version of read_bundle_header() public
  bundle-uri client: support for bundle-uri with "clone"
  bundle-uri: make the download program configurable

 Documentation/config/transfer.txt          |  33 ++
 Documentation/git-ls-remote-bundle-uri.txt |  62 +++
 Documentation/git-ls-remote.txt            |   1 +
 Documentation/technical/bundle-uri.txt     | 119 ++++++
 Documentation/technical/protocol-v2.txt    | 214 +++++++++++
 Makefile                                   |   3 +
 builtin.h                                  |   1 +
 builtin/clone.c                            |   7 +
 builtin/ls-remote-bundle-uri.c             |  90 +++++
 bundle-uri.c                               | 183 +++++++++
 bundle-uri.h                               |  29 ++
 bundle.c                                   |   8 +-
 bundle.h                                   |   2 +
 command-list.txt                           |   1 +
 connect.c                                  |  80 +++-
 fetch-pack.c                               | 306 ++++++++++++++-
 fetch-pack.h                               |   6 +
 git.c                                      |   1 +
 remote.h                                   |   4 +
 serve.c                                    |   6 +
 t/helper/test-bundle-uri.c                 |  83 ++++
 t/helper/test-tool.c                       |   1 +
 t/helper/test-tool.h                       |   1 +
 t/lib-t5730-protocol-v2-bundle-uri.sh      | 424 +++++++++++++++++++++
 t/t5701-git-serve.sh                       | 124 +++++-
 t/t5730-protocol-v2-bundle-uri-file.sh     |  36 ++
 t/t5731-protocol-v2-bundle-uri-git.sh      |  17 +
 t/t5732-protocol-v2-bundle-uri-http.sh     |  17 +
 t/t5750-bundle-uri-parse.sh                | 153 ++++++++
 transport-helper.c                         |  13 +
 transport-internal.h                       |   7 +
 transport.c                                | 120 ++++++
 transport.h                                |  22 ++
 33 files changed, 2141 insertions(+), 33 deletions(-)
 create mode 100644 Documentation/git-ls-remote-bundle-uri.txt
 create mode 100644 Documentation/technical/bundle-uri.txt
 create mode 100644 builtin/ls-remote-bundle-uri.c
 create mode 100644 bundle-uri.c
 create mode 100644 bundle-uri.h
 create mode 100644 t/helper/test-bundle-uri.c
 create mode 100644 t/lib-t5730-protocol-v2-bundle-uri.sh
 create mode 100755 t/t5730-protocol-v2-bundle-uri-file.sh
 create mode 100755 t/t5731-protocol-v2-bundle-uri-git.sh
 create mode 100755 t/t5732-protocol-v2-bundle-uri-http.sh
 create mode 100755 t/t5750-bundle-uri-parse.sh

Range-diff against v1:
 2:  3ac0539c053 !  1:  2fc87ce092b protocol v2: specify static seeding of clone/fetch via "bundle-uri"
    @@ Metadata
     Author: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## Commit message ##
    -    protocol v2: specify static seeding of clone/fetch via "bundle-uri"
    +    protocol v2: add server-side "bundle-uri" skeleton
     
    -    Add a server-side implementation of a new "bundle-uri" command to
    -    protocol v2. As discussed in the updated "protocol-v2.txt" this will
    -    allow conforming clients to optionally seed their initial clones or
    -    incremental fetches from URLs containing "*.bundle" files created with
    -    "git bundle create".
    +    Add a skeleton server-side implementation of a new "bundle-uri"
    +    command to protocol v2. This will allow conforming clients to
    +    optionally seed their initial clones or incremental fetches from URLs
    +    containing "*.bundle" files created with "git bundle create".
     
         The use-cases are similar to those of the existing "Packfile URIs",
         and the two feature can be combined within a single request, but
         "bundle-uri" has a few advantages over packfile-uris in some some
         common scenarios, discussed below.
     
    -    This change does not give us a working "bundle-uri" client. I have
    -    those patches as a follow-up, but let's first establish what the
    -    protocol for this should be like first. The client implementation will
    -    then implement this specification.
    +    This change does not give us a working "bundle-uri" client, subsequent
    +    commits will do that. Let's first establish what the protocol for this
    +    should be like first. The client implementation will then implement
    +    this specification.
     
         With this change when the uploadpack.bundleURI config is set to a
         URI (or URIs, if set >1 times), advertise a "bundle-uri" command. Then
    @@ Commit message
         .gitmodules check in that context. See [6] for the "ls-refs unborn"
         feature which modified code in similar areas of the request flow.
     
    +    Finally, there's currently a concurrent (submitted after the v1 of
    +    this commit, but before the subsequent client parts of this
    +    implementation) RFC of a somewhat similar "bundle-uri" facility at
    +    [7].
    +
         1. https://lore.kernel.org/git/20111110074330.GA27925@sigill.intra.peff.net/
         2. https://lore.kernel.org/git/20190514092900.GA11679@sigill.intra.peff.net/
         3. https://lore.kernel.org/git/YFJWz5yIGng+a16k@coredump.intra.peff.net/
    @@ Commit message
            Merged as 6ee353d42f3 (Merge branch 'jt/transfer-fsck-across-packs',
            2021-03-01)
         6. 69571dfe219 (Merge branch 'jt/clone-unborn-head', 2021-02-17)
    +    7. https://lore.kernel.org/git/pull.1160.git.1645641063.gitgitgadget@gmail.com/
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
    @@ bundle-uri.h (new)
     @@
     +#ifndef BUNDLE_URI_H
     +#define BUNDLE_URI_H
    -+
    -+struct repository;
    -+struct packet_reader;
    -+struct packet_writer;
    ++#include "repository.h"
    ++#include "pkt-line.h"
    ++#include "strbuf.h"
     +
     +/**
     + * API used by serve.[ch].
 -:  ----------- >  2:  84c4036a510 bundle-uri docs: add design notes
 3:  64224ec2cba !  3:  3abfb2290fd bundle-uri client: add "bundle-uri" parsing + tests
    @@ bundle-uri.c: int bundle_uri_command(struct repository *r,
     
      ## bundle-uri.h ##
     @@
    - struct repository;
    - struct packet_reader;
    - struct packet_writer;
    -+struct string_list;
    + #include "repository.h"
    + #include "pkt-line.h"
    + #include "strbuf.h"
    ++#include "string-list.h"
      
      /**
       * API used by serve.[ch].
    -@@ bundle-uri.h: struct packet_writer;
    +@@
      int bundle_uri_advertise(struct repository *r, struct strbuf *value);
      int bundle_uri_command(struct repository *r, struct packet_reader *request);
      
 1:  7639b9bbac5 !  4:  f64aefa9ece leak tests: mark t5701-git-serve.sh as passing SANITIZE=leak
    @@ Metadata
     Author: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## Commit message ##
    -    leak tests: mark t5701-git-serve.sh as passing SANITIZE=leak
    +    connect.c: refactor sending of agent & object-format
     
    -    The "t5701-git-serve.sh" test passes when run under a git compiled
    -    with SANITIZE=leak, let's mark it as such to add it to the
    -    "linux-leaks" CI job.
    +    Refactor the sending of the "agent" and "object-format" capabilities
    +    into a function.
    +
    +    This was added in its current form in ab67235bc4 (connect: parse v2
    +    refs with correct hash algorithm, 2020-05-25). When we connect to a v2
    +    server we need to know about its object-format, and it needs to know
    +    about ours. Since most things in connect.c and transport.c piggy-back
    +    on the eager getting of remote refs via the handshake() those commands
    +    can make use of the just-sent-over object-format by ls-refs.
    +
    +    But I'm about to add a command that may come after ls-refs, and may
    +    not, but we need the server to know about our user-agent and
    +    object-format. So let's split this into a function.
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
    - ## t/t5701-git-serve.sh ##
    -@@ t/t5701-git-serve.sh: test_description='test protocol v2 server commands'
    - GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
    - export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
    + ## connect.c ##
    +@@ connect.c: void check_stateless_delimiter(int stateless_rpc,
    + 		die("%s", error);
    + }
    + 
    ++static void send_capabilities(int fd_out, struct packet_reader *reader)
    ++{
    ++	const char *hash_name;
    ++
    ++	if (server_supports_v2("agent", 0))
    ++		packet_write_fmt(fd_out, "agent=%s", git_user_agent_sanitized());
    ++
    ++	if (server_feature_v2("object-format", &hash_name)) {
    ++		int hash_algo = hash_algo_by_name(hash_name);
    ++		if (hash_algo == GIT_HASH_UNKNOWN)
    ++			die(_("unknown object format '%s' specified by server"), hash_name);
    ++		reader->hash_algo = &hash_algos[hash_algo];
    ++		packet_write_fmt(fd_out, "object-format=%s", reader->hash_algo->name);
    ++	} else {
    ++		reader->hash_algo = &hash_algos[GIT_HASH_SHA1];
    ++	}
    ++}
    ++
    + struct ref **get_remote_refs(int fd_out, struct packet_reader *reader,
    + 			     struct ref **list, int for_push,
    + 			     struct transport_ls_refs_options *transport_options,
    +@@ connect.c: struct ref **get_remote_refs(int fd_out, struct packet_reader *reader,
    + 			     int stateless_rpc)
    + {
    + 	int i;
    +-	const char *hash_name;
    + 	struct strvec *ref_prefixes = transport_options ?
    + 		&transport_options->ref_prefixes : NULL;
    + 	const char **unborn_head_target = transport_options ?
    +@@ connect.c: struct ref **get_remote_refs(int fd_out, struct packet_reader *reader,
    + 	if (server_supports_v2("ls-refs", 1))
    + 		packet_write_fmt(fd_out, "command=ls-refs\n");
      
    -+TEST_PASSES_SANITIZE_LEAK=true
    - . ./test-lib.sh
    +-	if (server_supports_v2("agent", 0))
    +-		packet_write_fmt(fd_out, "agent=%s", git_user_agent_sanitized());
    +-
    +-	if (server_feature_v2("object-format", &hash_name)) {
    +-		int hash_algo = hash_algo_by_name(hash_name);
    +-		if (hash_algo == GIT_HASH_UNKNOWN)
    +-			die(_("unknown object format '%s' specified by server"), hash_name);
    +-		reader->hash_algo = &hash_algos[hash_algo];
    +-		packet_write_fmt(fd_out, "object-format=%s", reader->hash_algo->name);
    +-	} else {
    +-		reader->hash_algo = &hash_algos[GIT_HASH_SHA1];
    +-	}
    ++	/* Send capabilities */
    ++	send_capabilities(fd_out, reader);
      
    - test_expect_success 'test capability advertisement' '
    + 	if (server_options && server_options->nr &&
    + 	    server_supports_v2("server-option", 1))
 -:  ----------- >  5:  105ced66409 bundle-uri client: add minimal NOOP client
 -:  ----------- >  6:  617a6b16df8 bundle-uri client: add "git ls-remote-bundle-uri"
 -:  ----------- >  7:  b0ce379528e bundle-uri client: add transfer.injectBundleURI support
 -:  ----------- >  8:  44d96a0f5f8 bundle-uri client: add boolean transfer.bundleURI setting
 -:  ----------- >  9:  d9f5b486511 fetch-pack: add a deref_without_lazy_fetch_extended()
 -:  ----------- > 10:  31a22eb3bd4 fetch-pack: move --keep=* option filling to a function
 -:  ----------- > 11:  5ade9419454 bundle.h: make "fd" version of read_bundle_header() public
 -:  ----------- > 12:  bb0d681f5f0 bundle-uri client: support for bundle-uri with "clone"
 -:  ----------- > 13:  40f37c8b9d5 bundle-uri: make the download program configurable
-- 
2.35.1.1337.g7e32d794afe

