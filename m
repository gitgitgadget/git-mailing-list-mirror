From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 2/2] WIP per-path attribute based hunk header selection.
Date: Thu, 5 Jul 2007 12:25:36 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707051223520.9789@racer.site>
References: <Pine.LNX.4.64.0707041905570.4071@racer.site>
 <alpine.LFD.0.98.0707041140230.9434@woody.linux-foundation.org>
 <7vejjnhpap.fsf@assigned-by-dhcp.cox.net> <7vwsxfe96i.fsf@assigned-by-dhcp.cox.net>
 <7vlkdve93o.fsf_-_@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linus Torvalds <torvalds@linux-foundation.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 05 13:25:54 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I6PT7-0007wU-2m
	for gcvg-git@gmane.org; Thu, 05 Jul 2007 13:25:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754258AbXGELZv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 5 Jul 2007 07:25:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753998AbXGELZu
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Jul 2007 07:25:50 -0400
Received: from mail.gmx.net ([213.165.64.20]:47074 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753091AbXGELZu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Jul 2007 07:25:50 -0400
Received: (qmail invoked by alias); 05 Jul 2007 11:25:48 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp028) with SMTP; 05 Jul 2007 13:25:48 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX196d381S/t6E1koqlPn9ChnpLK05xaaXOs48+FxkB
	/ZjJs7ZCJzlJn9
X-X-Sender: gene099@racer.site
In-Reply-To: <7vlkdve93o.fsf_-_@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51668>

Hi,

On Wed, 4 Jul 2007, Junio C Hamano wrote:

> diff --git a/diff.c b/diff.c
> index 552f7c0..0c7d2c6 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -3011,21 +3079,6 @@ void diffcore_std(struct diff_options *options)
>  	if (options->quiet)
>  		return;
>  
> -	/*
> -	 * break/rename count similarity differently depending on
> -	 * the binary-ness.
> -	 */
> -	if ((options->break_opt != -1) || (options->detect_rename)) {
> -		struct diff_queue_struct *q = &diff_queued_diff;
> -		int i;
> -
> -		for (i = 0; i < q->nr; i++) {
> -			struct diff_filepair *p = q->queue[i];
> -			p->one->is_binary = file_is_binary(p->one);
> -			p->two->is_binary = file_is_binary(p->two);
> -		}
> -	}
> -
>  	if (options->break_opt != -1)
>  		diffcore_break(options->break_opt);
>  	if (options->detect_rename)
> diff --git a/diffcore-delta.c b/diffcore-delta.c
> index a038b16..d9729e5 100644
> --- a/diffcore-delta.c
> +++ b/diffcore-delta.c
> @@ -129,7 +129,7 @@ static struct spanhash_top *hash_chars(struct diff_filespec *one)
>  	struct spanhash_top *hash;
>  	unsigned char *buf = one->data;
>  	unsigned int sz = one->size;
> -	int is_text = !one->is_binary;
> +	int is_text = !diff_filespec_is_binary(one);
>  
>  	i = INITIAL_HASH_SIZE;
>  	hash = xmalloc(sizeof(*hash) + sizeof(struct spanhash) * (1<<i));

It is quite cute to hide this in the funcname patch...

Ciao,
Dscho
