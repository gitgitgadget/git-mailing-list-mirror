X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Michael K. Edwards" <medwards.linux@gmail.com>
Subject: [PATCH] Make "git checkout <branch> <path>" work when <path> is a directory.
Date: Thu, 16 Nov 2006 21:49:21 -0800
Message-ID: <f2b55d220611162149m719079f3ubdaeac43fe9798cb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Fri, 17 Nov 2006 05:49:29 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=WscioDism9xLkbd0HI/M+xE5ntlIxBfKq7QR6XbvcPwMNJwB2JWbd6GQpXui4Yv14hFOMOfEN44ux/Zcv2GqzNZht4cB++SHdW0JXkX7ZkoojBWH4opt3zOdTMA8DvlaJRFvXVtBFtMoP8HYtrzWaHEddacTcqt1CeNg2LitBKE=
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31666>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GkwbM-0001eo-TD for gcvg-git@gmane.org; Fri, 17 Nov
 2006 06:49:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1424776AbWKQFtW (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 17 Nov 2006
 00:49:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424778AbWKQFtW
 (ORCPT <rfc822;git-outgoing>); Fri, 17 Nov 2006 00:49:22 -0500
Received: from wx-out-0506.google.com ([66.249.82.238]:53221 "EHLO
 wx-out-0506.google.com") by vger.kernel.org with ESMTP id S1424776AbWKQFtV
 (ORCPT <rfc822;git@vger.kernel.org>); Fri, 17 Nov 2006 00:49:21 -0500
Received: by wx-out-0506.google.com with SMTP id s7so840447wxc for
 <git@vger.kernel.org>; Thu, 16 Nov 2006 21:49:21 -0800 (PST)
Received: by 10.90.89.5 with SMTP id m5mr1190830agb.1163742561153; Thu, 16
 Nov 2006 21:49:21 -0800 (PST)
Received: by 10.90.25.4 with HTTP; Thu, 16 Nov 2006 21:49:21 -0800 (PST)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

This improves the workflow for, say, kernel subsystem backporting.

Signed-off-by: Michael K. Edwards <medwards-linux@gmail.com>
---
 git-checkout.sh |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/git-checkout.sh b/git-checkout.sh
index dd47724..5866604 100755
--- a/git-checkout.sh
+++ b/git-checkout.sh
@@ -106,7 +106,8 @@ Did you intend to checkout '$@' which ca
 		git-ls-tree --full-name -r "$new" "$@" |
 		git-update-index --index-info || exit $?
 	fi
-	git-checkout-index -f -u -- "$@"
+	git-ls-files "$@" |
+	git-checkout-index -f -u --stdin
 	exit $?
 else
 	# Make sure we did not fall back on $arg^{tree} codepath
-- 
