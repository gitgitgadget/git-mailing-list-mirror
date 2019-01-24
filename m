Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D27A11F453
	for <e@80x24.org>; Thu, 24 Jan 2019 19:49:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731700AbfAXTtD (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 Jan 2019 14:49:03 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:39207 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729295AbfAXTtC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Jan 2019 14:49:02 -0500
Received: by mail-wm1-f66.google.com with SMTP id y8so4346294wmi.4
        for <git@vger.kernel.org>; Thu, 24 Jan 2019 11:49:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=qipxG+xzKynQ4fdLh7UDM/0d1dQvEALi0MrBZZUaT5s=;
        b=oqSmHZCap9iOu7cyh6KaMDBo5F2EnBIUWHG13ARiexf3GhCg/U151/vAT1uteMBKqY
         /LkDEQhqqFOU0jsHFtj7tvvWJ3sddWOeQUqlXNJDOK45iksGzTmfgwMaUD9wSqBq3DvX
         vIPYgYge7S/cqQ3Wbe2H9lwxHo7OxhI6A965PKuSCjUn3JbDwfJqXf4UK4rkQ7N6IDvh
         omeruuGNz32LhuYFSOeixxWkQ+KZpeP7Jptc0UTGtc5zcZi6ngXgIrV6jbcAXHum0qbS
         O+AcpMbk2CCl3dlaiuuMeCDDhgsLdRI0Ty3K3QJ03VXCxKcHzMwKagHGVYpU/0/U4Wnj
         CDRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=qipxG+xzKynQ4fdLh7UDM/0d1dQvEALi0MrBZZUaT5s=;
        b=RomWRy2fispIhjfgQz23gDLCyTHm6gUyO4+O0XXfxsK5U3suhr2IEyGfIw71T/XgMc
         4LP2IknD2ueUBd1JBhrklWnqxdb1sWP0RP7J2krldeH9JR6I6AKc/t9qEjQnJdb94qyz
         9vi12+9P7JHdCRjHbODJR08h3t5aWbUJ0kdADUzCyp4nDPLWzNx8NPTx71POlA6t2D06
         iCM0/9deVEkkHCoQK3hGHFHMv0SvtZb3jdG68Y880dGDRoOizNbjuEHzUmQYCzfbJ/kY
         DLvcBG2xZxEHv/1zuIaJzuYfHJAwgPKOJc5y/b4B9Bn2Uw0CsTVM28PMOTKm6HZkwsxF
         eSpA==
X-Gm-Message-State: AJcUukeLku4Tq+htAqD/qUyy/kdWlUSDha8GmCxO1cFzwgh7z1yZttM8
        fjod/P7kcDsfXCgFKQNxDkfHr60a
X-Google-Smtp-Source: ALg8bN6irdJxr5iVj8hclSNWBLgj/gMMjCx4NukW4MptieRzYBrPsupjmnbLCZzgmp6jeqymNSbt2Q==
X-Received: by 2002:a1c:2007:: with SMTP id g7mr3911361wmg.79.1548359339987;
        Thu, 24 Jan 2019 11:48:59 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id r77sm78702207wmd.22.2019.01.24.11.48.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 24 Jan 2019 11:48:58 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Patrick Hogg <phogg@novamoon.net>,
        Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v3 2/2] pack-objects: merge read_lock and lock in packing_data struct
References: <20190124010521.28452-1-phogg@novamoon.net>
        <20190124010521.28452-2-phogg@novamoon.net>
        <CACsJy8BDn-WBci72-DaAmc=SJsDnaiiN_rW+Yjb-1G1KFH7eCw@mail.gmail.com>
