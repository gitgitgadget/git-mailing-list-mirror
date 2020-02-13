Return-Path: <SRS0=eUpu=4B=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B41FC352A3
	for <git@archiver.kernel.org>; Thu, 13 Feb 2020 23:14:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB8F72082F
	for <git@archiver.kernel.org>; Thu, 13 Feb 2020 23:14:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mq1qW/d6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727571AbgBMXOc (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Feb 2020 18:14:32 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:35657 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726780AbgBMXOb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Feb 2020 18:14:31 -0500
Received: by mail-pf1-f194.google.com with SMTP id y73so3854166pfg.2
        for <git@vger.kernel.org>; Thu, 13 Feb 2020 15:14:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=YzIhHGJnLJVoKCklzSwASCV0HTK4jTHx5Y6xhKErliA=;
        b=mq1qW/d6Oz80PRC5OYbX2UkqlB6nlcnUMwLgxWLmCZIrFo5IUwFVyQ2hB3zk6ygOPX
         GsUUQBO/H6tHXRvRXya4ueq7y/VSLcLkkFqjOKDvMPsDlsUK2vdc+zsfEA39w8JZfMpS
         063Kpx8Y+XUVT6o3sAPSavwxGg0fIPPwXokSf4rD0ruE7tq6iiiatIoX3bta2xqHevS7
         Wab1QUGOSQGiShaP1LEXE2QFpHv1diFnmfZzucFc8DL4gr29EH+9yz2UDOOgdeowWYop
         nLRONGIH7brJhOwN5dM6qfsEdeO1XxcixZk8YB22GsCnhkk9HjLmSfv2fzRQoM1vxLxZ
         htbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=YzIhHGJnLJVoKCklzSwASCV0HTK4jTHx5Y6xhKErliA=;
        b=FETldNKhP7YX8V+xD2j/AWHIksljHwNvGMo/LJMvgXJIp2WnPRYLUed40j5Ekcx+uA
         lcPYLcSLFZVUzKNvX8R8lOH+rkyrVGRP+EiUERwtAasZZgnMCyuLVyrIshDntzr67vws
         niCDVkT2Bx0Vs+XyGy45Vne3j01kxdc8OZ5hMui7g1AWbCyI3Plwc5nmm2KuxwIWyZj9
         Dn8ZsTL3HGQcLDvKNaWZcgC8cq0dmwI2FZilKZ+XLlTVZN6iNMzpFF/4dEZfinr6qGWE
         V1vVhdLYucSda0m2LevSLgZnP9fwSlQyiQZHeF9zGWL7d0YkC4LV2yNB7f8r0QErqj8X
         Z0qw==
X-Gm-Message-State: APjAAAWOauW6U0ydZKuJOmCVT+/iExuF83UnGXgylHbvo/H7MAokkkJj
        eQzdRQ5MVamruLAFPQfj8bfeHQ==
X-Google-Smtp-Source: APXvYqxQtk3dZOetEVsSp1HUQegTsWHdV7Brn85oB6PpE2smqI3E4lqf3eQW4NPSeuy555LCLezclQ==
X-Received: by 2002:a65:5242:: with SMTP id q2mr313458pgp.74.1581635669422;
        Thu, 13 Feb 2020 15:14:29 -0800 (PST)
Received: from google.com ([2620:15c:2ce:0:231c:11cc:aa0a:6dc5])
        by smtp.gmail.com with ESMTPSA id b24sm4129325pfo.84.2020.02.13.15.14.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2020 15:14:28 -0800 (PST)
Date:   Thu, 13 Feb 2020 15:14:24 -0800
From:   Emily Shaffer <emilyshaffer@google.com>
To:     SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org,
        Martin =?iso-8859-1?Q?=C5gren?= <martin.agren@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v6 09/15] bugreport: generate config safelist based on
 docs
Message-ID: <20200213231424.GJ190927@google.com>
References: <20200206004108.261317-1-emilyshaffer@google.com>
 <20200206004108.261317-10-emilyshaffer@google.com>
 <20200207153042.GI2868@szeder.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200207153042.GI2868@szeder.dev>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 07, 2020 at 04:30:42PM +0100, SZEDER Gábor wrote:
> On Wed, Feb 05, 2020 at 04:41:02PM -0800, Emily Shaffer wrote:
> > diff --git a/Documentation/asciidoctor-extensions.rb b/Documentation/asciidoctor-extensions.rb
> > index d906a00803..382bd8f6f4 100644
> > --- a/Documentation/asciidoctor-extensions.rb
> > +++ b/Documentation/asciidoctor-extensions.rb
> > @@ -37,6 +37,10 @@ module Git
> >            output = output.sub(/<\/refmeta>/, new_tags + "</refmeta>")
> >          end
> >          output
> > +
> > +    class AnnotateProcessor < Asciidoctor::Extensions::InlineMacroProcessor
> > +      def process(parent, target, attrs)
> > +        ""
> 
> This change breaks building the documentation with Asciidoctor v1.5.8:
> 
>   /home/travis/.rvm/rubies/ruby-2.5.3/lib/ruby/site_ruby/2.5.0/rubygems/core_ext/kernel_require.rb:59:in `require': /home/travis/build/git/git/Documentation/asciidoctor-extensions.rb:41: class definition in method body (SyntaxError)
>   
>   ...xtensions::InlineMacroProcessor
>   
>   ...                               ^
>   
>   /home/travis/build/git/git/Documentation/asciidoctor-extensions.rb:53: syntax error, unexpected end-of-input, expecting keyword_end
> 
> 
>   https://travis-ci.org/git/git/jobs/647093871#L1127

Done. It passes locally for me now if I run:

  USE_ASCIIDOCTOR=1 make doc

Thanks for the heads up.

 - Emily
