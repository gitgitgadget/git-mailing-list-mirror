Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0B004208DB
	for <e@80x24.org>; Wed, 30 Aug 2017 17:50:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752245AbdH3Rub (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Aug 2017 13:50:31 -0400
Received: from mout.web.de ([212.227.17.11]:57708 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752024AbdH3RuJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Aug 2017 13:50:09 -0400
Received: from debian.fritz.box ([91.20.59.6]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MddFQ-1eA7cp29oi-00PPSP for
 <git@vger.kernel.org>; Wed, 30 Aug 2017 19:50:07 +0200
From:   Rene Scharfe <l.s.r@web.de>
To:     git@vger.kernel.org
Subject: [PATCH 15/34] help: release strbuf on error return in exec_woman_emacs()
Date:   Wed, 30 Aug 2017 19:49:46 +0200
Message-Id: <20170830175005.20756-16-l.s.r@web.de>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20170830175005.20756-1-l.s.r@web.de>
References: <20170830175005.20756-1-l.s.r@web.de>
X-Provags-ID: V03:K0:Ea0+eTwTyiCniIEbhsdUVyvyFjeND1FErx60T4ldRl+cwuo3Iq5
 k4J3sMQSO+di8B31/zSAdIKhR2evEiZPDsCipj2yA7bPNeq5CZN4sLrt2eZ8Te6O0dVeZMw
 Wiyq05DlvBm+ylnx6Vn/+dqPXhXUk2arUSFMo1vu88yQW4UJd+gs7fUNYyfZOkndYVgjKyr
 2XFc6Xf83KGn0ic654h/Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ZdPYJ816czY=:OQ4nlFxNx90Yt1g2u5o/+E
 IYUCteKwpSK2KuhkoduK8mfjUNvYmpsWBNfeLoSegow+og62myx7TN1x4twssgShtMhWPij0Q
 lw+lgTIs+kbdrQQ5giHs22hZuaUgm48WUQ1P24hguvU9ZJw602Sr3gXvLD7rTdQIk4+p/SN5g
 msE82c/uS9mrdVe43tn97uw/FeH7TmiWC9Ps7YRAhgKKCEZkMpQcXyFojZLptlAYidOBJ3ACe
 r92ShO5/HHOzTYroRkbKduOaAEKh1YrU9XhGlU1VYLEBoLElQk+A0ioEG1R3l+MMBqlTfme+p
 p2kDOTkY+KGopvJzeIckrda8jvYKfoT+fVe8CM5PRQqt28+64Hx0CGxbhNR45dapGCEwD9ewN
 RNIOSvO85zPhwGHieGb2adp43CVrNatAZATfGJ91D0njMEy5/ilDxLI9M1HzvVfCeORh+cRbS
 j06Xf6BOccEMNGoBWWaZTMFF/z/zA8U9U+Ilgb+VbnkFZRozi6adMrkN+LWqKWtl1HC4WClSV
 D6xjmsSps+No68gXfs4QKVOaBjcOd3zK7UCJV99hJsibla2Bo62JjpTouyOqL8hdgVsSkWTay
 /DKVDZ9KH5lTuTYlFod8TwVA1YXDPLGPcH4YtwoA2vh/27RReERhhDb3dH/4dfMbYKTqIF0ti
 NdtpQD1e3QXWvRm+4F5HC38BkAefVwUbLBA+/89/bp7NRXueraOIS5LUqrdj8rkHVvE+t/K+/
 5OU/pk5nh1fs9gUQ6NDq7N1bLQiGjJdCXcsyvEM+VXAApRgx3esIIEof1TrUj7r+/YyMp7KZV
 jqAiV+rhCQnDkvbUbugSOMSSPv5Kg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 builtin/help.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/builtin/help.c b/builtin/help.c
index 12fb48933e..b3f60a8f30 100644
--- a/builtin/help.c
+++ b/builtin/help.c
@@ -123,14 +123,15 @@ static int check_emacsclient_version(void)
 static void exec_woman_emacs(const char *path, const char *page)
 {
 	if (!check_emacsclient_version()) {
 		/* This works only with emacsclient version >= 22. */
 		struct strbuf man_page = STRBUF_INIT;
 
 		if (!path)
 			path = "emacsclient";
 		strbuf_addf(&man_page, "(woman \"%s\")", page);
 		execlp(path, "emacsclient", "-e", man_page.buf, (char *)NULL);
 		warning_errno(_("failed to exec '%s'"), path);
+		strbuf_release(&man_page);
 	}
 }
 
-- 
2.14.1

