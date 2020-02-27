Return-Path: <SRS0=G+lC=4P=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9CF7C4BA2D
	for <git@archiver.kernel.org>; Thu, 27 Feb 2020 12:48:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 924B424695
	for <git@archiver.kernel.org>; Thu, 27 Feb 2020 12:48:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=pascalroeleven.nl header.i=@pascalroeleven.nl header.b="bIRzKynX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729067AbgB0Msa (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Feb 2020 07:48:30 -0500
Received: from web0081.zxcs.nl ([185.104.29.10]:56078 "EHLO web0081.zxcs.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729033AbgB0Msa (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Feb 2020 07:48:30 -0500
X-Greylist: delayed 3970 seconds by postgrey-1.27 at vger.kernel.org; Thu, 27 Feb 2020 07:48:30 EST
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=pascalroeleven.nl; s=x; h=Message-ID:Subject:To:From:Date:
        Content-Transfer-Encoding:Content-Type:MIME-Version:Sender:Reply-To:Cc:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=E2tdv6zpiJ5OUQFGxJOQ696gDZ5Czm8oAuEFiwBUS2c=; b=bIRzKynXrB8j8KyJ3vl+j1TRG
        dw/FUtLuS7fhlU8aXoh5cVuhK2oXoO9S1GEVVJYQNpeupjhJlJdDH9WbA/g5mHZvt7U4D5jypecgh
        h2nPI1fDWqzVfvqFtPaEcllwH8XtAP3oAuXwAVsQqQz9hYF7BiybYQR0MAi6FVvRlZ+Lp55tNStuE
        iZYn8R7+mUM1nq3G16zVH2XahyZ2YiXw51Qw08pGyP/D7seujo4z6eOGyZXl/vsSemmhP4S2Zmzry
        44WdXKD7JTWt8PgFUjTdnQQdO/xxDgpyYdoMQ+cWSgRAhkJsOIPYcLU3x8TsMTLlig/n+l7ewb/l7
        le3Vgf0Mw==;
Received: from spamrelay.zxcs.nl ([185.104.28.12]:44992 helo=mail-slave01.zxcs.nl)
        by web0081.zxcs.nl with esmtp (Exim 4.92.3)
        (envelope-from <dev@pascalroeleven.nl>)
        id 1j7HYZ-000FIS-0m
        for git@vger.kernel.org; Thu, 27 Feb 2020 12:42:19 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 27 Feb 2020 12:42:18 +0100
From:   dev@pascalroeleven.nl
To:     git@vger.kernel.org
Subject: [PATCH 1/1] ls-remote: don't use '-h' for options
User-Agent: Roundcube Webmail/1.4.2
Message-ID: <b0397b3285eab3448a3fd5dd2c50abb9@pascalroeleven.nl>
X-Sender: dev@pascalroeleven.nl
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The '-h' option for ls-remote will never be reached as the argument is
already processed by the git wrapper before passed on to ls-remote.
The ls-remote help text will therefore be displayed instead of the
'--heads' option.

Signed-off-by: Pascal Roeleven <dev@pascalroeleven.nl>
---
  Documentation/git-ls-remote.txt | 1 -
  builtin/ls-remote.c             | 2 +-
  2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/Documentation/git-ls-remote.txt 
b/Documentation/git-ls-remote.txt
index a2ea1fd..b5b7d7a 100644
--- a/Documentation/git-ls-remote.txt
+++ b/Documentation/git-ls-remote.txt
@@ -21,7 +21,6 @@ commit IDs.

  OPTIONS
  -------
--h::
  --heads::
  -t::
  --tags::
diff --git a/builtin/ls-remote.c b/builtin/ls-remote.c
index 6ef5195..85ce336 100644
--- a/builtin/ls-remote.c
+++ b/builtin/ls-remote.c
@@ -63,7 +63,7 @@ int cmd_ls_remote(int argc, const char **argv, const 
char *prefix)
  			   N_("path of git-upload-pack on the remote host"),
  			   PARSE_OPT_HIDDEN },
  		OPT_BIT('t', "tags", &flags, N_("limit to tags"), REF_TAGS),
-		OPT_BIT('h', "heads", &flags, N_("limit to heads"), REF_HEADS),
+		OPT_BIT(0, "heads", &flags, N_("limit to heads"), REF_HEADS),
  		OPT_BIT(0, "refs", &flags, N_("do not show peeled tags"), 
REF_NORMAL),
  		OPT_BOOL(0, "get-url", &get_url,
  			 N_("take url.<base>.insteadOf into account")),
-- 
2.20.1

