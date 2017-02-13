Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 62E751FC44
	for <e@80x24.org>; Mon, 13 Feb 2017 20:14:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753315AbdBMUOJ (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Feb 2017 15:14:09 -0500
Received: from avasout02.plus.net ([212.159.14.17]:51095 "EHLO
        avasout02.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752670AbdBMUOH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Feb 2017 15:14:07 -0500
Received: from [10.0.2.15] ([146.90.175.113])
        by avasout02 with smtp
        id kLE41u0012TAAPE01LE5dU; Mon, 13 Feb 2017 20:14:06 +0000
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.2 cv=F9YnTupN c=1 sm=1 tr=0
 a=xPbQrKg7pJ/t022iV9eLWw==:117 a=xPbQrKg7pJ/t022iV9eLWw==:17
 a=IkcTkHD0fZMA:10 a=pGLkceISAAAA:8 a=hJMdrLrWMElkqMNHnW8A:9 a=QEXdDO2ut3YA:10
 a=6kGIvZw6iX1k4Y-7sg4_:22
X-AUTH: ramsayjones@:2500
Subject: Re: [PATCH 01/11] refs-internal.c: make files_log_ref_write() static
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, git@vger.kernel.org
References: <20170213152011.12050-1-pclouds@gmail.com>
 <20170213152011.12050-2-pclouds@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        sbeller@google.com, novalis@novalis.org
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <6510f4b2-51bb-eabd-9cd7-30bc4164b25d@ramsayjones.plus.com>
Date:   Mon, 13 Feb 2017 20:14:03 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.0
MIME-Version: 1.0
In-Reply-To: <20170213152011.12050-2-pclouds@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 13/02/17 15:20, Nguyễn Thái Ngọc Duy wrote:
> Created in 5f3c3a4e6f (files_log_ref_write: new function - 2015-11-10)
> but probably never used outside refs-internal.c
> 
> Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
> ---
>  refs/files-backend.c | 3 +++
>  refs/refs-internal.h | 4 ----
>  2 files changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/refs/files-backend.c b/refs/files-backend.c
> index cdb6b8ff5..75565c3aa 100644
> --- a/refs/files-backend.c
> +++ b/refs/files-backend.c
> @@ -165,6 +165,9 @@ static struct ref_entry *create_dir_entry(struct files_ref_store *ref_store,
>  					  const char *dirname, size_t len,
>  					  int incomplete);
>  static void add_entry_to_dir(struct ref_dir *dir, struct ref_entry *entry);
> +static int files_log_ref_write(const char *refname, const unsigned char *old_sha1,
> +			       const unsigned char *new_sha1, const char *msg,
> +			       int flags, struct strbuf *err);

Why? I don't like adding forward declarations unless it
is absolutely necessary (ie mutually recursive functions),
and even in the current 'pu' branch (@c04899d50), the
definition of this function appears before all uses in
this file. (ie, just add static to the definition).

What am I missing?

ATB,
Ramsay Jones

>  
>  static struct ref_dir *get_ref_dir(struct ref_entry *entry)
>  {
> diff --git a/refs/refs-internal.h b/refs/refs-internal.h
> index 33adbf93b..59e65958a 100644
> --- a/refs/refs-internal.h
> +++ b/refs/refs-internal.h
> @@ -222,10 +222,6 @@ struct ref_transaction {
>  	enum ref_transaction_state state;
>  };
>  
> -int files_log_ref_write(const char *refname, const unsigned char *old_sha1,
> -			const unsigned char *new_sha1, const char *msg,
> -			int flags, struct strbuf *err);
> -
>  /*
>   * Check for entries in extras that are within the specified
>   * directory, where dirname is a reference directory name including
> 
