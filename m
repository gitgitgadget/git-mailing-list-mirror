Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F3B002013C
	for <e@80x24.org>; Wed, 15 Feb 2017 05:19:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750810AbdBOFTH (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 Feb 2017 00:19:07 -0500
Received: from mail-qt0-f178.google.com ([209.85.216.178]:36079 "EHLO
        mail-qt0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750729AbdBOFTG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Feb 2017 00:19:06 -0500
Received: by mail-qt0-f178.google.com with SMTP id k15so129295678qtg.3
        for <git@vger.kernel.org>; Tue, 14 Feb 2017 21:19:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=PpkrECq+4rQUpu1sIopnaRMjBa9xuODkKqUwy77tcXo=;
        b=trbo9JqjQT+IuEtFc2n8GYikIPKLrKVo+0ytbMAsEPRxQv1J/2X2MTEwCr5kEqdt2E
         wiTS2k4cYSqSQJ0n1JpvN/tgqAi29RAs4PpV5JDviobVjZ25om4rCK71vA0M4sAaNk8J
         89dTNe3kw/PXbNtGjLov0cqL9eRDSxMBdUV/XibkEKt0t3czGsA8HxO6zTU8dxnaQ0+r
         2jurgLurfL3gq2XNyMqd3WOTQ223qkXpx5tSRJPzS/k+86htoCnhKWuFDJSq+b8ps2Of
         Q2lGhx1ePp4KOVHWDDM+F3XVQ4U3YJ5oEJsRe/vobYqVBB7mZgomZFElIopQrfoIt/oD
         qOfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=PpkrECq+4rQUpu1sIopnaRMjBa9xuODkKqUwy77tcXo=;
        b=BC1lW3FaLDIdro/i7L7pBZwopGQmA/Dzp9xq2IhrIrDcILEDcgx4K9skgT4yFm+K+/
         3HNH0WZTfKVtklAf/S9twsV4s9DIZ82dYq3kGeB6qwHquGHzdvIIIQpwSU7Heoo9DVZz
         k31OggmwGOIvd28m2b/uc78qQagzB00Th+iyG4N/07d3UHQKvHe3Q/A1gI/WUHzHVzsn
         ity6czm0PoR0vfS+dF2Ksbh+pSNyW3MVtN7uP9j2aTR+hcpTRYkVMZl6f+y3Ey1vvGAM
         rsN+6wYv/UrJMdJFRmlAXThX2usf8a3ELWyq3I1RSvi+S9qrjJmsSYjeJJ+O3JP/pJ5x
         73Cg==
X-Gm-Message-State: AMke39lgGe9tiDbKv3xOHINubqdaphWeJAEUIB2swhq3fJ7I3ov+88qdyRhNU9zAJ4pL2npphx9CubJ7Y+BvYA==
X-Received: by 10.200.40.177 with SMTP id i46mr30142856qti.279.1487135945742;
 Tue, 14 Feb 2017 21:19:05 -0800 (PST)
MIME-Version: 1.0
Received: by 10.237.52.198 with HTTP; Tue, 14 Feb 2017 21:19:05 -0800 (PST)
From:   Edmundo Carmona Antoranz <eantoranz@gmail.com>
Date:   Tue, 14 Feb 2017 23:19:05 -0600
Message-ID: <CAOc6etYz6+FzDRbkLS2SB9=F9DP18=6uLKdfCN3D3yd2Gug-tw@mail.gmail.com>
Subject: difflame improvements
To:     Git List <git@vger.kernel.org>
Cc:     Jeff King <peff@peff.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi!

I've been working on detecting revisions where a "real" deletion was
made and I think I advanced a lot in that front. I still have to work
on many scenarios (renamed files, for example... also performance) but
at least I'm using a few runs against git-scm history and the results
are "promising":

23:05 $ git blame -s --reverse -L 25,40 HEAD~20..HEAD -- versioncmp.c
066fb0494e 25) static int initialized;
066fb0494e 26)
066fb0494e 27) /*
8ec68d1ae2 28)  * p1 and p2 point to the first different character in
two strings. If
8ec68d1ae2 29)  * either p1 or p2 starts with a prerelease suffix, it
will be forced
8ec68d1ae2 30)  * to be on top.
8ec68d1ae2 31)  *
8ec68d1ae2 32)  * If both p1 and p2 start with (different) suffix, the orde=
r is
8ec68d1ae2 33)  * determined by config file.
066fb0494e 34)  *
8ec68d1ae2 35)  * Note that we don't have to deal with the situation
when both p1 and
8ec68d1ae2 36)  * p2 start with the same suffix because the common
part is already
8ec68d1ae2 37)  * consumed by the caller.
066fb0494e 38)  *
066fb0494e 39)  * Return non-zero if *diff contains the return value
for versioncmp()
066fb0494e 40)  */

