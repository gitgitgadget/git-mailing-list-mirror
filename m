Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E71A31FF76
	for <e@80x24.org>; Mon, 19 Dec 2016 08:36:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752947AbcLSIfE (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Dec 2016 03:35:04 -0500
Received: from alum-mailsec-scanner-3.mit.edu ([18.7.68.14]:51971 "EHLO
        alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750947AbcLSIfD (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 19 Dec 2016 03:35:03 -0500
X-Greylist: delayed 423 seconds by postgrey-1.27 at vger.kernel.org; Mon, 19 Dec 2016 03:35:03 EST
X-AuditID: 1207440e-7c7ff700000009ec-6e-585799ff65e0
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        by alum-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id 64.33.02540.FF997585; Mon, 19 Dec 2016 03:27:46 -0500 (EST)
Received: from [192.168.69.190] (p57906BA3.dip0.t-ipconnect.de [87.144.107.163])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id uBJ8RfJL020845
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
        Mon, 19 Dec 2016 03:27:42 -0500
Subject: Re: [PATCH 1/5] check-ref-format: Refactor out check_one_ref_format
To:     Ian Jackson <ijackson@chiark.greenend.org.uk>, git@vger.kernel.org
References: <20161104191358.28812-1-ijackson@chiark.greenend.org.uk>
 <20161104191358.28812-2-ijackson@chiark.greenend.org.uk>
From:   Michael Haggerty <mhagger@alum.mit.edu>
Message-ID: <3e277bb8-bd1f-0d8c-47a7-9673ad711bce@alum.mit.edu>
Date:   Mon, 19 Dec 2016 09:27:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Icedove/45.5.1
MIME-Version: 1.0
In-Reply-To: <20161104191358.28812-2-ijackson@chiark.greenend.org.uk>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrCIsWRmVeSWpSXmKPExsUixO6iqMs0KzzC4PVHFouuK91MFqtbFrE4
        MHl8O7WJ2ePzJrkApigum5TUnMyy1CJ9uwSujN8fX7AX3OGtWPliB2MD41uuLkZODgkBE4mr
        e3exdDFycQgJXGaUuPPhMTOEc4FJYufXZYwgVcICPhL7TvYzg9giAm4SZz81MoHYQgL1EidO
        7ASrYRPQlVjU0wwW5xWwl/i7bAdYnEVAVWLR9vVgvaICIRKX5xxlg6gRlDg58wkLiM0p4Cqx
        4vsJsBpmAT2JHdd/sULY8hLb385hnsDINwtJyywkZbOQlC1gZF7FKJeYU5qrm5uYmVOcmqxb
        nJyYl5dapGusl5tZopeaUrqJERJ4fDsY29fLHGIU4GBU4uEteB8WIcSaWFZcmXuIUZKDSUmU
        d8rakAghvqT8lMqMxOKM+KLSnNTiQ4wSHMxKIrzfpodHCPGmJFZWpRblw6SkOViUxHnVlqj7
        CQmkJ5akZqemFqQWwWRlODiUJHijZgI1ChalpqdWpGXmlCCkmTg4QYbzAA2vmQEyvLggMbc4
        Mx0if4pRUUqc9yBIQgAkkVGaB9cLSwyvGMWBXhHmlQFZwQNMKnDdr4AGMwENXtgNNrgkESEl
        1cDouv9GpMOkmg3cr58+uhBafao56sU9LisGj7orN662hgkEc87YsvLsn5M39x8WSvoruO+V
        ehVnTWPNyd+FjhnO7hkrhV5Pu1E/1/3tivceBRUSF60Su3fOZf6vm3686oqJtESEuZ7cZatX
        YUmqvt3vvWMPVM5WSYuKYlj4r/7BNJmZXU+e/RVRYinOSDTUYi4qTgQAqfrITOcCAAA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/04/2016 08:13 PM, Ian Jackson wrote:
> We are going to want to reuse this.  No functional change right now.
> 
> It currently has a hidden memory leak if --normalize is used.
> 
> Signed-off-by: Ian Jackson <ijackson@chiark.greenend.org.uk>
> ---
>  builtin/check-ref-format.c | 26 ++++++++++++++------------
>  1 file changed, 14 insertions(+), 12 deletions(-)
> 
> diff --git a/builtin/check-ref-format.c b/builtin/check-ref-format.c
> index eac4994..4d56caa 100644
> --- a/builtin/check-ref-format.c
> +++ b/builtin/check-ref-format.c
> @@ -48,12 +48,22 @@ static int check_ref_format_branch(const char *arg)
>  	return 0;
>  }
>  
> +static int normalize = 0;
> +static int flags = 0;
> +
> +static int check_one_ref_format(const char *refname)
> +{
> +	if (normalize)
> +		refname = collapse_slashes(refname);
> +	if (check_refname_format(refname, flags))
> +		return 1;
> +	if (normalize)
> +		printf("%s\n", refname);

This function needs to `return 0` if it gets to the end.

> +}
> +
>  int cmd_check_ref_format(int argc, const char **argv, const char *prefix)
>  {
>  	int i;
> -	int normalize = 0;
> -	int flags = 0;
> -	const char *refname;
>  
>  	if (argc == 2 && !strcmp(argv[1], "-h"))
>  		usage(builtin_check_ref_format_usage);
> @@ -76,13 +86,5 @@ int cmd_check_ref_format(int argc, const char **argv, const char *prefix)
>  	if (! (i == argc - 1))
>  		usage(builtin_check_ref_format_usage);
>  
> -	refname = argv[i];
> -	if (normalize)
> -		refname = collapse_slashes(refname);
> -	if (check_refname_format(refname, flags))
> -		return 1;
> -	if (normalize)
> -		printf("%s\n", refname);
> -
> -	return 0;
> +	return check_one_ref_format(argv[i]);
>  }
> 

Michael

