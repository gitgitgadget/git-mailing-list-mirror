Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 279EE20966
	for <e@80x24.org>; Fri, 31 Mar 2017 04:21:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750975AbdCaEVd (ORCPT <rfc822;e@80x24.org>);
        Fri, 31 Mar 2017 00:21:33 -0400
Received: from mout.web.de ([217.72.192.78]:61809 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750929AbdCaEVc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Mar 2017 00:21:32 -0400
Received: from [192.168.88.106] ([194.47.243.242]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LwYnz-1c4C1n0KmF-018GpW; Fri, 31
 Mar 2017 06:21:20 +0200
Subject: Re: [PATCH] http.postbuffer: make a size_t
To:     David Turner <dturner@twosigma.com>, git@vger.kernel.org
References: <20170330202917.24281-1-dturner@twosigma.com>
From:   =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Message-ID: <d312abfe-f87d-3940-ecfa-348fed7ad3a1@web.de>
Date:   Fri, 31 Mar 2017 06:22:13 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:45.0)
 Gecko/20100101 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <20170330202917.24281-1-dturner@twosigma.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:lQS/Gwf8wlEbDj1NGLTjyWwfAcJoukS/m46dA9BXRwQOcal2J44
 FUbS65W4503/De/rwZTmbe0CnUVYZ8SN2MEvKEm9ono6Hx6d+mp9uPyC8xi2eascyGVZI2b
 FQMF+NaSQNdK8f6UusGzmna2vKeXevMlEn/YDwJLKrsvG82J/wR9+axjT5f8q41xkUfXk+w
 pWlPn2f42GiWirhEh3Cig==
X-UI-Out-Filterresults: notjunk:1;V01:K0:O6Psxh3VVe4=:Dv5bJICXYgwLSC6AaGz2e5
 D44SctojPyLtso9OV0Cg1MUmmUluBYzn/grCGgf9fg+Sd+paJWggSviNc7H59wmP6Zgm6c5Ix
 yfJ4yEGOwMpTQWc1mc4CtgchV4jT2djD4bBIQ1rtZh/uAAQJu7HTzwgr59zuyWZBxv9kVIQu6
 MLsZG9rnspAFQWx53oY1n24P+2qbVsMytRPJVrzCvtPHkw0ZPi/k+W3ogSAF8rYfloyX8DuJC
 U8sY+sxo5paOXG1K22AxLC53C98M/wLjhG59/itIeAiN3peThHDtgz4Gnj+5g5tekTuKfWv1Z
 6Nil4hEQpKU+XhRMbhcwe7S+yJ+UX9LsWCjO8O4pbl4y1coEy2/9doEYXqZ4yYTlQiuF4sbM1
 BbTBr18lLI43MGBKRULad32p1vfIxF00N8191RdDUC4c9QgdDQdpBd6yIQgjII27U1Ua6kYqf
 5iDQQugFjmZV/VPmB++Mzji8JOpfE4Rb3c2neDVLvaRvseIHFyR7HOyQQpkRQPGRe65++BVS4
 +oMhwIpKytAwnVV8VxAzsqAm9NqXxymp5e4E6B3/coCZRh0dOCcSGWvpipEr8ufknix/zSxSX
 wmxLKUrqGY5vU83raburcIIRud+U7R5mDEYG6EfmmF3hm1xi/WYBQNBks1arrFjx5sMGqF4ih
 Mnp7KjK3H5j3bZRsUCVTDk1eHrurK7HvyurhfDrAFyNXw5WyZevE/pj3RgFrkpGqmNamz2IGT
 G4IMN7WNTu1/u79wXoZmHbU8smazxG5609AidTvKuu4KEKAMVUVA9G+BYC6rvwzS7mYbTnscg
 YNtNeP6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 30/03/17 22:29, David Turner wrote:
> Unfortunately, in order to push some large repos, the http postbuffer
> must sometimes exceed two gigabytes.  On a 64-bit system, this is OK:
> we just malloc a larger buffer.
>
> Signed-off-by: David Turner <dturner@twosigma.com>
> ---
>  cache.h  |  1 +
>  config.c | 17 +++++++++++++++++
>  http.c   |  2 +-
>  3 files changed, 19 insertions(+), 1 deletion(-)
>
> diff --git a/cache.h b/cache.h
> index fbdf7a815a..a8c1b65db0 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -1900,6 +1900,7 @@ extern int git_parse_maybe_bool(const char *);
>  extern int git_config_int(const char *, const char *);
>  extern int64_t git_config_int64(const char *, const char *);
>  extern unsigned long git_config_ulong(const char *, const char *);
> +extern size_t git_config_size_t(const char *, const char *);
>  extern int git_config_bool_or_int(const char *, const char *, int *);
>  extern int git_config_bool(const char *, const char *);
>  extern int git_config_maybe_bool(const char *, const char *);
> diff --git a/config.c b/config.c
> index 1a4d85537b..7b706cf27a 100644
> --- a/config.c
> +++ b/config.c
> @@ -834,6 +834,15 @@ int git_parse_ulong(const char *value, unsigned long *ret)
>  	return 1;
>  }
>
> +static size_t git_parse_size_t(const char *value, unsigned long *ret)
> +{
> +	size_t tmp;
> +	if (!git_parse_signed(value, &tmp, maximum_unsigned_value_of_type(size_t)))
> +		return 0;
> +	*ret = tmp;
> +	return 1;
> +}
What is the return value here ?
Isn't it a size_t we want ?
(There was a recent discussion about "unsigned long" vs "size_t", which
  are the same on many systems, but not under Win64)
Would the following work ?

static int git_parse_size_t(const char *value, size_t *ret)
{
	if (!git_parse_signed(value, ret, maximum_unsigned_value_of_type(size_t)))
		return 0;
	return 1;
}

[]
> +size_t git_config_size_t(const char *name, const char *value)
> +{
> +	unsigned long ret;
> +	if (!git_parse_size_t(value, &ret))
> +		die_bad_number(name, value);
> +	return ret;
> +}
> +
Same here:
size_t git_config_size_t(const char *name, const char *value)
{
	size_t ret;
	if (!git_parse_size_t(value, &ret))
		die_bad_number(name, value);
	return ret;
}
