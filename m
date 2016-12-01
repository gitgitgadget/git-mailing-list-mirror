Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2D1D11FF40
	for <e@80x24.org>; Thu,  1 Dec 2016 00:15:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755880AbcLAAPi (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Nov 2016 19:15:38 -0500
Received: from mail-io0-f174.google.com ([209.85.223.174]:34421 "EHLO
        mail-io0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752330AbcLAAPh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Nov 2016 19:15:37 -0500
Received: by mail-io0-f174.google.com with SMTP id c21so356210085ioj.1
        for <git@vger.kernel.org>; Wed, 30 Nov 2016 16:15:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=uplinklabs-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to;
        bh=h2g9wUTYYLqI24XkRDo3HNHYK1yh0XK94Xj08SeHrL0=;
        b=UYCnnl0jf2wDjqpKJgnXJxS5auB/OCpePCdYwlTcJ9QkK/eL0Rcm9drsjdV0kj+vq+
         cia7imyNfLXCmlitDXCd/1W+mTJaSasEgDPmEZecUVPcFJ+hAQPxL+I7IISp0JOF9fAa
         ETQzl9wq577Hkp5labNw+pcbUUKo0gzbxLkvZ6TBzV++OSJz6d8LHJLB2izBMejYBVCf
         Eqm9/AXFlWDSmC2K7YKnZaz64tSPskOYbD4NtbUaOZ8btEUY7U9lRfHJjUDsRTkjzKOd
         Mxrmwa0xPGdMd/qSnWtiOdoW79lHKoqs/oRx/4FLcX1uvVQxdssMdWZ+6Pp6NJAXZjk6
         0tJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=h2g9wUTYYLqI24XkRDo3HNHYK1yh0XK94Xj08SeHrL0=;
        b=Bq3z3YPJ7UCGcZS5U7O3TXl0PJydMRscQHNz82Dp18DTYFfAj4fnJH20YOIhf0tnaS
         jydJJYwdOaF/tDlpc3zeF3RlsG2V7Nu54ekTp7QaTBK2A81lo41cASy6pjOQq3vDuxiX
         /YKC1HVbUL90Smtbx0bDBUL6+L9x3PhGAVia+ooS+S5g7i91LSrNZMdST/g3eJKmJyDA
         Fq7ja0ifIiPs9VAvKslZY/p/xFgc3NtHtw0HmYxhuD3dvSVqiag1umxsxUA6QXFwutDk
         godSpK9teySoAiuel5yD4IsuUSh0/0I61hs9wMyDt1IeojT1I9jhfK+ak57aAHgoe6p/
         BjWw==
X-Gm-Message-State: AKaTC016+4xG9IucbmfduHrPQBRFwYkN+p68AkKDJiyihGLwMsA9iFIwSrkjIqq1pLJbpEQsSx2XYcDPnRMkrA==
X-Received: by 10.157.47.167 with SMTP id r36mr21698126otb.78.1480551333963;
 Wed, 30 Nov 2016 16:15:33 -0800 (PST)
MIME-Version: 1.0
Received: by 10.182.45.202 with HTTP; Wed, 30 Nov 2016 16:15:33 -0800 (PST)
From:   Steven Noonan <steven@uplinklabs.net>
Date:   Wed, 30 Nov 2016 16:15:33 -0800
Message-ID: <CAKbGBLjZ2WLVRM9f=by337xLhPgKCy10T8ra6Qz7OWA=QF-5yA@mail.gmail.com>
Subject: 'git repack' and repack.writeBitmaps=true with kept packs
To:     git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I have some unexpected behavior with 'git repack' on git 2.10.2 and 2.11.0.

$ cat /etc/gitconfig
[pack]
        writeBitmapHashCache = true
[repack]
        writeBitmaps = true
$ touch objects/pack/pack-3841d81123a96cedeb3c1bd7acf7e29bfba26639.keep
$ find objects
objects
objects/pack
objects/pack/pack-3841d81123a96cedeb3c1bd7acf7e29bfba26639.keep
objects/pack/pack-3841d81123a96cedeb3c1bd7acf7e29bfba26639.idx
objects/pack/pack-3841d81123a96cedeb3c1bd7acf7e29bfba26639.bitmap
objects/pack/pack-3841d81123a96cedeb3c1bd7acf7e29bfba26639.pack
objects/info
objects/info/packs
$ git repack -Adfl
Counting objects: 16321, done.
Delta compression using up to 24 threads.
Compressing objects: 100% (16118/16118), done.
Writing objects: 100% (16321/16321), done.
Reusing bitmaps: 110, done.
Selecting bitmap commits: 3257, done.
Building bitmaps: 100% (137/137), done.
Total 16321 (delta 11568), reused 4507 (delta 0)
$ du -sh objects/pack/pack*
100K    objects/pack/pack-3841d81123a96cedeb3c1bd7acf7e29bfba26639.bitmap
524K    objects/pack/pack-3841d81123a96cedeb3c1bd7acf7e29bfba26639.idx
512     objects/pack/pack-3841d81123a96cedeb3c1bd7acf7e29bfba26639.keep
4.3M    objects/pack/pack-3841d81123a96cedeb3c1bd7acf7e29bfba26639.pack
100K    objects/pack/pack-6043151bee7bd61bdae6e3a2ba0f13cd1b0277af.bitmap
524K    objects/pack/pack-6043151bee7bd61bdae6e3a2ba0f13cd1b0277af.idx
5.8M    objects/pack/pack-6043151bee7bd61bdae6e3a2ba0f13cd1b0277af.pack

It seems like it's behaving as though I've provided
--pack-kept-objects. In order to ensure the .bitmap is created, it
repacks everything, including everything in existing .pack files (not
respecting .keep). But then it's not deleting the old .pack file
(oddly, respecting .keep).

What I'd expect it to do here is ignore the 'repack.writeBitmaps =
true' value if there's a .keep that needs to be respected. Is this not
a correct assumption?
