Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D124AC433EF
	for <git@archiver.kernel.org>; Tue, 24 May 2022 19:32:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240898AbiEXTcK (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 May 2022 15:32:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236870AbiEXTcJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 May 2022 15:32:09 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64E796D3B7
        for <git@vger.kernel.org>; Tue, 24 May 2022 12:32:04 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id l14so17729329pjk.2
        for <git@vger.kernel.org>; Tue, 24 May 2022 12:32:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Kf6PH5h1t2syAxL/MxCn4SZUfJIekDp1hHIAQ2OitMM=;
        b=h9n1BSEegBUcxyukNut9RwvgnvFc9YMzFQka1ZzdBuPWvc9mSQDS33DE50QR6RBmZX
         ZfXQjoXXbQzOl3UUcA54RB9Srgi8jhb9EzipaJizep3aHy7CoZDvSpzAqoh1P7xa2gbA
         N0OVq4CPNvCIZHgBs645sfMDavxCAIb4hRl+LtT0Nqje3i9uGUxi7KMjC/beZwzBMZIO
         yWnS6VpSx0ae7IYbBkvELFAeu7Tk7KBg1jMBxrKZ03GzbQX55o32b6QIx5rI9HF45zox
         NUYERlPQqrBsO2qCz/kXo2jlc5w0i83kPvYRPg2gIobLgAxeVbiDZiGNH33ZYgdMz5P1
         HxRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Kf6PH5h1t2syAxL/MxCn4SZUfJIekDp1hHIAQ2OitMM=;
        b=nCIJEq6/GKOVO5B07PE3yzHYnVlOjUHJ6AWfZtpmp8JJ22QRmiIIRY/nq/0dXTES16
         xEBmZpDp3QeL1gbRpr8uWChzqBunRiVJKBeOGmMBsKFIFGG6OWFddIyd/4402dtg4th+
         hFE4TwF+K/RWj/mSGoVPHGTe7yiuu6OJEf0hknPzzPa0Z49kLr8857taOPyDgHa22WDi
         SkdT73P+ukJOk6cHTTS/NhYcMuuW3yD2Sfoc5plC9yFAvBqzl5y4QXG3+oGhiElXz+PU
         +pSCPbRSgFKrLip/ZPFyPEf+XrRPWxy7RijxdA8Lg0FfD8iSJ7iglvN4b6tijLVDEV9V
         duXg==
X-Gm-Message-State: AOAM532TDeyc5JqdsfKoZ+1dwfcE6x2LnYWV0fODQJ3+AuS9LXZvT/TQ
        wQqBEBFvYEbK3+iiWTwD0D4=
X-Google-Smtp-Source: ABdhPJwbp4FYq4K1TYIz3IsELn9F8Yy7B5lrk+dIOK226CIm2Ap0gniydpTS67QZib5PlIuN43aqhw==
X-Received: by 2002:a17:902:6b83:b0:15d:1ea2:4f80 with SMTP id p3-20020a1709026b8300b0015d1ea24f80mr28361712plk.41.1653420723714;
        Tue, 24 May 2022 12:32:03 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:40e4:8614:8b45:ee10])
        by smtp.gmail.com with ESMTPSA id b4-20020a170902d50400b0015e8d4eb1dcsm7780001plg.38.2022.05.24.12.32.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 May 2022 12:32:03 -0700 (PDT)
Date:   Tue, 24 May 2022 12:32:01 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, avarab@gmail.com, derrickstolee@github.com,
        gitster@pobox.com, larsxschneider@gmail.com, tytso@mit.edu
Subject: Re: [PATCH v5 02/17] pack-mtimes: support reading .mtimes files
Message-ID: <Yo0ysWZKFJoiCSqv@google.com>
References: <cover.1638224692.git.me@ttaylorr.com>
 <cover.1653088640.git.me@ttaylorr.com>
 <91a9d21b0b7d99023083c0bbb6f91ccdc1782736.1653088640.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <91a9d21b0b7d99023083c0bbb6f91ccdc1782736.1653088640.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Taylor Blau wrote:

> This patch prepares for cruft packs by defining the `.mtimes` format,
> and introducing a basic API that callers can use to read out individual
> mtimes.

Makes sense.  Does this intend to produce any functional change?  I'm
guessing not (and the lack of tests agrees), but the commit message
doesn't say so.

By the way, is this something we could cover in tests, e.g. using a
test helper that exercises the new code?

[...]
> --- a/Documentation/technical/pack-format.txt
> +++ b/Documentation/technical/pack-format.txt
> @@ -294,6 +294,25 @@ Pack file entry: <+
>  
>  All 4-byte numbers are in network order.
>  
> +== pack-*.mtimes files have the format:
> +
> +All 4-byte numbers are in network byte order.
> +
> +  - A 4-byte magic number '0x4d544d45' ('MTME').
> +
> +  - A 4-byte version identifier (= 1).
> +
> +  - A 4-byte hash function identifier (= 1 for SHA-1, 2 for SHA-256).
> +
> +  - A table of 4-byte unsigned integers. The ith value is the
> +    modification time (mtime) of the ith object in the corresponding
> +    pack by lexicographic (index) order. The mtimes count standard
> +    epoch seconds.
> +
> +  - A trailer, containing a checksum of the corresponding packfile,
> +    and a checksum of all of the above (each having length according
> +    to the specified hash function).
> +

