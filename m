From: =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH] read-cache: increase write buffer size
Date: Sat, 19 Mar 2016 09:05:55 +0100
Message-ID: <56ED0863.3020709@web.de>
References: <1458350341-12276-1-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
To: David Turner <dturner@twopensource.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 19 09:06:14 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ahBtk-0007mY-U2
	for gcvg-git-2@plane.gmane.org; Sat, 19 Mar 2016 09:06:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751787AbcCSIGI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Mar 2016 04:06:08 -0400
Received: from mout.web.de ([212.227.17.12]:65196 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751244AbcCSIGB (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Mar 2016 04:06:01 -0400
Received: from macce.local ([93.222.58.143]) by smtp.web.de (mrweb101) with
 ESMTPSA (Nemesis) id 0LlWKh-1a7JVj2Vs7-00bHUh; Sat, 19 Mar 2016 09:05:56
 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:38.0)
 Gecko/20100101 Thunderbird/38.6.0
In-Reply-To: <1458350341-12276-1-git-send-email-dturner@twopensource.com>
X-Provags-ID: V03:K0:v4seyuunDPermZI7UiNy1UqcUZciUKPd0EThHG2tg5khQw18Sd3
 SHW2qXPZKG5C8mzgBOmBovGC4infdO+JyNY+NGS3ghumhxOFJt1Z7ACVTwf1RujQrK24GPL
 6647IyC4u7sjZLX/R6Yyl9gbeEcB5j6OCW22ujekdtUJ4mF3A5MJLJ1zm9BgefR/jo626VT
 7VNbYq3hjtY8++xzOYwuA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:S3N4Z7sFYko=:NCrzc6rzlznnXncFTPIgUe
 d4L+HusSqomNDeCtQO2bXFih72gePehJn9CgaxfJ4K9x/6Hwk4JN4ueuNYthT52obHz1Vvgip
 V0bfof629++CBap5KQSdpshHKv0ldas1fvRbY23wZi7TIHSOKcdNSuhSdA4rWYzcL5olVMaq2
 HBZgfFbHs6zGhKKRHPbCbUUXGVQpkBQqPMAeeV3jyj0fzlOp8jYhIiyHtwxfpy8cpm1hWjdec
 of1riRL9K4YqiEtkn9NEbWoooPLa2dLb0xOfDBKixNi0tT//yZlqbDC5h+OB0nP5+csCCkWia
 wO2gk3aGGwgUoE1gIaF0595VHIgKF5SwCs6bJ0vLzrDJ7MZBKifGazSOjdtYjdGvcA2KrD/yo
 3FR2p03rsbkzH6+eeq7y7Mawl3MHQIr7IG3FysHWkXcYl6CqMyhOi38SDlzYDrg5rs9X1qQk9
 Wva6uHF1So60w+M5DbqilNku3/6zK4Hg2NY3Up+Pgns4fIi9YWJ4KWtrUfSb+Qrq1Cc7nE/MI
 wDsMZSrV0A+oT3KkmEhKRLjgpWvehXSzCV0pUSbYMrhUT+AlZt9/HtYIF2cnVBAYJ+LQZeC0Y
 Lktfs3R1e2kqpyV8pe7xo3E1GsuoscWRkZLsymLdY0ZvpDQ5Lmi3irxpMjjsTdBhg0Uk0l+Nd
 VRWHacAN5KwTRu8DFFboeWnIV7L4QoS/3lE3IYsE1UlVR+y5BaKMs8vLkk3zrh49uN6w/gjB6
 SZDrw0SVBy2KnkIlKmZTMF/bt++o4YdvTsS5Lzy2kwmjZ8IW41CZzIBHV17Mq2q5wtb7y3Rw 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289296>

On 2016-03-19 02.19, David Turner wrote:
> Each write() has syscall overhead, and writing a large index entails
> many such calls.  A larger write buffer reduces the overhead,
> leading to increased performance.
> 
> On my repo, which has an index size of 30m, this saves about 10ms of
> time writing the index.
> 
> Signed-off-by: David Turner <dturner@twopensource.com>
> ---
>  read-cache.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/read-cache.c b/read-cache.c
> index d9fb78b..09ebe08 100644
> --- a/read-cache.c
> +++ b/read-cache.c
> @@ -1714,7 +1714,7 @@ int unmerged_index(const struct index_state *istate)
>  	return 0;
>  }
>  
> -#define WRITE_BUFFER_SIZE 8192
> +#define WRITE_BUFFER_SIZE 131072
>  static unsigned char write_buffer[WRITE_BUFFER_SIZE];
>  static unsigned long write_buffer_len;
>  
> 
Do I read that right, it saves 10 milliseconds ?
What happens to small system (like Raspberry PI), when you
want 128K write buffer ?
Could the buffer size be turned into a makefile variable, defaulting to 8192 ?
