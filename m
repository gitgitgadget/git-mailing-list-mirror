Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D350EC433B4
	for <git@archiver.kernel.org>; Mon, 10 May 2021 11:50:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B671761278
	for <git@archiver.kernel.org>; Mon, 10 May 2021 11:50:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233555AbhEJLvy (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 May 2021 07:51:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236359AbhEJLcC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 May 2021 07:32:02 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA9D5C061761
        for <git@vger.kernel.org>; Mon, 10 May 2021 04:30:57 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id j26so14609193edf.9
        for <git@vger.kernel.org>; Mon, 10 May 2021 04:30:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=g4bnpVFaYuAEQZs3AuB1ZUIK1YHchR40hHQmr8TM5wA=;
        b=UIN6GXmp+2Q8Jgt9gLvDmuFlQYJMLXkcyNTSnxVgBrZY68ysHB331gz5AHmfYZ1I7p
         hMY4JBBR9SgXiRY9IzXm91q4sXs4dN1NZ3vf3WtH0SL5RjCtuOucoT+TnFpoa72PU87S
         xBE4JJTk0wqgs2qknMaZpWHgMOi05Wipuw0J3hmMPPCdSF1ag6lbIq4XJb1kLFEaFVea
         Qfl1TltEJD9+gqOyFiD7ZnyaFL31h4bl71KmokhVel4qTKXhHs1xCbLm6dkVBWEGkErb
         zt5l7/ZDGmL0bxfkbqV9r56pj8q0ZGr7ZYW5wE1arJ0nb8oYr+JOPbGubPkbbREK7FFh
         jEYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=g4bnpVFaYuAEQZs3AuB1ZUIK1YHchR40hHQmr8TM5wA=;
        b=ktftxbJkCBwKlmwWW+/zKgJX/I95/oiETyTptw4Rx/OPIBDyT0qeI6rddjWMiP9jBQ
         owy7Y2Hx4gaDnpjns5Z+IfIAIRd5MWI+e+4mhetD4OvoH2b1qx33bJbyAOXY1EuZEXK6
         dRo/qsvTM+LfvUePW91lrxCSqgq5LWrHAAeKb1tRZFfNOR1BAo8Ig864tUJmggBS4LLp
         FZNI4p4HBNctwUODOTyOp3rxQNwUYMDkvm6ts9RXvp1x/IkUlly8sAzB9QoGBzkdREBs
         6ogg1lkaP+1u0ey7oD1OE9qlkfizHfFdo6pB7yfBegVNBZ+IN6H40S6Z9rZaSxd01uvr
         aJBQ==
X-Gm-Message-State: AOAM532Ae86+zEf/pnH5sQ+1RsDYsWkAM3WZKRz9r3O2Wo9Vp6BllmqF
        wwyy3YAW4k+k0lWriQ6mCPY=
X-Google-Smtp-Source: ABdhPJxnpk3kkw5dlafbCHSLVE6sy7/hekTX9atxv7V2O8yYZbFd2NjLoKoBjEzdAdq79jJrY5lUfA==
X-Received: by 2002:a05:6402:154d:: with SMTP id p13mr29299981edx.371.1620646256412;
        Mon, 10 May 2021 04:30:56 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id bu20sm9025081ejb.76.2021.05.10.04.30.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 May 2021 04:30:55 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Teng Long <dyroneteng@gmail.com>
Cc:     git@vger.kernel.org, jonathantanmy@google.com
Subject: Re: [PATCH] Packfile-uris support excluding commit objects
Date:   Mon, 10 May 2021 13:14:40 +0200
References: <20210507021140.31372-1-dyroneteng@gmail.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.5.12
In-reply-to: <20210507021140.31372-1-dyroneteng@gmail.com>
Message-ID: <87wns6u8pc.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, May 07 2021, Teng Long wrote:

It seems like this and your
http://lore.kernel.org/git/20210506073354.27833-1-dyroneteng@gmail.com
should be part of one series, not split up.

> On the server, more sophisticated means of excluding objects should be
> supported, such as commit object. This commit introduces a new
> configuration `uploadpack.commitpackfileuri` for this.

Per my understanding in
https://lore.kernel.org/git/87o8hk820f.fsf@evledraar.gmail.com/ this +
Jonathan's earlier bfc2a36ff2a (Doc: clarify contents of packfile sent
as URI, 2021-01-20) still makes this whole thing more confusing that it
needs to be.

I think we should just have a new uploadpack.excludeObject, and document
that uploadpack.blobpackfileuri is an (unfortunately named) synonym for
it. I.e. the actual implementation doesn't care about the objec type it
just excludes any object listed via an oidmap. No?

