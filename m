Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1D2D720984
	for <e@80x24.org>; Tue, 13 Sep 2016 15:22:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758959AbcIMPWK (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Sep 2016 11:22:10 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53285 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1756134AbcIMPWJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Sep 2016 11:22:09 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 720393AD5B;
        Tue, 13 Sep 2016 11:22:07 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=nd4bF5CCBUKmjahRbjaJjAmTr44=; b=fN8ZCE
        t6TSVcM259yxWaA46Ghh3jIMtp20+OtO4srBNDBHa5NgkS4/uJlpsLT+SDCv/hhY
        khzQ82fCZyj3p6H02B2iShE6odpRwf+p3xND4ma3RdVHcnquSxGgCHxFVr3mDGeW
        r+Dy7vo1ScEKWJdAHHFa2Rz5A6BJs9BVrz1Bk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=WTUVVmY54VRi7ao7f4UizHRqho2T4YM0
        CfIv0KL4mKRASrpJm+lufGhQZACG/aTsqd+xeCMTN8oShnerpITCyYAZjUeb93LF
        UNFxsoKnQYH0gHzNj1dJfK5nbgd5EsOpwM+ogWScgD/cQ2y7W7ssDJxnIdTXkY/X
        oNoQeInYYPM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5A2E93AD59;
        Tue, 13 Sep 2016 11:22:07 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id CB4963AD58;
        Tue, 13 Sep 2016 11:22:06 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     larsxschneider@gmail.com
Cc:     git@vger.kernel.org, peff@peff.net, sbeller@google.com,
        Johannes.Schindelin@gmx.de, jnareb@gmail.com, mlbright@gmail.com,
        tboegi@web.de, jacob.keller@gmail.com
Subject: Re: [PATCH v7 10/10] convert: add filter.<driver>.process option
References: <20160908182132.50788-1-larsxschneider@gmail.com>
        <20160908182132.50788-11-larsxschneider@gmail.com>
Date:   Tue, 13 Sep 2016 08:22:04 -0700
In-Reply-To: <20160908182132.50788-11-larsxschneider@gmail.com>
        (larsxschneider@gmail.com's message of "Thu, 8 Sep 2016 20:21:32
        +0200")
Message-ID: <xmqq8tuvx1sz.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D4EB6BD4-79C5-11E6-95CA-51057B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

larsxschneider@gmail.com writes:

> diff --git a/contrib/long-running-filter/example.pl b/contrib/long-running-filter/example.pl
> ...
> +sub packet_read {
> +    my $buffer;
> +    my $bytes_read = read STDIN, $buffer, 4;
> +    if ( $bytes_read == 0 ) {
> +
> +        # EOF - Git stopped talking to us!
> +        exit();
> +...
> +packet_write( "clean=true\n" );
> +packet_write( "smudge=true\n" );
> +packet_flush();
> +
> +while (1) {

These extra SP around the contents inside () pair look unfamiliar
and somewhat strange to me, but as long as they are consistently
done (and I think you are mostly being consistent), it is OK.

> +#define CAP_CLEAN    (1u<<0)
> +#define CAP_SMUDGE   (1u<<1)

As these are meant to be usable together, i.e. bits in a single flag
word, they are of type "unsigned int", which makes perfect sense.

Make sure your variables and fields that store them are of the same
type.  I think I saw "int' used to pass them in at least one place.

> +static int apply_filter(const char *path, const char *src, size_t len,
> +                        int fd, struct strbuf *dst, struct convert_driver *drv,
> +                        const int wanted_capability)
> +{
> +	const char* cmd = NULL;

"const char *cmd = NULL;" of course.

> diff --git a/unpack-trees.c b/unpack-trees.c
> index 11c37fb..f6798f8 100644
> --- a/unpack-trees.c
> +++ b/unpack-trees.c
> @@ -10,6 +10,7 @@
>  #include "attr.h"
>  #include "split-index.h"
>  #include "dir.h"
> +#include "convert.h"
>  
>  /*
>   * Error messages expected by scripts out of plumbing commands such as

Why?  The resulting file seems to compile without this addition.
