From: Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [PATCH v4 03/16] index-helper: new daemon for caching index and
 related stuff
Date: Wed, 13 Apr 2016 18:00:11 +0100
Message-ID: <570E7B1B.6040207@ramsayjones.plus.com>
References: <1460507589-25525-1-git-send-email-dturner@twopensource.com>
 <1460507589-25525-4-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
To: David Turner <dturner@twopensource.com>, git@vger.kernel.org,
	pclouds@gmail.co,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 13 19:00:26 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aqO9Q-0008LM-P2
	for gcvg-git-2@plane.gmane.org; Wed, 13 Apr 2016 19:00:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751798AbcDMRAS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Apr 2016 13:00:18 -0400
Received: from avasout07.plus.net ([84.93.230.235]:38082 "EHLO
	avasout07.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751775AbcDMRAQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Apr 2016 13:00:16 -0400
Received: from [10.0.2.15] ([91.125.197.102])
	by avasout07 with smtp
	id ht0D1s0022D2Veb01t0EBl; Wed, 13 Apr 2016 18:00:15 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.1 cv=QqujpgGd c=1 sm=1 tr=0
 a=mTUfFwB0nGOO66Ym8a+i3w==:117 a=mTUfFwB0nGOO66Ym8a+i3w==:17
 a=L9H7d07YOLsA:10 a=9cW_t1CCXrUA:10 a=s5jvgZ67dGcA:10 a=IkcTkHD0fZMA:10
 a=ryu0DrI1DaY1dus9n70A:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
In-Reply-To: <1460507589-25525-4-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291460>



On 13/04/16 01:32, David Turner wrote:

[snip]

> diff --git a/git-compat-util.h b/git-compat-util.h
> index c07e0c1..8b878fe 100644
> --- a/git-compat-util.h
> +++ b/git-compat-util.h
> @@ -513,6 +513,7 @@ static inline int ends_with(const char *str, const char *suffix)
>  #define PROT_READ 1
>  #define PROT_WRITE 2
>  #define MAP_PRIVATE 1
> +#define MAP_SHARED 2
>  #endif
>  
>  #define mmap git_mmap
> @@ -1045,4 +1046,21 @@ struct tm *git_gmtime_r(const time_t *, struct tm *);
>  #define getc_unlocked(fh) getc(fh)
>  #endif
>  
> +#ifdef __linux__
> +#define UNIX_PATH_MAX 108
> +#elif defined(__APPLE__) || defined(BSD)
> +#define UNIX_PATH_MAX 104
> +#else
> +/*
> + * Quoth POSIX: The size of sun_path has intentionally been left
> + * undefined. This is because different implementations use different
> + * sizes. For example, 4.3 BSD uses a size of 108, and 4.4 BSD uses a
> + * size of 104. Since most implementations originate from BSD
> + * versions, the size is typically in the range 92 to 108.
> + *
> + * Thanks, POSIX!  Super-helpful!  Hope we don't overflow any buffers!
> + */
> +#define UNIX_PATH_MAX 92
> +#endif
> +

It seems you forgot to delete this hunk. ;-)

>  #endif

ATB,
Ramsay Jones
