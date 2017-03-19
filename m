Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DADED20323
	for <e@80x24.org>; Sun, 19 Mar 2017 20:35:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752616AbdCSUfq (ORCPT <rfc822;e@80x24.org>);
        Sun, 19 Mar 2017 16:35:46 -0400
Received: from avasout01.plus.net ([84.93.230.227]:47242 "EHLO
        avasout01.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752609AbdCSUfn (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 19 Mar 2017 16:35:43 -0400
Received: from [10.0.2.15] ([146.90.175.94])
        by avasout01 with smtp
        id xwb11u00722aPyA01wb2KN; Sun, 19 Mar 2017 20:35:03 +0000
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.2 cv=BZKo6vl2 c=1 sm=1 tr=0
 a=c4JbszTospdBBUsinAk+iw==:117 a=c4JbszTospdBBUsinAk+iw==:17
 a=IkcTkHD0fZMA:10 a=pGLkceISAAAA:8 a=e2-a8QnzKVL_YJ6qN-QA:9 a=QEXdDO2ut3YA:10
 a=6kGIvZw6iX1k4Y-7sg4_:22
X-AUTH: ramsayjones@:2500
Subject: Re: [PATCH v6 02/27] files-backend: make files_log_ref_write() static
To:     Michael Haggerty <mhagger@alum.mit.edu>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, git@vger.kernel.org
References: <20170222140450.30886-1-pclouds@gmail.com>
 <20170318020337.22767-1-pclouds@gmail.com>
 <20170318020337.22767-3-pclouds@gmail.com>
 <a949cc96-34a4-fb5d-06c6-e124f6c025aa@alum.mit.edu>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Stefan Beller <sbeller@google.com>, novalis@novalis.org
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <dda96cdb-ec10-cb46-96e9-576062d90841@ramsayjones.plus.com>
Date:   Sun, 19 Mar 2017 20:35:01 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.0
MIME-Version: 1.0
In-Reply-To: <a949cc96-34a4-fb5d-06c6-e124f6c025aa@alum.mit.edu>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 19/03/17 19:10, Michael Haggerty wrote:
> On 03/18/2017 03:03 AM, Nguyễn Thái Ngọc Duy wrote:
>> Created in 5f3c3a4e6f (files_log_ref_write: new function - 2015-11-10)
>> but probably never used outside refs-internal.c
>>
>> Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
>> ---
>>  refs/files-backend.c | 3 +++
>>  refs/refs-internal.h | 4 ----
>>  2 files changed, 3 insertions(+), 4 deletions(-)
>>
>> diff --git a/refs/files-backend.c b/refs/files-backend.c
>> index 50188e92f9..0a6d2bf6bc 100644
>> --- a/refs/files-backend.c
>> +++ b/refs/files-backend.c
>> @@ -165,6 +165,9 @@ static struct ref_entry *create_dir_entry(struct files_ref_store *ref_store,
>>  					  const char *dirname, size_t len,
>>  					  int incomplete);
>>  static void add_entry_to_dir(struct ref_dir *dir, struct ref_entry *entry);
>> +static int files_log_ref_write(const char *refname, const unsigned char *old_sha1,
>> +			       const unsigned char *new_sha1, const char *msg,
>> +			       int flags, struct strbuf *err);
>>  
>>  static struct ref_dir *get_ref_dir(struct ref_entry *entry)
>>  {
>> diff --git a/refs/refs-internal.h b/refs/refs-internal.h
>> index fa93c9a32e..f732473e1d 100644
>> --- a/refs/refs-internal.h
>> +++ b/refs/refs-internal.h
>> @@ -228,10 +228,6 @@ struct ref_transaction {
>>  	enum ref_transaction_state state;
>>  };
>>  
>> -int files_log_ref_write(const char *refname, const unsigned char *old_sha1,
>> -			const unsigned char *new_sha1, const char *msg,
>> -			int flags, struct strbuf *err);
>> -
>>  /*
>>   * Check for entries in extras that are within the specified
>>   * directory, where dirname is a reference directory name including
>>
> 
> You changed the declaration, but the definition still makes the function
> non-static.

Actually, this is a static symbol, since it's 'static-ness' derives
from the above forward declaration.

However, as I said in a previous email, this tickles sparse to issue
a warning. In addition, simply adding 'static' to the definition
(ie simply _don't_ do the forward declaration) is less work! :-D

ATB,
Ramsay Jones


