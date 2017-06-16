Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5E0D51FA7B
	for <e@80x24.org>; Fri, 16 Jun 2017 19:29:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752348AbdFPT3E (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Jun 2017 15:29:04 -0400
Received: from mail-wm0-f53.google.com ([74.125.82.53]:33177 "EHLO
        mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752252AbdFPT3C (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Jun 2017 15:29:02 -0400
Received: by mail-wm0-f53.google.com with SMTP id m7so5871038wmg.0
        for <git@vger.kernel.org>; Fri, 16 Jun 2017 12:28:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1nL8wwBDW8zq8d37zCPQl/EIHYspnAWrA+8BPAqZWEE=;
        b=a3RtktZHSRz874Dm9Pet0XBTbRyTLrSaXmso7wpPdt761E5CXuWgqH3QkQDxuP1Ji7
         ge3yYc8KXcqUjKtZ5l1Ufi/pxy7gyhFxv6Lu1f1WKIGT2SzQVUqkPJxqp5fi0kopQ8FR
         KQQ7onYT32Rm8bcJ5G4NF3YqL79n8Ub6O80GDbiE7rUiD5LkRkzKR/t71gYi2FbNVOpN
         z6xYyCmjlAsClz6RDNidBlkniOQJ13g8dK/sDPTmlPKmVauIYlG2b34oGy0q/W8dyKcL
         WfSsdaIOv80dQOlhxFN73iKmuauDK2UBgaMmnJX6x1gYkaXkK5ye+c8lPvSZPCVBdcB+
         wlQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1nL8wwBDW8zq8d37zCPQl/EIHYspnAWrA+8BPAqZWEE=;
        b=GjZQBABEDoBPrZdTa9agxHrY2FOGsD/tJAVDz71rs7GMG6FzsHnZtXZlWmfuVjsnm2
         ex0BndGqpMpt7C02UPgDyzYOEmWbbL4vEb/ZqiRuPDepe53gs7fqt8vQTiFGTr6KCeFt
         s7nXBp7/Acfmq8zFJaWmKOF2jxb8lWWujr3cUxCS4a0A4+ffKOBmBSo74HZWlR1jHkKr
         W1cbIj6C0sFziu6rQpHEX/x4bOALefFfXG2agGTRCXE5+Kf2ZCYi2L+iACpDv26JFzob
         guidOGLRzupqfKOrFRAGPQK6zcDuEt9eAcQlDe5C3B2yG+tlbgzoPoun64Z1d6zX2GE7
         jUzA==
X-Gm-Message-State: AKS2vOyrJiL760hohiM9HRgpxFDBB392m9mHPPHNxVqwYRFPZlx44eBj
        cbaOYTAT8gFDSea5
X-Received: by 10.28.18.145 with SMTP id 139mr7668538wms.2.1497641330299;
        Fri, 16 Jun 2017 12:28:50 -0700 (PDT)
Received: from localhost.localdomain (x4db0ef0e.dyn.telefonica.de. [77.176.239.14])
        by smtp.gmail.com with ESMTPSA id c71sm2658026wmh.21.2017.06.16.12.28.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 16 Jun 2017 12:28:49 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Jonathan Nieder <jrnieder@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [RFC/PATCH 0/5] remote: eliminate remote->{fetch,push}_refspec and lazy parsing of refspecs
Date:   Fri, 16 Jun 2017 21:28:32 +0200
Message-Id: <20170616192837.11035-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.13.1.501.g45ae33cbf
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


'struct remote' stores refspecs twice: once in their original string
form in remote->{fetch,push}_refspecs and once in their parsed form in
remote->{fetch,push}.  This is necessary, because we need the refspecs
for lazy parsing after we finished reading the configuration: we don't
want to die() on a bogus refspec while reading the configuration of a
remote we are not going to access at all.

However, storing refspecs in both forms has some drawbacks:

  - The same information is stored twice, wasting memory.
  - remote->{fetch,push}_refspecs, i.e. the string arrays are
    conveniently ALLOC_GROW()-able with associated
    {fetch,push}_refspec_{nr,alloc} fields, but remote->{fetch,push}
    are not.
  - Wherever remote->{fetch,push} are accessed, the number of parsed
    refspecs in there is specified by remote->{fetch,push}_refspec_nr.
    This requires us to keep the two arrays in sync and makes adding
    additional refspecs cumbersome and error prone.

  - And worst of all, it pissed me off while working on
    sg/clone-refspec-from-command-line-config ;)


So here is my crack at getting rid of them.

The idea is to parse refspecs gently while reading the configuration:
this way we won't need to store all refspecs as strings, and won't
die() on a bogus refspec right away.  A bogus refspec, if there's one,
will be stored in the remote it belongs to, so it will be available
later when that remote is accessed and can be used in the error
message.

At the end of the series the remote API will have public functions
add_{fetch,push}_refspec() for, well, adding refspecs, including
parsing, to those that were already present in the configuration.  I'm
not sure what the use case for adding extra push refspecs could be,
but sg/clone-refspec-from-command-line-config has shown that there is
a need for adding fetch refspecs, and this way they are at least
symmetrical.  Though I don't see any other use case for adding extra
fetch refspecs, either.  Anyway, there's less subtlety without the
need to keep the two arrays ->fetch and ->fetch_refspec in sync.


The first three patches are preparation.
Patch 3 was done with --patience, otherwise it's unreadable.  -w will
help even more to see what's going on.
The last patch's commit message is rather terse... but I deemed it
sufficient for an initial RFC; will expand it later, if there's an
agreement that this approach is worth pursuing.


This applies on top of a merge of master and the fresh reroll (v5) of
sg/clone-refspec-from-command-line-config:

  http://public-inbox.org/git/20170616173849.8071-1-szeder.dev@gmail.com/T/#m7f9c81fb415920acc2af93f432aecfa52477e6b8

It's also available at:

  https://github.com/szeder/git remote-no-string-refspecs


Best,
Gábor


SZEDER Gábor (5):
  remote: don't use remote->{fetch,push}_refspec
  remote.c: don't pass copies of refspecs to add_{fetch,push}_refspec()
  remote.c: extract a helper function to parse a single refspec
  remote.c: eliminate remote->fetch_refspec
  remote.c: eliminate remote->push_refspec

 builtin/clone.c  |   7 +-
 builtin/fetch.c  |  20 ++--
 builtin/push.c   |  12 ++-
 builtin/remote.c |  47 ++++++---
 remote.c         | 316 +++++++++++++++++++++++++++++++------------------------
 remote.h         |  31 ++++--
 6 files changed, 248 insertions(+), 185 deletions(-)

-- 
2.13.1.505.g7cc9fcafb

