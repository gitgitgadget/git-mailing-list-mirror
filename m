Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CC38E20D09
	for <e@80x24.org>; Mon, 17 Apr 2017 01:41:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757172AbdDQBlo (ORCPT <rfc822;e@80x24.org>);
        Sun, 16 Apr 2017 21:41:44 -0400
Received: from cloud.peff.net ([104.130.231.41]:34561 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757100AbdDQBln (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 16 Apr 2017 21:41:43 -0400
Received: (qmail 13744 invoked by uid 109); 17 Apr 2017 01:41:43 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 17 Apr 2017 01:41:43 +0000
Received: (qmail 20398 invoked by uid 111); 17 Apr 2017 01:42:05 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sun, 16 Apr 2017 21:42:05 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 16 Apr 2017 21:41:41 -0400
Date:   Sun, 16 Apr 2017 21:41:41 -0400
From:   Jeff King <peff@peff.net>
To:     Sebastian Schuberth <sschuberth@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] sha1_file: remove an used fd variable
Message-ID: <20170417014140.gxto2q76v6ajxwd3@sigill.intra.peff.net>
References: <0102015b7826824a-7bacaa78-5158-4d33-9615-e1a5bffea7a2-000000@eu-west-1.amazonses.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0102015b7826824a-7bacaa78-5158-4d33-9615-e1a5bffea7a2-000000@eu-west-1.amazonses.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Apr 16, 2017 at 07:04:01PM +0000, Sebastian Schuberth wrote:

> Signed-off-by: Sebastian Schuberth <sschuberth@gmail.com>
> ---
>  sha1_file.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/sha1_file.c b/sha1_file.c
> index 7106389..9ecf71f 100644
> --- a/sha1_file.c
> +++ b/sha1_file.c
> @@ -3970,7 +3970,6 @@ int read_loose_object(const char *path,
>  		      void **contents)
>  {
>  	int ret = -1;
> -	int fd = -1;
>  	void *map = NULL;
>  	unsigned long mapsize;
>  	git_zstream stream;
> @@ -4020,7 +4019,5 @@ int read_loose_object(const char *path,
>  out:
>  	if (map)
>  		munmap(map, mapsize);
> -	if (fd >= 0)
> -		close(fd);
>  	return ret;

Thanks, this looks obviously correct. The mistake is mine; in an early
iteration of the series, the caller of map_sha1_file_1() was responsible
for opening the file itself, but I later switched it to take the path.

-Peff
