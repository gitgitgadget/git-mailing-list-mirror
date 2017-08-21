Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 10667208CD
	for <e@80x24.org>; Mon, 21 Aug 2017 12:53:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753257AbdHUMxU (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 Aug 2017 08:53:20 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:62332 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752234AbdHUMxT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Aug 2017 08:53:19 -0400
Received: from localhost ([130.75.46.4]) by mrelayeu.kundenserver.de (mreue104
 [212.227.15.183]) with ESMTPSA (Nemesis) id 0M9pIu-1dqQ202sDw-00B1hB; Mon, 21
 Aug 2017 14:53:16 +0200
From:   Michael J Gruber <git@grubix.eu>
To:     git@vger.kernel.org
Cc:     hIpPy <hippy2981@gmail.com>
Subject: [PATCH v2 0/3] Keep merge during kills
Date:   Mon, 21 Aug 2017 14:53:13 +0200
Message-Id: <cover.1503319519.git.git@grubix.eu>
X-Mailer: git-send-email 2.14.1.364.ge466dba5f7
In-Reply-To: <fe681e447791ded6db52ccd84e64e3637c08ffe5.1503309751.git.git@grubix.eu>
References: <fe681e447791ded6db52ccd84e64e3637c08ffe5.1503309751.git.git@grubix.eu>
X-Provags-ID: V03:K0:uyu+vXrMp0DKST6++7LYSylNFlVJDo5HGkLuX8d/A0CSVUBzI/g
 HRNr9GSNIm5zu2uY4+tHjlYVQEUTNk8Yeu9Lbpzsnc7bWVhDjoez8omn4CB/3PlUyTtbEGU
 kmnv+qzs/5tGWpCMlDNdkfVlUJ1sVhS9fWUovm1mLxfhyxHi+RSuANUvd3MPa/hCNpZNhpJ
 BQHTDC9sCPdr+WR4xhEyw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:yOs4qVvSOS4=:p4aierj3VTmhUgdlIfOrGd
 pHncbWqwoGVjKG9x1ZxAP+wWDSnZdJPrvo9N6Q9fDF/E+UN1SjAe57T+mg/6gZfrnG4pxD8nt
 OTqJmwEBDHsU+sLWt1HZdFfYfzcSOR93/ENUKVIYpBGwu2wjhpH75gco2n0+X5s2TM78zwg0N
 bPxhFvJyaXHytwpzVbsWC0qaRRmGqfTdJWrxCcn6NwTYVHqIePZtKExXKysZq5mYucoRJNuoF
 Pflr3HiDIFLGZSEULyseM2W31kC9ykhwGTSMYZ0EUskcMb1hrdGyNiUrWWuPY+JXXOKewbt0t
 dfF36Cjj6CVPl5HsIWmp2Li70VUrwBeVVc4D7IaxdxU7shyRDjsMm0zh8YVH3vDwj+KbIUv3y
 n9VbbI9NhsIxtVSOPNLf2yRCzGQsCy2icSjg4ywm7XmiPlGNgulbH0wXe9KUlLPcbbPrtpnhf
 G2CuuAwZaR7iOlAgxCBi64rAznPEyiwgyk0Zsb9wp7w2J7mGlR5H8hgbbVUzsrlvBgYxR6YNR
 /H0Sbf4SlEJSmjgqtCa+1pUBQtx1TjibLx/nKAf/Waq+0xBsaDyz1eNBGxYPuPqcfmKc870pa
 ANmNUfd5ajYxgmx4DX1jJWYkY0sjrD6ZL99jnmNsCUxQXKkNmWsBFxTnOhAsKzKw5typ/62K/
 qZECdr0rNquNQjHexeS1JavQZIgK3Is1S5EdrCPMummnZD7kbk3zProAB+/zEiwqchDddc2Uw
 C362P7aqfJH8gRPdyw0guyZup+s+EOEnWl76vw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

So here's a little series.

1/3 I just noted along the way

2/3 splits the merge state writing into parts as a preparatory step.
This is something we may want to carry further and get rid of some other
places which write merge_msg unneccessarily so that merge performance
does not suffer because of the additional write.

3/3 comes with a test now. It's crafted after t7502 and does not work
under MINGW, unfortunately. But the fix does :)

I'm still asking for comments whether this has other side effects. I've
been told there are people who do a lot of merges regularly, and they're
not the kind of people that I'd like to make angry - at least not
without a good reason.

Michael J Gruber (3):
  Documentation/git-merge: explain --continue
  merge: split write_merge_state in two
  merge: save merge state earlier

 Documentation/git-merge.txt |  5 ++++-
 builtin/merge.c             | 14 +++++++++++---
 t/t7600-merge.sh            | 15 +++++++++++++++
 3 files changed, 30 insertions(+), 4 deletions(-)

-- 
2.14.1.364.ge466dba5f7

