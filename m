Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79294EB64D7
	for <git@archiver.kernel.org>; Fri, 16 Jun 2023 23:04:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232422AbjFPXEn (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Jun 2023 19:04:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229950AbjFPXEm (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Jun 2023 19:04:42 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAFED3A8B
        for <git@vger.kernel.org>; Fri, 16 Jun 2023 16:04:40 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id ffacd0b85a97d-307d20548adso927176f8f.0
        for <git@vger.kernel.org>; Fri, 16 Jun 2023 16:04:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686956679; x=1689548679;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AAy15H1NAb3zE4nf1v0bBJDkVfimvNUZizit8CxcBo0=;
        b=MR1uWpjpMG1ZTSsF3+/D4apEg3FeDJhYPgTcJzJbHOv8Cs/IBkDAa2kukqQM0na2TT
         75XP+2eJLATzg51O1mQs7lD7h+MYKguN9R3sLqTzRNfVQUgiLIn3VV0vwb24eu6DJGzW
         X/TCB0cQqxzLP1p4pHaVSnwPDGeSFc42jU9cc6gBcPLELebZVYKXwnzqPpPq9PJ8t+W8
         POWZxitJ0LkrvbDmri//XqCNGVbUNP77xiJPRjoFjV7e0Zg05HPOwfy3lQw545ouAZS9
         XfgKAeMBzyTD1ofacy3c8Vy83PBr802G3S73/u56cHXvSk5pKVNkqT+fimVpIWfwjSGd
         T5TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686956679; x=1689548679;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AAy15H1NAb3zE4nf1v0bBJDkVfimvNUZizit8CxcBo0=;
        b=E7GRltf1jBTpg4ZSWPvUCEZYWbo9f4NXkQHse8fW2nMbhdp4nnKMxV8eQ09fmuBPKa
         4RTOQ6Z2cDVaPXVgc06GmxlCBC6Oiztrfmr+Wnqn/R73a2kWI6U0RZTPYKnep16C7iFc
         XT+F4UiqGpEKyFYGL9zxlp+nkx4zedVeg1MuLiJyIgRLrZkZvAF0gri4Kxp8Q11GvMxW
         tF/bBdWGdUOwlIe1i05w+LxAnbTAOhRwe5pPmBa5+vtgozY3EEBdN/TFoOsVLolG3L1Q
         Lf+krVXYa6ATawXYTKjY3m2HS33nO0iMTKnXXmj7mbKvhfYXl5Wj0Tc2fd3/Ok2uyPch
         FyYQ==
X-Gm-Message-State: AC+VfDxEw7uXXnCa4Q/dfLBfhO3m39IEuTMAJ4BO7JXohqpbVG9C/7Gt
        B2CkcMv3+uMSLCPd2FF8wxUMXBTLwdo=
X-Google-Smtp-Source: ACHHUZ5wBqtC7lXzouoQMevMgU8Wo02AjAYQE7qAGy+FIaIlJRYh3V+AcgtwlLCjbSkA6TI+EN+pgA==
X-Received: by 2002:a5d:5444:0:b0:30f:c7da:57e1 with SMTP id w4-20020a5d5444000000b0030fc7da57e1mr2394853wrv.34.1686956679241;
        Fri, 16 Jun 2023 16:04:39 -0700 (PDT)
Received: from [192.168.2.52] (151.red-88-14-53.dynamicip.rima-tde.net. [88.14.53.151])
        by smtp.gmail.com with ESMTPSA id i4-20020a5d5584000000b0030fc576633dsm14046356wrv.16.2023.06.16.16.04.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Jun 2023 16:04:38 -0700 (PDT)
Subject: Re: [PATCH 10/11] config: fix a leak in
 git_config_copy_or_rename_section_in_file
To:     Jeff King <peff@peff.net>
Cc:     Git List <git@vger.kernel.org>
References: <9eb931e7-dd18-8ce8-4d4a-cf3d85066189@gmail.com>
 <3ee93720-dce0-8f90-68bf-0242e5731a36@gmail.com>
 <20230612040518.GJ306352@coredump.intra.peff.net>
From:   =?UTF-8?Q?Rub=c3=a9n_Justo?= <rjusto@gmail.com>
Message-ID: <21325f3e-a502-fdb6-1c67-500bce47e920@gmail.com>
Date:   Sat, 17 Jun 2023 01:04:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20230612040518.GJ306352@coredump.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12-jun-2023 00:05:18, Jeff King wrote:
> On Sun, Jun 11, 2023 at 08:50:45PM +0200, Rubén Justo wrote:
> 
> > diff --git a/config.c b/config.c
> > index 39a7d7422c..207e4394a3 100644
> > --- a/config.c
> > +++ b/config.c
> > @@ -3833,6 +3833,7 @@ static int git_config_copy_or_rename_section_in_file(const char *config_filename
> >  						output[0] = '\t';
> >  					}
> >  				} else {
> > +					strbuf_release(&copystr);
> >  					copystr = store_create_section(new_name, &store);
> >  				}
> >  			}
> 
> Wow, I did a double-take on this code. It is uncommon in our codebase to
> assign a struct by value in a function return like this, and doubly
> weird to assign a strbuf (since the whole point of strbuf is to use the
> opaque functions to make sure we aren't overwriting existing allocations
> or aliasing pointers).
> 
> I think your fix here is the correct thing if we aren't going to clean
> up the code further.
> 
> The more usual thing for our codebase would be refactoring like:
> 
> diff --git a/config.c b/config.c
> index b79baf83e3..f5a7cced7c 100644
> --- a/config.c
> +++ b/config.c
> @@ -3140,37 +3140,36 @@ static int write_error(const char *filename)
>  	return 4;
>  }
>  
> -static struct strbuf store_create_section(const char *key,
> -					  const struct config_store_data *store)
> +static void store_create_section(const char *key,
> +				 const struct config_store_data *store,
> +				 struct strbuf *sb)
>  {
>  	const char *dot;
>  	size_t i;
> -	struct strbuf sb = STRBUF_INIT;
>  
>  	dot = memchr(key, '.', store->baselen);
>  	if (dot) {
> -		strbuf_addf(&sb, "[%.*s \"", (int)(dot - key), key);
> +		strbuf_addf(sb, "[%.*s \"", (int)(dot - key), key);
>  		for (i = dot - key + 1; i < store->baselen; i++) {
>  			if (key[i] == '"' || key[i] == '\\')
> -				strbuf_addch(&sb, '\\');
> -			strbuf_addch(&sb, key[i]);
> +				strbuf_addch(sb, '\\');
> +			strbuf_addch(sb, key[i]);
>  		}
> -		strbuf_addstr(&sb, "\"]\n");
> +		strbuf_addstr(sb, "\"]\n");
>  	} else {
> -		strbuf_addch(&sb, '[');
> -		strbuf_add(&sb, key, store->baselen);
> -		strbuf_addstr(&sb, "]\n");
> +		strbuf_addch(sb, '[');
> +		strbuf_add(sb, key, store->baselen);
> +		strbuf_addstr(sb, "]\n");
>  	}
> -
> -	return sb;
>  }
>  
>  static ssize_t write_section(int fd, const char *key,
>  			     const struct config_store_data *store)
>  {
> -	struct strbuf sb = store_create_section(key, store);
> +	struct strbuf sb = STRBUF_INIT;
>  	ssize_t ret;
>  
> +	store_create_section(key, store, &sb);
>  	ret = write_in_full(fd, sb.buf, sb.len);
>  	strbuf_release(&sb);
>  
> @@ -3833,7 +3832,9 @@ static int git_config_copy_or_rename_section_in_file(const char *config_filename
>  						output[0] = '\t';
>  					}
>  				} else {
> -					copystr = store_create_section(new_name, &store);
> +					strbuf_reset(&copystr);
> +					store_create_section(new_name, &store,
> +							     &copystr);
>  				}
>  			}
>  			remove = 0;

I have a draft with the exact same change.  I chose the simple fix,
though.  I wasn't expecting your review :)

I'll definitely re-roll with this.

Thanks!
