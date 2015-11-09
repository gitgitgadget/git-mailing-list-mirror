From: Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [PATCH v7 07/11] refs/refs-internal.h: new header file
Date: Mon, 9 Nov 2015 19:46:43 +0000
Message-ID: <5640F823.5010902@ramsayjones.plus.com>
References: <cover.1447085798.git.mhagger@alum.mit.edu>
 <5f62351689318a4ef9feeb3639e6a7a00b354a02.1447085798.git.mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, David Turner <dturner@twopensource.com>,
	Lukas Fleischer <lfleischer@lfos.de>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 09 20:47:11 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZvsP3-0005h1-42
	for gcvg-git-2@plane.gmane.org; Mon, 09 Nov 2015 20:46:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751697AbbKITqx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Nov 2015 14:46:53 -0500
Received: from avasout04.plus.net ([212.159.14.19]:42206 "EHLO
	avasout04.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751339AbbKITqw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Nov 2015 14:46:52 -0500
Received: from [10.0.2.15] ([146.199.93.105])
	by avasout04 with smtp
	id fXmp1r0052GQ2gJ01XmrJ1; Mon, 09 Nov 2015 19:46:51 +0000
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.1 cv=CvRCCSMD c=1 sm=1 tr=0
 a=SWxm+s7FAPvPP0IAAWI2og==:117 a=SWxm+s7FAPvPP0IAAWI2og==:17 a=0Bzu9jTXAAAA:8
 a=EBOSESyhAAAA:8 a=N659UExz7-8A:10 a=ZkIGFN-mwHTVqstyOvoA:9 a=pILNOxqGKmIA:10
X-AUTH: ramsayjones@:2500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.3.0
In-Reply-To: <5f62351689318a4ef9feeb3639e6a7a00b354a02.1447085798.git.mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281079>



On 09/11/15 17:03, Michael Haggerty wrote:
> There are a number of constants, structs, and static functions defined
> in refs.c and treated as private to the references module. But we want
> to support multiple reference backends within the reference module,
> and those backends will need access to some heretofore private
> declarations.
> 
> We don't want those declarations to be visible to non-refs code, so we
> don't want to move them to refs.h. Instead, add a new header file,
> refs/refs-internal.h, that is intended to be included only from within
> the refs module. Make some functions non-static and move some
> declarations (and their corresponding docstrings) from refs.c to this
> file.
> 
> In a moment we will add more content to the "refs" subdirectory.
> 
> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
> ---
>  refs.c               | 175 +++----------------------------------------------
>  refs/refs-internal.h | 182 +++++++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 191 insertions(+), 166 deletions(-)
>  create mode 100644 refs/refs-internal.h
> 
> diff --git a/refs.c b/refs.c
> index f48c58a..9aff0c8 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -1,6 +1,6 @@
>  #include "cache.h"
> +#include "refs/refs-internal.h"
>  #include "lockfile.h"
> -#include "refs.h"

This looked wrong to me, until I had read the remainder of the
patch and noticed that the 'internal' header #included the
'public' interface header.

Unfortunately, this still feels wrong to me! I would rather that
the internal header _not_ include the public header (so, include
them _both_ when necessary). Just my opinion, which you can simply
ignore. :-D

ATB,
Ramsay Jones
