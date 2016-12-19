Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A9DF21FF76
	for <e@80x24.org>; Mon, 19 Dec 2016 11:11:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933012AbcLSLKO (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Dec 2016 06:10:14 -0500
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:42934 "EHLO
        alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932982AbcLSLKM (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 19 Dec 2016 06:10:12 -0500
X-AuditID: 12074413-465ff70000000a33-ae-5857c0049654
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id 13.D1.02611.400C7585; Mon, 19 Dec 2016 06:09:57 -0500 (EST)
Received: from [192.168.69.190] (p57906BA3.dip0.t-ipconnect.de [87.144.107.163])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id uBJB9tKo027396
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
        Mon, 19 Dec 2016 06:09:56 -0500
Subject: Re: [PATCH 3/5] check-ref-format: Abolish leak of collapsed refname
To:     Ian Jackson <ijackson@chiark.greenend.org.uk>, git@vger.kernel.org
References: <20161104191358.28812-1-ijackson@chiark.greenend.org.uk>
 <20161104191358.28812-4-ijackson@chiark.greenend.org.uk>
From:   Michael Haggerty <mhagger@alum.mit.edu>
Message-ID: <71960ab9-c42f-2db6-5359-58afb5a2a8fb@alum.mit.edu>
Date:   Mon, 19 Dec 2016 12:09:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Icedove/45.5.1
MIME-Version: 1.0
In-Reply-To: <20161104191358.28812-4-ijackson@chiark.greenend.org.uk>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrMIsWRmVeSWpSXmKPExsUixO6iqMt6IDzC4MkzC4uuK91MFqtbFrE4
        MHl8O7WJ2ePzJrkApigum5TUnMyy1CJ9uwSujLal71kKXrNXvP56mK2BcSlbFyMnh4SAicSb
        2X2sXYxcHEIClxklLrQ3sUE4F5gkLp4/wgxSJSzgI3Hv2AsWEFtEwE3i7KdGpi5GDqCieomW
        lRkgYTYBXYlFPc1MIDavgL3EjZ8fWEFsFgFViav/2sBaRQVCJC7POcoGUSMocXLmE7A4p4Cr
        xJ5Xe8BWMQvoSey4/osVwpaX2P52DvMERr5ZSFpmISmbhaRsASPzKka5xJzSXN3cxMyc4tRk
        3eLkxLy81CJdc73czBK91JTSTYyQsBPewbjrpNwhRgEORiUe3oL3YRFCrIllxZW5hxglOZiU
        RHmnrA2JEOJLyk+pzEgszogvKs1JLT7EKMHBrCTCu21veIQQb0piZVVqUT5MSpqDRUmcV22J
        up+QQHpiSWp2ampBahFMVoaDQ0mC98g+oEbBotT01Iq0zJwShDQTByfIcB6g4d4gNbzFBYm5
        xZnpEPlTjIpS4rw3QRICIImM0jy4XlhaeMUoDvSKMO9VkCoeYEqB634FNJgJaPDCbrDBJYkI
        KakGxmYur12HmW7O2SLguNP2iPrOkp+HCtqLZr/jOvvnmnzHlJd3/xVnuPAu49n1jyVuhUOJ
        ytsTajMsl+/g3e0jbP68MZHL9tjmO3NXrf2x6UfCqvUFezdFTqiZfESqxOXnlUdnJ67/Vd+8
        PGJqoU7Gu1reB8e1+WaczdC0yLtXrqiwOu7fv7ifvFFKLMUZiYZazEXFiQCzcGbz5gIAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/04/2016 08:13 PM, Ian Jackson wrote:
> collapse_slashes always returns a value from xmallocz.
> 
> Right now this leak is not very interesting, since we only call
> check_one_ref_format once.
> 
> Signed-off-by: Ian Jackson <ijackson@chiark.greenend.org.uk>
> ---
>  builtin/check-ref-format.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/builtin/check-ref-format.c b/builtin/check-ref-format.c
> index f12c19c..020ebe8 100644
> --- a/builtin/check-ref-format.c
> +++ b/builtin/check-ref-format.c
> @@ -63,8 +63,10 @@ static int check_one_ref_format(const char *refname)
>  		: check_refname_format(refname, flags);
>  	if (got)
>  		return 1;

If the function returns via the line above, then the memory will still
be leaked.

> -	if (normalize)
> +	if (normalize) {
>  		printf("%s\n", refname);
> +		free((void*)refname);
> +	}
>  }
>  
>  int cmd_check_ref_format(int argc, const char **argv, const char *prefix)
> 

Michael

