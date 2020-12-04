Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0278EC4361A
	for <git@archiver.kernel.org>; Fri,  4 Dec 2020 19:10:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 973BF22C9C
	for <git@archiver.kernel.org>; Fri,  4 Dec 2020 19:10:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727838AbgLDTKw (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Dec 2020 14:10:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726392AbgLDTKw (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Dec 2020 14:10:52 -0500
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EDECC061A4F
        for <git@vger.kernel.org>; Fri,  4 Dec 2020 11:10:12 -0800 (PST)
Received: by mail-lj1-x243.google.com with SMTP id a1so6460990ljq.3
        for <git@vger.kernel.org>; Fri, 04 Dec 2020 11:10:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=A/xOn4hI5ImsQyMLY0MFCa+/eqS5VqK6+WzMA4qKBGo=;
        b=qvKlR9jeUDLspXrxRP58Mxbpx4mqHQSS2ApoqUK+iPDmb2dGR7uq+F/9SVB26cPJyk
         DYEzWzObox4GouurgjfA44ff2M/69CqoyhrFchjmB1N1ly0praPdOGS6e0/adiNlOtHu
         1XA9P8Fez6MV+aXORZqz9fFvNIuiblygpnpxzlN1/M5n5DblMkLn6KWFPfdUugmXkt5j
         ysJZ3+jSEHHZBsQduccoqus2oSTBaKVtKs1Pe/Mo/MHRbF5R5SEHzT6ImPhh7cMra582
         puz3c6mOSEq8xEwo+Oz73NMDo+63AS+x8h9oLcdZj/ohKwg+HmOIlP78J0R8mfwoAf0i
         QuIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=A/xOn4hI5ImsQyMLY0MFCa+/eqS5VqK6+WzMA4qKBGo=;
        b=kny48EcuXShX13Y8t4HP+46JLqN9HnY9r/TyCawyyGfa0ngPAdWBWVZ71l6BPGhaT4
         32HGN01UdUzr9tyBNhkepJyBj5P7UAm1Uy8UNk2dv0xy1Fp+KXu/CvwS5oIP7ABwPhao
         RPQp1s70RT7lchq1I/LoKXjMJwRhnli8SrK3yDL3ztEOgGj3nvD7fHQE5bmJOhS+rZ23
         yjx668veyCNCGXLvnmctaaKaMIgvS/SXRFyvyxAT9TmRMy/AqaZ6Rh3MBmWt9OwKF67H
         BNm67joyCvGsxN50YdA1aQ57Yf45RyiOC7sdtrcCsXOE5bQC1IVTyOMbCoie7/dGr+oj
         AatA==
X-Gm-Message-State: AOAM532hixGMIP6HgBVAbheNGj+qCf+7y4npCGikyRyrenpTSonrecwg
        op5FU7KpnQrpkCBsspNmRYcrVJLMbc8=
X-Google-Smtp-Source: ABdhPJz4/9BDSHNH6aIB5oErCzDntK4mafYF7O3ZQ4WXLl5dBK31JRbG25gGThmBna7BimqSlD9waw==
X-Received: by 2002:a2e:868c:: with SMTP id l12mr4248704lji.154.1607109010094;
        Fri, 04 Dec 2020 11:10:10 -0800 (PST)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id q21sm2018055ljm.52.2020.12.04.11.10.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Dec 2020 11:10:07 -0800 (PST)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Philip Oakley <philipoakley@iee.email>,
        git@vger.kernel.org
Subject: Re: [PATCH v1 01/27] revision: factor out parsing of diff-merge
 related options
References: <20201101193330.24775-1-sorganov@gmail.com>
        <20201108213838.4880-1-sorganov@gmail.com>
        <20201108213838.4880-2-sorganov@gmail.com>
        <xmqqv9djk9tv.fsf@gitster.c.googlers.com> <87a6uuj4wx.fsf@osv.gnss.ru>
        <xmqqlfeef56k.fsf@gitster.c.googlers.com>
Date:   Fri, 04 Dec 2020 22:10:06 +0300
In-Reply-To: <xmqqlfeef56k.fsf@gitster.c.googlers.com> (Junio C. Hamano's
        message of "Thu, 03 Dec 2020 22:36:51 -0800")
Message-ID: <87360lpeup.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Sergey Organov <sorganov@gmail.com> writes:
>
>>>> +		if (!strcmp(optarg, "off")) {
>>>> +			revs->ignore_merges = 1;
>>>> +		} else {
>>>> +			die(_("unknown value for --diff-merges: %s"), optarg);
>>>> +		}
>>>
>>> To correct the above bug, it probably is sufficient to add
>>>
>>> 		return argcount;
>>>
>>> here.
>>
>> Right, but not enough. "argcount" should also be set to 1 at the
>> beginning of the function, to avoid returning uninitialized value here.
>
> You seem to be a bit confused.
>
> The suggested fix is to ...
>
> +static int parse_diff_merge_opts(struct rev_info *revs, const char **argv) {
> +	int argcount;
> +	const char *optarg;
> +	const char *arg = argv[0];
> +
> +	if (!strcmp(arg, "-m")) {
> +		/*
> +		 * To "diff-index", "-m" means "match missing", and to the "log"
> +		 * family of commands, it means "show full diff for merges". Set
> +		 * both fields appropriately.
> +		 */
> +		revs->ignore_merges = 0;
> +		revs->match_missing = 1;
> +	} else if (!strcmp(arg, "-c")) {
> +		revs->diff = 1;
> +		revs->dense_combined_merges = 0;
> +		revs->combine_merges = 1;
> +	} else if (!strcmp(arg, "--cc")) {
> +		revs->diff = 1;
> +		revs->dense_combined_merges = 1;
> +		revs->combine_merges = 1;
> +	} else if (!strcmp(arg, "--no-diff-merges")) {
> +		revs->ignore_merges = 1;
> +	} else if (!strcmp(arg, "--combined-all-paths")) {
> +		revs->diff = 1;
> +		revs->combined_all_paths = 1;
> +	} else if ((argcount = parse_long_opt("diff-merges", argv, &optarg))) {
> +		if (!strcmp(optarg, "off")) {
> +			revs->ignore_merges = 1;
> +		} else {
> +			die(_("unknown value for --diff-merges: %s"), optarg);
> +		}
>
> ... add
>
> 		return argcount;
>
> here.  We know argcount has a valid value that was returned from
> parse_long_opt() at this point.  

[...]

OK, thanks, I now see what you meant, yet I now implemented it slightly
differently, as I finally need one point of return from the function
with non-zero value.

The end result is hopefully the same though.

Thanks,
-- Sergey Organov
