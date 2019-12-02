Return-Path: <SRS0=5D3W=ZY=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51CE1C432C3
	for <git@archiver.kernel.org>; Mon,  2 Dec 2019 19:26:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17A0C20833
	for <git@archiver.kernel.org>; Mon,  2 Dec 2019 19:26:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h42veFpA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727973AbfLBT0V (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Dec 2019 14:26:21 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:35934 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727586AbfLBT0V (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Dec 2019 14:26:21 -0500
Received: by mail-pf1-f195.google.com with SMTP id b19so161632pfd.3
        for <git@vger.kernel.org>; Mon, 02 Dec 2019 11:26:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3WU+yUvGePDu78iw0VdQSSfUfNR4gQGu6fItPXZ1wX0=;
        b=h42veFpAe2gF2/Jpl7iv+LUOyxqmjnfmVATSQFkB+FjfWFTNfzx5yXc5VQRizjl1hp
         uOnd7jHjJSXKsPyp4lXigjrUBHU+Hm55cOzPjG4fW78h/MFrwWyMe+me9UuAjPctrUH4
         TJaNNo5q0AOwjz61rgTvHgtbTdImPiA+LZH4AZ9nMEsqt+mFwZZzigN0wTBWVUM15Oxk
         fyLbGYzDtSa+AscJRnOnWf5rB9ikGXUc+y5vU95yTafbaNaXZ0mwyg5U/QnQakX/HWDJ
         Z6p5kpXrdlvySKYKVaiKqrGMdbsC34ftJPgRkNboiJZwZ93rlN2AAP7wVtQ9q4TmjhVH
         pIHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3WU+yUvGePDu78iw0VdQSSfUfNR4gQGu6fItPXZ1wX0=;
        b=U6jy2r5Pafp4V8I3svLrXW8GSSuXApqc/4oXCq3x7HJbladFaT4e3Tyg1CGN/FtYYq
         w9NVHOF0+VH/k9Tl3LAz28A4rwtoMz64cnGjfBPn+0NCRd/RMx110/6ZFh2XcxHozp83
         9n2pR7JdkL6moCcK+CWi0l1Rqjp4XUihvAnv74oRfmbR8BRPEM2/tw1SeUO5K+BzD5u3
         tPvV+tf2r/hsBiPMtkx1/WOjB39gYMclEpiBGt6olEH8U8sB3JR5aDZF4OTIh4tk1nPA
         4lV7zFG0kiYEzxy02hnKPl1gwI/42YkMAxccVxiV3UuNjyvM+lmBAl1cUbUOH6dEHsFQ
         Wszg==
X-Gm-Message-State: APjAAAX9f2eN38jSmQJEQtPJqwEROD5p0jvCi9qAG+LgHRwTG05uZSIN
        avrDzXIvUaaDk1D2vmAgKU9eA+4G
X-Google-Smtp-Source: APXvYqwB5r4Y58m+EJIrtd1kGvH8RtL58P8VuQwtQ7juFUQZBGteb53wuFbyfXPeQ74VIK2I4T8dnw==
X-Received: by 2002:a63:b64a:: with SMTP id v10mr726633pgt.145.1575314778364;
        Mon, 02 Dec 2019 11:26:18 -0800 (PST)
Received: from generichostname ([204.14.239.138])
        by smtp.gmail.com with ESMTPSA id b21sm294226pfp.0.2019.12.02.11.26.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2019 11:26:17 -0800 (PST)
Date:   Mon, 2 Dec 2019 11:26:15 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Jeff King <peff@peff.net>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        Eric Wong <e@80x24.org>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 0/3] Doc: replace opaque mail archive links with
 lore.kernel.org
Message-ID: <cover.1575314676.git.liu.denton@gmail.com>
References: <cover.1574882812.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1574882812.git.liu.denton@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We reference many mail archives that use opaque links. Even though many
have been around for a long time, they may still be liable to go down
(see Gmane) leaving us with dead links that we cannot reference in the
future. Replace these links with links to lore.kernel.org which use
Message-IDs so that if lore.kernel.org ever goes down, it will be much
easier to find these messages in the future.

My series is based on top of 'jk/lore-is-the-archive'.

Denton Liu (3):
  doc: replace MARC links with lore.kernel.org
  RelNotes: replace Gmane with real Message-IDs
  doc: replace LKML link with lore.kernel.org

 Documentation/RelNotes/1.6.2.txt     | 2 +-
 Documentation/RelNotes/1.6.3.txt     | 2 +-
 Documentation/RelNotes/1.6.4.txt     | 2 +-
 Documentation/RelNotes/1.6.5.txt     | 2 +-
 Documentation/RelNotes/1.6.6.txt     | 2 +-
 Documentation/RelNotes/1.8.4.txt     | 2 +-
 Documentation/RelNotes/2.5.0.txt     | 3 ++-
 Documentation/RelNotes/2.8.3.txt     | 4 ++--
 Documentation/RelNotes/2.9.0.txt     | 2 +-
 Documentation/git-bisect-lk2009.txt  | 2 +-
 Documentation/gitcli.txt             | 4 ++--
 Documentation/technical/racy-git.txt | 2 +-
 Documentation/user-manual.txt        | 4 ++--
 t/t6021-merge-criss-cross.sh         | 2 +-
 14 files changed, 18 insertions(+), 17 deletions(-)

Range-diff against v1:
1:  14167012a1 ! 1:  0f100f06c5 doc: replace MARC links with LKML
    @@ Metadata
     Author: Denton Liu <liu.denton@gmail.com>
     
      ## Commit message ##
    -    doc: replace MARC links with LKML
    +    doc: replace MARC links with lore.kernel.org
     
         Since we're now recommending lore.kernel.org, replace marc.info links
         with lore.kernel.org.
     
         Although MARC has been around for a long time, nothing lasts forever
         (see Gmane). Since MARC uses opaque message identifiers, switching to
    -    LKML should be a strict improvement since, even if LKML goes
    -    down, the Message-ID will allow future readers to look up the referenced
    -    messages on any other archive.
    +    lore.kernel.org should be a strict improvement since, even if
    +    lore.kernel.org goes down, the Message-ID will allow future readers to
    +    look up the referenced messages on any other archive.
     
         We leave behind one reference to MARC in the README.md since it's a
         perfectly fine mail archive for personal reading, just not for linking
2:  ebb2328a02 ! 2:  cad77e0989 RelNotes: replace Gmane with real Message-IDs
    @@ Commit message
         are definitely not in active use, they might be of historical interest
         for future readers so let's ensure that mail references are more robust.
     
    -    Replace links to Gmane with links to LKML (which is our new preferred
    -    mailing list archive and has the Message-ID in the URL) and bare Gmane
    -    ID references with Message-IDs.
    +    Replace links to Gmane with links to lore.kernel.org (which is our new
    +    preferred mailing list archive and has the Message-ID in the URL) and
    +    bare Gmane ID references with Message-IDs.
     
         The Message-IDs were found by searching for "gmane:<id>" on
         https://public-inbox.org/git/ and taking the resulting message.
    @@ Documentation/RelNotes/2.8.3.txt: Fixes since v2.8.2
         has been used in Cygwin packaged versions of Git for quite a while.
     -   See http://thread.gmane.org/gmane.comp.version-control.git/291853
     -   and http://thread.gmane.org/gmane.comp.version-control.git/275680.
    -+   See https://lkml.org/git/20160419091055.GF2345@dinwoodie.org/
    -+   and https://lkml.org/git/20150811100527.GW14466@dinwoodie.org/.
    ++   See https://lore.kernel.org/git/20160419091055.GF2345@dinwoodie.org/
    ++   and https://lore.kernel.org/git/20150811100527.GW14466@dinwoodie.org/.
      
       * "git replace -e" did not honour "core.editor" configuration.
      
    @@ Documentation/RelNotes/2.9.0.txt: notes for details).
         already enabled for the MinGW and plain Windows builds.  It also
         has been used in Cygwin packaged versions of Git for quite a while.
     -   See http://thread.gmane.org/gmane.comp.version-control.git/291853
    -+   See https://lkml.org/git/20160419091055.GF2345@dinwoodie.org/
    ++   See https://lore.kernel.org/git/20160419091055.GF2345@dinwoodie.org/
      
       * "merge-octopus" strategy did not ensure that the index is clean
         when merge begins.
-:  ---------- > 3:  a7c8981ba5 doc: replace LKML link with lore.kernel.org
-- 
2.24.0.504.g3cd56eb17d

