Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A6A4E1F404
	for <e@80x24.org>; Tue, 14 Aug 2018 19:31:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730075AbeHNWTw (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Aug 2018 18:19:52 -0400
Received: from mout.web.de ([212.227.17.12]:45329 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728722AbeHNWTw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Aug 2018 18:19:52 -0400
Received: from [192.168.178.36] ([91.20.56.63]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MOAjQ-1fmNEt2MS4-005ZdP; Tue, 14
 Aug 2018 21:30:59 +0200
Subject: Re: [PATCH 3/4] cat-file: use a single strbuf for all output
To:     Jeff King <peff@peff.net>, Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
References: <20180814181358.GA26391@sigill.intra.peff.net>
 <20180814182022.GC26919@sigill.intra.peff.net>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <567deabf-cdd3-c4e3-bb6a-b593c1f87c6e@web.de>
Date:   Tue, 14 Aug 2018 21:30:57 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20180814182022.GC26919@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:fszE5QTK1lCjdzIW1QvrOZD15C+XzZBrQPfReuD4H0fILFIDnbF
 Q0REdFU3yU0cOZT0OhfvAbvMulJiVU6xwAi9j7KgDPk/gNX1yULaIMW8MFXGjb9pPQ+qJZN
 L1tXG83RYBdkl8BZJCVDtKPF6KlzlSf6fuRCuwoSvZN/j/YKK8gmYyW3hexHBnt9DRb1vT7
 bcIc6OGeIr9RA//7KDORQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:gyRXcPFz6LU=:bp+CgASpK2uRlXpy0nIRmX
 d+j5U83xAHgUIdXT+01CuJ67Rx/cOhqAWz6uU91XskuTV06Z0qY+Lj8ePy9/Y+3ih0Z5+Ccr/
 QlcNGh1LcQhVPsIqZUcpwSxraWudQ4CAJAzYEKMo32N65WHsop+lPuWqi0jiD6aQw6iJ0v/pg
 nCrpEjPIfixe31R1Is0Cg6tgBOV5G3kH0WNtSFNLp17C7C82JB7fpkWVEHnbnmklwTCxDnu4h
 +gTcmv0pvK3YdHj6k4vsRsthEdv2B0HIgbtG/vilTl1lyMVWgflwJG7qmNhbtlG4UdBG+ROH2
 L+Wkyg1EFteK7jSj7wsaqWWTMQ4zqL12WDLSJMvB8RL+8MlFGq6c7VqA6Zs3o4pcyijCEpLlB
 kiUKddLd24Ggg2G8y4Qi5EhP5/01iE+2WIHnOmE6FHu5u7b+JYcvonvfydRh98MFOE8ri5pFr
 PBYcnsxCXp6KO6c+IRlekz3Ky1+zJcanC0N5k14y1x5SRSa9eu720wYMPCK7IRbCQaOSxpH+5
 nKqFMYuea4jmjVV3anI1OI3ZUiu0vtdZ2rFSLvEKEW1x+xjZp8C+7ZGYC7bcke/B5Wb1BOGJG
 BNOXM6gYBSZB4Ol2pksC6y9c0T3rcbdDvVi65Zb1t2kr3gU61XoyX4BB42ZbybgI1fIz3Wsey
 HbB/MQTBPVuWm2tsxYCzyeL13/dmGCzUaYAOWoONBRDQZDjxEaFh+0KW/SF0OBAOOILAMg9iZ
 aIWNU6WqvEPL+iW5e8e9E1ISQLp15gLUgiRj6qaGoytPx1Iyom390lmdcvaiUP3FA4WEa73WG
 MoRr87a
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 14.08.2018 um 20:20 schrieb Jeff King:
> When we're in batch mode, we end up in batch_object_write()
> for each object, which allocates its own strbuf for each
> call. Instead, we can provide a single "scratch" buffer that
> gets reused for each output. When running:
> 
>   git cat-file --batch-all-objects --batch-check='%(objectname)'
> 
> on git.git, my best-of-five time drops from:
> 
>   real	0m0.171s
>   user	0m0.159s
>   sys	0m0.012s
> 
> to:
> 
>   real	0m0.133s
>   user	0m0.121s
>   sys	0m0.012s
> 
> Note that we could do this just by putting the "scratch"
> pointer into "struct expand_data", but I chose instead to
> add an extra parameter to the callstack. That's more
> verbose, but it makes it a bit more obvious what is going
> on, which in turn makes it easy to see where we need to be
> releasing the string in the caller (right after the loop
> which uses it in each case).
> 
> Based-on-a-patch-by: René Scharfe <l.s.r@web.de>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> It also made it easy to see that without the prior patch,
> we'd have been using "buf" for two parameters. :)

Good catch.

> 
>  builtin/cat-file.c | 28 +++++++++++++++++-----------
>  1 file changed, 17 insertions(+), 11 deletions(-)
> 
> diff --git a/builtin/cat-file.c b/builtin/cat-file.c
> index 3ed1d0be80..08dced2614 100644
> --- a/builtin/cat-file.c
> +++ b/builtin/cat-file.c
> @@ -338,11 +338,11 @@ static void print_object_or_die(struct batch_options *opt, struct expand_data *d
>  	}
>  }
>  
> -static void batch_object_write(const char *obj_name, struct batch_options *opt,
> +static void batch_object_write(const char *obj_name,
> +			       struct strbuf *scratch,
> +			       struct batch_options *opt,
>  			       struct expand_data *data)
>  {
> -	struct strbuf buf = STRBUF_INIT;

We could also avoid passing that buffer around by making it static.  I
shy away from adding static variables because the resulting code won't
be thread-safe, but that fear might be irrational, especially with
cat-file.

> -
>  	if (!data->skip_object_info &&
>  	    oid_object_info_extended(the_repository, &data->oid, &data->info,
>  				     OBJECT_INFO_LOOKUP_REPLACE) < 0) {
> @@ -352,10 +352,10 @@ static void batch_object_write(const char *obj_name, struct batch_options *opt,
>  		return;
>  	}
>  
> -	strbuf_expand(&buf, opt->format, expand_format, data);
> -	strbuf_addch(&buf, '\n');
> -	batch_write(opt, buf.buf, buf.len);
> -	strbuf_release(&buf);
> +	strbuf_reset(scratch);
> +	strbuf_expand(scratch, opt->format, expand_format, data);
> +	strbuf_addch(scratch, '\n');
> +	batch_write(opt, scratch->buf, scratch->len);
>  
>  	if (opt->print_contents) {
>  		print_object_or_die(opt, data);
> @@ -363,7 +363,9 @@ static void batch_object_write(const char *obj_name, struct batch_options *opt,
>  	}
>  }
>  
> -static void batch_one_object(const char *obj_name, struct batch_options *opt,
> +static void batch_one_object(const char *obj_name,
> +			     struct strbuf *scratch,
> +			     struct batch_options *opt,
>  			     struct expand_data *data)
>  {
>  	struct object_context ctx;
> @@ -405,20 +407,21 @@ static void batch_one_object(const char *obj_name, struct batch_options *opt,
>  		return;
>  	}
>  
> -	batch_object_write(obj_name, opt, data);
> +	batch_object_write(obj_name, scratch, opt, data);
>  }
>  
>  struct object_cb_data {
>  	struct batch_options *opt;
>  	struct expand_data *expand;
>  	struct oidset *seen;
> +	struct strbuf *scratch;
>  };
>  
>  static int batch_object_cb(const struct object_id *oid, void *vdata)
>  {
>  	struct object_cb_data *data = vdata;
>  	oidcpy(&data->expand->oid, oid);
> -	batch_object_write(NULL, data->opt, data->expand);
> +	batch_object_write(NULL, data->scratch, data->opt, data->expand);
>  	return 0;
>  }
>  
> @@ -509,6 +512,7 @@ static int batch_objects(struct batch_options *opt)
>  
>  		cb.opt = opt;
>  		cb.expand = &data;
> +		cb.scratch = &output;
>  
>  		if (opt->unordered) {
>  			struct oidset seen = OIDSET_INIT;
> @@ -531,6 +535,7 @@ static int batch_objects(struct batch_options *opt)
>  			oid_array_clear(&sa);
>  		}
>  
> +		strbuf_release(&output);
>  		return 0;
>  	}
>  
> @@ -559,10 +564,11 @@ static int batch_objects(struct batch_options *opt)
>  			data.rest = p;
>  		}
>  
> -		batch_one_object(input.buf, opt, &data);
> +		batch_one_object(input.buf, &output, opt, &data);
>  	}
>  
>  	strbuf_release(&input);
> +	strbuf_release(&output);
>  	warn_on_object_refname_ambiguity = save_warning;
>  	return retval;
>  }
> 
