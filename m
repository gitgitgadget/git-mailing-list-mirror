Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0A8481F403
	for <e@80x24.org>; Sun, 10 Jun 2018 10:56:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753869AbeFJK4r (ORCPT <rfc822;e@80x24.org>);
        Sun, 10 Jun 2018 06:56:47 -0400
Received: from mout.web.de ([217.72.192.78]:34763 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751815AbeFJK4q (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 10 Jun 2018 06:56:46 -0400
Received: from [192.168.178.36] ([79.237.242.156]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MdLsF-1fjuFN3MGZ-00IXDq; Sun, 10
 Jun 2018 12:56:34 +0200
Subject: Re: [PATCH 24/30] merge-recursive: Add computation of collisions due
 to dir rename & merging
To:     Elijah Newren <newren@gmail.com>, git@vger.kernel.org
References: <20171110190550.27059-1-newren@gmail.com>
 <20171110190550.27059-25-newren@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <7d1237c7-5a83-d766-7d93-5f0d59166067@web.de>
Date:   Sun, 10 Jun 2018 12:56:31 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20171110190550.27059-25-newren@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:xtHgT2Hiq+swmI0fowr0OaWrgZKUzx9GisUxXlcfRUxFWzS7JbO
 iaLRPNptE1s9PLp3RbSM7R+3IDYwtNaCQ2q7tLsjU8ChOfTKEOux1gtNgSkRwmHF8TvBu5a
 YpjeI3tkDLGzLJKb1F4BE0aU0PoWwWzFWvqZNH9GKABqQs+x+66tbBbO6CsHAThyx54Mu94
 NmvXFRPLXqOtKbpcqMnkQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:eh6dwt9jN7g=:b6hCKHS+/O+uc1Rr7egert
 WoxcZE9MyXTwFhEg2xFT80hhiENq/9+YFEiwZ4VeYUYDktQjsJEqJvOftf/RUi6yKM3xEs10M
 6TyGCNHlDWE7pZOankJQ3mG/5KlDowdR2jwTZIsymWUx6DNY05suPI14l2B9sb1/7985YtBF5
 ao3BhpZbYQKEOf24bQqcBIdoGOZ23g1L759PxaS007szkJn6fnSfxqeJ/kYtT3k/1iweeR8a4
 wvck9kZxWJJWHmv72DjLtkPJXt2RuGod4Huh2PF1vh70SICrm2fqgoX8AdFXAgDeNdtPpedF8
 wjW4HDr3viRph5dt9a7eZH/XQceQ07ARLXQ3M97R0wBtUEnkHluXCOxE92MYQJvq+QKp3PB4C
 ZSp/393F9goT8L1P/fD8Lr9GkMbKiHBHMGsB/5Chg8qliakaldoY5XPNKjF29845nCUbld0JW
 klrChEJtUZfdAHgdIU42iW6FlrHpUUYcuztYqdkUznzh4IVFWIsuoQOT35LgtrexWh6aSvCDN
 p6z2YZSnTsHLkThyoQjPBLm8/I6NCqqkzO7O32TH5qySheDKETeYr0le7kma0Xak2YxAXixDJ
 C/VJRHDKP7cJAUOKxoBB9wOaO4G/CY0QnNFFcWkjRL2O8u8cIr12M2vrLBGRg0FI91x+Rxu8w
 i8qoMtMIwU8TgUh4ZqnHrANNXwkIRPfOi519nPqH5lsFirxCVyNXZuRmZkM2TT+Lz4f1nvdpW
 7fFGzjykcO5f4qjlZxYusRog1W4Mz8Uy8JgIq1GioMgpbY/v/GTS+Ps4zU3Q4Eo+l53KpEPJq
 /nYRfdQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 10.11.2017 um 20:05 schrieb Elijah Newren:
> +static struct dir_rename_entry *check_dir_renamed(const char *path,
> +						  struct hashmap *dir_renames) {
> +	char temp[PATH_MAX];
> +	char *end;
> +	struct dir_rename_entry *entry;
> +
> +	strcpy(temp, path);
> +	while ((end = strrchr(temp, '/'))) {
> +		*end = '\0';
> +		entry = dir_rename_find_entry(dir_renames, temp);
> +		if (entry)
> +			return entry;
> +	}
> +	return NULL;
> +}

The value of PATH_MAX is platform-dependent, so it's easy to exceed when
doing cross-platform development.  It's also not a hard limit on most
operating systems, not even on Windows.  Further reading:

   https://insanecoding.blogspot.com/2007/11/pathmax-simply-isnt.html

So using a fixed buffer is not a good idea, and writing to it without
checking is dangerous.  Here's a fix:

-- >8 --
Subject: [PATCH] merge-recursive: use xstrdup() instead of fixed buffer

Paths can be longer than PATH_MAX.  Avoid a buffer overrun in
check_dir_renamed() by using xstrdup() to make a private copy safely.

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 merge-recursive.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index ac27abbd4c..db708176c5 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -2211,18 +2211,18 @@ static struct hashmap *get_directory_renames(struct diff_queue_struct *pairs,
 static struct dir_rename_entry *check_dir_renamed(const char *path,
 						  struct hashmap *dir_renames)
 {
-	char temp[PATH_MAX];
+	char *temp = xstrdup(path);
 	char *end;
-	struct dir_rename_entry *entry;
+	struct dir_rename_entry *entry = NULL;;
 
-	strcpy(temp, path);
 	while ((end = strrchr(temp, '/'))) {
 		*end = '\0';
 		entry = dir_rename_find_entry(dir_renames, temp);
 		if (entry)
-			return entry;
+			break;
 	}
-	return NULL;
+	free(temp);
+	return entry;
 }
 
 static void compute_collisions(struct hashmap *collisions,
-- 
2.17.1
