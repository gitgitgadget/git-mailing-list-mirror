Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6BA821F97E
	for <e@80x24.org>; Sun, 14 Oct 2018 02:40:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726190AbeJNKKe (ORCPT <rfc822;e@80x24.org>);
        Sun, 14 Oct 2018 06:10:34 -0400
Received: from avasout03.plus.net ([84.93.230.244]:39824 "EHLO
        avasout03.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725734AbeJNKKe (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 14 Oct 2018 06:10:34 -0400
Received: from [10.0.2.15] ([80.189.70.193])
        by smtp with ESMTPA
        id BWBTguVZUO2g2BWBUgZJ16; Sun, 14 Oct 2018 03:31:12 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=DKChHRFb c=1 sm=1 tr=0
 a=wSR+GDtF+fsrIzE5OYgxVg==:117 a=wSR+GDtF+fsrIzE5OYgxVg==:17
 a=IkcTkHD0fZMA:10 a=extA4yZ_AAAA:8 a=ybZZDoGAAAAA:8 a=pGLkceISAAAA:8
 a=EBOSESyhAAAA:8 a=Il5ipZVrGIDEcJ8nfvAA:9 a=QEXdDO2ut3YA:10
 a=hVSmkA6k2N-FF26V3nNA:22 a=0RhZnL1DYvcuLYC8JZ5M:22 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
Subject: Re: [PATCH v2 1/1] zlib.c: use size_t for size
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
To:     =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>,
        =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org, Martin Koegler <martin.koegler@chello.at>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <xmqqsh1bbq36.fsf@gitster-ct.c.googlers.com>
 <20181012204229.11890-1-tboegi@web.de> <20181012222234.GF19800@szeder.dev>
 <20181013050057.GA6805@tor.lan>
 <fb6367b3-975b-1bc6-e95b-a457fb9e3a33@ramsayjones.plus.com>
Message-ID: <989a3ec9-d82d-45a1-8253-bf92ef18ce94@ramsayjones.plus.com>
Date:   Sun, 14 Oct 2018 03:31:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <fb6367b3-975b-1bc6-e95b-a457fb9e3a33@ramsayjones.plus.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfCviGTM29turz+A5LP4fMFCl+0ZKlSkA26cFPhS0dMaDwUPzK/uwvMExc18XPUPGV3h/tdQD03RLk0i8B5Wz285yk3v/SWDM1iHGm2NLzQbB4Jaqs//0
 bqAZtNBrO61LMf/fZYrv/znbCNe5ao+ieHl/9L2dfL42PHpCSXyeyDHc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 14/10/18 03:16, Ramsay Jones wrote:
> 
> 
> On 13/10/18 06:00, Torsten Bögershausen wrote:
>> []
>>> Neither v1 nor v2 of this patch compiles on 32 bit Linux; see
>>>
>>>   https://travis-ci.org/git/git/jobs/440514375#L628
>>>
>>> The fixup patch below makes it compile on 32 bit and the test suite
>>> passes as well, but I didn't thoroughly review the changes; I only
>>> wanted to get 'pu' build again.
>>>
>>
>> Oh, yes, I didn't test under Linux 32 bit (and neither Windows)
>> I will try to compose a proper v3 the next days.
> 
> I had a look at this today, and the result is given below.
> 
> The patch is effectively your v2 patch with SZEDER's fix-up
> patch on top! (I actually started with my own patch and 'pared
> it back' by removing the off_t -> size_t changes, etc; so I was
> somewhat amused to note that the end result was effectively
> SZEDER's patch on top of your v2 ;-) ).
> 
> I have tested this on 32- and 64-bit Linux, along with 64-bit
> cygwin (the test suite run hasn't finished yet, but I don't
> expect any problem). I have an old Msys2 installation on Windows,
> which is the closest thing I have to a windows dev system, so I
> also built this on MINGW32 and MINGW64 along with some light
> manual testing (the test suite has never passed on Msys2 for me).
> This is not the same as testing on Gfw, of course.

Ho, Hum. Of course, I have just noticed that, similar to
copy_pack_data(), check_pack_crc() should probably use a
call to xsize_t(len) when assigning to avail.

Sorry about that. (I need some sleep now!)

ATB,
Ramsay Jones


> -- >8 --
> From: Martin Koegler <martin.koegler@chello.at>
> Subject: [PATCH v3 1/1] zlib.c: use size_t for size
> 
> Signed-off-by: Martin Koegler <martin.koegler@chello.at>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> Signed-off-by: Torsten Bögershausen <tboegi@web.de>
> Helped-by: SZEDER Gábor <szeder.dev@gmail.com>
> Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
> ---
>  builtin/pack-objects.c | 11 ++++++-----
>  cache.h                | 10 +++++-----
>  pack-check.c           |  4 ++--
>  packfile.c             |  4 ++--
>  packfile.h             |  2 +-
>  wrapper.c              |  8 ++++----
>  zlib.c                 |  8 ++++----
>  7 files changed, 24 insertions(+), 23 deletions(-)
> 
> diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
> index b059b86aee..3b5f2c38b3 100644
> --- a/builtin/pack-objects.c
> +++ b/builtin/pack-objects.c
> @@ -269,12 +269,12 @@ static void copy_pack_data(struct hashfile *f,
>  		off_t len)
>  {
>  	unsigned char *in;
> -	unsigned long avail;
> +	size_t avail;
>  
>  	while (len) {
>  		in = use_pack(p, w_curs, offset, &avail);
>  		if (avail > len)
> -			avail = (unsigned long)len;
> +			avail = xsize_t(len);
>  		hashwrite(f, in, avail);
>  		offset += avail;
>  		len -= avail;
> @@ -1529,8 +1529,8 @@ static void check_object(struct object_entry *entry)
>  		struct pack_window *w_curs = NULL;
>  		const unsigned char *base_ref = NULL;
>  		struct object_entry *base_entry;
> -		unsigned long used, used_0;
> -		unsigned long avail;
> +		size_t used, used_0;
> +		size_t avail;
>  		off_t ofs;
>  		unsigned char *buf, c;
>  		enum object_type type;
> @@ -2002,7 +2002,8 @@ unsigned long oe_get_size_slow(struct packing_data *pack,
>  	struct pack_window *w_curs;
>  	unsigned char *buf;
>  	enum object_type type;
> -	unsigned long used, avail, size;
> +	unsigned long used, size;
> +	size_t avail;
>  
>  	if (e->type_ != OBJ_OFS_DELTA && e->type_ != OBJ_REF_DELTA) {
>  		read_lock();
> diff --git a/cache.h b/cache.h
> index 5d83022e3b..ba0ad73de1 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -20,10 +20,10 @@
>  #include <zlib.h>
>  typedef struct git_zstream {
>  	z_stream z;
> -	unsigned long avail_in;
> -	unsigned long avail_out;
> -	unsigned long total_in;
> -	unsigned long total_out;
> +	size_t avail_in;
> +	size_t avail_out;
> +	size_t total_in;
> +	size_t total_out;
>  	unsigned char *next_in;
>  	unsigned char *next_out;
>  } git_zstream;
> @@ -40,7 +40,7 @@ void git_deflate_end(git_zstream *);
>  int git_deflate_abort(git_zstream *);
>  int git_deflate_end_gently(git_zstream *);
>  int git_deflate(git_zstream *, int flush);
> -unsigned long git_deflate_bound(git_zstream *, unsigned long);
> +size_t git_deflate_bound(git_zstream *, size_t);
>  
>  /* The length in bytes and in hex digits of an object name (SHA-1 value). */
>  #define GIT_SHA1_RAWSZ 20
> diff --git a/pack-check.c b/pack-check.c
> index fa5f0ff8fa..d1e7f554ae 100644
> --- a/pack-check.c
> +++ b/pack-check.c
> @@ -33,7 +33,7 @@ int check_pack_crc(struct packed_git *p, struct pack_window **w_curs,
>  	uint32_t data_crc = crc32(0, NULL, 0);
>  
>  	do {
> -		unsigned long avail;
> +		size_t avail;
>  		void *data = use_pack(p, w_curs, offset, &avail);
>  		if (avail > len)
>  			avail = len;
> @@ -68,7 +68,7 @@ static int verify_packfile(struct packed_git *p,
>  
>  	the_hash_algo->init_fn(&ctx);
>  	do {
> -		unsigned long remaining;
> +		size_t remaining;
>  		unsigned char *in = use_pack(p, w_curs, offset, &remaining);
>  		offset += remaining;
>  		if (!pack_sig_ofs)
> diff --git a/packfile.c b/packfile.c
> index f2850a00b5..013294aec7 100644
> --- a/packfile.c
> +++ b/packfile.c
> @@ -585,7 +585,7 @@ static int in_window(struct pack_window *win, off_t offset)
>  unsigned char *use_pack(struct packed_git *p,
>  		struct pack_window **w_cursor,
>  		off_t offset,
> -		unsigned long *left)
> +		size_t *left)
>  {
>  	struct pack_window *win = *w_cursor;
>  
> @@ -1104,7 +1104,7 @@ int unpack_object_header(struct packed_git *p,
>  			 unsigned long *sizep)
>  {
>  	unsigned char *base;
> -	unsigned long left;
> +	size_t left;
>  	unsigned long used;
>  	enum object_type type;
>  
> diff --git a/packfile.h b/packfile.h
> index 6c4037605d..1fb482424b 100644
> --- a/packfile.h
> +++ b/packfile.h
> @@ -78,7 +78,7 @@ extern void close_pack_index(struct packed_git *);
>  
>  extern uint32_t get_pack_fanout(struct packed_git *p, uint32_t value);
>  
> -extern unsigned char *use_pack(struct packed_git *, struct pack_window **, off_t, unsigned long *);
> +extern unsigned char *use_pack(struct packed_git *, struct pack_window **, off_t, size_t *);
>  extern void close_pack_windows(struct packed_git *);
>  extern void close_pack(struct packed_git *);
>  extern void close_all_packs(struct raw_object_store *o);
> diff --git a/wrapper.c b/wrapper.c
> index e4fa9d84cd..1a510bd6fc 100644
> --- a/wrapper.c
> +++ b/wrapper.c
> @@ -67,11 +67,11 @@ static void *do_xmalloc(size_t size, int gentle)
>  			ret = malloc(1);
>  		if (!ret) {
>  			if (!gentle)
> -				die("Out of memory, malloc failed (tried to allocate %lu bytes)",
> -				    (unsigned long)size);
> +				die("Out of memory, malloc failed (tried to allocate %" PRIuMAX " bytes)",
> +				    (uintmax_t)size);
>  			else {
> -				error("Out of memory, malloc failed (tried to allocate %lu bytes)",
> -				      (unsigned long)size);
> +				error("Out of memory, malloc failed (tried to allocate %" PRIuMAX " bytes)",
> +				      (uintmax_t)size);
>  				return NULL;
>  			}
>  		}
> diff --git a/zlib.c b/zlib.c
> index d594cba3fc..197a1acc7b 100644
> --- a/zlib.c
> +++ b/zlib.c
> @@ -29,7 +29,7 @@ static const char *zerr_to_string(int status)
>   */
>  /* #define ZLIB_BUF_MAX ((uInt)-1) */
>  #define ZLIB_BUF_MAX ((uInt) 1024 * 1024 * 1024) /* 1GB */
> -static inline uInt zlib_buf_cap(unsigned long len)
> +static inline uInt zlib_buf_cap(size_t len)
>  {
>  	return (ZLIB_BUF_MAX < len) ? ZLIB_BUF_MAX : len;
>  }
> @@ -46,8 +46,8 @@ static void zlib_pre_call(git_zstream *s)
>  
>  static void zlib_post_call(git_zstream *s)
>  {
> -	unsigned long bytes_consumed;
> -	unsigned long bytes_produced;
> +	size_t bytes_consumed;
> +	size_t bytes_produced;
>  
>  	bytes_consumed = s->z.next_in - s->next_in;
>  	bytes_produced = s->z.next_out - s->next_out;
> @@ -150,7 +150,7 @@ int git_inflate(git_zstream *strm, int flush)
>  #define deflateBound(c,s)  ((s) + (((s) + 7) >> 3) + (((s) + 63) >> 6) + 11)
>  #endif
>  
> -unsigned long git_deflate_bound(git_zstream *strm, unsigned long size)
> +size_t git_deflate_bound(git_zstream *strm, size_t size)
>  {
>  	return deflateBound(&strm->z, size);
>  }
> 
