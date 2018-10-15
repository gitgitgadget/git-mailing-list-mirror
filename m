Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 61F131F453
	for <e@80x24.org>; Mon, 15 Oct 2018 17:33:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726691AbeJPBTs (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 Oct 2018 21:19:48 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:45495 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726585AbeJPBTs (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Oct 2018 21:19:48 -0400
Received: by mail-qt1-f193.google.com with SMTP id e10-v6so22385543qtq.12
        for <git@vger.kernel.org>; Mon, 15 Oct 2018 10:33:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=9zv/K7HBHwrxTYfupAJMnqEMSsEFCQ1W/JhQXB/ZPY8=;
        b=eHUqD53VSbpTYGUBSGn9z7qQ1A1KboU1IRFfWugc68YfVpzDIvaKB/IfLp32TedQw7
         UoUTHOXPA/cdswD6/YnNRTxPzEPSvaKanuFemsTfDYVzPmpBSHiNtREjuKghXXH4wN5T
         qhQoG987pUTtNrkhAOHlxJreK87qzNhlNPvH+DW9rsSWxLy3UoG7QujjjiJosuEZE6q3
         zh2v/k20RkDxAA8GXTVn39PvfJ+brLHBOdi3JekaOrUtHZWhuFESoxXBJLyeQWywDuZN
         tvVICGWhXgf8sJJyWHT09mXuRc/rBpmn6UbKylrIrXF4xINDnguaZSQRLVmmyEdC9xLn
         D74A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9zv/K7HBHwrxTYfupAJMnqEMSsEFCQ1W/JhQXB/ZPY8=;
        b=ZxEAyoSjnaHC1BUlR5KbbFG6cP3XFCTfjNWCvIed/FMBtrPEkAsyx4E9InhKKkH5D2
         Usq9lUOsDeUNxmrecIh1J5OCeHZKHvBkmWm1sgiBaKV7/sCxBg4CP65wygwF95E1gDbz
         ZzrTVwSKbtHgdG7Ls+xS5fh8xJo8qOwkEKGB1qxS1srLyQgTnLHJHoda1wRReE7PSLyv
         qCuInfUMsaOvwQW3r08jPhOjJ3mmQHjFVNOhBwaBYTw2/mOOKrVNJShsjcGKXODczEDC
         CclWk1ImxVwK9EOn1PMwTuCMQ1bwdX1yZs68eg7G1zUUse9iQUGckmHiwmk6tOJWvpvT
         UliA==
X-Gm-Message-State: ABuFfojlOk+voab1vSoEhtjEO/Le60M1o90Zt4B47MWsBd9409hkHU91
        bidnZcoCRkY3ZXVwFLv3768=
X-Google-Smtp-Source: ACcGV61VQNRMPhdB58YP/KeT7KnwdDWTwiHKNDii2ZgmIqHT+Hj2apvhyyajggKf/aHPkQc13B34Ww==
X-Received: by 2002:ac8:65cd:: with SMTP id t13-v6mr16759791qto.260.1539624815544;
        Mon, 15 Oct 2018 10:33:35 -0700 (PDT)
Received: from [192.168.1.97] (70-33-148-227.unassigned.ntelos.net. [70.33.148.227])
        by smtp.gmail.com with ESMTPSA id n67-v6sm10359718qkh.66.2018.10.15.10.33.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Oct 2018 10:33:34 -0700 (PDT)
Subject: Re: [PATCH v8 0/7] speed up index load through parallelization
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Ben Peart <benpeart@microsoft.com>
References: <20180823154053.20212-1-benpeart@microsoft.com>
 <20181010155938.20996-1-peartben@gmail.com>
 <CACsJy8CyG0DWPyq5cSUteFUiz1ZCpmmVFjYjt8Gxm3Hnvd5q9g@mail.gmail.com>
From:   Ben Peart <peartben@gmail.com>
Message-ID: <3a7fb135-95e3-9dab-ca31-8daadc5cf80c@gmail.com>
Date:   Mon, 15 Oct 2018 13:33:32 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CACsJy8CyG0DWPyq5cSUteFUiz1ZCpmmVFjYjt8Gxm3Hnvd5q9g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

fixup! IEOT error messages

Enable localizing new error messages and improve the error message for
invalid IEOT extension sizes.

Signed-off-by: Ben Peart <benpeart@microsoft.com>
---
  read-cache.c | 4 ++--
  1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/read-cache.c b/read-cache.c
index 7acc2c86f4..f9fa6a7979 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -3480,7 +3480,7 @@ static struct index_entry_offset_table 
*read_ieot_extension(const char *mmap, si
         /* validate the version is IEOT_VERSION */
         ext_version = get_be32(index);
         if (ext_version != IEOT_VERSION) {
-	       error("invalid IEOT version %d", ext_version);
+	       error(_("invalid IEOT version %d"), ext_version);
  	       return NULL;
         }
         index += sizeof(uint32_t);
@@ -3488,7 +3488,7 @@ static struct index_entry_offset_table 
*read_ieot_extension(const char *mmap, si
         /* extension size - version bytes / bytes per entry */
         nr = (extsize - sizeof(uint32_t)) / (sizeof(uint32_t) + 
sizeof(uint32_t));
         if (!nr) {
-	       error("invalid number of IEOT entries %d", nr);
+	       error(_("invalid IEOT extension size %d"), extsize);
  	       return NULL;
         }
         ieot = xmalloc(sizeof(struct index_entry_offset_table)
-- 
2.18.0.windows.1



On 10/14/2018 8:28 AM, Duy Nguyen wrote:
> On Wed, Oct 10, 2018 at 5:59 PM Ben Peart <peartben@gmail.com> wrote:
>> @@ -3460,14 +3479,18 @@ static struct index_entry_offset_table *read_ieot_extension(const char *mmap, si
>>
>>          /* validate the version is IEOT_VERSION */
>>          ext_version = get_be32(index);
>> -       if (ext_version != IEOT_VERSION)
>> +       if (ext_version != IEOT_VERSION) {
>> +              error("invalid IEOT version %d", ext_version);
> 
> Please wrap this string in _() so that it can be translated.
> 
>>                 return NULL;
>> +       }
>>          index += sizeof(uint32_t);
>>
>>          /* extension size - version bytes / bytes per entry */
>>          nr = (extsize - sizeof(uint32_t)) / (sizeof(uint32_t) + sizeof(uint32_t));
>> -       if (!nr)
>> +       if (!nr) {
>> +              error("invalid number of IEOT entries %d", nr);
> 
> Ditto. And reporting extsize may be more useful than nr, which we know
> is zero, but we don't know why it's calculated zero unless we know
> extsize.
> 
