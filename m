Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B31DF1F4B6
	for <e@80x24.org>; Sat, 11 May 2019 23:38:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726287AbfEKXiA (ORCPT <rfc822;e@80x24.org>);
        Sat, 11 May 2019 19:38:00 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:43956 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726033AbfEKXiA (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 11 May 2019 19:38:00 -0400
Received: by mail-ed1-f67.google.com with SMTP id w33so11128390edb.10
        for <git@vger.kernel.org>; Sat, 11 May 2019 16:37:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=u7DnGDW/sZix63puaIRT5gt9UYHdNfM8uV6v7fEtDlU=;
        b=rRtTA/pxRrHH1Bf4XLJqhldPjTrrmzx2N9xFEniD67iEKDtohPLMvVDJgYK453/Go9
         sJjO/zqwLGMYsoM4O93B1Mg/c/ViFAnH/jkJE96+t3o2P/e8Q5cDjH1r9fziR5YOEMPD
         b6vbp48bKQ05eLsOQePbic6WWpZAvtbcmBpC1lCapht9gskEIgWgbbeoJWkrzkEPcNib
         p+lghszDFRPnXlUpgJqf9qR8dWSkNiY6JKr91sfUaY2E5EKVjd9xQJBtEiiSP+vQ1H6h
         zzR236fwu0I2N8ttKkXs+t7DmMnWw16GL38TKI7dm8mL/vGCZFNYN2XyrPP+DCRFA5Eo
         nFeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=u7DnGDW/sZix63puaIRT5gt9UYHdNfM8uV6v7fEtDlU=;
        b=JT9sT9uBqbPQyDzRfsAKMsT2OnfY6IdeCZ4PCD+wLWFl5fWHLyxYEiufqXOp4XQkgW
         1z6DQfJF4CQJaniQFGwJX9w04NiMRANSCiL51cwGjzO+8kfLGiMtfvC5eet7aJM7nlyu
         /7/lp74uz/25P16vq/SGGNXP7Iqj0TyATa35XNzP3ye1xatuwOISGkCr8dU9WtobQb5H
         gXWM2q7s3Filg1PggHTA3okRNsGPWRL10/psQ6Afb1m0PwkshWRO0htrcck2iM+HgFN2
         mODkomhYsjgDMGbJTR5pTMCFjsrfj8gc0QgoT8/j8n/ha/JZ73e4NwD5RnEsPeClNDyu
         F8ow==
X-Gm-Message-State: APjAAAXU8+B9Qlj8l7h2lwv0MuVsEVRIYgqj0A+Y70wGhAFViAts/mhT
        V3WPfi3Zi1TdsCqUX+HQ4ylh+so7
X-Google-Smtp-Source: APXvYqxdOQP+VZd1bo59Voyg7bH1B032sPmQe608Nd5JMpVMD5Ikg9l0v/9Ebq4/5wViaXLT48nY7g==
X-Received: by 2002:a17:906:25d1:: with SMTP id n17mr15085081ejb.257.1557617877683;
        Sat, 11 May 2019 16:37:57 -0700 (PDT)
Received: from evledraar (dhcp-077-251-215-224.chello.nl. [77.251.215.224])
        by smtp.gmail.com with ESMTPSA id k18sm2576375eda.92.2019.05.11.16.37.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 11 May 2019 16:37:56 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Eric Wong <e@80x24.org>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] update-server-info: avoid needless overwrites
References: <20190511013455.5886-1-e@80x24.org>
User-agent: Debian GNU/Linux buster/sid; Emacs 26.1; mu4e 1.1.0
In-reply-to: <20190511013455.5886-1-e@80x24.org>
Date:   Sun, 12 May 2019 01:37:55 +0200
Message-ID: <87v9ygwoj0.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sat, May 11 2019, Eric Wong wrote:

> Do not change the existing info/refs and objects/info/packs
> files if they match the existing content on the filesystem.
> This is intended to preserve mtime and make it easier for dumb
> HTTP pollers to rely on the If-Modified-Since header.
>
> Combined with stdio and kernel buffering; the kernel should be
> able to avoid block layer writes and reduce wear.
>
> Signed-off-by: Eric Wong <e@80x24.org>
> ---
>  server-info.c                 | 61 +++++++++++++++++++++++++++++------
>  t/t5200-update-server-info.sh | 41 +++++++++++++++++++++++
>  2 files changed, 92 insertions(+), 10 deletions(-)
>  create mode 100755 t/t5200-update-server-info.sh
>
> diff --git a/server-info.c b/server-info.c
> index 41274d098b..34599e4817 100644
> --- a/server-info.c
> +++ b/server-info.c
> @@ -6,37 +6,78 @@
>  #include "tag.h"
>  #include "packfile.h"
>  #include "object-store.h"
> +#include "strbuf.h"
> +
> +static int files_differ(FILE *fp, const char *path)
> +{
> +	struct stat st;
> +	git_hash_ctx c;
> +	struct object_id oid_old, oid_new;
> +	struct strbuf tmp = STRBUF_INIT;
> +	long new_len = ftell(fp);
> +
> +	if (new_len < 0 || stat(path, &st) < 0)
> +		return 1;
> +	if (!S_ISREG(st.st_mode))
> +		return 1;
> +	if ((off_t)new_len != st.st_size)
> +		return 1;
> +
> +	rewind(fp);
> +	if (strbuf_fread(&tmp, (size_t)new_len, fp) != (size_t)new_len)
> +		return 1;
> +	the_hash_algo->init_fn(&c);
> +	the_hash_algo->update_fn(&c, tmp.buf, tmp.len);
> +	the_hash_algo->final_fn(oid_new.hash, &c);
> +	strbuf_release(&tmp);
> +
> +	if (strbuf_read_file(&tmp, path, (size_t)st.st_size) < 0)
> +		return 1;
> +	the_hash_algo->init_fn(&c);
> +	the_hash_algo->update_fn(&c, tmp.buf, tmp.len);
> +	the_hash_algo->final_fn(oid_old.hash, &c);
> +	strbuf_release(&tmp);
> +
> +	return hashcmp(oid_old.hash, oid_new.hash);
> +}

