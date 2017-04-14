Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 405AD20970
	for <e@80x24.org>; Fri, 14 Apr 2017 18:50:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752257AbdDNSu4 (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Apr 2017 14:50:56 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:57422 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752008AbdDNSuz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Apr 2017 14:50:55 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id A099820970;
        Fri, 14 Apr 2017 18:50:54 +0000 (UTC)
Date:   Fri, 14 Apr 2017 18:50:54 +0000
From:   Eric Wong <e@80x24.org>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org, jrnieder@gmail.com
Subject: Re: [PATCH v3 07/10] run-command: eliminate calls to error handling
 functions in child
Message-ID: <20170414185054.GA23865@whir>
References: <20170413183252.4713-1-bmwill@google.com>
 <20170414165902.174167-1-bmwill@google.com>
 <20170414165902.174167-8-bmwill@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170414165902.174167-8-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Brandon Williams <bmwill@google.com> wrote:
> +++ b/run-command.c
> @@ -211,14 +211,82 @@ static const char **prepare_shell_cmd(struct argv_array *out, const char **argv)
>  #ifndef GIT_WINDOWS_NATIVE
>  static int child_notifier = -1;
>  
> -static void notify_parent(void)
> +enum child_errcode {
> +	CHILD_ERR_CHDIR,
> +	CHILD_ERR_ENOENT,
> +	CHILD_ERR_SILENT,
> +	CHILD_ERR_ERRNO,
> +};

I realize I introduced this in my original, but trailing commas
on the last enum value might not be portable.  Checking other
enum usages in our tree suggests we omit the last comma.
