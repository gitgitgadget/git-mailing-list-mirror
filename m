Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BBB3B1F731
	for <e@80x24.org>; Fri,  2 Aug 2019 15:40:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387474AbfHBPj7 (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Aug 2019 11:39:59 -0400
Received: from forward105j.mail.yandex.net ([5.45.198.248]:38320 "EHLO
        forward105j.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726150AbfHBPj7 (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 2 Aug 2019 11:39:59 -0400
Received: from mxback17j.mail.yandex.net (mxback17j.mail.yandex.net [IPv6:2a02:6b8:0:1619::93])
        by forward105j.mail.yandex.net (Yandex) with ESMTP id F3A3BB21D7E
        for <git@vger.kernel.org>; Fri,  2 Aug 2019 18:39:55 +0300 (MSK)
Received: from smtp3p.mail.yandex.net (smtp3p.mail.yandex.net [2a02:6b8:0:1472:2741:0:8b6:8])
        by mxback17j.mail.yandex.net (nwsmtp/Yandex) with ESMTP id vOHn7e1jKY-dtNO4Fhv;
        Fri, 02 Aug 2019 18:39:55 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1564760395;
        bh=m9cCoe1rToBEHK0vRNUM3HE+xTkuTBOKpqYulKPdCQo=;
        h=Subject:To:From:Date:Message-ID;
        b=aCJ3vAfZZ+LrOKxy7osHvTNoBsQE8DaFyJgrMTkiwC+SPbVFkTiDsjVGsdLGw9gK1
         7nmZxstk4htnzATwwQ/Lf4lrx0TcP/Nkv2WiVwuAvGGpYpZQ6zQXUkfT0EfDIsRlNc
         oRlFpUeFT7seXdoRy9ssxTWlph0oZen78VGB4D2Y=
Authentication-Results: mxback17j.mail.yandex.net; dkim=pass header.i=@yandex.ru
Received: by smtp3p.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id yZsT0HxDh5-dtbOpjdX;
        Fri, 02 Aug 2019 18:39:55 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (Client certificate not present)
Date:   Fri, 2 Aug 2019 18:39:54 +0300
From:   Eugen Konkov <kes-kes@yandex.ru>
Message-ID: <1543205721.20190802183954@yandex.ru>
To:     Git Mailing List <git@vger.kernel.org>
Subject: bad patch created when I use  --ignore-blank-lines option
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello Git,

I add and remove only blank lines at my file:

$ git log -p t/29-cmd_l.t

--- a/t/29-cmd_l.t
+++ b/t/29-cmd_l.t
@@ -218,7 +218,6 @@ __DATA__
 @@ list
 -e:0005  1;    
 -e:0002    2;
-
 -e
     0: use Devel::DbBatch split(/,/,q{list.conf;b 2;a 2 1;s 2;l .;q});;
     1: sub t {
@@ -226,26 +225,26 @@ ab>>2:     2;
     3: }
     4:
    x5: 1;
+
 @@ list from first
 -e:0010  t2();
-
 -e
     0: use Devel::DbBatch split(/,/,q{list.conf;l 0;q});;
     1: sub t0 {
    x2:     1;
     3: }
+
 @@ list from last
 -e:0010  t2();
-
 -e
     14:
     15:
     16:
     17: # Perl implicitly adds one new line after this one
     18:
+
 @@ list middle
 -e:0010  t2();
-
 -e
    x5:     t0();
     6: }



But  when I use --ignore-blank-lines option I see broken patch. I have
not added '-e' line, but it is displayed as it was added. Notice '+-e'

$ git log -p --ignore-blank-lines t/29-cmd_l.t

diff --git a/t/29-cmd_l.t b/t/29-cmd_l.t
index 4b77279..d7739d2 100755
--- a/t/29-cmd_l.t
+++ b/t/29-cmd_l.t
@@ -219,6 +219,7 @@ __DATA__
 -e:0005  1;    
 -e:0002    2;
 
+-e
     0: use Devel::DbBatch split(/,/,q{list.conf;b 2;a 2 1;s 2;l .;q});;
     1: sub t {
 ab>>2:     2;
@@ -228,6 +229,7 @@ ab>>2:     2;
 @@ list from first
 -e:0010  t2();
 
+-e
     0: use Devel::DbBatch split(/,/,q{list.conf;l 0;q});;
     1: sub t0 {
    x2:     1;
@@ -235,6 +237,7 @@ ab>>2:     2;
 @@ list from last
 -e:0010  t2();
 
+-e
     14:
     15:
     16:
@@ -243,6 +246,7 @@ ab>>2:     2;
 @@ list middle
 -e:0010  t2();
 
+-e
    x5:     t0();
     6: }
     7: sub t2 {


$ git --version
git version 2.22.0


-- 
Best regards,
Eugen Konkov

