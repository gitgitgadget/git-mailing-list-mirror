From: Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [PATCH v7 29/33] setup: configure ref storage on setup
Date: Tue, 1 Mar 2016 17:18:05 +0000
Message-ID: <56D5CECD.6020301@ramsayjones.plus.com>
References: <1456793586-22082-1-git-send-email-dturner@twopensource.com>
 <1456793586-22082-30-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>
To: David Turner <dturner@twopensource.com>, git@vger.kernel.org,
	peff@peff.net, mhagger@alum.mit.edu, pclouds@gmail.com
X-From: git-owner@vger.kernel.org Tue Mar 01 18:18:25 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aanwD-0005zc-FK
	for gcvg-git-2@plane.gmane.org; Tue, 01 Mar 2016 18:18:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752118AbcCARSS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Mar 2016 12:18:18 -0500
Received: from avasout01.plus.net ([84.93.230.227]:57247 "EHLO
	avasout01.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751693AbcCARSP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Mar 2016 12:18:15 -0500
Received: from [10.0.2.15] ([46.208.159.221])
	by avasout01 with smtp
	id QhJA1s00C4mu3xa01hJBw0; Tue, 01 Mar 2016 17:18:13 +0000
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.1 cv=bsGxfxui c=1 sm=1 tr=0
 a=Sp5fw55EgyGSOjouSGNDoQ==:117 a=Sp5fw55EgyGSOjouSGNDoQ==:17
 a=L9H7d07YOLsA:10 a=9cW_t1CCXrUA:10 a=s5jvgZ67dGcA:10 a=N659UExz7-8A:10
 a=6NG_XSeZAAAA:8 a=ybZZDoGAAAAA:8 a=OMMNu6pZ7ObkGL86ozsA:9 a=pILNOxqGKmIA:10
X-AUTH: ramsayjones@:2500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
In-Reply-To: <1456793586-22082-30-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288040>



On 01/03/16 00:53, David Turner wrote:
> This sets up the existing backend early, so that other code which
> reads refs is reading from the right place.
> 
> Signed-off-by: David Turner <dturner@twopensource.com>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  config.c | 1 +
>  setup.c  | 4 ++++
>  2 files changed, 5 insertions(+)
> 
> diff --git a/config.c b/config.c
> index 9ba40bc..cca7e28 100644
> --- a/config.c
> +++ b/config.c
> @@ -11,6 +11,7 @@
>  #include "strbuf.h"
>  #include "quote.h"
>  #include "hashmap.h"
> +#include "refs.h"
>  #include "string-list.h"
>  #include "utf8.h"
>  

I was just skimming these patches as they passed by, and this
caught my eye. If this include is required (eg. to fix a compiler
warning), then it should probably be in an earlier patch.
Otherwise, it should be in a later patch, no?

ATB,
Ramsay Jones

> diff --git a/setup.c b/setup.c
> index bd3a2cf..e2e1220 100644
> --- a/setup.c
> +++ b/setup.c
> @@ -457,6 +457,10 @@ static int check_repository_format_gently(const char *gitdir, int *nongit_ok)
>  		ret = -1;
>  	}
>  
> +	register_ref_storage_backends();
> +	if (set_ref_storage_backend(ref_storage_backend))
> +		die(_("Unknown ref storage backend %s"), ref_storage_backend);
> +
>  	strbuf_release(&sb);
>  	return ret;
>  }
> 
