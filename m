Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8368A20960
	for <e@80x24.org>; Thu, 13 Apr 2017 18:10:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753550AbdDMSKf (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Apr 2017 14:10:35 -0400
Received: from mail-pg0-f53.google.com ([74.125.83.53]:35149 "EHLO
        mail-pg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752153AbdDMSKe (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Apr 2017 14:10:34 -0400
Received: by mail-pg0-f53.google.com with SMTP id 72so25514447pge.2
        for <git@vger.kernel.org>; Thu, 13 Apr 2017 11:10:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=AMoKJzZD7ZIGjY27mU11RQQIBw8Hr4d7sti6lfCbQUo=;
        b=GO2ccV0RVLHKRLOKsJtHqcf+lfoTtNun7KvvOTpOR19O0AVQ1w+CGRfToogqKVV3rE
         ubL7YYxUb1EHBL258EiEOAXl4Ep6pXU2+0RAGEoux+EMzbWAkrkNTVjUdldDbZV55aik
         nhraxbDhv55R1dloCGXAq7bkNyWbKHJALR6ELfq4M3N+ZBuuf80PSUcnk1HR43hRziMH
         XWK/7tVJQJo0ZQZCspjcXjiGXy7uaybZ5/UFJsh2lrrO1J0PZ5jwWNGT1IelllR6HmYZ
         dvs5czUtcdKWuqI9sBT98YdDI2HUTmW7PFDAEcJRdQFV2rdO4auMz0KvUuzQRLAt8+lB
         xFKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=AMoKJzZD7ZIGjY27mU11RQQIBw8Hr4d7sti6lfCbQUo=;
        b=ZFL5Pv38s5XLih4j1vOGvWwAaLxDkus/WeYro9TuzulA9JaD4XRZmNjN5kMSvgs9O3
         tUvB+09invhrs7Jx5X4l8SUyelfaL92D7fCXnJzMacoByvNlhxXwH1oXvJDleZv0Y2sB
         UUJkw7CF7VBUrMyXz5YYgERRWP5f9WP0CGPLJMpBvfvpiLiMhGJC70F86YpBUJuJWXab
         Y1Q6SVzt7cCCWg3kW7eAbyuQyjvuTgiKQy2qSdhB0hgwpNgsLoBnndx6GBwmx1+dD9qR
         WU12z6i/u/h9zkhk6BqS3Q3DZTHzGnU5asR7CR5C7j7h4uIqUucdnCV4ZEVl600taCZj
         uvmQ==
X-Gm-Message-State: AN3rC/7D0r3iubvbL1r/uW3Ag1J+WXpeBV9/4uv+Pl5n1eyap7SXQD8E
        g86jsamIiE3KlVBo
X-Received: by 10.99.107.72 with SMTP id g69mr4253802pgc.149.1492107033154;
        Thu, 13 Apr 2017 11:10:33 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b10:1426:66e2:260b:9db9])
        by smtp.gmail.com with ESMTPSA id s21sm44033130pgg.65.2017.04.13.11.10.31
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 13 Apr 2017 11:10:32 -0700 (PDT)
Date:   Thu, 13 Apr 2017 11:10:31 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Jacob Keller <jacob.e.keller@intel.com>
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>,
        Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH v2 2/2] ls-files: fix path used when recursing into
 submodules
Message-ID: <20170413181031.GB96917@google.com>
References: <CA+P7+xqE-SZ5D6pk6-Dx+-VzHijmgmrUR2F=-370Rh8oKr10Nw@mail.gmail.com>
 <20170413171224.3537-1-jacob.e.keller@intel.com>
 <20170413171224.3537-2-jacob.e.keller@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170413171224.3537-2-jacob.e.keller@intel.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 04/13, Jacob Keller wrote:
> From: Jacob Keller <jacob.keller@gmail.com>
> 
> Don't assume that the current working directory is the root of the
> repository. Correctly generate the path for the recursing child
> processes by building it from the work_tree() root instead. Otherwise if
> we run ls-files using --git-dir or --work-tree it will not work
> correctly as it attempts to change directory into a potentially invalid
> location. Best case, it doesn't exist and we produce an error. Worst
> case we cd into the wrong location and unknown behavior occurs.
> 
> Add a new test which highlights this possibility.
> 
> Signed-off-by: Jacob Keller <jacob.keller@gmail.com>
> ---
> I'm not sure that I'm convinced by this method of solving the problem as
> I suspect it has some corner cases (what about when run inside a
> subdirectory? It seems to work for me but I'm not sure...) Additionally,
> it felt weird that there's no helper function for creating a toplevel
> relative path.

I never considered the case where you use --git-dir or --work-tree,
definitely an oversight on my part.  This change seems reasonable to me.

-- 
Brandon Williams
