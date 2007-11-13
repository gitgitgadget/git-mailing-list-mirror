From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH/RFC 1/3] send-pack: track errors for each ref
Date: Tue, 13 Nov 2007 20:04:47 +0100
Message-ID: <20071113190447.GB3268@steel.home>
References: <20071113102500.GA2767@sigill.intra.peff.net> <20071113102709.GA2905@sigill.intra.peff.net>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Pierre Habouzit <madcoder@debian.org>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Nov 13 20:08:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Is17W-000451-Ik
	for gcvg-git-2@gmane.org; Tue, 13 Nov 2007 20:08:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757360AbXKMTEw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Nov 2007 14:04:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754045AbXKMTEv
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Nov 2007 14:04:51 -0500
Received: from mo-p07-ob.rzone.de ([81.169.146.190]:49364 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753189AbXKMTEu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Nov 2007 14:04:50 -0500
Received: from tigra.home (Faa9a.f.strato-dslnet.de [195.4.170.154])
	by post.webmailer.de (fruni mo1) (RZmta 14.0)
	with ESMTP id e0215djADHwlhF ; Tue, 13 Nov 2007 20:04:47 +0100 (MET)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 7111D277AE;
	Tue, 13 Nov 2007 20:04:47 +0100 (CET)
Received: by steel.home (Postfix, from userid 1000)
	id 1563356D22; Tue, 13 Nov 2007 20:04:47 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20071113102709.GA2905@sigill.intra.peff.net>
User-Agent: Mutt/1.5.15+20070412 (2007-04-11)
X-RZG-AUTH: z4gQVF2k5XWuW3CculzxtolA10Q=
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64829>

Jeff King, Tue, Nov 13, 2007 11:27:09 +0100:
> diff --git a/cache.h b/cache.h
> index 5f40e12..ca5d96d 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -499,8 +499,17 @@ struct ref {
>  	struct ref *next;
>  	unsigned char old_sha1[20];
>  	unsigned char new_sha1[20];
> -	unsigned char force;
> -	unsigned char merge;
> +	unsigned char force : 1;
> +	unsigned char merge : 1;
> +	unsigned char nonff : 1;

        unsigned char fastforward : 1; ? ffwd?

> +	unsigned char deletion : 1;
> +	enum {
> +		REF_STATUS_NONE = 0,
> +		REF_STATUS_OK,
> +		REF_STATUS_NONFF,

isn't it a duplication of nonff?