Date:   Thu, 24 Jan 2019 11:48:58 -0800
In-Reply-To: <CACsJy8BDn-WBci72-DaAmc=SJsDnaiiN_rW+Yjb-1G1KFH7eCw@mail.gmail.com>
        (Duy Nguyen's message of "Thu, 24 Jan 2019 15:33:09 +0700")
Message-ID: <xmqq7eetj0ph.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Duy Nguyen <pclouds@gmail.com> writes:

> On Thu, Jan 24, 2019 at 8:06 AM Patrick Hogg <phogg@novamoon.net> wrote:
>> diff --git a/pack-objects.h b/pack-objects.h
>> index 0a038e3bc..dc869f26c 100644
>> --- a/pack-objects.h
>> +++ b/pack-objects.h
>> @@ -146,7 +146,6 @@ struct packing_data {
>>         struct packed_git **in_pack;
>>
>>         pthread_mutex_t lock;
>> -       pthread_mutex_t read_lock;
>
> "lock" without any comments in this struct, to me, implies that it
> protects access to this struct alone. But since you're using it as
> "read lock" (aka access to object database), I think you should add a
> comment here clarify the new role of "lock" variable.

Sounds sensible.  How about squashing something like this in?

Some older part of this file still tries to hide the reliance on the
global variable "to_pack", but newer code refers to it already, and
I think it no longer is buying us much.

 builtin/pack-objects.c | 24 ++++++++++--------------
 pack-objects.c         |  2 +-
 pack-objects.h         | 11 ++++++++---
 3 files changed, 19 insertions(+), 18 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 5439b434c6..cfef48217f 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -1953,10 +1953,6 @@ static int delta_cacheable(unsigned long src_size, unsigned long trg_size,
 	return 0;
 }
 
-/* Protect access to object database */
-#define pack_lock()		packing_data_lock(&to_pack)
-#define pack_unlock()		packing_data_unlock(&to_pack)
-
 /* Protect delta_cache_size */
 static pthread_mutex_t cache_mutex;
 #define cache_lock()		pthread_mutex_lock(&cache_mutex)
@@ -1992,11 +1988,11 @@ unsigned long oe_get_size_slow(struct packing_data *pack,
 	unsigned long used, avail, size;
 
 	if (e->type_ != OBJ_OFS_DELTA && e->type_ != OBJ_REF_DELTA) {
-		pack_lock();
+		packing_data_lock(&to_pack);
 		if (oid_object_info(the_repository, &e->idx.oid, &size) < 0)
 			die(_("unable to get size of %s"),
 			    oid_to_hex(&e->idx.oid));
-		pack_unlock();
+		packing_data_unlock(&to_pack);
 		return size;
 	}
 
@@ -2004,7 +2000,7 @@ unsigned long oe_get_size_slow(struct packing_data *pack,
 	if (!p)
 		BUG("when e->type is a delta, it must belong to a pack");
 
-	pack_lock();
+	packing_data_lock(&to_pack);
 	w_curs = NULL;
 	buf = use_pack(p, &w_curs, e->in_pack_offset, &avail);
 	used = unpack_object_header_buffer(buf, avail, &type, &size);
@@ -2013,7 +2009,7 @@ unsigned long oe_get_size_slow(struct packing_data *pack,
 		    oid_to_hex(&e->idx.oid));
 
 	unuse_pack(&w_curs);
-	pack_unlock();
+	packing_data_unlock(&to_pack);
 	return size;
 }
 
@@ -2075,9 +2071,9 @@ static int try_delta(struct unpacked *trg, struct unpacked *src,
 
 	/* Load data if not already done */
 	if (!trg->data) {
-		pack_lock();
+		packing_data_lock(&to_pack);
 		trg->data = read_object_file(&trg_entry->idx.oid, &type, &sz);
-		pack_unlock();
+		packing_data_unlock(&to_pack);
 		if (!trg->data)
 			die(_("object %s cannot be read"),
 			    oid_to_hex(&trg_entry->idx.oid));
@@ -2088,9 +2084,9 @@ static int try_delta(struct unpacked *trg, struct unpacked *src,
 		*mem_usage += sz;
 	}
 	if (!src->data) {
-		pack_lock();
+		packing_data_lock(&to_pack);
 		src->data = read_object_file(&src_entry->idx.oid, &type, &sz);
-		pack_unlock();
+		packing_data_unlock(&to_pack);
 		if (!src->data) {
 			if (src_entry->preferred_base) {
 				static int warned = 0;
@@ -2336,9 +2332,9 @@ static void find_deltas(struct object_entry **list, unsigned *list_size,
 
 static void try_to_free_from_threads(size_t size)
 {
-	pack_lock();
+	packing_data_lock(&to_pack);
 	release_pack_memory(size);
-	pack_unlock();
+	packing_data_unlock(&to_pack);
 }
 
 static try_to_free_t old_try_to_free_routine;
diff --git a/pack-objects.c b/pack-objects.c
index 6f32a7ba04..a1dc5eb726 100644
--- a/pack-objects.c
+++ b/pack-objects.c
@@ -148,7 +148,7 @@ void prepare_packing_data(struct packing_data *pdata)
 					     1U << OE_SIZE_BITS);
 	pdata->oe_delta_size_limit = git_env_ulong("GIT_TEST_OE_DELTA_SIZE",
 						   1UL << OE_DELTA_SIZE_BITS);
-	init_recursive_mutex(&pdata->lock);
+	init_recursive_mutex(&pdata->odb_lock);
 }
 
 struct object_entry *packlist_alloc(struct packing_data *pdata,
diff --git a/pack-objects.h b/pack-objects.h
index dc869f26c2..a0c21959b2 100644
--- a/pack-objects.h
+++ b/pack-objects.h
@@ -145,7 +145,11 @@ struct packing_data {
 	struct packed_git **in_pack_by_idx;
 	struct packed_git **in_pack;
 
-	pthread_mutex_t lock;
+	/* 
+	 * During packing with multiple threads, protect the in-core
+	 * object database from concurrent accesses.
+	 */
+	pthread_mutex_t odb_lock;
 
 	/*
 	 * This list contains entries for bases which we know the other side
@@ -165,13 +169,14 @@ struct packing_data {
 
 void prepare_packing_data(struct packing_data *pdata);
 
+/* Protect access to object database */
 static inline void packing_data_lock(struct packing_data *pdata)
 {
-	pthread_mutex_lock(&pdata->lock);
+	pthread_mutex_lock(&pdata->odb_lock);
 }
 static inline void packing_data_unlock(struct packing_data *pdata)
 {
-	pthread_mutex_unlock(&pdata->lock);
+	pthread_mutex_unlock(&pdata->odb_lock);
 }
 
 struct object_entry *packlist_alloc(struct packing_data *pdata,
