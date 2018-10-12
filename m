Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 846781F97E
	for <e@80x24.org>; Fri, 12 Oct 2018 23:23:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725962AbeJMG5x (ORCPT <rfc822;e@80x24.org>);
        Sat, 13 Oct 2018 02:57:53 -0400
Received: from avasout03.plus.net ([84.93.230.244]:35863 "EHLO
        avasout03.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725926AbeJMG5x (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 13 Oct 2018 02:57:53 -0400
Received: from [10.0.2.15] ([80.189.70.193])
        by smtp with ESMTPA
        id B6lvgsYU3O2g2B6lwgYS1A; Sat, 13 Oct 2018 00:23:09 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=DKChHRFb c=1 sm=1 tr=0
 a=wSR+GDtF+fsrIzE5OYgxVg==:117 a=wSR+GDtF+fsrIzE5OYgxVg==:17
 a=IkcTkHD0fZMA:10 a=ybZZDoGAAAAA:8 a=EBOSESyhAAAA:8 a=YkKfvmTKkDq5XXr34iEA:9
 a=QEXdDO2ut3YA:10 a=0RhZnL1DYvcuLYC8JZ5M:22 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
Subject: Re: [PATCH] zlib.c: use size_t for size
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Martin Koegler <martin.koegler@chello.at>
References: <xmqqsh1bbq36.fsf@gitster-ct.c.googlers.com>
 <nycvar.QRO.7.76.6.1810121150050.45@tvgsbejvaqbjf.bet>
 <xmqqzhvj9ssa.fsf@gitster-ct.c.googlers.com>
 <nycvar.QRO.7.76.6.1810121733560.561@tvgsbejvaqbjf.bet>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <61d49c5f-826f-f28b-8eac-84a5abfab0ee@ramsayjones.plus.com>
Date:   Sat, 13 Oct 2018 00:23:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <nycvar.QRO.7.76.6.1810121733560.561@tvgsbejvaqbjf.bet>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfMZtir//RlOfK18RhumzQFN6hDk+Wd67bARLSwP+oqGKT51y/k426Hbw27LJXf3tSQqNz41/TRX70vtwQ0jHzWGBflaGip1HiJ0vX/JgJFCVxHk7NFdg
 ldDcjtSGTZNIHW9wHFjfUVKgbOhkjRPO4ET3e2V4/T1rVi44B4QrXw7xs5wwaaFyyzY1uibAKe6wWA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 12/10/18 16:34, Johannes Schindelin wrote:
> Hi Junio,
> 
> On Fri, 12 Oct 2018, Junio C Hamano wrote:
> 
>> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>>
>>> Hi Junio,
>>>
>>> On Fri, 12 Oct 2018, Junio C Hamano wrote:
>>>
>>>> From: Martin Koegler <martin.koegler@chello.at>
>>>> Date: Thu, 10 Aug 2017 20:13:08 +0200
>>>>
>>>> Signed-off-by: Martin Koegler <martin.koegler@chello.at>
>>>> Signed-off-by: Junio C Hamano <gitster@pobox.com>
>>>> ---
>>>>
>>>>  * I made minimal adjustments to make the change apply to today's
>>>>    codebase.  I still find some choices and mixing of off_t and
>>>>    size_t done by the patch a bit iffy, and some arith may need to
>>>>    become st_addX().  Extra set of eyes are very much appreciated.
>>>>
>>>>  builtin/pack-objects.c | 10 +++++-----
>>>>  cache.h                | 10 +++++-----
>>>>  pack-check.c           |  6 +++---
>>>>  pack.h                 |  2 +-
>>>>  packfile.h             |  2 +-
>>>>  wrapper.c              |  8 ++++----
>>>>  zlib.c                 |  8 ++++----
>>>>  7 files changed, 23 insertions(+), 23 deletions(-)
>>>>
>>>> diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
>>>> index e6316d294d..b9ca04eb8a 100644
>>>> --- a/builtin/pack-objects.c
>>>> +++ b/builtin/pack-objects.c
>>>> @@ -266,15 +266,15 @@ static void copy_pack_data(struct hashfile *f,
>>>>  		struct packed_git *p,
>>>>  		struct pack_window **w_curs,
>>>>  		off_t offset,
>>>> -		off_t len)
>>>> +		size_t len)
>>>>  {
>>>>  	unsigned char *in;
>>>> -	unsigned long avail;
>>>> +	size_t avail;
>>>>  
>>>>  	while (len) {
>>>>  		in = use_pack(p, w_curs, offset, &avail);
>>>>  		if (avail > len)
>>>
>>> Do we have to be careful to handle sizeof(off_t) != sizeof(size_t) here? I
>>> guess we would receive a compiler warning about different sizes in that
>>> case, but it makes me worry.
>>
>> Yup, you just said exactly the same thing as I already said in the
>> part you quoted.  I still find the mixed use of off_t and size_t in
>> this patch iffy, and that was the secondary reason why the patch was
>> kept in the stalled state for so long.  The primary reason was that
>> nobody tried to dust it off and reignite the topic so far---which I
>> am trying to correct, but as I said, this is just minimally adjusted
>> to today's codebase, without any attempt to improve relative to the
>> original patch.
>>
>> I think we are in agreement in that this is not making things worse,
>> as we are already in the mixed arith territory before this patch.
> 
> I will *try* to find the time to audit this some more, then. Maybe next
> week, maybe the one afterwards... ;-)

This fails to compile on 32-bit Linux. The patch given below is
what I used to get git to build on 32-bit Linux (and it even
passes the tests).

I haven't even given the off_t -> size_t issue any thought, but I
suspect that will have to change as well. Anyway, I have no more
time tonight ...

ATB,
Ramsay Jones

-- >8 --
Subject: [PATCH] zlib: minimum fix-up on 32-bit linux

Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
---
 builtin/pack-objects.c |  3 ++-
 packfile.c             | 16 ++++++++--------
 packfile.h             |  2 +-
 3 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 7e693071b..cc11a0426 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -2002,7 +2002,8 @@ unsigned long oe_get_size_slow(struct packing_data *pack,
 	struct pack_window *w_curs;
 	unsigned char *buf;
 	enum object_type type;
-	unsigned long used, avail, size;
+	size_t used, avail;
+	unsigned long size;
 
 	if (e->type_ != OBJ_OFS_DELTA && e->type_ != OBJ_REF_DELTA) {
 		read_lock();
diff --git a/packfile.c b/packfile.c
index f2850a00b..7571ac988 100644
--- a/packfile.c
+++ b/packfile.c
@@ -585,7 +585,7 @@ static int in_window(struct pack_window *win, off_t offset)
 unsigned char *use_pack(struct packed_git *p,
 		struct pack_window **w_cursor,
 		off_t offset,
-		unsigned long *left)
+		size_t *left)
 {
 	struct pack_window *win = *w_cursor;
 
@@ -1034,19 +1034,19 @@ struct list_head *get_packed_git_mru(struct repository *r)
 	return &r->objects->packed_git_mru;
 }
 
-unsigned long unpack_object_header_buffer(const unsigned char *buf,
-		unsigned long len, enum object_type *type, unsigned long *sizep)
+size_t unpack_object_header_buffer(const unsigned char *buf,
+		size_t len, enum object_type *type, unsigned long *sizep)
 {
 	unsigned shift;
-	unsigned long size, c;
-	unsigned long used = 0;
+	size_t size, c;
+	size_t used = 0;
 
 	c = buf[used++];
 	*type = (c >> 4) & 7;
 	size = c & 15;
 	shift = 4;
 	while (c & 0x80) {
-		if (len <= used || bitsizeof(long) <= shift) {
+		if (len <= used || bitsizeof(size_t) <= shift) {
 			error("bad object header");
 			size = used = 0;
 			break;
@@ -1104,8 +1104,8 @@ int unpack_object_header(struct packed_git *p,
 			 unsigned long *sizep)
 {
 	unsigned char *base;
-	unsigned long left;
-	unsigned long used;
+	size_t left;
+	size_t used;
 	enum object_type type;
 
 	/* use_pack() assures us we have [base, base + 20) available
diff --git a/packfile.h b/packfile.h
index 1fb482424..e8bf11b62 100644
--- a/packfile.h
+++ b/packfile.h
@@ -132,7 +132,7 @@ extern off_t find_pack_entry_one(const unsigned char *sha1, struct packed_git *)
 
 extern int is_pack_valid(struct packed_git *);
 extern void *unpack_entry(struct repository *r, struct packed_git *, off_t, enum object_type *, unsigned long *);
-extern unsigned long unpack_object_header_buffer(const unsigned char *buf, unsigned long len, enum object_type *type, unsigned long *sizep);
+extern size_t unpack_object_header_buffer(const unsigned char *buf, size_t len, enum object_type *type, unsigned long *sizep);
 extern unsigned long get_size_from_delta(struct packed_git *, struct pack_window **, off_t);
 extern int unpack_object_header(struct packed_git *, struct pack_window **, off_t *, unsigned long *);
 
-- 
2.19.0