This describes the "syntax" but not the "semantics" of the file.
Should I look to a separate piece of documentation for the semantics?
If so, can this one include a mention of that piece of documentation
to make it easier to find?

[...]
> --- a/object-store.h
> +++ b/object-store.h
> @@ -115,12 +115,15 @@ struct packed_git {
>  		 freshened:1,
>  		 do_not_close:1,
>  		 pack_promisor:1,
> -		 multi_pack_index:1;
> +		 multi_pack_index:1,
> +		 is_cruft:1;
>  	unsigned char hash[GIT_MAX_RAWSZ];
>  	struct revindex_entry *revindex;
>  	const uint32_t *revindex_data;
>  	const uint32_t *revindex_map;
>  	size_t revindex_size;
> +	const uint32_t *mtimes_map;
> +	size_t mtimes_size;

What does mtimes_map contain?  A comment would help.


> --- /dev/null
> +++ b/pack-mtimes.c
> @@ -0,0 +1,126 @@
> +#include "pack-mtimes.h"
> +#include "object-store.h"
> +#include "packfile.h"

Missing #include of git-compat-util.h.

> +
> +static char *pack_mtimes_filename(struct packed_git *p)
> +{
> +	size_t len;
> +	if (!strip_suffix(p->pack_name, ".pack", &len))
> +		BUG("pack_name does not end in .pack");
> +	/* NEEDSWORK: this could reuse code from pack-revindex.c. */
> +	return xstrfmt("%.*s.mtimes", (int)len, p->pack_name);
> +}

This seems simple enough that it's not obvious we need more code
sharing.  Do you agree?  If so, I'd suggest just removing the
NEEDSWORK comment.

> +
> +#define MTIMES_HEADER_SIZE (12)
> +#define MTIMES_MIN_SIZE (MTIMES_HEADER_SIZE + (2 * the_hash_algo->rawsz))

Hm, the all-caps name makes this feel like a compile-time constant but
it contains a reference to the_hash_algo.  Could it be an inline
function instead?

> +
> +struct mtimes_header {
> +	uint32_t signature;
> +	uint32_t version;
> +	uint32_t hash_id;
> +};
> +
> +static int load_pack_mtimes_file(char *mtimes_file,
> +				 uint32_t num_objects,
> +				 const uint32_t **data_p, size_t *len_p)

What does this function do?  A comment would help.

> +{
> +	int fd, ret = 0;
> +	struct stat st;
> +	void *data = NULL;
> +	size_t mtimes_size;
> +	struct mtimes_header header;
> +	uint32_t *hdr;
> +
> +	fd = git_open(mtimes_file);
> +
> +	if (fd < 0) {

nit: this would be more readable without the blank line between
setting and checking fd (likewise for the other examples below).
> +		ret = -1;
> +		goto cleanup;
> +	}

[...]
> +	if (mtimes_size - MTIMES_MIN_SIZE != st_mult(sizeof(uint32_t), num_objects)) {

This presupposes that the hash_id matches the_hash_algo.  Maybe worth
a NEEDSWORK comment.

[...]
> +cleanup:
> +	if (ret) {
> +		if (data)
> +			munmap(data, mtimes_size);
> +	} else {
> +		*len_p = mtimes_size;
> +		*data_p = (const uint32_t *)data;

Do we know that 'data' is uint32_t aligned?  Casting earlier in the
function could make that more obvious.

[...]
> +int load_pack_mtimes(struct packed_git *p)

This could use a doc comment in the header file.  For example, what
requirements do we have on what the caller passes as 'p'?

[...]
> +uint32_t nth_packed_mtime(struct packed_git *p, uint32_t pos)

Likewise.

[...]
> --- a/packfile.c
> +++ b/packfile.c
[...]
> @@ -363,7 +373,7 @@ void close_object_store(struct raw_object_store *o)
>  
>  void unlink_pack_path(const char *pack_name, int force_delete)
>  {
> -	static const char *exts[] = {".pack", ".idx", ".rev", ".keep", ".bitmap", ".promisor"};
> +	static const char *exts[] = {".pack", ".idx", ".rev", ".keep", ".bitmap", ".promisor", ".mtimes"};

Are these in any particular order?  Should they be?

[...]
> @@ -718,6 +728,10 @@ struct packed_git *add_packed_git(const char *path, size_t path_len, int local)
>  	if (!access(p->pack_name, F_OK))
>  		p->pack_promisor = 1;
>  
> +	xsnprintf(p->pack_name + path_len, alloc - path_len, ".mtimes");
> +	if (!access(p->pack_name, F_OK))
> +		p->is_cruft = 1;
> +
>  	xsnprintf(p->pack_name + path_len, alloc - path_len, ".pack");
>  	if (stat(p->pack_name, &st) || !S_ISREG(st.st_mode)) {
>  		free(p);
> @@ -869,7 +883,8 @@ static void prepare_pack(const char *full_name, size_t full_name_len,
>  	    ends_with(file_name, ".pack") ||
>  	    ends_with(file_name, ".bitmap") ||
>  	    ends_with(file_name, ".keep") ||
> -	    ends_with(file_name, ".promisor"))
> +	    ends_with(file_name, ".promisor") ||
> +	    ends_with(file_name, ".mtimes"))

likewise

Thanks,
Jonathan
