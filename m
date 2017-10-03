Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 07AA12036B
	for <e@80x24.org>; Tue,  3 Oct 2017 23:37:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751266AbdJCXhK (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Oct 2017 19:37:10 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:37925 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750865AbdJCXhK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Oct 2017 19:37:10 -0400
Received: by mail-pf0-f196.google.com with SMTP id a7so10607262pfj.5
        for <git@vger.kernel.org>; Tue, 03 Oct 2017 16:37:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7vp29EtogbE2/GozNzczfqGR/aghFPl6lZo2A5zAzpM=;
        b=pInttvjn8sHwvNKLSL5Hl6ooK3HrDDSG4QkryC/lYDs4RI8yNKVddi4auHRpDy4/1H
         MD5JzJ6B7W+vNok4XWhoW5g+4jXZ1lW/5qjD6x0VVfMyOCggjQyyIY2u/GTXtf1XqOoj
         RmnT4e0mdEyFaoP83fFnSyKlcuGdaSH5vrKdAifmhad/HPXdNTlK3sd9c6xyxhJu98Az
         7sR8PKMeTqlnLj00h8kJ0402Qf91O3jEbihqcWQFvvRrHkW95bpWqHVHw+Y3xssdhEyz
         F8Jjiko9Xkh230hUgGYJPUaLINrRowj67+x8gAG6t34RmPrJeT1ItWkS3wyod7IFHJ9T
         KjyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7vp29EtogbE2/GozNzczfqGR/aghFPl6lZo2A5zAzpM=;
        b=YOVxdwzVG1rm0N8iJKQRZ2Xh8L5slrLE87KVDAfGUihY5XgA2u57NdmXYtKbGtu3I2
         lwtg0oKhZhfLv5kv800cDZFu86zSAxLK1yApyHenASxDtkXnVyyRo3IciQDMQYIqFbBm
         w308IU+wLnml179PH1RPVzZRODtg840J+A7sz3KULQjCgcoqHMQbX+NfN6g2CuBWCNb8
         cR4W0JIs+MBo25Rp8Pjws36IJrgLQbmdgu6/pWrK2nnRxeFkKuVpLWPxIHlkG907XsrK
         LpDFHcmbK8JprEdojbXOVFLxUScMzl9/fmYLRod53n0qKJvNXI+kJNvVS3+IByMSalSo
         7EUw==
X-Gm-Message-State: AHPjjUgCwUszyB9P4nnw0UOsOztsqbY++cZi3dbIhdVqaC/JuCSKQpnh
        p5/1IDCiaZF6OSh1OQWKOmM=
X-Google-Smtp-Source: AOwi7QDi4LrtepCuKH/7J8nl4g+dDoshXEWZTBC8p0gcUSKUFsNyV/F/pMkj76X3vB5EQs4rffzfnw==
X-Received: by 10.101.82.8 with SMTP id o8mr16466118pgp.261.1507073829092;
        Tue, 03 Oct 2017 16:37:09 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:422:3463:ab6b:5863:927c])
        by smtp.gmail.com with ESMTPSA id s68sm24921005pfd.72.2017.10.03.16.37.08
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 03 Oct 2017 16:37:08 -0700 (PDT)
Date:   Tue, 3 Oct 2017 16:37:06 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Thomas Gummerer <t.gummerer@gmail.com>, git@vger.kernel.org,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/3] path.c: fix uninitialized memory access
Message-ID: <20171003233706.GH19555@aiede.mtv.corp.google.com>
References: <20171003195713.13395-1-t.gummerer@gmail.com>
 <20171003195713.13395-2-t.gummerer@gmail.com>
 <20171003224501.GD19555@aiede.mtv.corp.google.com>
 <20171003233040.2ws6kny3e4kypfub@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171003233040.2ws6kny3e4kypfub@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King wrote:
> On Tue, Oct 03, 2017 at 03:45:01PM -0700, Jonathan Nieder wrote:

>> In other words, an alternative fix would be
>> 
>> 	if (*path == '.' && path[1] == '/') {
>> 		...
>> 	}
>> 
>> which would not require passing in 'len' or switching to index-based
>> arithmetic.  I think I prefer it.  What do you think?
>
> Yes, I think that approach is much nicer. I think you could even use
> skip_prefix. Unfortunately you have to play a few games with const-ness,
> but I think the resulting signature for cleanup_path() is an
> improvement:

Ooh!

For what it's worth, if you add a commit message with Thomas's
Reported-by then this lgtm.

Thanks,
Jonathan

> diff --git a/path.c b/path.c
> index 00ec04e7a5..2e09a7bce0 100644
> --- a/path.c
> +++ b/path.c
> @@ -34,11 +34,10 @@ static struct strbuf *get_pathname(void)
>  	return sb;
>  }
>  
> -static char *cleanup_path(char *path)
> +static const char *cleanup_path(const char *path)
>  {
>  	/* Clean it up */
> -	if (!memcmp(path, "./", 2)) {
> -		path += 2;
> +	if (skip_prefix(path, "./", &path)) {
>  		while (*path == '/')
>  			path++;
>  	}
> @@ -47,7 +46,7 @@ static char *cleanup_path(char *path)
>  
>  static void strbuf_cleanup_path(struct strbuf *sb)
>  {
> -	char *path = cleanup_path(sb->buf);
> +	const char *path = cleanup_path(sb->buf);
>  	if (path > sb->buf)
>  		strbuf_remove(sb, 0, path - sb->buf);
>  }
> @@ -64,7 +63,7 @@ char *mksnpath(char *buf, size_t n, const char *fmt, ...)
>  		strlcpy(buf, bad_path, n);
>  		return buf;
>  	}
> -	return cleanup_path(buf);
> +	return (char *)cleanup_path(buf);
>  }
>  
>  static int dir_prefix(const char *buf, const char *dir)
