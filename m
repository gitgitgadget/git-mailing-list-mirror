Return-Path: <SRS0=D6Hn=4A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80571C352A4
	for <git@archiver.kernel.org>; Wed, 12 Feb 2020 22:36:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5249021569
	for <git@archiver.kernel.org>; Wed, 12 Feb 2020 22:36:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NRAd0SID"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729133AbgBLWgs (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Feb 2020 17:36:48 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:50819 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727947AbgBLWgs (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Feb 2020 17:36:48 -0500
Received: by mail-pj1-f65.google.com with SMTP id r67so1487698pjb.0
        for <git@vger.kernel.org>; Wed, 12 Feb 2020 14:36:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2nxLALyp81Mo20K7bN+bFgkeSg2xDRUhr9iSCcFs5Yg=;
        b=NRAd0SIDAzFq7t16nLhNsvfZVGIFXHJDfUyL2RMPQar/NFgvfcPgyw7lwJQAuDF42r
         63WXfYK8WyC5j8jTY81eZUC4vRIujEUkQuYLGMMY3d5+SOcVgqtfsrZhon0BmuTymtK4
         jgiWNL/p92keSLmYYETsOVlVCzXL61dfJW6NWW5uFXIVueCn3xYVaUrkl84+3ELp7T6C
         +XbtVY7y0rt6kQx4qtPB6InsNl6Sn6TvVGqPhTfG2lCT5kw3qqLEmgSr9rOSYoXfCMsm
         djXgrT9t5B0UaQcgIKtjwJPMhXfXS+aBbOXo6LCbo7W/eg7dwZVJTlJS0smRdbxzbsPa
         2S6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2nxLALyp81Mo20K7bN+bFgkeSg2xDRUhr9iSCcFs5Yg=;
        b=SsRj54Hj+An4xmCUK9q02L6Ae5pZYwEmcErw6QGbR1EI5xtQfA7WPuvieBRU0+aSjN
         Hsi9Ly+Mp3nNPlP8rQOpcuuJA3WUlyG8PtYZqKVIwWej6jgs/Hh/M3h2lJIhRjLCmF5t
         xXcasUT+XjTGoGkutA8k1cDF6YRSIHqC0w9ya5T2hzk0pDjQCTobHGK1hmbUW3THNNRk
         2g7cSLvdte21eNfUh4MTUHdMMxKE75zXe3zbXDG4WRxZ847oizSgGZN0s4yOoDxHXKaf
         D2RSaJDZI4A//4U92ph9lzsrqy7VMB3LATr80tnMQR7ZmVOAmc3jcnBPkPLSZeaocG5v
         pqyQ==
X-Gm-Message-State: APjAAAU6/nq84FywUwiIQhB2l1Xd+TTZh+nEbvXRc1mVVOyvAXZ4pDPh
        nq6RQaVceVC23P5AdAz4EW1p/w+dCnM=
X-Google-Smtp-Source: APXvYqz4HULOqWgZbYXYSjaWGX743yuTmMQCzniyrZrw6GIbldZNYyNuY7OCZBuUhNWGMlauAjuvGw==
X-Received: by 2002:a17:90a:c78f:: with SMTP id gn15mr1477296pjb.64.1581547007183;
        Wed, 12 Feb 2020 14:36:47 -0800 (PST)
Received: from google.com ([2620:15c:2ce:0:231c:11cc:aa0a:6dc5])
        by smtp.gmail.com with ESMTPSA id r9sm247976pfl.136.2020.02.12.14.36.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2020 14:36:46 -0800 (PST)
Date:   Wed, 12 Feb 2020 14:36:42 -0800
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v6 03/15] bugreport: add tool to generate debugging info
Message-ID: <20200212223642.GG190927@google.com>
References: <20200206004108.261317-1-emilyshaffer@google.com>
 <20200206004108.261317-4-emilyshaffer@google.com>
 <xmqq36bfvfwr.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq36bfvfwr.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 12, 2020 at 10:06:44AM -0800, Junio C Hamano wrote:
> As this topic seems to break under GIT_TEST_GETTEXT_POISON=yes, I'll
> apply the following band-aid on top before merging it to 'pu'.  
> 
> Most of them are style fixes, but quoting $REPORT, not just makes
> the redirection honor the coding guidelines, will ensure that an
> error is caught if git-bugreport-* glob matches no paths or more
> than on paths.

Thanks. Most of these I have locally, but not all. I'll apply this as a
fixup on patch 3/n (the one that introduces the tests) and add a
Helped-by line.

I'm hoping to get a reroll out today; it was the first thing on my list
this week, and then a high-priority internal issue shows up (so it
goes). Sorry for the inconvenience with the CI failures.

 - Emily

>  t/t0091-bugreport.sh | 17 ++++++++++-------
>  1 file changed, 10 insertions(+), 7 deletions(-)
> 
> diff --git a/t/t0091-bugreport.sh b/t/t0091-bugreport.sh
> index 451badff0c..f2186941ce 100755
> --- a/t/t0091-bugreport.sh
> +++ b/t/t0091-bugreport.sh
> @@ -8,9 +8,12 @@ test_description='git bugreport'
>  # information there; we can make sure all our headers were followed by some
>  # information to check if the command was successful.
>  HEADER_PATTERN="^\[.*\]$"
> -check_all_headers_populated() {
> -	while read -r line; do
> -		if test "$(grep "$HEADER_PATTERN" "$line")"; then
> +
> +check_all_headers_populated () {
> +	while read -r line
> +	do
> +		if test "$(grep "$HEADER_PATTERN" "$line")"
> +		then
>  			echo "$line"
>  			read -r nextline
>  			if test -z "$nextline"; then
> @@ -23,12 +26,12 @@ check_all_headers_populated() {
>  test_expect_success 'creates a report with content in the right places' '
>  	git bugreport &&
>  	REPORT="$(ls git-bugreport-*)" &&
> -	check_all_headers_populated <$REPORT &&
> -	rm $REPORT
> +	check_all_headers_populated <"$REPORT" &&
> +	rm "$REPORT"
>  '
>  
>  test_expect_success 'dies if file with same name as report already exists' '
> -	touch git-bugreport-duplicate.txt &&
> +	>>git-bugreport-duplicate.txt &&
>  	test_must_fail git bugreport --suffix duplicate &&
>  	rm git-bugreport-duplicate.txt
>  '
> @@ -42,7 +45,7 @@ test_expect_success '--output-directory puts the report in the provided dir' '
>  
>  test_expect_success 'incorrect arguments abort with usage' '
>  	test_must_fail git bugreport --false 2>output &&
> -	grep usage output &&
> +	test_i18ngrep usage output &&
>  	test_path_is_missing git-bugreport-*
>  '
>  
> -- 
> 2.25.0-455-gcf3c3a5ab4
> 
