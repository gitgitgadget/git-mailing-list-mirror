Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE4BDC433ED
	for <git@archiver.kernel.org>; Mon,  3 May 2021 15:35:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F19C61159
	for <git@archiver.kernel.org>; Mon,  3 May 2021 15:35:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230366AbhECPgD (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 May 2021 11:36:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229588AbhECPf7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 May 2021 11:35:59 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3B13C06174A
        for <git@vger.kernel.org>; Mon,  3 May 2021 08:35:05 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id o27so5416073qkj.9
        for <git@vger.kernel.org>; Mon, 03 May 2021 08:35:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=Rx5Ty2SPhTF8oFwCsBclkvYznaLXtGSAFRjLgSGJlNE=;
        b=MIFP1ZjmgHGE+cXu6ba9SsliBKqg44bPRxkyrRz5IqXWCrn5q/gHf7KRnuQEJHoyH0
         h/letFtAM2VrZzttD+dnNNIpsCOoCfy9AhfBf3XIYPP4r108h5FvPKMkVAuf39YK0y8V
         tQHGuLwBYV7TEXQlV4iQiHmppNNuaZCdCBYLDKzp/mExrNh5d5sFwJElWQgKz1C4Oz83
         2U73iBifj7MWLEcmw8rKN36Xg5M12EtVfWQhIMGM5Xx/mNt3rwpTrmclNalkDT/dGpEJ
         8XgE4W8p4hf6P3DSKF5Y8otuT0Dqc4HSZ08yfIFTSOEZ/lWJdmVXExZInjRR1CMHAJPP
         Ah3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Rx5Ty2SPhTF8oFwCsBclkvYznaLXtGSAFRjLgSGJlNE=;
        b=eOBMNpLDsUi4qXQLaMwtCYBtyvDmCUFiuZiFzTO0km/qj5NjbrNcRZUXRQiabLF5pR
         mYbrWKKLY3nuSnBRuhHukDRy41Pzcco8GCzlhAeYQvZTOUeMStxjJkPuO1QQnr09woUm
         /rAxPLB8ypi1ZzA5EyydA0mU9oMVNQD0W4AZydpF61CU/ZPVy5+OWARKpn+kgAxiAOGS
         AijEDy8gyILI3YomtOCAQOghhr4bdrIjag/BkRbnO/+hDoZStQUuAP/E6ACHbSII1++f
         kPipuh9dj03uS2OfQPjfLaaOKXVyKFua8uxp224Ewbu4jBkku3H1OWAYevPeUnf8sycu
         SzQw==
X-Gm-Message-State: AOAM531d8BpbOAj+JmiEtiviM+irOHXhsCtWC0d7jnu0uPa/1QBDykGz
        4F4BdX8Jfbz9iQhnTT++QX5Tq9dpCusy3g==
X-Google-Smtp-Source: ABdhPJxxYOknf87lskI/jE5dKpq0MRN0WVv7geddUhbDKHtSfOnq/9vQq/5iZYt4LBL8uJ/rcahkiA==
X-Received: by 2002:a37:7985:: with SMTP id u127mr19895149qkc.333.1620056104078;
        Mon, 03 May 2021 08:35:04 -0700 (PDT)
Received: from Derricks-MBP.attlocal.net ([2600:1700:e72:80a0:7dc8:8c84:e13f:8092])
        by smtp.gmail.com with ESMTPSA id f2sm8904507qkh.76.2021.05.03.08.35.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 May 2021 08:35:03 -0700 (PDT)
Subject: Re: [PATCH 6/6] send-pack: support push negotiation
To:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org
References: <cover.1617929278.git.jonathantanmy@google.com>
 <a2daa1022c41820b2109d9572069d12684470cb8.1617929278.git.jonathantanmy@google.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <c2780570-81ec-bede-2f4e-75748b788bbb@gmail.com>
Date:   Mon, 3 May 2021 11:35:02 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <a2daa1022c41820b2109d9572069d12684470cb8.1617929278.git.jonathantanmy@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 4/8/21 9:10 PM, Jonathan Tan wrote:
> Teach Git the push.negotiate config variable.
...
> +push.negotiate::
> +	If set to "true", attempt to reduce the size of the packfile
> +	sent by rounds of negotiation in which the client and the
> +	server attempt to find commits in common. If "false", Git will
> +	rely solely on the server's ref advertisement to find commits
> +	in common.

Works for me.

> diff --git a/send-pack.c b/send-pack.c
> index 5f215b13c7..9cb9f71650 100644
> --- a/send-pack.c
> +++ b/send-pack.c
> @@ -56,7 +56,9 @@ static void feed_object(const struct object_id *oid, FILE *fh, int negative)
>  /*
>   * Make a pack stream and spit it out into file descriptor fd
>   */
> -static int pack_objects(int fd, struct ref *refs, struct oid_array *extra, struct send_pack_args *args)
> +static int pack_objects(int fd, struct ref *refs, struct oid_array *advertised,
> +			struct oid_array *negotiated,
> +			struct send_pack_args *args)

At the moment, I don't see why we need two oid_arrays here.
Instead, this 'extra' could instead be renamed to something
like 'server_objects' or 'base_objects' to make it clear
that we don't want those objects, and can even use them and
their reachable objects as delta bases, when appropriate.

Or, just don't touch it.

> +static void get_commons_through_negotiation(const char *url,
> +					    const struct ref *remote_refs,
> +					    struct oid_array *commons)
> +{
> +	struct child_process child = CHILD_PROCESS_INIT;
> +	const struct ref *ref;
> +	int len = the_hash_algo->hexsz + 1; /* hash + NL */
> +
> +	child.git_cmd = 1;
> +	child.no_stdin = 1;
> +	child.out = -1;
> +	strvec_pushl(&child.args, "fetch", "--negotiate-only", NULL);
> +	for (ref = remote_refs; ref; ref = ref->next)
> +		strvec_pushf(&child.args, "--negotiation-tip=%s", oid_to_hex(&ref->new_oid));
> +	strvec_push(&child.args, url);

Oh! We are using a 'git fetch --negotiate-only' subprocess here. You
can ignore my previous message about updating the docs for this to be
used only by tests.

> +
> +	if (start_command(&child))
> +		die(_("send-pack: unable to fork off fetch subprocess"));
> +
> +	do {
> +		char hex_hash[GIT_MAX_HEXSZ + 1];
> +		int read_len = read_in_full(child.out, hex_hash, len);
> +		struct object_id oid;
> +		const char *end;
> +
> +		if (!read_len)
> +			break;
> +		if (read_len != len)
> +			die("invalid length read %d", read_len);
> +		if (parse_oid_hex(hex_hash, &oid, &end) || *end != '\n')
> +			die("invalid hash");
> +		oid_array_append(commons, &oid);
This appends, so there is no reason why it needs to be empty before
the method. Is there a way we could feed the extra_have set when
calling this method? Or is it happening at a strange time?

> +	} while (1);
> +
> +	if (finish_command(&child)) {
> +		/*
> +		 * The information that push negotiation provides is useful but
> +		 * not mandatory.
> +		 */
> +		warning(_("push negotiation failed; proceeding anyway with push"));
> +	}
> +}
> +
>  int send_pack(struct send_pack_args *args,
>  	      int fd[], struct child_process *conn,
>  	      struct ref *remote_refs,
>  	      struct oid_array *extra_have)
>  {
> +	struct oid_array commons = OID_ARRAY_INIT;
>  	int in = fd[0];
>  	int out = fd[1];
>  	struct strbuf req_buf = STRBUF_INIT;
> @@ -426,6 +474,7 @@ int send_pack(struct send_pack_args *args,
>  	int quiet_supported = 0;
>  	int agent_supported = 0;
>  	int advertise_sid = 0;
> +	int push_negotiate = 0;
>  	int use_atomic = 0;
>  	int atomic_supported = 0;
>  	int use_push_options = 0;
> @@ -437,6 +486,10 @@ int send_pack(struct send_pack_args *args,
>  	const char *push_cert_nonce = NULL;
>  	struct packet_reader reader;
>  
> +	git_config_get_bool("push.negotiate", &push_negotiate);
> +	if (push_negotiate)
> +		get_commons_through_negotiation(args->url, remote_refs, &commons);
> +
>  	git_config_get_bool("transfer.advertisesid", &advertise_sid);
>  
>  	/* Does the other end support the reporting? */
> @@ -625,7 +678,7 @@ int send_pack(struct send_pack_args *args,
>  			   PACKET_READ_DIE_ON_ERR_PACKET);
>  
>  	if (need_pack_data && cmds_sent) {
> -		if (pack_objects(out, remote_refs, extra_have, args) < 0) {
> +		if (pack_objects(out, remote_refs, extra_have, &commons, args) < 0) {

Here, it would be nice if extra_have and commons were merged before calling
pack_objects(). I mentioned a way to perhaps make that easier above, but
the context might not make that be super-simple. Running a loop here to
scan 'commons' and append them to 'extra_have' might be a sufficient
approach.

Generally, this approach seems like it would work. I have not done any
local testing, yet.

Thanks,
-Stolee

