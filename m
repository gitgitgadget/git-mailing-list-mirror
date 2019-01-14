Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F2698211B4
	for <e@80x24.org>; Mon, 14 Jan 2019 23:09:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726818AbfANXJG (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 Jan 2019 18:09:06 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:39583 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726776AbfANXJG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Jan 2019 18:09:06 -0500
Received: by mail-pf1-f196.google.com with SMTP id r136so327049pfc.6
        for <git@vger.kernel.org>; Mon, 14 Jan 2019 15:09:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=RNlSN7aMYUpBm4TgxwSDAnHloCn0zoEQRjfEeb4uW8o=;
        b=QdhL8rcTqSWWc2rTXqwDWAm+5V3Mrzz/wHTy/Dy2DPX+1AGdwo+idXNnPLSoXSsVfd
         wuTu72+PFNWee5Aq3dRYTU/IcjF4j79nyJb6skocl2K+tHgpiIJmDYPn6fIoM83LUr6N
         RHPQMXpRtsFXFkWgMc9fN0dFd53sC/3H3DsaFsHdz0ghyCwA/F+XyvEChtcAUKtSrDWs
         pnFFqriYOr+qd2i7oAvLuPqGkgCzsC3T5/e/DJL31+cD62Suye6J4CZlAAAU/jwDgPXE
         E0Web9b77CfWSUi4nw7mcEsByrPGyeaiXxYhiR5HTWlLLhiMYdabEIflgq6OoKojDWtw
         1jAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=RNlSN7aMYUpBm4TgxwSDAnHloCn0zoEQRjfEeb4uW8o=;
        b=s9Sz+K7YVOkT/L9f6sSYvQRx5578yZ4obaOI1HNprWYHb00Km9Yub8rt3Dw0XYu+EJ
         ESbVJXjtC/sddfDbV+tYvAhvvgDDcBQETzv7Nx1oaEilFEj7/w4t8J9nMkEOR+rKnsIF
         0dSWBenlztAWkwwFwS+eSWGmCWS+zbv/6kZesOtuk4PEJdmDCfRb8WewVDQ7bx1Gp09v
         re1gVgAnaSCi33k+8ANBKvt1QASFmH6H8ktln/FJrv1LHRLa/gNlcRxQnBLiRNMJ/N9+
         OkHyfLS6qCYrpQPrnhZ500YEYqNuzzM0tajGYh3KxRoiNWr6ixqR+iBPvquBOP7SlMBC
         KtVA==
X-Gm-Message-State: AJcUukf8080EoXYJbTsHKL2z/pQk4AIzfgb6pD50f1JylgSxj9xmNLwr
        C+y8Jxvo3aA2TrYcd5CKJElsr+8i
X-Google-Smtp-Source: ALg8bN4dDuBjU/Av7k67EPSIPFUxdCFGLZeRiKFtZp2jpv1u7ZqibCWepDR6C51bKtUAH+GUrdtaCg==
X-Received: by 2002:a63:7e5b:: with SMTP id o27mr885287pgn.214.1547507344565;
        Mon, 14 Jan 2019 15:09:04 -0800 (PST)
Received: from google.com ([2620:0:100e:913:3fb0:1473:cdbf:42])
        by smtp.gmail.com with ESMTPSA id n78sm2216742pfk.19.2019.01.14.15.09.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 14 Jan 2019 15:09:04 -0800 (PST)
Date:   Mon, 14 Jan 2019 15:09:02 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: [PATCH/RFC] fsck: complain when .gitignore and .gitattributes are
 symlinks
Message-ID: <20190114230902.GG162110@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff King <peff@peff.net>
Date: Sun, 13 May 2018 14:14:34 -0400

This case is already forbidden by verify_path(), so let's
check it in fsck. It's easier to handle than .gitmodules,
because we don't care about checking the blob content. This
is really just about whether the name and mode for the tree
entry are valid.

Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Hi,

This patch is from the 2.20.0 era, from the same series as

 fsck: detect submodule urls starting with dash

It was omitted from that series because it does not address any known
exploit, but to me it seems worthwhile anyway:

- if a client enables transfer.fsckObjects, this helps them protect
  themselves against weird input that does *not* have a known exploit
  attached, to

- it generally feels more simple and robust.  Git-related tools can
  benefit from this kind of check as an indication of input they can
  bail out on instead of trying to support.

Peff checked it against repos in the wild and found this to be very
rare but existent (e.g. https://github.com/acquia/blt has a
.gitattributes symlink).  Linus suggested that we may want it to be
INFO instead of ERROR, so that people can at least notice that their
.gitattributes symlink is likely to have no effect.  This patch still
uses ERROR because I suspect that this is rare enough in the wild that
people will be able to cope.

Thoughts?

Thanks,
Jonathan

 fsck.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/fsck.c b/fsck.c
index 68502ce85b..850363fc8e 100644
--- a/fsck.c
+++ b/fsck.c
@@ -68,6 +68,8 @@ static struct oidset gitmodules_done = OIDSET_INIT;
 	FUNC(GITMODULES_SYMLINK, ERROR) \
 	FUNC(GITMODULES_URL, ERROR) \
 	FUNC(GITMODULES_PATH, ERROR) \
+	FUNC(GITIGNORE_SYMLINK, ERROR) \
+	FUNC(GITATTRIBUTES_SYMLINK, ERROR) \
 	/* warnings */ \
 	FUNC(BAD_FILEMODE, WARN) \
 	FUNC(EMPTY_NAME, WARN) \
@@ -627,6 +629,19 @@ static int fsck_tree(struct tree *item, struct fsck_options *options)
 						 ".gitmodules is a symbolic link");
 		}
 
+		if (S_ISLNK(mode)) {
+			if (is_hfs_dotgitignore(name) ||
+			    is_ntfs_dotgitignore(name))
+				retval += report(options, &item->object,
+						 FSCK_MSG_GITIGNORE_SYMLINK,
+						 ".gitignore is a symlink");
+			if (is_hfs_dotgitattributes(name) ||
+			    is_ntfs_dotgitattributes(name))
+				retval += report(options, &item->object,
+						 FSCK_MSG_GITATTRIBUTES_SYMLINK,
+						 ".gitattributes is a symlink");
+		}
+
 		if (update_tree_entry_gently(&desc)) {
 			retval += report(options, &item->object, FSCK_MSG_BAD_TREE, "cannot be parsed as a tree");
 			break;
-- 
2.20.1.97.g81188d93c3

