Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C3D1520437
	for <e@80x24.org>; Tue, 31 Oct 2017 16:34:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753576AbdJaQeU (ORCPT <rfc822;e@80x24.org>);
        Tue, 31 Oct 2017 12:34:20 -0400
Received: from ikke.info ([178.21.113.177]:59396 "EHLO vps892.directvps.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751876AbdJaQeU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Oct 2017 12:34:20 -0400
Received: by vps892.directvps.nl (Postfix, from userid 1008)
        id 73A6544039C; Tue, 31 Oct 2017 17:34:18 +0100 (CET)
Date:   Tue, 31 Oct 2017 17:34:18 +0100
From:   Kevin Daudt <me@ikke.info>
To:     =?iso-8859-1?Q?Ren=E9?= Scharfe <l.s.r@web.de>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Ralf Thielow <ralf.thielow@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 2/2] sequencer: use O_TRUNC to truncate files
Message-ID: <20171031163418.GB19161@alpha.vpn.ikke.info>
References: <6150c80b-cb0e-06d4-63a7-a4f4a9107ab2@web.de>
 <6b8e2a79-302e-7e69-00bd-f4643d5195af@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6b8e2a79-302e-7e69-00bd-f4643d5195af@web.de>
User-Agent: Mutt/1.8.3 (2017-05-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 31, 2017 at 10:58:16AM +0100, René Scharfe wrote:
> Cut off any previous content of the file to be rewritten by passing the
> flag O_TRUNC to open(2) instead of calling ftruncate(2) at the end.
> That's easier and shorter.
> 
> Signed-off-by: Rene Scharfe <l.s.r@web.de>
> ---
>  sequencer.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/sequencer.c b/sequencer.c
> index 17360eb38a..f93b60f615 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -2668,13 +2668,11 @@ int check_todo_list(void)
>  static int rewrite_file(const char *path, const char *buf, size_t len)
>  {
>  	int rc = 0;
> -	int fd = open(path, O_WRONLY);
> +	int fd = open(path, O_WRONLY | O_TRUNC);
>  	if (fd < 0)
>  		return error_errno(_("could not open '%s' for writing"), path);
>  	if (write_in_full(fd, buf, len) < 0)
>  		rc = error_errno(_("could not write to '%s'"), path);
> -	if (!rc && ftruncate(fd, len) < 0)
> -		rc = error_errno(_("could not truncate '%s'"), path);
>  	close(fd);
>  	return rc;
>  }
> -- 
> 2.15.0

Makes sense