Lines 28-33:

23:05 $ git show --summary 8ec68d1ae2
commit 8ec68d1ae2863823b74d67c5e92297e38bbf97bc
Merge: e801be066 c48886779
Author: Junio C Hamano <>
Date:   Mon Jan 23 15:59:21 2017 -0800

    Merge branch 'vn/diff-ihc-config'

    "git diff" learned diff.interHunkContext configuration variable
    that gives the default value for its --inter-hunk-context option.

    * vn/diff-ihc-config:
      diff: add interhunk context config option



And this is not telling me the _real_ revision where the lines were
_deleted_ so it's not very helpful, as Peff has already mentioned.

Running difflame:

23:06 $ time ~/proyectos/git/difflame/difflame.py -bp=3D-s -w HEAD~20
HEAD -- versioncmp.c
diff --git a/versioncmp.c b/versioncmp.c
index 80bfd109f..9f81dc106 100644
--- a/versioncmp.c
+++ b/versioncmp.c
@@ -24,42 +24,83 @@
.
.
.
+b17846432d  33) static void find_better_matching_suffix(const char
*tagname, const char *suffix,
+b17846432d  34)                                        int
suffix_len, int start, int conf_pos,
+b17846432d  35)                                        struct
suffix_match *match)
+b17846432d  36) {
b17846432d  37)        /*
       c026557a3 versioncmp: generalize version sort suffix reordering
-c026557a3 (SZEDER 28)  * p1 and p2 point to the first different
character in two strings. If
-c026557a3 (SZEDER 29)  * either p1 or p2 starts with a prerelease
suffix, it will be forced
-c026557a3 (SZEDER 30)  * to be on top.
-c026557a3 (SZEDER 31)  *
-c026557a3 (SZEDER 32)  * If both p1 and p2 start with (different)
suffix, the order is
-c026557a3 (SZEDER 33)  * determined by config file.
       b17846432 versioncmp: factor out helper for suffix matching
+b17846432d  38)         * A better match either starts earlier or
starts at the same offset
+b17846432d  39)         * but is longer.
+b17846432d  40)         */
+b17846432d  41)        int end =3D match->len < suffix_len ?
match->start : match->start-1;
.
.
.

Same range of (deleted) lines:

23:10 $ git --show --name-status c026557a3
commit c026557a37361b7019acca28f240a19f546739e9
Author: SZEDER G=C3=A1bor <>
Date:   Thu Dec 8 15:24:01 2016 +0100

   versioncmp: generalize version sort suffix reordering

   The 'versionsort.prereleaseSuffix' configuration variable, as its name
   suggests, is supposed to only deal with tagnames with prerelease
.
.
.


   Signed-off-by: SZEDER G=C3=A1bor <>
   Signed-off-by: Junio C Hamano <>

M       Documentation/config.txt
M       Documentation/git-tag.txt
M       t/t7004-tag.sh
M       versioncmp.c


This is the revision where the deletion happened.

That's it for the time being.
