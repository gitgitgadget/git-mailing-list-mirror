From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 05/21] Make parse_tag_buffer_internal() handle item ==
 NULL
Date: Sun, 10 Jun 2007 09:06:37 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0706100905210.4059@racer.site>
References: <Pine.LNX.4.64.0706072348110.4046@racer.site>
 <7vzm3aig7j.fsf@assigned-by-dhcp.cox.net> <200706090210.36270.johan@herland.net>
 <200706090214.39337.johan@herland.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Sun Jun 10 10:10:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HxIUo-00010s-1M
	for gcvg-git@gmane.org; Sun, 10 Jun 2007 10:09:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762445AbXFJIJw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 10 Jun 2007 04:09:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762412AbXFJIJu
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Jun 2007 04:09:50 -0400
Received: from mail.gmx.net ([213.165.64.20]:42389 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1762165AbXFJIJt (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Jun 2007 04:09:49 -0400
Received: (qmail invoked by alias); 10 Jun 2007 08:09:48 -0000
Received: from rdcg01.wifihubtelecom.net (EHLO [10.140.3.169]) [213.174.113.122]
  by mail.gmx.net (mp046) with SMTP; 10 Jun 2007 10:09:48 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19WUPg8G61WWF6xJldZ8iqD/k/NVZ6ry3SCPhODP5
	ldiS122ZDqZ1Al
X-X-Sender: gene099@racer.site
In-Reply-To: <200706090214.39337.johan@herland.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49670>

Hi,

On Sat, 9 Jun 2007, Johan Herland wrote:

> -	tag_len = tagger_line - tag_line - strlen("tag \n");
> -	item->tag = xmalloc(tag_len + 1);
> -	memcpy(item->tag, tag_line + 4, tag_len);
> -	item->tag[tag_len] = '\0';
> -
> -	if (!strcmp(type, blob_type)) {
> -		item->tagged = &lookup_blob(sha1)->object;
> -	} else if (!strcmp(type, tree_type)) {
> -		item->tagged = &lookup_tree(sha1)->object;
> -	} else if (!strcmp(type, commit_type)) {
> -		item->tagged = &lookup_commit(sha1)->object;
> -	} else if (!strcmp(type, tag_type)) {
> -		item->tagged = &lookup_tag(sha1)->object;
> -	} else {
> -		error("Unknown type %s", type);
> -		item->tagged = NULL;
> -	}
> -
> -	if (item->tagged && track_object_refs) {
> -		struct object_refs *refs = alloc_object_refs(1);
> -		refs->ref[0] = item->tagged;
> -		set_object_refs(&item->object, refs);
> +	if (item) {
> +		tag_len = tagger_line - tag_line - strlen("tag \n");
> +		item->tag = xmalloc(tag_len + 1);
> +		memcpy(item->tag, tag_line + 4, tag_len);
> +		item->tag[tag_len] = '\0';
> +
> +		if (!strcmp(type, blob_type)) {
> +			item->tagged = &lookup_blob(sha1)->object;
> +		} else if (!strcmp(type, tree_type)) {
> +			item->tagged = &lookup_tree(sha1)->object;
> +		} else if (!strcmp(type, commit_type)) {
> +			item->tagged = &lookup_commit(sha1)->object;
> +		} else if (!strcmp(type, tag_type)) {
> +			item->tagged = &lookup_tag(sha1)->object;
> +		} else {
> +			error("Unknown type %s", type);
> +			item->tagged = NULL;
> +		}
> +
> +		if (item->tagged && track_object_refs) {
> +			struct object_refs *refs = alloc_object_refs(1);
> +			refs->ref[0] = item->tagged;
> +			set_object_refs(&item->object, refs);
> +		}
>  	}
>  
>  	return 0;

The patch would have been so much simpler, and so much more descriptive of 
what you're doing, had you just said

	if (!item)
		return 0;

Ciao,
Dscho
