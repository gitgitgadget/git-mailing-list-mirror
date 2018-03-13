Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 283491F404
	for <e@80x24.org>; Tue, 13 Mar 2018 19:04:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751988AbeCMTEo (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Mar 2018 15:04:44 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:38304 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751606AbeCMTEn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Mar 2018 15:04:43 -0400
Received: by mail-wr0-f194.google.com with SMTP id l8so1947021wrg.5
        for <git@vger.kernel.org>; Tue, 13 Mar 2018 12:04:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=qQdvsYrls9shprXXI/Z/TG71lg6NsVN6NgHiO4inKc0=;
        b=tPVcC91b8/uXtAn8KFttSJ0QR4m1RDd07VPxhXKY3nyjTK7PuaXROZx2OJ4DE2jaeW
         nsiEbhjWRTJSxl4xdrML2n55gXwBXeL3Ww/l2zghkLAal0wW+KlrPHs9WvoqEDFP/IGu
         eSSPZzpcbwYmBG9tGVbcL7VnydRCgYvqT4bbEB9iWus0lzM8eqW89XOADsvGmKAIW89V
         9qJXM/ILP4bJrtYmeNvas8OCqIHMinecsdr1h6WkNB2nF3ko73F1zM64RLsaTKnVsORX
         UhPFoYH9WCV8zUQhYpDpKngerhC3iBPveGbaiV4XzulmKvC87mS+241OirT405SCC2dP
         0Bzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=qQdvsYrls9shprXXI/Z/TG71lg6NsVN6NgHiO4inKc0=;
        b=hxqMaZjJURbCWJ4JH3hQ6+1yhzWn/TOQg+LGBRiJ8TUGbVMM28UvJivNP1BI/LY9Up
         vrEPWDR9iS/2fdjrjPwxtuBxO55Gad3bv8/V1tuwOGYGMwYoo4LrPbkwx4wJh8aQc6gg
         I2e5+ZUzDcjSJuTkw15kwSCn7/cOedawkLDfit4RJwp682Pgn3K0faPB8gqiDZAUUPBl
         z6G2AyP9auOy2AabL4ZYIcyAIioBWBWO/Y1xndKVGWDlmxK4OrHuwjV86UB6SHCwTLkN
         +TzFTJf615Z22iWL7kWm1OTuyKFkzB4UX40aNqaCo67n/y1r3KlPyGBBWWiaiB/dgfJf
         CjMw==
X-Gm-Message-State: AElRT7G4q2PfTrLwBLgSuH0+e5taeA24+bh/NzG8iTJpyEf0stGIoh9y
        18RRs/2kaD56w1Zk706GCrE=
X-Google-Smtp-Source: AG47ELspFDW0JT/eoHpS1WM2OQYNbJbgyUxWXYj8PnLQUnmhPUN5dxWc3UJopXVi/A40rCaQ40qoHw==
X-Received: by 10.28.241.2 with SMTP id p2mr1597398wmh.105.1520967882383;
        Tue, 13 Mar 2018 12:04:42 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id c5sm1250152wrb.47.2018.03.13.12.04.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 13 Mar 2018 12:04:41 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Takuto Ikuta <tikuta@chromium.org>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v5] fetch-pack.c: use oidset to check existence of loose object
References: <20180310123445.79609-1-tikuta@chromium.org>
        <20180310124643.82666-1-tikuta@chromium.org>
Date:   Tue, 13 Mar 2018 12:04:40 -0700
In-Reply-To: <20180310124643.82666-1-tikuta@chromium.org> (Takuto Ikuta's
        message of "Sat, 10 Mar 2018 21:46:43 +0900")
Message-ID: <xmqq7eqf3ign.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Takuto Ikuta <tikuta@chromium.org> writes:

> +struct loose_object_iter {
> +	struct oidset *loose_object_set;
> +	struct ref *refs;
> +};
> +
> +/*
> + *  If the number of refs is not larger than the number of loose objects,
> + *  this function stops inserting and returns false.
> + */
> +static int add_loose_objects_to_set(const struct object_id *oid,
> +				    const char *path,
> +				    void *data)
> +{
> +	struct loose_object_iter *iter = data;
> +	oidset_insert(iter->loose_object_set, oid);
> +	if (iter->refs == NULL)
> +		return 1;
> +
> +	iter->refs = iter->refs->next;
> +	return 0;
> +}

That's clever.  By traversing the refs list as you iterate over the
loose objects, you do not do any unnecessary work ;-)

Thanks for working on this.

> @@ -719,16 +741,31 @@ static int everything_local(struct fetch_pack_args *args,
>  	int retval;
>  	int old_save_commit_buffer = save_commit_buffer;
>  	timestamp_t cutoff = 0;
> +	struct oidset loose_oid_set = OIDSET_INIT;
> +	int use_oidset = 0;
> +	struct loose_object_iter iter = {&loose_oid_set, *refs};
> +
> +	/* Enumerate all loose objects or know refs are not so many. */
> +	use_oidset = !for_each_loose_object(add_loose_objects_to_set,
> +					    &iter, 0);
>  
>  	save_commit_buffer = 0;
>  
>  	for (ref = *refs; ref; ref = ref->next) {
>  		struct object *o;
> +		unsigned int flags = OBJECT_INFO_QUICK;
>  
> -		if (!has_object_file_with_flags(&ref->old_oid,
> -						OBJECT_INFO_QUICK))
> -			continue;
> +		if (use_oidset &&
> +		    !oidset_contains(&loose_oid_set, &ref->old_oid)) {
> +			/*
> +			 * I know this does not exist in the loose form,
> +			 * so check if it exists in a non-loose form.
> +			 */
> +			flags |= OBJECT_INFO_IGNORE_LOOSE;
> +		}
>  
> +		if (!has_object_file_with_flags(&ref->old_oid, flags))
> +			continue;
>  		o = parse_object(&ref->old_oid);
>  		if (!o)
>  			continue;
