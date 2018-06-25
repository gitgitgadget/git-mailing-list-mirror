Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 98EC31F516
	for <e@80x24.org>; Mon, 25 Jun 2018 19:38:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934973AbeFYTiX (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Jun 2018 15:38:23 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:44645 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934911AbeFYTiW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Jun 2018 15:38:22 -0400
Received: by mail-wr0-f195.google.com with SMTP id p12-v6so13191954wrn.11
        for <git@vger.kernel.org>; Mon, 25 Jun 2018 12:38:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=1qbU8H+Oa1dg4gaEGg8xntoxRv0mV4mqBLBTK7NBEtc=;
        b=aiQrcGbhjKeAVCEaPfEnV5Cx7RKmvHEZTjX4NyDuptZSZQ1iaG1EWeBeDT1QFkfAzd
         a8kkbnv6nn9bTtWbGAL9pN25G7mTiGUM3z4L164rFLSlj3VvqVfD0ZwQDACNfCGI2n/1
         bPe+D1NetrMbtdNT8Z3YO3zqWm7UOyQHwHJPSLc/jxAwMrCOYoUWdKmK27RyipzvUwjv
         K+5C9cxiMQMrSHnTkh3PpyT5T0kxtw6DsK5FjSRx1U2y5FoVNGpSrOevyO3Y34JfSMDS
         RQAY3GSem7Pae3iKpZPsBEBWhlXxBBLyw5QubJqDuR9LWqxnVV0b3RYFRDCyX25QbFHm
         th0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=1qbU8H+Oa1dg4gaEGg8xntoxRv0mV4mqBLBTK7NBEtc=;
        b=IqFpDBY7gAlHm0KsvDZ6zP8EhSHuR9IzMGg4ZZfrvF0NGacfutbEJ5OanhCxr8mPFl
         tzHkl8QK5SgsEmLI5MIo3/mRsj5SsrMUYGLssUpkk64Uf40Ntz6jF4mSNQot0SBRzciG
         AdOXyxiyYLSeE5Z8UH/J0uNiFYLsdNpTPQ43lvyTrEAW2Z/PFyw3/yGs1UOs61fDFVQx
         17/RbK/OPFtH3JED11io4J8eKQkJU0S7THhUutsO6FIC5n/GQhbALyh6HPHkp7p6+BTj
         84A/X/w/um/2h1G4YJVrb8uqs8Xdda8i6zU61gsyY3RKF9VgAWzW+LNPsv9mBhHyOeJw
         xrdw==
X-Gm-Message-State: APt69E1haGuMTL5zDMz74ZjmVeb6or0dVI7ffYw+kmBLF31TLwx2Inoq
        LWc6yH0UBpQpC4jLPYKUGfI=
X-Google-Smtp-Source: ADUXVKL6KW2k+RIHJam3aB+5tI3T4fORuOxpkCqTl/d9VWXHqN/7+6ohFpESsljrmZ60r9SkOmpvGw==
X-Received: by 2002:adf:a925:: with SMTP id u34-v6mr12102475wrc.248.1529955501210;
        Mon, 25 Jun 2018 12:38:21 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id a184-v6sm21910wmf.30.2018.06.25.12.38.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 25 Jun 2018 12:38:20 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     git@vger.kernel.org, sbeller@google.com, pclouds@gmail.com,
        avarab@gmail.com, Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v2 06/24] multi-pack-index: load into memory
References: <20180607140338.32440-1-dstolee@microsoft.com>
        <20180625143434.89044-1-dstolee@microsoft.com>
        <20180625143434.89044-7-dstolee@microsoft.com>
Date:   Mon, 25 Jun 2018 12:38:20 -0700
In-Reply-To: <20180625143434.89044-7-dstolee@microsoft.com> (Derrick Stolee's
        message of "Mon, 25 Jun 2018 10:34:16 -0400")
Message-ID: <xmqqfu1aodw3.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

