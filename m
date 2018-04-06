Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C5EF91F42D
	for <e@80x24.org>; Fri,  6 Apr 2018 16:56:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752168AbeDFQ4T (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Apr 2018 12:56:19 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:48774 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751201AbeDFQ4T (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Apr 2018 12:56:19 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id A95E91F404;
        Fri,  6 Apr 2018 16:56:18 +0000 (UTC)
Date:   Fri, 6 Apr 2018 16:56:18 +0000
From:   Eric Wong <e@80x24.org>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Joseph Mingrone <jrm@ftfl.ca>, garga@FreeBSD.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Ben Caradoc-Davies <ben@transient.nz>, 894997@bugs.debian.org
Subject: Re: [PATCH] git-svn: avoid warning on undef readline()
Message-ID: <20180406165618.GA6367@80x24.org>
References: <86h8oobl36.fsf@phe.ftfl.ca>
 <20180406131514.740-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180406131514.740-1-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> wrote:
> See https://public-inbox.org/git/86h8oobl36.fsf@phe.ftfl.ca/ for the
> original report.

Thanks for taking a look at this.  Also https://bugs.debian.org/894997

> --- a/perl/Git.pm
> +++ b/perl/Git.pm
> @@ -554,7 +554,7 @@ sub get_record {
>  	my ($fh, $rs) = @_;
>  	local $/ = $rs;
>  	my $rec = <$fh>;
> -	chomp $rec if defined $rs;
> +	chomp $rec if defined $rs and defined $rec;

I'm struggling to understand the reason for the "defined $rs"
check.  I think it was a braino on my part and meant to use:

	chomp $rec if defined $rec;
