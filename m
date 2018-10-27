Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D67F41F453
	for <e@80x24.org>; Sat, 27 Oct 2018 06:54:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727856AbeJ0P1G (ORCPT <rfc822;e@80x24.org>);
        Sat, 27 Oct 2018 11:27:06 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:38604 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726672AbeJ0P1F (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Oct 2018 11:27:05 -0400
Received: by mail-wr1-f68.google.com with SMTP id d10-v6so3364066wrs.5
        for <git@vger.kernel.org>; Fri, 26 Oct 2018 23:47:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=tKVSy0Quq9UcLUlAKgcIgsDOQhuOCzbCXN7xiMYNI5s=;
        b=g1tKZ+Wz/ISmetHdFqV7jEU5XBvP5gfzngb4j008EA84l/cRNvPPEzb6AOZgYt67up
         IOP3lNkL40OMUUbRrD7oB+T2CRUXRZbEOnuqAtteb1uJp8zY9S6ilYMFNSp/NDavodLZ
         x1NtQltUDxad0+s3MtiBCoMne9c+iRSvPpxcjX+vdRlswhKus5bSiTCJrQgFnJDMjjIn
         zBVeRcVTKwpg5W3hnb/GWqLrgDUhTpYV1FoIPSKrMrKcAhg79yUehk5d/3OPIqeZRZpY
         5/XVhrZNHMcFlz4SSXk7YBjhZwEDFbJKl/GP6tO3G447D0++X6DQFuP0TBUXAdTgPXwE
         JMkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=tKVSy0Quq9UcLUlAKgcIgsDOQhuOCzbCXN7xiMYNI5s=;
        b=Bp01XuIufiXThmD4OJAQQl5zilYOu+x1axMyi38VHfrtuvz2k72ByPKKBLc6PSxGTe
         xth25FnbqjC1iocq0uJP4Ty5O2c0wii+DcQlnvfFRPHHehls3t7tcXzx3blOQMzbR0y8
         u8y3novMnRhwaPkFxgDPJ1cJqMQE9fafrzMy66kXR2Il/OUVb5xhHc9zvp4QRg0dIpvm
         cccl2EMqNLC9/M1L0UwG3taNGOGqvKznnUXXQfV+NC2mNNVJ+UUqqUf5mAOodqNBtILA
         4WhjAEN4npKtynQYxkgp9Ucl/9yWm3Z7hImqx7I2LLRiiTZqfqz3nzWgumj7/ya2ubbg
         2aJw==
X-Gm-Message-State: AGRZ1gL1VS//Vxm7+eErA/Iicnww5l7SmPmkMZ93UF4GXSNRVmWhNWlp
        6YRlaAkQfhxO9hF/WbotI3Q=
X-Google-Smtp-Source: AJdET5dPQ//icb1qt6Ff/lJQTUdAb3wjQiy+T6M9hU9rVzqTSRh28ce9C0+GmYfWTSA6R/i1y8nBNw==
X-Received: by 2002:adf:8304:: with SMTP id 4-v6mr7946573wrd.285.1540622826245;
        Fri, 26 Oct 2018 23:47:06 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id c9-v6sm6158031wrh.50.2018.10.26.23.47.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 26 Oct 2018 23:47:05 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Stefan Beller <sbeller@google.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re*: [PATCH v3] fetch: replace string-list used as a look-up table with a hashmap
References: <xmqqin2sj6df.fsf@gitster-ct.c.googlers.com>
        <20180927053418.GB14178@sigill.intra.peff.net>
        <xmqq5zyn91ku.fsf@gitster-ct.c.googlers.com>
        <xmqqy3au1tr1.fsf_-_@gitster-ct.c.googlers.com>
        <nycvar.QRO.7.76.6.1810221140510.4546@tvgsbejvaqbjf.bet>
Date:   Sat, 27 Oct 2018 15:47:04 +0900
In-Reply-To: <nycvar.QRO.7.76.6.1810221140510.4546@tvgsbejvaqbjf.bet>
        (Johannes Schindelin's message of "Mon, 22 Oct 2018 11:57:46 +0200
        (DST)")
Message-ID: <xmqqk1m3c2dz.fsf_-_@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Just one thing^W^Wa couple of things:
>
> It would probably make more sense to `hashmap_get_from_hash()` and
> `strhash()` here (and `strhash()` should probably be used everywhere
> instead of `memhash(str, strlen(str))`).

hashmap_get_from_hash() certainly is much better suited for simpler
usage pattern like these callsites, and the ones in sequencer.c.  It
is a shame that a more complex variant takes the shorter-and-sweeter
name hashmap_get().

I wish we named the latter hashmap_get_fullblown_feature_rich() and
called the _from_hash() thing a simple hashmap_get() from day one,
but it is way too late.

I looked briefly the users of the _get() variant, and some of their
uses are legitimately not-simple and cannot be reduced to use the
simpler _get_from_hash variant, it seems.  But others like those in
builtin/difftool.c should be straight-forward to convert to use the
simpler get_from_hash variant.  It could be a low-hanging fruit left
for later clean-up, perhaps.

>> @@ -271,10 +319,10 @@ static void find_non_local_tags(const struct ref *refs,
>>  			    !has_object_file_with_flags(&ref->old_oid,
>>  							OBJECT_INFO_QUICK) &&
>>  			    !will_fetch(head, ref->old_oid.hash) &&
>> -			    !has_sha1_file_with_flags(item->util,
>> +			    !has_sha1_file_with_flags(item->oid.hash,
>
> I am not sure that we need to test for null OIDs here, given that...
> ...
> Of course, `has_sha1_file_with_flags()` is supposed to return `false` for
> null OIDs, I guess.

Yup.  An alternative is to make item->oid a pointer to oid, not an
oid object itself, so that we can express "no OID for this ref" in a
more explicit way, but is_null_oid() is already used as "no OID" in
many other codepaths, so...

>> +	for_each_string_list_item(remote_ref_item, &remote_refs_list) {
>> +		const char *refname = remote_ref_item->string;
>> +		struct hashmap_entry key;
>> +
>> +		hashmap_entry_init(&key, memhash(refname, strlen(refname)));
>> +		item = hashmap_get(&remote_refs, &key, refname);
>> +		if (!item)
>> +			continue; /* can this happen??? */
>
> This would indicate a BUG, no?

Possibly.  Alternatively, we can just use item without checking and
let the runtime segfault.

Here is an incremental on top that can be squashed in to turn v3
into v4.

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 0f8e333022..aee1d9bf21 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -259,7 +259,7 @@ static struct refname_hash_entry *refname_hash_add(struct hashmap *map,
 	size_t len = strlen(refname);
 
 	FLEX_ALLOC_MEM(ent, refname, refname, len);
-	hashmap_entry_init(ent, memhash(refname, len));
+	hashmap_entry_init(ent, strhash(refname));
 	oidcpy(&ent->oid, oid);
 	hashmap_add(map, ent);
 	return ent;
@@ -282,11 +282,7 @@ static void refname_hash_init(struct hashmap *map)
 
 static int refname_hash_exists(struct hashmap *map, const char *refname)
 {
-	struct hashmap_entry key;
-	size_t len = strlen(refname);
-	hashmap_entry_init(&key, memhash(refname, len));
-
-	return !!hashmap_get(map, &key, refname);
+	return !!hashmap_get_from_hash(map, strhash(refname), refname);
 }
 
 static void find_non_local_tags(const struct ref *refs,
@@ -365,12 +361,10 @@ static void find_non_local_tags(const struct ref *refs,
 	 */
 	for_each_string_list_item(remote_ref_item, &remote_refs_list) {
 		const char *refname = remote_ref_item->string;
-		struct hashmap_entry key;
 
-		hashmap_entry_init(&key, memhash(refname, strlen(refname)));
-		item = hashmap_get(&remote_refs, &key, refname);
+		item = hashmap_get_from_hash(&remote_refs, strhash(refname), refname);
 		if (!item)
-			continue; /* can this happen??? */
+			BUG("unseen remote ref?");
 
 		/* Unless we have already decided to ignore this item... */
 		if (!is_null_oid(&item->oid)) {
@@ -497,12 +491,12 @@ static struct ref *get_ref_map(struct remote *remote,
 
 	for (rm = ref_map; rm; rm = rm->next) {
 		if (rm->peer_ref) {
-			struct hashmap_entry key;
 			const char *refname = rm->peer_ref->name;
 			struct refname_hash_entry *peer_item;
 
-			hashmap_entry_init(&key, memhash(refname, strlen(refname)));
-			peer_item = hashmap_get(&existing_refs, &key, refname);
+			peer_item = hashmap_get_from_hash(&existing_refs,
+							  strhash(refname),
+							  refname);
 			if (peer_item) {
 				struct object_id *old_oid = &peer_item->oid;
 				oidcpy(&rm->peer_ref->old_oid, old_oid);
