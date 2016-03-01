From: Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [PATCH v7 30/33] refs: break out resolve_ref_unsafe_submodule
Date: Tue, 1 Mar 2016 17:21:32 +0000
Message-ID: <56D5CF9C.4010808@ramsayjones.plus.com>
References: <1456793586-22082-1-git-send-email-dturner@twopensource.com>
 <1456793586-22082-31-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>
To: David Turner <dturner@twopensource.com>, git@vger.kernel.org,
	peff@peff.net, mhagger@alum.mit.edu, pclouds@gmail.com
X-From: git-owner@vger.kernel.org Tue Mar 01 18:21:45 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aanzR-0008Rl-7K
	for gcvg-git-2@plane.gmane.org; Tue, 01 Mar 2016 18:21:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752568AbcCARVh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Mar 2016 12:21:37 -0500
Received: from avasout04.plus.net ([212.159.14.19]:52844 "EHLO
	avasout04.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751693AbcCARVg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Mar 2016 12:21:36 -0500
Received: from [10.0.2.15] ([46.208.159.221])
	by avasout04 with smtp
	id QhMY1s0044mu3xa01hMZkA; Tue, 01 Mar 2016 17:21:34 +0000
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.1 cv=K//fZHiI c=1 sm=1 tr=0
 a=Sp5fw55EgyGSOjouSGNDoQ==:117 a=Sp5fw55EgyGSOjouSGNDoQ==:17
 a=L9H7d07YOLsA:10 a=9cW_t1CCXrUA:10 a=s5jvgZ67dGcA:10 a=N659UExz7-8A:10
 a=6NG_XSeZAAAA:8 a=ybZZDoGAAAAA:8 a=KgTIGM78oc_XMtQDjMMA:9 a=pILNOxqGKmIA:10
X-AUTH: ramsayjones@:2500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
In-Reply-To: <1456793586-22082-31-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288041>



On 01/03/16 00:53, David Turner wrote:
> It will soon be useful for resolve_ref_unsafe to support submodules.
> But since it is called from so many places, changing it would have
> been painful.  Fortunately, it's just a thin wrapper around (the
> former) resolve_ref_1.  So now resolve_ref_1 becomes
> resolve_ref_unsafe_submodule, and it passes its submodule argument
> through to read_raw_ref.
> 
> The files backend doesn't need this functionality, but it doesn't
> hurt.
> 
> Signed-off-by: David Turner <dturner@twopensource.com>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  refs.c               | 41 +++++++++++++++++++++++++----------------
>  refs/files-backend.c |  8 ++++++--
>  refs/refs-internal.h | 19 ++++++++++++++++---
>  3 files changed, 47 insertions(+), 21 deletions(-)
> 
> diff --git a/refs.c b/refs.c
> index 5fe0bac..d1cf707 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -60,6 +60,9 @@ void register_ref_storage_backends(void)
>  	 * entries below when you add a new backend.
>  	 */
>  	register_ref_storage_backend(&refs_be_files);
> +#ifdef USE_LIBLMDB
> +	register_ref_storage_backend(&refs_be_lmdb);
> +#endif

Again, just skimming patches, ...

The lmdb refs backend (hence refs_be_lmdb) is not introduced until
the next patch [31/33], right?

ATB,
Ramsay Jones