This way of doing it just seems so weirdly convoluted. Read them one at
a time, compute the SHA-1, just to see if they're different. Why not
something closer to a plain memcmp():

	static int files_differ(FILE *fp, const char *path)
	{
		struct strbuf old = STRBUF_INIT, new = STRBUF_INIT;
		long new_len = ftell(fp);
		int diff = 1;

		rewind(fp);
		if (strbuf_fread(&new, (size_t)new_len, fp) != (size_t)new_len)
			goto release_return;
		if (strbuf_read_file(&old, path, 0) < 0)
			goto release_return;

		diff = strbuf_cmp(&old, &new);

	release_return:
		strbuf_release(&old);
		strbuf_release(&new);

		return diff;
	}

I.e. optimze for code simplicity with something close to a dumb "cmp
--silent". I'm going to make the bold claim that nobody using "dumb
http" is going to be impacted by the performance of reading their
for-each-ref or for-each-pack dump, hence opting for not even bothing to
stat() to get the size before reading.

Because really, if we were *trying* to micro-optimize this for time or
memory use there's much better ways, e.g. reading the old file and
memcmp() as we go and stream the "generate" callback, but I just don't
see the point of trying in this case.

>  /*
>   * Create the file "path" by writing to a temporary file and renaming
>   * it into place. The contents of the file come from "generate", which
>   * should return non-zero if it encounters an error.
>   */
> -static int update_info_file(char *path, int (*generate)(FILE *))
> +static int update_info_file(char *path, int (*generate)(FILE *), int force)
>  {
>  	char *tmp = mkpathdup("%s_XXXXXX", path);

Unrelated to this, patch, but I hadn't thought about this nasty race
condition. We recommend users run this from the "post-update" (or
"post-receive") hook, and don't juggle the lock along with the ref
update, thus due to the vagaries of scheduling you can end up with two
concurrent ref updates where the "old" one wins.

But I guess that brings me back to something close to "nobody with that
sort of update rate is using 'dumb http'" :)

For this to work properly we'd need to take some sort of global "ref
update/pack update" lock, and I guess at that point this "cmp" case
would be a helper similar to commit_lock_file_to(),
i.e. a commit_lock_file_to_if_different().

>  	int ret = -1;
>  	int fd = -1;
>  	FILE *fp = NULL, *to_close;
> +	int do_update;
>
>  	safe_create_leading_directories(path);
>  	fd = git_mkstemp_mode(tmp, 0666);
>  	if (fd < 0)
>  		goto out;
> -	to_close = fp = fdopen(fd, "w");
> +	to_close = fp = fdopen(fd, "w+");
>  	if (!fp)
>  		goto out;
>  	fd = -1;
>  	ret = generate(fp);
>  	if (ret)
>  		goto out;
> +
> +	do_update = force || files_differ(fp, path);
> [...]
>
> -static int update_info_refs(void)
> +static int update_info_refs(int force)

So, I was going to say "shouldn't we update the docs?" which for --force
say "Update the info files from scratch.".

But reading through it that "from scratch" wording is from c743e6e3c0
("Add a link from update-server-info documentation to repository
layout.", 2005-09-04).

There it was a refrence to a bug since fixed in 60d0526aaa ("Unoptimize
info/refs creation.", 2005-09-14), and then removed from the docs in
c5fe5b6de9 ("Remove obsolete bug warning in man git-update-server-info",
2009-04-25).

Then in b3223761c8 ("update_info_refs(): drop unused force parameter",
2019-04-05) Jeff removed the unused-for-a-decade "force" param.

So having gone through the history I think we're better off just
dropping the --force argument entirely, or at least changing the
docs.

Before this change the only thing it was doing was pruning stuff we
haven't written since 2005-ish (see 3e15c67c90 ("server-info: throw away
T computation as well.", 2005-12-04)), rather than "detect if useless"
we should just write out the file again, and then skip if changed
(i.e. this logic).

That would also take care of the parse_pack_def() case by proxy, i.e. we
don't need some "is stale if pack is missing" special case if we just
always write out a new file (or not if it memcmp's the same as the "old"
one), we want to change the file if the packs are updated anyway
