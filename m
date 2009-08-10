From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC PATCH v2 4/4] read-tree: add --no-sparse to turn off sparse
 hook
Date: Mon, 10 Aug 2009 18:46:05 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0908101842530.8324@intel-tinevez-2-302>
References: <1249917562-5931-1-git-send-email-pclouds@gmail.com> <1249917562-5931-2-git-send-email-pclouds@gmail.com> <1249917562-5931-3-git-send-email-pclouds@gmail.com> <1249917562-5931-4-git-send-email-pclouds@gmail.com>
 <1249917562-5931-5-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-859552127-1249922766=:8324"
Cc: git@vger.kernel.org
To: =?VISCII?Q?Nguy=ADn_Th=E1i_Ng=F7c_Duy?= <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 10 18:46:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MaY0x-0007UQ-0O
	for gcvg-git-2@gmane.org; Mon, 10 Aug 2009 18:46:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932143AbZHJQqI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Aug 2009 12:46:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932110AbZHJQqI
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Aug 2009 12:46:08 -0400
Received: from mail.gmx.net ([213.165.64.20]:60950 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932109AbZHJQqH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Aug 2009 12:46:07 -0400
Received: (qmail invoked by alias); 10 Aug 2009 16:46:06 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp067) with SMTP; 10 Aug 2009 18:46:06 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18xAIEfhScxCH+4yP7PI/d3yph0+QMxhO3Tz1Yv4U
	IGL0VKHsbMIEAW
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <1249917562-5931-5-git-send-email-pclouds@gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.55
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125486>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-859552127-1249922766=:8324
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

Hi,

On Mon, 10 Aug 2009, Nguyễn Thái Ngọc Duy wrote:

> diff --git a/unpack-trees.c b/unpack-trees.c
> index f407bf5..d087112 100644
> --- a/unpack-trees.c
> +++ b/unpack-trees.c
> @@ -530,8 +530,10 @@ int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
>  	if (o->trivial_merges_only && o->nontrivial_merge)
>  		return unpack_failed(o, "Merge requires file-level merging");
>  
> -	if (run_sparse_hook(o))
> -		return unpack_failed(o, NULL);
> +	if (!o->no_sparse_hook) {
> +		if (run_sparse_hook(o))
> +			return unpack_failed(o, NULL);
> +	}
>  

IMHO this would read nicelier as

	if (!o->no_sparse_hook && run_sparse_hook(o))
		return unpack_failed(o, NULL);

> diff --git a/unpack-trees.h b/unpack-trees.h
> index ad21823..81eb2ef 100644
> --- a/unpack-trees.h
> +++ b/unpack-trees.h
> @@ -30,6 +30,7 @@ struct unpack_trees_options {
>  		     skip_unmerged,
>  		     initial_checkout,
>  		     diff_index_cached,
> +		     no_sparse_hook,
>  		     gently;

Hmm.  I understand that the assumption is that memset(&opts, 0, 
sizeof(opts)); should give you a sensible default, but I cannot avoid 
noticing that "no_sparse_hook = 0" is a double negation, something to be 
avoided...

Thanks,
Dscho

--8323329-859552127-1249922766=:8324--