> +#define MIDX_HASH_LEN 20
> +#define MIDX_MIN_SIZE (MIDX_HEADER_SIZE + MIDX_HASH_LEN)
>  
>  static char *get_midx_filename(const char *object_dir)
>  {
>  	return xstrfmt("%s/pack/multi-pack-index", object_dir);
>  }
>  
> +struct multi_pack_index *load_multi_pack_index(const char *object_dir)
> +{
> +	struct multi_pack_index *m = NULL;
> +	int fd;
> +	struct stat st;
> +	size_t midx_size;
> +	void *midx_map = NULL;
> +	uint32_t hash_version;
> +	char *midx_name = get_midx_filename(object_dir);
> +
> +	fd = git_open(midx_name);
> +
> +	if (fd < 0) {
> +		error_errno(_("failed to read %s"), midx_name);
> +		FREE_AND_NULL(midx_name);
> +		return NULL;
> +	}
> +	if (fstat(fd, &st)) {
> +		error_errno(_("failed to read %s"), midx_name);
> +		FREE_AND_NULL(midx_name);
> +		close(fd);
> +		return NULL;
> +	}
> +
> +	midx_size = xsize_t(st.st_size);
> +
> +	if (midx_size < MIDX_MIN_SIZE) {
> +		close(fd);
> +		error(_("multi-pack-index file %s is too small"), midx_name);
> +		goto cleanup_fail;
> +	}
> +
> +	FREE_AND_NULL(midx_name);

Error handling in the above part looks a bit inconsistent.  I first
thought that the earlier ones manually clean up and leave because
jumping to cleanup_fail would need a successfully opened fd and
successfully mmapped midx_map, but the above "goto" forces
cleanup_fail: to munmap NULL and close an already closed fd.

I wonder if it is simpler to do

	cleanup_fail:
		/* no need to check for NULL when freeing */
		free(m);
		free(midx_name);
		if (midx_map)
			munmap(midx_map, midx_size);
		if (0 <= fd)
			close(fd);
		return NULL;

and have all of the above error codepath to jump there.

> +	midx_map = xmmap(NULL, midx_size, PROT_READ, MAP_PRIVATE, fd, 0);
> +
> +	m = xcalloc(1, sizeof(*m) + strlen(object_dir) + 1);
> +	strcpy(m->object_dir, object_dir);
> +	m->data = midx_map;
> +
> +	m->signature = get_be32(m->data);
> +	if (m->signature != MIDX_SIGNATURE) {
> +		error(_("multi-pack-index signature 0x%08x does not match signature 0x%08x"),
> +		      m->signature, MIDX_SIGNATURE);
> +		goto cleanup_fail;
> +	}
> +
> +	m->version = m->data[4];
> +	if (m->version != MIDX_VERSION) {
> +		error(_("multi-pack-index version %d not recognized"),
> +		      m->version);
> +		goto cleanup_fail;
> +	}
> +
> +	hash_version = m->data[5];

Is there a good existing example to show a better way to avoid these
hard-coded constants that describe/define the file format?

> +	if (hash_version != MIDX_HASH_VERSION) {
> +		error(_("hash version %u does not match"), hash_version);
> +		goto cleanup_fail;
> +	}
> +	m->hash_len = MIDX_HASH_LEN;
> +
> +	m->num_chunks = *(m->data + 6);

By the way, this mixture of m->data[4] and *(m->data + 6) is even
worse.  You could do get_be32(&8[m->data]) if you want to irritate
readers even more ;-)

> +	m->num_packs = get_be32(m->data + 8);
> +
> +	return m;
> +
> +cleanup_fail:
> +	FREE_AND_NULL(m);
> +	FREE_AND_NULL(midx_name);
> +	munmap(midx_map, midx_size);
> +	close(fd);
> +	return NULL;
> +}
> +


> diff --git a/t/t5319-multi-pack-index.sh b/t/t5319-multi-pack-index.sh
> index 8622a7cdce..0372704c96 100755
> --- a/t/t5319-multi-pack-index.sh
> +++ b/t/t5319-multi-pack-index.sh
> @@ -3,9 +3,19 @@
>  test_description='multi-pack-indexes'
>  . ./test-lib.sh
>  
> +midx_read_expect() {

"midx_read_expect () {", i.e. SP on both sides of (), please.

> +	cat >expect <<- EOF

"<<-\EOF", i.e. make it easy for readers to spot that there is no
funny substitutions happening in the here-doc body.


> +	header: 4d494458 1 0 0
> +	object_dir: .
> +	EOF
> +	test-tool read-midx . >actual &&
> +	test_cmp expect actual
> +}
> +
>  test_expect_success 'write midx with no packs' '
>  	git multi-pack-index --object-dir=. write &&
> -	test_path_is_file pack/multi-pack-index
> +	test_path_is_file pack/multi-pack-index &&
> +	midx_read_expect
>  '
>  
>  test_done
