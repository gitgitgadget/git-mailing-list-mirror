Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ABEFC202A2
	for <e@80x24.org>; Mon, 16 Oct 2017 21:25:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753084AbdJPVZk (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Oct 2017 17:25:40 -0400
Received: from ikke.info ([178.21.113.177]:36374 "EHLO vps892.directvps.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751935AbdJPVZk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Oct 2017 17:25:40 -0400
Received: by vps892.directvps.nl (Postfix, from userid 1008)
        id A3085440392; Mon, 16 Oct 2017 23:25:38 +0200 (CEST)
Date:   Mon, 16 Oct 2017 23:25:38 +0200
From:   Kevin Daudt <me@ikke.info>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org, martin.agren@gmail.com, simon@ruderich.org,
        bturner@atlassian.com, git@jeffhostetler.com, gitster@pobox.com,
        jonathantanmy@google.com, jrnieder@gmail.com, peff@peff.net,
        sbeller@google.com
Subject: Re: [PATCH v4 03/11] protocol: introduce protocol extension
 mechanisms
Message-ID: <20171016212538.GA19335@alpha.vpn.ikke.info>
References: <20171003201507.3589-1-bmwill@google.com>
 <20171016175532.73459-1-bmwill@google.com>
 <20171016175532.73459-4-bmwill@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171016175532.73459-4-bmwill@google.com>
User-Agent: Mutt/1.8.3 (2017-05-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 16, 2017 at 10:55:24AM -0700, Brandon Williams wrote:
> Create protocol.{c,h} and provide functions which future servers and
> clients can use to determine which protocol to use or is being used.
> 
> Also introduce the 'GIT_PROTOCOL' environment variable which will be
> used to communicate a colon separated list of keys with optional values
> to a server.  Unknown keys and values must be tolerated.  This mechanism
> is used to communicate which version of the wire protocol a client would
> like to use with a server.
> 
> Signed-off-by: Brandon Williams <bmwill@google.com>
> ---
>  Documentation/config.txt | 17 +++++++++++
>  Documentation/git.txt    |  6 ++++
>  Makefile                 |  1 +
>  cache.h                  |  8 +++++
>  protocol.c               | 79 ++++++++++++++++++++++++++++++++++++++++++++++++
>  protocol.h               | 33 ++++++++++++++++++++
>  6 files changed, 144 insertions(+)
>  create mode 100644 protocol.c
>  create mode 100644 protocol.h
>
> [...]
> 
> diff --git a/protocol.h b/protocol.h
> new file mode 100644
> index 000000000..1b2bc94a8
> --- /dev/null
> +++ b/protocol.h
> @@ -0,0 +1,33 @@
> +#ifndef PROTOCOL_H
> +#define PROTOCOL_H
> +
> +enum protocol_version {
> +	protocol_unknown_version = -1,
> +	protocol_v0 = 0,
> +	protocol_v1 = 1,
> +};
> +
> +/*
> + * Used by a client to determine which protocol version to request be used when
> + * communicating with a server, reflecting the configured value of the
> + * 'protocol.version' config.  If unconfigured, a value of 'protocol_v0' is
> + * returned.
> + */

The first sentence reads a little weird to me around 'which version to
request be used'. 
