From: bdowning@lavos.net (Brian Downing)
Subject: Re: [PATCH] Don't allow fast-import tree delta chains to exceed maximum depth
Date: Tue, 13 Nov 2007 23:45:24 -0600
Message-ID: <20071114054524.GV6212@lavos.net>
References: <20071114044842.GA6876@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Nov 14 06:45:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IsB4K-0004Xn-Ch
	for gcvg-git-2@gmane.org; Wed, 14 Nov 2007 06:45:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759941AbXKNFp1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Nov 2007 00:45:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758302AbXKNFp1
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Nov 2007 00:45:27 -0500
Received: from mxsf07.insightbb.com ([74.128.0.77]:47570 "EHLO
	mxsf07.insightbb.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756845AbXKNFp0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Nov 2007 00:45:26 -0500
X-IronPort-AV: E=Sophos;i="4.21,414,1188792000"; 
   d="scan'208";a="131502463"
Received: from unknown (HELO asav01.insightbb.com) ([172.31.249.124])
  by mxsf07.insightbb.com with ESMTP; 14 Nov 2007 00:45:25 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Ah4FAKMaOkdKhvkY/2dsb2JhbACBWw
X-IronPort-AV: E=Sophos;i="4.21,414,1188792000"; 
   d="scan'208";a="94091622"
Received: from 74-134-249-24.dhcp.insightbb.com (HELO mail.lavos.net) ([74.134.249.24])
  by asav01.insightbb.com with ESMTP; 14 Nov 2007 00:45:24 -0500
Received: by mail.lavos.net (Postfix, from userid 1000)
	id BF2EF309F21; Tue, 13 Nov 2007 23:45:24 -0600 (CST)
Content-Disposition: inline
In-Reply-To: <20071114044842.GA6876@spearce.org>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64948>

On Tue, Nov 13, 2007 at 11:48:42PM -0500, Shawn O. Pearce wrote:
> @@ -1105,7 +1108,7 @@ static int store_object(
>  		unsigned pos = sizeof(hdr) - 1;
>  
>  		delta_count_by_type[type]++;
> -		last->depth++;
> +		e->depth = ++last->depth++;
>  
>  		hdrlen = encode_header(OBJ_OFS_DELTA, deltalen, hdr);
>  		write_or_die(pack_data->pack_fd, hdr, hdrlen);

I'm not sure, but I think that's too many ++'s.

The earlier patch had:

@@ -1084,6 +1087,7 @@ static int store_object(

                delta_count_by_type[type]++;
                last->depth++;
+               e->depth = last->depth;

                hdrlen = encode_header(OBJ_OFS_DELTA, deltalen, hdr);
                write_or_die(pack_data->pack_fd, hdr, hdrlen);

Which of course would be the equivalent of:

> +		e->depth = ++last->depth;

Maybe there's some cleverness here I'm missing, though.

-bcd
