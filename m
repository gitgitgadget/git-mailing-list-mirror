From: =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Subject: Re: [PATCHv2] Porting resolve_relative_url from shell to C
Date: Thu, 17 Dec 2015 08:47:18 +0100
Message-ID: <56726886.6060305@web.de>
References: <1449709654-30189-1-git-send-email-sbeller@google.com>
 <1450311999-3992-1-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: gitster@pobox.com, jens.lehmann@web.de, j6t@kdbg.org
To: Stefan Beller <sbeller@google.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 17 08:47:38 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a9THm-0007lW-2X
	for gcvg-git-2@plane.gmane.org; Thu, 17 Dec 2015 08:47:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751938AbbLQHre (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Dec 2015 02:47:34 -0500
Received: from mout.web.de ([212.227.17.11]:52289 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751439AbbLQHrd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Dec 2015 02:47:33 -0500
Received: from birne9.local ([213.66.56.100]) by smtp.web.de (mrweb103) with
 ESMTPSA (Nemesis) id 0MHp4r-1aD2iO0pTx-003cF1; Thu, 17 Dec 2015 08:47:25
 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.9; rv:38.0)
 Gecko/20100101 Thunderbird/38.4.0
In-Reply-To: <1450311999-3992-1-git-send-email-sbeller@google.com>
X-Provags-ID: V03:K0:OQt4ljxCQJ08VuLTzDTrKEKaRXJOjggAwPYzkBxB3xPW94j74cX
 URCJ6VpxN6ZJLN8KiOXpCM0sBJFODHj/HLo1gpnGG92zXtrdxTv2MXTgNMvxJZBs8woUijQ
 ruqh3zrbNW/SyXNHtDVHO/8g/tmgJVW/esOZaI+5rXcYEGk5IGsdVdzH2mdLUCYXFwoHOIM
 53i0RWvy8Lqnt2zJDPvRw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:vrtQ0O5kIJI=:HXUyjl/lL/ttjsgjMl0jB1
 /1mpFIVZlxdRkU8Zq8lrIazP5k7RKnUX3X6EHEs83HdYL0Du/eHyM8EMFBtIk+6p1gLhgGXNb
 FLcvKfwRN7cnSVgta0k5xgT8rECNAkbS5JrFJ0dQgwWvomoOaJ5Ejk6wtYcWRQIVLyiEcIjtz
 /msUx2rBelv2mywiG1miIQzA6/xCh03NcS+qsENykbGX/SK13mDD4s7o0VMy0hvnuJ3aY5TWD
 bQuIjBYPHbE+bERsxEDG8wvSbhwujsYJGDuEqcF2FmyI0G5YORVg0DnleKnLmlSA9pnaOO3qn
 OyzffD4Amc8/DJD0SIMsK+dQHnbccA/H+e6FDO3/+PaG43QjQlrlm087fMflx/yA6e/efNdR0
 Qdqb/YmmZV/QrRBXMVCeGPkTfV8KT4vnum91u99xMk7+OuuvOCJED39wmPhWRQIO9VKrjX4gY
 fTHjCwA4cnlzECyZkv/HYpufJQTsGaEY1qd39XrPvsQ1YFolkXM+vNqpQVywop0zFZvNXn+ju
 5urYWp/TrJBobP9dZ+5tI/JTtmcLWDhdcevrRndDDogAGAOq59e5XIOhTJorgxAs1Zw61m8Bf
 eYbzZ4pnzCW+fQLnM3QNHzl5QpTlHOwWFdrzGCgdpwTIQCSQDW8PBCVq9aZI73ptESgrz+7c/
 u/jIO9m33FXSS3ibjMvSRn0XxwyR5azGc5HnaCAlau+Gm50KplJMzv+AX6xd5NCkd2XBzEVo/
 /3u3Y+0ihd35RWGjqK2nVr1O6usvt1IdLms4AK6L4LECMKRjwzpF/796GfuhXpalEgt/OxMz 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282637>

On 17.12.15 01:26, Stefan Beller wrote:
> A new version of the patch, which spells out more its intent and
> may actually work in Windows.
> 
> Any comment welcome,
> Thanks,
> Stefan
> 
> Stefan Beller (1):
>   submodule: Port resolve_relative_url from shell to C
> 
>  builtin/submodule--helper.c | 151 ++++++++++++++++++++++++++++++++++++++++++++
>  git-submodule.sh            |  81 ++----------------------
>  2 files changed, 155 insertions(+), 77 deletions(-)
> 
> interdiff to previous version:
> 
> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
> index f48b5b5..b925bed 100644
> --- a/builtin/submodule--helper.c
> +++ b/builtin/submodule--helper.c
> @@ -31,6 +31,36 @@ static const char *get_default_remote(void)
>  		return xstrdup(dest);
>  }
>  
> +static int has_same_dir_prefix(const char *str, const char **out)
> +{
> +#ifdef GIT_WINDOWS_NATIVE
Should that be
if defined(GIT_WINDOWS_NATIVE) || defined(__CYGWIN__)
