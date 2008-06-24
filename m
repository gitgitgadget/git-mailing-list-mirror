From: Jon Loeliger <jdl@freescale.com>
Subject: Re: [PATCH] factorize pack structure allocation
Date: Tue, 24 Jun 2008 18:13:02 -0500
Message-ID: <48617F7E.4020706@freescale.com>
References: <alpine.LFD.1.10.0806241851420.2979@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Teemu Likonen <tlikonen@iki.fi>
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Wed Jun 25 01:14:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBHij-0005pI-4f
	for gcvg-git-2@gmane.org; Wed, 25 Jun 2008 01:14:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752798AbYFXXN0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jun 2008 19:13:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752796AbYFXXN0
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Jun 2008 19:13:26 -0400
Received: from az33egw01.freescale.net ([192.88.158.102]:49480 "EHLO
	az33egw01.freescale.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751321AbYFXXN0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jun 2008 19:13:26 -0400
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw01.freescale.net (8.12.11/az33egw01) with ESMTP id m5OND8oK028908;
	Tue, 24 Jun 2008 16:13:08 -0700 (MST)
Received: from [10.214.72.255] (mvp-10-214-72-255.am.freescale.net [10.214.72.255])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id m5OND6fk017818;
	Tue, 24 Jun 2008 18:13:07 -0500 (CDT)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <alpine.LFD.1.10.0806241851420.2979@xanadu.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86176>

Nicolas Pitre wrote:
> New pack structures are currently allocated in 2 different places
> and all members have to be initialized explicitly.  This is prone
> to errors leading to segmentation faults as found by Teemu Likonen.
> 
> Let's have a common place where this structure is allocated, and have 
> all members implicitly initialized to zero.
> 
> Signed-off-by: Nicolas Pitre <nico@cam.org>
> ---
> diff --git a/sha1_file.c b/sha1_file.c
> index a92f023..c56f674 100644
> --- a/sha1_file.c
> +++ b/sha1_file.c
> @@ -792,18 +792,28 @@ unsigned char* use_pack(struct packed_git *p,
>  	return win->base + offset;
>  }
>  
> +static struct packed_git *alloc_packed_git(int extra)
> +{
> +	struct packed_git *p = xmalloc(sizeof(*p) + extra);
> +	memset(p, 0, sizeof(*p));
> +	p->pack_fd = -1;
> +	return p;
> +}

Nit:  That's an explicit 0 initialization!

jdl