As for some comments on the implementation:

> This patch only pack the commit object, not including the that commit
> and all objects that it references. This work will be done in a further
> patch recently.

I realize you're probably not a native English speaker (neither am I),
but I honestly can't understand that "This work will be done in a
further patch recently.". Do you mean something like:

    This change does not add support for recursively excluding things
    referenced by container objects such as "commit", "tag", and
    "tree". We'll still just dumbly exclude that specific object (this
    was originally meant for specific "blobs"). Smartly excluding things
    recursively might be implemented by a future change.

> Similarly, there are related documents that will be included in
> subsequent patches.

Please send the earlier doc cleanup + the spec change for this + any doc
updates as one series.

Narrow comments on the patch:

> Signed-off-by: Teng Long <dyroneteng@gmail.com>
> ---
>  builtin/pack-objects.c |  8 ++---
>  fetch-pack.c           |  8 +++++
>  t/t5702-protocol-v2.sh | 71 +++++++++++++++++++++++++++++++++---------
>  upload-pack.c          |  7 +++--
>  4 files changed, 73 insertions(+), 21 deletions(-)
>
> diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
> index 6d13cd3e1a..2f1817fe28 100644
> --- a/builtin/pack-objects.c
> +++ b/builtin/pack-objects.c
> @@ -2985,7 +2985,7 @@ static int git_pack_config(const char *k, const char *v, void *cb)
>  			pack_idx_opts.flags &= ~WRITE_REV;
>  		return 0;
>  	}
> -	if (!strcmp(k, "uploadpack.blobpackfileuri")) {
> +    if (!strcmp(k, "uploadpack.blobpackfileuri") || !strcmp(k, "uploadpack.commitpackfileuri")) {


Nit: Split this across two lines.

>  		struct configured_exclusion *ex = xmalloc(sizeof(*ex));
>  		const char *oid_end, *pack_end;
>  		/*
> @@ -2998,11 +2998,11 @@ static int git_pack_config(const char *k, const char *v, void *cb)
>  		    *oid_end != ' ' ||
>  		    parse_oid_hex(oid_end + 1, &pack_hash, &pack_end) ||
>  		    *pack_end != ' ')
> -			die(_("value of uploadpack.blobpackfileuri must be "
> -			      "of the form '<object-hash> <pack-hash> <uri>' (got '%s')"), v);
> +            die(_("value of uploadpack.blobpackfileuri or upload.commitpackfileuri must be "
> +                  "of the form '<object-hash> <pack-hash> <uri>' (got '%s')"), v);

Indending with spaces.

>  		if (oidmap_get(&configured_exclusions, &ex->e.oid))
>  			die(_("object already configured in another "
> -			      "uploadpack.blobpackfileuri (got '%s')"), v);
> +			      "uploadpack.blobpackfileuri or uploadpack.commitpackfileuri (got '%s')"), v);

I think by having a uploadpack.excludeObject documented as the primary
interface to this we could just say "object already listed by an earlier
exclusion" or something like that.

>  		ex->pack_hash_hex = xcalloc(1, pack_end - oid_end);
>  		memcpy(ex->pack_hash_hex, oid_end + 1, pack_end - oid_end - 1);
>  		ex->uri = xstrdup(pack_end + 1);
> diff --git a/fetch-pack.c b/fetch-pack.c
> index 2318ebe680..24a947835b 100644
> --- a/fetch-pack.c
> +++ b/fetch-pack.c
> @@ -23,6 +23,7 @@
>  #include "fetch-negotiator.h"
>  #include "fsck.h"
>  #include "shallow.h"
> +#include "strmap.h"
>  
>  static int transfer_unpack_limit = -1;
>  static int fetch_unpack_limit = -1;
> @@ -1677,6 +1678,8 @@ static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
>  		}
>  	}
>  
> +	struct strset uris;
> +	strset_init(&uris);
>  	for (i = 0; i < packfile_uris.nr; i++) {
>  		int j;
>  		struct child_process cmd = CHILD_PROCESS_INIT;
> @@ -1684,6 +1687,11 @@ static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
>  		const char *uri = packfile_uris.items[i].string +
>  			the_hash_algo->hexsz + 1;
>  
> +        if (strset_contains(&uris, uri)) {
> +            continue;
> +        }


More indenting with spaces, also don't need the {} here.

> +
> +        strset_add(&uris, uri);
>  		strvec_push(&cmd.args, "http-fetch");
>  		strvec_pushf(&cmd.args, "--packfile=%.*s",
>  			     (int) the_hash_algo->hexsz,
> diff --git a/t/t5702-protocol-v2.sh b/t/t5702-protocol-v2.sh
> index 2e1243ca40..d444177fb5 100755
> --- a/t/t5702-protocol-v2.sh
> +++ b/t/t5702-protocol-v2.sh
> @@ -824,12 +824,22 @@ test_expect_success 'when server does not send "ready", expect FLUSH' '
>  '
>  
>  configure_exclusion () {
> -	git -C "$1" hash-object "$2" >objh &&
> -	git -C "$1" pack-objects "$HTTPD_DOCUMENT_ROOT_PATH/mypack" <objh >packh &&
> -	git -C "$1" config --add \
> -		"uploadpack.blobpackfileuri" \
> -		"$(cat objh) $(cat packh) $HTTPD_URL/dumb/mypack-$(cat packh).pack" &&
> -	cat objh
> +    if test "$1" = "blob"
> +        then

Don't indent the "then", also spaces...

> +            git -C "$2" hash-object "$3" >objh &&
> +            git -C "$2" pack-objects "$HTTPD_DOCUMENT_ROOT_PATH/mypack" <objh >packh &&
> +            git -C "$2" config --add \
> +            		"uploadpack.blobpackfileuri" \
> +            		"$(cat objh) $(cat packh) $HTTPD_URL/dumb/mypack-$(cat packh).pack" &&
> +            cat objh
> +        else
> +            echo "$3" > objh &&

Use ">objh" not "> objh".

> +            git -C "$2" pack-objects "$HTTPD_DOCUMENT_ROOT_PATH/mypack" <objh >packh &&
> +            git -C "$2" config --add \
> +            		"uploadpack.commitpackfileuri" \
> +            		"$(cat objh) $(cat packh) $HTTPD_URL/dumb/mypack-$(cat packh).pack" &&
> +            cat objh


This whole if/else seems like it could be better split up by discovering
the variable first, using that as a variable, and then avoiding the
duplication. But if we just used uploadpack.excludeObject...

> +    fi
>  }
>  
>  test_expect_success 'part of packfile response provided as URI' '
> @@ -845,8 +855,8 @@ test_expect_success 'part of packfile response provided as URI' '
>  	git -C "$P" add other-blob &&
>  	git -C "$P" commit -m x &&
>  
> -	configure_exclusion "$P" my-blob >h &&
> -	configure_exclusion "$P" other-blob >h2 &&
> +	configure_exclusion blob "$P" my-blob >h &&
> +	configure_exclusion blob "$P" other-blob >h2 &&
>  
>  	GIT_TRACE=1 GIT_TRACE_PACKET="$(pwd)/log" GIT_TEST_SIDEBAND_ALL=1 \
>  	git -c protocol.version=2 \
> @@ -881,7 +891,7 @@ test_expect_success 'part of packfile response provided as URI' '
>  	test_line_count = 6 filelist
>  '
>  
> -test_expect_success 'packfile URIs with fetch instead of clone' '
> +test_expect_success 'blobs packfile URIs with fetch instead of clone' '
>  	P="$HTTPD_DOCUMENT_ROOT_PATH/http_parent" &&
>  	rm -rf "$P" http_child log &&
>  
> @@ -892,7 +902,7 @@ test_expect_success 'packfile URIs with fetch instead of clone' '
>  	git -C "$P" add my-blob &&
>  	git -C "$P" commit -m x &&
>  
> -	configure_exclusion "$P" my-blob >h &&
> +	configure_exclusion blob "$P" my-blob >h &&
>  
>  	git init http_child &&
>  
> @@ -902,6 +912,37 @@ test_expect_success 'packfile URIs with fetch instead of clone' '
>  		fetch "$HTTPD_URL/smart/http_parent"
>  '
>  
> +test_expect_success 'commits packfile URIs with fetch instead of clone' '
> +	P="$HTTPD_DOCUMENT_ROOT_PATH/http_parent" &&
> +	rm -rf "$P" http_child log &&

Put stuff like this in "test_when_finished"

> +
> +	git init "$P" &&
> +	git -C "$P" config "uploadpack.allowsidebandall" "true" &&
> +
> +	echo my-blob >"$P/my-blob" &&
> +	git -C "$P" add my-blob &&
> +	git -C "$P" commit -m x &&

You can just use test_commit here, no?

> +
> +
> +	mycommit=$(git -C "$P" rev-parse HEAD) &&
> +    echo other-blob >"$P/other-blob" &&
> +    git -C "$P" add other-blob &&
> +    git -C "$P" commit -m x &&

ditto test_commit.

> +	othercommit=$(git -C "$P" rev-parse HEAD) &&
> +	configure_exclusion commit "$P" "$mycommit" >h &&
> +	configure_exclusion commit "$P" "$othercommit" >h2 &&

Personally I'd just skip this whole "rev-parse HEAD" etc. and just pass
the tag name(s) created by earlier test_commit, then have
configure_exclusion ust always do a rev-parse...

> +
> +	git init http_child &&
> +
> +	GIT_TRACE=1 GIT_TEST_SIDEBAND_ALL=1 \
> +	git -C http_child -c protocol.version=2 \
> +		-c fetch.uriprotocols=http,https \
> +		fetch "$HTTPD_URL/smart/http_parent" &&
> +	ls http_child/.git/objects/pack/*.pack \
> +    	    http_child/.git/objects/pack/*.idx >filelist &&
> +    	test_line_count = 6 filelist
> +'
> +
>  test_expect_success 'fetching with valid packfile URI but invalid hash fails' '
>  	P="$HTTPD_DOCUMENT_ROOT_PATH/http_parent" &&
>  	rm -rf "$P" http_child log &&
> @@ -915,7 +956,7 @@ test_expect_success 'fetching with valid packfile URI but invalid hash fails' '
>  	git -C "$P" add other-blob &&
>  	git -C "$P" commit -m x &&
>  
> -	configure_exclusion "$P" my-blob >h &&
> +	configure_exclusion blob "$P" my-blob >h &&
>  	# Configure a URL for other-blob. Just reuse the hash of the object as
>  	# the hash of the packfile, since the hash does not matter for this
>  	# test as long as it is not the hash of the pack, and it is of the
> @@ -944,7 +985,7 @@ test_expect_success 'packfile-uri with transfer.fsckobjects' '
>  	git -C "$P" add my-blob &&
>  	git -C "$P" commit -m x &&
>  
> -	configure_exclusion "$P" my-blob >h &&
> +	configure_exclusion blob "$P" my-blob >h &&
>  
>  	sane_unset GIT_TEST_SIDEBAND_ALL &&
>  	git -c protocol.version=2 -c transfer.fsckobjects=1 \
> @@ -978,7 +1019,7 @@ test_expect_success 'packfile-uri with transfer.fsckobjects fails on bad object'
>  	git -C "$P" add my-blob &&
>  	git -C "$P" commit -m x &&
>  
> -	configure_exclusion "$P" my-blob >h &&
> +	configure_exclusion blob "$P" my-blob >h &&
>  
>  	sane_unset GIT_TEST_SIDEBAND_ALL &&
>  	test_must_fail git -c protocol.version=2 -c transfer.fsckobjects=1 \
> @@ -1000,7 +1041,7 @@ test_expect_success 'packfile-uri with transfer.fsckobjects succeeds when .gitmo
>  	git -C "$P" add .gitmodules &&
>  	git -C "$P" commit -m x &&
>  
> -	configure_exclusion "$P" .gitmodules >h &&
> +	configure_exclusion blob "$P" .gitmodules >h &&
>  
>  	sane_unset GIT_TEST_SIDEBAND_ALL &&
>  	git -c protocol.version=2 -c transfer.fsckobjects=1 \
> @@ -1026,7 +1067,7 @@ test_expect_success 'packfile-uri with transfer.fsckobjects fails when .gitmodul
>  	git -C "$P" add .gitmodules &&
>  	git -C "$P" commit -m x &&
>  
> -	configure_exclusion "$P" .gitmodules >h &&
> +	configure_exclusion blob "$P" .gitmodules >h &&
>  
>  	sane_unset GIT_TEST_SIDEBAND_ALL &&
>  	test_must_fail git -c protocol.version=2 -c transfer.fsckobjects=1 \
> diff --git a/upload-pack.c b/upload-pack.c
> index 5c1cd19612..34f8bb81a8 100644
> --- a/upload-pack.c
> +++ b/upload-pack.c
> @@ -1744,9 +1744,12 @@ int upload_pack_advertise(struct repository *r,
>  		     allow_sideband_all_value))
>  			strbuf_addstr(value, " sideband-all");
>  
> -		if (!repo_config_get_string(the_repository,
> +		if ((!repo_config_get_string(the_repository,
>  					    "uploadpack.blobpackfileuri",
> -					    &str) &&
> +					    &str) ||
> +            !repo_config_get_string(the_repository,
> +                        "uploadpack.commitpackfileuri",
> +                        &str)) &&
>  		    str) {
>  			strbuf_addstr(value, " packfile-uris");
>  			free(str);

Not a new issue, but I wonder if we shouldn't just export
configset_find_element(). This is at least 2 stackframes down the chain
of the "does this key exist?" we actually care about here.
