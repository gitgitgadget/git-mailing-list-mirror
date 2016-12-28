Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F297720441
	for <e@80x24.org>; Wed, 28 Dec 2016 22:32:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752095AbcL1Wcy (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Dec 2016 17:32:54 -0500
Received: from bsmtp3.bon.at ([213.33.87.17]:17962 "EHLO bsmtp3.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751890AbcL1Wcx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Dec 2016 17:32:53 -0500
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp3.bon.at (Postfix) with ESMTPSA id 3tpnYb1Q5rz5tlL;
        Wed, 28 Dec 2016 23:32:50 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id B878A1E71;
        Wed, 28 Dec 2016 23:32:49 +0100 (CET)
Subject: Re: [PATCH v4 2/2] repack: die on incremental + write-bitmap-index
To:     David Turner <dturner@twosigma.com>
References: <1482948720-21488-1-git-send-email-dturner@twosigma.com>
 <1482948720-21488-2-git-send-email-dturner@twosigma.com>
Cc:     git@vger.kernel.org, peff@peff.net
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <65a85e09-63ca-48f8-d842-ee8c292d7c2e@kdbg.org>
Date:   Wed, 28 Dec 2016 23:32:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.5.1
MIME-Version: 1.0
In-Reply-To: <1482948720-21488-2-git-send-email-dturner@twosigma.com>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 28.12.2016 um 19:12 schrieb David Turner:
> +static const char incremental_bitmap_conflict_error[] = N_(
> +"Incremental repacks are incompatible with bitmap indexes.  Use \n"

The SP before LF could be removed.

> +"--no-write-bitmap-index or disable the pack.writebitmaps configuration."
> +);

The string is marked for translation here...

> +
> +
>  static int repack_config(const char *var, const char *value, void *cb)
>  {
>  	if (!strcmp(var, "repack.usedeltabaseoffset")) {
> @@ -206,6 +212,9 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
>  	if (pack_kept_objects < 0)
>  		pack_kept_objects = write_bitmaps;
>
> +	if (write_bitmaps && !(pack_everything & ALL_INTO_ONE))
> +		die(incremental_bitmap_conflict_error);

... but then any translations remain unused. This should be

		die(_(incremental_bitmap_conflict_error));

-- Hannes

