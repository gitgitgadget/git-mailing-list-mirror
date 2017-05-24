Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 21A7820281
	for <e@80x24.org>; Wed, 24 May 2017 04:13:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S938058AbdEXENh (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 May 2017 00:13:37 -0400
Received: from mout.web.de ([212.227.15.3]:58631 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S938053AbdEXENg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 May 2017 00:13:36 -0400
Received: from [192.168.88.106] ([194.47.243.242]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LqXBp-1dqrMa1BtR-00e27t; Wed, 24
 May 2017 06:13:33 +0200
Subject: Re: [PATCH v6 6/6] clean: teach clean -d to preserve ignored paths
To:     Samuel Lijin <sxlijin@gmail.com>, git@vger.kernel.org
References: <20170523100937.8752-1-sxlijin@gmail.com>
 <20170523100937.8752-7-sxlijin@gmail.com>
From:   =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Message-ID: <517a9182-0366-d51a-b7e5-f9085df5b4f9@web.de>
Date:   Wed, 24 May 2017 06:14:44 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:52.0)
 Gecko/20100101 Thunderbird/52.1.1
MIME-Version: 1.0
In-Reply-To: <20170523100937.8752-7-sxlijin@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:OG9SKRLOqG7wO7G59CmsbFVjUn9k2i46Ln2webA8Pd0RJyxYaBX
 TOKUGRemuHp3ScCU6nhoHaa778AneEK4vA47mC+x1PKOmsh0P6yLZGvIDh9QGoTAWZqKqGV
 kUqo+n4ePMrftEiqgyCDedcPG1quMqT8MMUTB2Hx8241x9stiKZjQi5NPxQUVI6KFDl2abN
 qzZQ8ocqQRK7XqqJ94FRQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:71wmfu34Xw4=:SpiivMUbVmKntUY/jl9liO
 WW3K7O+U6lfIXkHZqBmwEipEUv505ongJYnf94+HslRmWBcaMJgEc0umpNmFdfJHco3u3y6CA
 S05SUKBZ8mcDFCT5lzX4NhEF4mhvr5jnAqTYB1uzAMhGZDTZ0FdLjBUrDzOSrZAgrQTyOkctc
 SqgsJP/7OCfFLr+0JSxTbokOiiPJEuK3Tdviqx97OYfVdHRcPItHglCNmT9krx7jSbuQdpAhv
 qsuyzN+B+7fQf/COUf2+MDuJOsBUXvuGOdvYzYOXnhcek8f9qqOJERXFiQWDT0WJGDfLYizgE
 2Daod0WkcL6cbcVj1VRvRAAzGMx8+9LQAL1IXjO693M4q3YwgSBi/UPnlCUTA+XyDTflB6W3s
 E5EU6X/HQqlPagtFcASmNjuRyRg5F6+NKJu0bEoZ8GUgwsorvM+2skFjF63AxERzmQmA8zczf
 rYXlF3T4MVBtBiW/lsFXl78y8fmCv+kj71Gj0hhce6f7lXrIaVmKChS9Giwzp1e830KFCUG7T
 gqhjnmcEr5EE98HqkiSnIAy3CmhLFki2DYRdDW0jh5hsHNnJSWAQ4/zGPwngZ8puLTPTH4JR3
 acVYX4FLaOUu5hDcDU0dPAM8LLgeUtn3IBKJJGhcflx5ksUhC8ywlUBqF2g8BxyBxiJm+A7ZQ
 M44m6ODZusgMKA6Rzn1Ns1sZ6/4+n1uUJe/CwUnbRmMPmHu/JWWstBFSW9qDih6KC+xPJDyVj
 Wl7s5cXvzCzoP1hv1yDoVmxUy/wWef9hCbVINa3xb3Mt0CAEf/8lX1bxlgM6L4bmd3pRc64s5
 7Ekxupn
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> diff --git a/builtin/clean.c b/builtin/clean.c
> index d861f836a..937eb17b6 100644
> --- a/builtin/clean.c
> +++ b/builtin/clean.c
> @@ -857,6 +857,38 @@ static void interactive_main_loop(void)
>   	}
>   }
>   
> +static void correct_untracked_entries(struct dir_struct *dir)
> +{
> +	int src, dst, ign;
> +
> +	for (src = dst = ign = 0; src < dir->nr; src++) {
> +		/* skip paths in ignored[] that cannot be inside entries[src] */
> +		while (ign < dir->ignored_nr &&
> +		       0 <= cmp_dir_entry(&dir->entries[src], &dir->ignored[ign]))
> +			ign++;
> +
> +		if (ign < dir->ignored_nr &&
> +		    check_dir_entry_contains(dir->entries[src], dir->ignored[ign])) {
> +			/* entries[src] contains an ignored path, so we drop it */
> +			free(dir->entries[src]);
> +		} else {
> +			struct dir_entry *ent = dir->entries[src++];
> +
> +			/* entries[src] does not contain an ignored path, so we keep it */
> +			dir->entries[dst++] = ent;
> +
> +			/* then discard paths in entries[] contained inside entries[src] */
> +			while (src < dir->nr &&
> +			       check_dir_entry_contains(ent, dir->entries[src]))
> +				free(dir->entries[src++]);
> +
> +			/* compensate for the outer loop's loop control */
> +			src--;
> +		}
> +	}
> +	dir->nr = dst;
> +}
> +

Looking what the function does, would
drop_or_keep_untracked_entries()
make more sense ?


