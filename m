Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1C1A02013A
	for <e@80x24.org>; Fri, 17 Feb 2017 09:41:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755431AbdBQJlu (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Feb 2017 04:41:50 -0500
Received: from alum-mailsec-scanner-8.mit.edu ([18.7.68.20]:46986 "EHLO
        alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1755335AbdBQJlr (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 17 Feb 2017 04:41:47 -0500
X-AuditID: 12074414-807ff70000002bfd-1c-58a6c54ed9cc
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id 37.F4.11261.E45C6A85; Fri, 17 Feb 2017 04:41:37 -0500 (EST)
Received: from [192.168.69.190] (p4FEDF52F.dip0.t-ipconnect.de [79.237.245.47])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v1H9fWdl023554
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
        Fri, 17 Feb 2017 04:41:33 -0500
Subject: Re: [PATCH v2 15/19] refs: simplify parsing of reflog entries
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
References: <20170214023141.842922-1-sandals@crustytoothpaste.net>
 <20170214023141.842922-16-sandals@crustytoothpaste.net>
Cc:     Jeff King <peff@peff.net>
From:   Michael Haggerty <mhagger@alum.mit.edu>
Message-ID: <784a4960-e890-eec4-0349-3e27b4c7997a@alum.mit.edu>
Date:   Fri, 17 Feb 2017 10:41:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Icedove/45.6.0
MIME-Version: 1.0
In-Reply-To: <20170214023141.842922-16-sandals@crustytoothpaste.net>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrBIsWRmVeSWpSXmKPExsUixO6iqBt4dFmEwYtrmhZdV7qZLH609DBb
        tM38weTA7LH85l8mj2e9exg9Pm+SC2CO4rJJSc3JLEst0rdL4Mro2X2BrWCGUEX7vIgGxjl8
        XYycHBICJhLbZk5n7mLk4hAS2MEk8fD9fFYI5zyTROOUVhaQKmEBN4nt/VeZQWwRAS+J+Y9m
        ABVxABXVSGzaYQcSZhaQlVi/4i8jiM0moCuxqKeZCcTmFbCX2LX5DjuIzSKgKjF55yVWEFtU
        IERizsIHjBA1ghInZz4BW8Up4CKx/kEDK8RMPYkd139B2fIS29/OYZ7AyD8LScssJGWzkJQt
        YGRexSiXmFOaq5ubmJlTnJqsW5ycmJeXWqRroZebWaKXmlK6iRESoCI7GI+clDvEKMDBqMTD
        m7F9aYQQa2JZcWXuIUZJDiYlUd5F05ZFCPEl5adUZiQWZ8QXleakFh9ilOBgVhLhVdsHlONN
        SaysSi3Kh0lJc7AoifN+W6zuJySQnliSmp2aWpBaBJOV4eBQkuDVOwLUKFiUmp5akZaZU4KQ
        ZuLgBBnOAzT88SGQ4cUFibnFmekQ+VOMilLivDsPAyUEQBIZpXlwvbAE8opRHOgVYd4AkBU8
        wOQD1/0KaDAT0ODOiKUgg0sSEVJSDYwJ2vcD+efy7Pm+cUf7l6L5/fON57+bbym6z/7JglU+
        v5YFVrrZrZX1a9ConcrHK93xIf+p4x0Ja1Wde/wKx4LXH2SVObrN4WZqU0rVmw7b1jSVmesZ
        PofVOrA/a67beUZmAb+e84YfR9vWhXryuf9V8P2ictlWK3ZX7xYV1QuL07QYnj7f3afEUpyR
        aKjFXFScCADJpv1R+wIAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 02/14/2017 03:31 AM, brian m. carlson wrote:
> The current code for reflog entries uses a lot of hard-coded constants,
> making it hard to read and modify.  Use parse_oid_hex and two temporary
> variables to simplify the code and reduce the use of magic constants.
> 
> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> ---
>  refs/files-backend.c | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/refs/files-backend.c b/refs/files-backend.c
> index d7a5fd2a7c..09227a3f63 100644
> --- a/refs/files-backend.c
> +++ b/refs/files-backend.c
> @@ -3117,12 +3117,14 @@ static int show_one_reflog_ent(struct strbuf *sb, each_reflog_ent_fn fn, void *c
>  	char *email_end, *message;
>  	unsigned long timestamp;
>  	int tz;
> +	const char *p = sb->buf;
> +	const int minlen = 2 * GIT_SHA1_HEXSZ + 3;
>  
>  	/* old SP new SP name <email> SP time TAB msg LF */
> -	if (sb->len < 83 || sb->buf[sb->len - 1] != '\n' ||
> -	    get_oid_hex(sb->buf, &ooid) || sb->buf[40] != ' ' ||
> -	    get_oid_hex(sb->buf + 41, &noid) || sb->buf[81] != ' ' ||
> -	    !(email_end = strchr(sb->buf + 82, '>')) ||
> +	if (sb->len < minlen || sb->buf[sb->len - 1] != '\n' ||
> +	    parse_oid_hex(p, &ooid, &p) || *p++ != ' ' ||
> +	    parse_oid_hex(p, &noid, &p) || *p++ != ' ' ||
> +	    !(email_end = strchr(p, '>')) ||
>  	    email_end[1] != ' ' ||
>  	    !(timestamp = strtoul(email_end + 2, &message, 10)) ||
>  	    !message || message[0] != ' ' ||
> @@ -3136,7 +3138,7 @@ static int show_one_reflog_ent(struct strbuf *sb, each_reflog_ent_fn fn, void *c
>  		message += 6;
>  	else
>  		message += 7;
> -	return fn(&ooid, &noid, sb->buf + 82, timestamp, tz, message, cb_data);
> +	return fn(&ooid, &noid, sb->buf + minlen - 1, timestamp, tz, message, cb_data);

I think `sb->buf + minlen - 1` is just `p` here, isn't it?

Also, I think instead of the initial test `sb->len < minlen`, it would
be enough to check `!sb->len` (i.e., error if it's zero to avoid a
buffer underflow in `sb->buf[sb->len - 1])`, because the
`parse_oid_hex()` calls together with the `*p++ != ' '` and
`sb->buf[sb->len - 1] != '\n'` checks already ensure that the string has
at least the minimum length.

Then you could do away with `minlen` entirely.

Michael

