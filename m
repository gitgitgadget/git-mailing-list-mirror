Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5FCBD20ABE
	for <e@80x24.org>; Sat, 21 Jan 2017 05:23:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750770AbdAUFXG (ORCPT <rfc822;e@80x24.org>);
        Sat, 21 Jan 2017 00:23:06 -0500
Received: from mail-qt0-f176.google.com ([209.85.216.176]:35854 "EHLO
        mail-qt0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750735AbdAUFXG (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Jan 2017 00:23:06 -0500
Received: by mail-qt0-f176.google.com with SMTP id k15so64064220qtg.3
        for <git@vger.kernel.org>; Fri, 20 Jan 2017 21:23:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=LwCMeNTHm1dotZtyDcwvuTCKQTr+1CAgzgiyTvtvxI0=;
        b=njseyp+QmCdongUJh6kDDIWWDukAYnARmb5GC0x8+VlCfVHJHoRxrPTRVzv/Vl3qbc
         A6/DgjQYd6sUXbkHo90mATm9FO4XFxBwZTqnA5iMcwGuXZQEUr2Kvr2cSiYgE/wkAOwH
         DANzqHRnyZoAamxTop9M4aaYgc3byANot31DuqvJhzwy780yNPixeJbR6Vll50eN0Hmw
         ZW24njA/mxavbuRULFzwnzTEcDXNWTLCBSVhJ8kdAe2k1VE7T9x4zQ2SnV2+ekfI8xN8
         vs9affUjyuYdwsymXTS54eAA/D5EutqFYmoRThtYyXCZIVrmI38jjb4/O4bJ8GrQLZ5P
         ueuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=LwCMeNTHm1dotZtyDcwvuTCKQTr+1CAgzgiyTvtvxI0=;
        b=mOXLxHXzJ3EQUPGRwTvza2FPou+39S8satSHOaFA2eBIX1SrE4Qn5ajlLF5LUxrMlj
         /R1ZynCa4H46VYzAY6Xf3+t9YaQx+k+CTveiNKoQaHLLdUXxZhPpo+t/s5uX6uquieuL
         4r/mAPh2xQZ7qe0Pzepts6KlUazXhzHmIEQKxkmJEF2OeRKQZpHaLAuZQGxoXSKnYiX4
         vOgm9CdyvA0KSARrYlc7TE0/qr9LgI4oAqyZCyeFWWyEs7qCw+pxvHSeBqAzb0lFdb/6
         ZMOnmEv4tGLh5NlyXnrmCMgi2c6c7ufUuy5HX2r/DFSOVRPiz3YRwvUqiC5fa/CVMRVo
         Bfaw==
X-Gm-Message-State: AIkVDXIru/Czg73G6U7tqiNiyoR4dWGqxI5M8p6QendEfVC3uTgDEG4/2rm6fa3PpEdSScRidsogubCGHuWvOw==
X-Received: by 10.200.47.53 with SMTP id j50mr14844820qta.273.1484976184814;
 Fri, 20 Jan 2017 21:23:04 -0800 (PST)
MIME-Version: 1.0
Received: by 10.237.45.132 with HTTP; Fri, 20 Jan 2017 21:23:04 -0800 (PST)
From:   Edmundo Carmona Antoranz <eantoranz@gmail.com>
Date:   Fri, 20 Jan 2017 23:23:04 -0600
Message-ID: <CAOc6etZ9QeJAf1CKh9Eraigwy45yR6eO-7Th+bZRnTa71BoPew@mail.gmail.com>
Subject: Does it make sense to show tips on blame?
To:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi!

I'm having fun with difflame. I added support for an option called
'tips' which would display 1-line summary of a block of added lines
that belong to the same revision, in order to provide context while
reading difflame output without having to run an additional git show
command.

Output is like this (from README.txt, taken from difflame on git
itself, sorry if it's too wide):

diff --git a/fast-import.c b/fast-import.c
index f561ba833..64fe602f0 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -2218,13 +2218,17 @@ static uintmax_t do_change_note_fanout(
2a113aee9b (Johan Herland 2009-12-07 12:27:24 +0100 2218)
char *fullpath, unsigned int fullpath_len,
2a113aee9b (Johan Herland 2009-12-07 12:27:24 +0100 2219)
unsigned char fanout)
2a113aee9b (Johan Herland 2009-12-07 12:27:24 +0100 2220) {
-02d0457eb4 (Junio C Hamano 2017-01-10 15:24:26 -0800 2221)     struct
tree_content *t = root->tree;
        405d7f4af fast-import: properly fanout notes when tree is imported
+405d7f4af6 (Mike Hommey   2016-12-21 06:04:48 +0900 2221)      struct
tree_content *t;
2a113aee9b (Johan Herland 2009-12-07 12:27:24 +0100 2222)      struct
tree_entry *e, leaf;
2a113aee9b (Johan Herland 2009-12-07 12:27:24 +0100 2223)
unsigned int i, tmp_hex_sha1_len, tmp_fullpath_len;
2a113aee9b (Johan Herland 2009-12-07 12:27:24 +0100 2224)
uintmax_t num_notes = 0;
2a113aee9b (Johan Herland 2009-12-07 12:27:24 +0100 2225)
unsigned char sha1[20];
2a113aee9b (Johan Herland 2009-12-07 12:27:24 +0100 2226)      char
realpath[60];
2a113aee9b (Johan Herland 2009-12-07 12:27:24 +0100 2227)
        405d7f4af fast-import: properly fanout notes when tree is imported
+405d7f4af6 (Mike Hommey   2016-12-21 06:04:48 +0900 2228)      if (!root->tree)
+405d7f4af6 (Mike Hommey   2016-12-21 06:04:48 +0900 2229)
 load_tree(root);
+405d7f4af6 (Mike Hommey   2016-12-21 06:04:48 +0900 2230)      t = root->tree;
+405d7f4af6 (Mike Hommey   2016-12-21 06:04:48 +0900 2231)
2a113aee9b (Johan Herland 2009-12-07 12:27:24 +0100 2232)      for (i
= 0; t && i < t->entry_count; i++) {
2a113aee9b (Johan Herland 2009-12-07 12:27:24 +0100 2233)
e = t->entries[i];
2a113aee9b (Johan Herland 2009-12-07 12:27:24 +0100 2234)
tmp_hex_sha1_len = hex_sha1_len + e->name->str_len;

The tip that was used for revision 405d7f4af on both "blocks" of added
lines can be seen.

The question is if you think it makes sense to add this option to
git-blame itself.

Something like:
git blame --tips README.txt

Thanks in advance
