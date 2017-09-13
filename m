Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5445520286
	for <e@80x24.org>; Wed, 13 Sep 2017 18:24:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751153AbdIMSYf (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Sep 2017 14:24:35 -0400
Received: from mail-pg0-f41.google.com ([74.125.83.41]:43402 "EHLO
        mail-pg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751128AbdIMSYe (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Sep 2017 14:24:34 -0400
Received: by mail-pg0-f41.google.com with SMTP id u18so1901309pgo.0
        for <git@vger.kernel.org>; Wed, 13 Sep 2017 11:24:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ETaLrCsfG80ZQ+rsbDhcwHes2IHzO5gittpKqg1ZCCw=;
        b=QmeispiEPnEIta6+XKScA7k681b8H+iynTqMwdH0X5ab9BvBMSn7NvJKwbcOcrtpDc
         zLvrWzj1/NVr77xZcxFSRvDFFfiVmLBsXqLMuQBJd0XNSaZ5eSji25V+GChm6bfuUSnJ
         +7lDplS3XUOuvgTxqJ4odDGDengu6Bob6oSTComC/q1FyFazuBIdaFPazVexZqf9kLCT
         vDGy2cJDC4p/3zhVTSQ57kouagt61WVxEWNuCwx+2Ajzclk9GzyoQpNdbkpYiiZ8XZaJ
         ckg20h81iTDscnoKmuX0TcPNTzHwhAGJv55i1kPYpkdi/stN/EzfxeM0v4j+QfiQHal2
         hB2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ETaLrCsfG80ZQ+rsbDhcwHes2IHzO5gittpKqg1ZCCw=;
        b=dZG20grr3k9ru3l++3tAGCPvvKh1IZoxqJWDAPpzr5woC28SdlGE0Eu0VR+hv1EmSm
         h6naxu3IQVemaBUyBXtkZb32IrRLqW2VSXCvJmc0CHjTAlrCmO/ZHKuu4TmJNeOenAHk
         uQwHTrdSx4bQw+uxjANsMiQsgiLsjgxX8iJLtODQ4AnqoAidrX/+SxBqnj/8pBDIXPVs
         Fl3MVU+lbTydNAO8p4+3OEhc6Df9czXxSkGhuF++tLp1tWWJvZjhOMshdLU2LniAg1IP
         FlrmX27QFZbjzZ7HE0OTcWzJEQqEBQktSoP26u355fkFwuyYdM2HwiZxyW/KqOU3+czT
         +gnA==
X-Gm-Message-State: AHPjjUgC0g13GEn1urNSYT2ruUVsppDdZZRWahWVK/YSph6CfP8H1MOJ
        pQo2XsbtfomYKuY1pCg=
X-Google-Smtp-Source: ADKCNb7VQqnxL4dGt+wFJ+NZiCo/+sbGlv3eToDAfe9JatugHerAUziEAuMwC+F4xVq0CU1+0RzlIQ==
X-Received: by 10.84.218.7 with SMTP id q7mr21770928pli.111.1505327073312;
        Wed, 13 Sep 2017 11:24:33 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:422:d132:98b:3ff1:a635])
        by smtp.gmail.com with ESMTPSA id n19sm27207927pfj.114.2017.09.13.11.24.32
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 13 Sep 2017 11:24:32 -0700 (PDT)
Date:   Wed, 13 Sep 2017 11:24:31 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     demerphq <demerphq@gmail.com>, Git <git@vger.kernel.org>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v2] config: avoid "write_in_full(fd, buf, len) < len"
 pattern
Message-ID: <20170913182431.GE27425@aiede.mtv.corp.google.com>
References: <20170913170807.cyx7rrpoyhaauvol@sigill.intra.peff.net>
 <20170913171104.yu7ags4aq2zdwz6r@sigill.intra.peff.net>
 <20170913181515.p7u2ouine3ysblqc@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170913181515.p7u2ouine3ysblqc@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King wrote:

> What I missed is that copy_begin and copy_end here are actually size_t
> variables, not the pointers. Sorry for the confusion, and here's an
> updated version of the patch with this paragraph amended (the patch
> itself is identical):

Subtle.  The world makes more sense now.  Thanks for figuring it out.

> -- >8 --
> Subject: [PATCH] config: avoid "write_in_full(fd, buf, len) < len" pattern
> 
> The return type of write_in_full() is a signed ssize_t,
> because we may return "-1" on failure (even if we succeeded
> in writing some bytes). But "len" itself is may be an
> unsigned type (the function takes a size_t, but of course we
> may have something else in the calling function). So while
> it seems like:
>
>   if (write_in_full(fd, buf, len) < len)
> 	die_errno("write error");
>
> would trigger on error, it won't if "len" is unsigned.  The
> compiler sees a signed/unsigned comparison and promotes the
> signed value, resulting in (size_t)-1, the highest possible
> size_t (or again, whatever type the caller has). This cannot
> possibly be smaller than "len", and so the conditional can
> never trigger.
>
> I scoured the code base for cases of this, but it turns out
> that these two in git_config_set_multivar_in_file_gently()
> are the only ones. Here our "len" is the difference between
> two size_t variables, making the result an unsigned size_t.
> We can fix this by just checking for a negative return value
> directly, as write_in_full() will never return any value
> except -1 or the full count.
[...]
> Reported-by: demerphq <demerphq@gmail.com>
> Signed-off-by: Jeff King <peff@peff.net>
> ---

For what it's worth,
Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

Thank you.

Compilers' signed/unsigned comparison warning can be noisy, but I'm
starting to feel it's worth the suppression noise to turn it on when
DEVELOPER=1 anyway.  What do you think?  Is there a way to turn it on
selectively for certain functions on the LHS (like read() and write()
style functions)?

Sincerely,
Jonathan
