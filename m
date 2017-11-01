Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 11EE620281
	for <e@80x24.org>; Wed,  1 Nov 2017 11:10:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754550AbdKALKx (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 Nov 2017 07:10:53 -0400
Received: from zucker2.schokokeks.org ([178.63.68.90]:41385 "EHLO
        zucker2.schokokeks.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754547AbdKALKw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Nov 2017 07:10:52 -0400
Received: from localhost ([::1])
  (AUTH: PLAIN simon@ruderich.org, TLS: TLSv1/SSLv3,256bits,ECDHE-RSA-AES256-GCM-SHA384)
  by zucker.schokokeks.org with ESMTPSA; Wed, 01 Nov 2017 12:10:50 +0100
  id 0000000000000057.0000000059F9ABBA.0000782B
Date:   Wed, 1 Nov 2017 12:10:50 +0100
From:   Simon Ruderich <simon@ruderich.org>
To:     =?iso-8859-1?Q?Ren=E9?= Scharfe <l.s.r@web.de>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Ralf Thielow <ralf.thielow@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 1/2] sequencer: factor out rewrite_file()
Message-ID: <20171101110715.e4s7td2weisog4wt@ruderich.org>
References: <6150c80b-cb0e-06d4-63a7-a4f4a9107ab2@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6150c80b-cb0e-06d4-63a7-a4f4a9107ab2@web.de>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 31, 2017 at 10:54:21AM +0100, René Scharfe wrote:
> +static int rewrite_file(const char *path, const char *buf, size_t len)
> +{
> +	int rc = 0;
> +	int fd = open(path, O_WRONLY);
> +	if (fd < 0)
> +		return error_errno(_("could not open '%s' for writing"), path);
> +	if (write_in_full(fd, buf, len) < 0)
> +		rc = error_errno(_("could not write to '%s'"), path);
> +	if (!rc && ftruncate(fd, len) < 0)
> +		rc = error_errno(_("could not truncate '%s'"), path);
> +	close(fd);

We might want to check the return value of close() as some file
systems report write errors only on close. But I'm not sure how
the rest of Git's code-base handles this.

> +	return rc;
> +}

Regards
Simon
-- 
+ privacy is necessary
+ using gnupg http://gnupg.org
+ public key id: 0x92FEFDB7E44C32F9
