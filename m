From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 2/2] fast-import: treat cat-blob as a delta base hint for
 next blob
Date: Sat, 20 Aug 2011 14:17:55 -0500
Message-ID: <20110820191754.GA22833@elie.gateway.2wire.net>
References: <1313867052-11993-1-git-send-email-divanorama@gmail.com>
 <1313867052-11993-3-git-send-email-divanorama@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>,
	David Barr <davidbarr@google.com>
To: Dmitry Ivankov <divanorama@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 20 21:18:09 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qur3Y-0003jR-CB
	for gcvg-git-2@lo.gmane.org; Sat, 20 Aug 2011 21:18:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754870Ab1HTTSE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Aug 2011 15:18:04 -0400
Received: from mail-iy0-f170.google.com ([209.85.210.170]:39734 "EHLO
	mail-iy0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754718Ab1HTTSC (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Aug 2011 15:18:02 -0400
Received: by iye16 with SMTP id 16so7658982iye.1
        for <git@vger.kernel.org>; Sat, 20 Aug 2011 12:18:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=6eA7I1RBvfXcivHvbF9VKKM4DCD+gE/2LruBDu43VQ0=;
        b=loTdLE+JEUxnbbOGxqZ9+v5tDWM5nEp7xKEtY3mM3HQWU3NQZzKqH8sAufHCH1HqPV
         n4XywNC3WilgLppoBTJyS7u51rF9VOGKo9S+jSYVfZIgJ0ynVles5rx6aFdgcyNubFdP
         XUb48p7NOU3iBSceQKZgCPl2y/2RhcQRV96Gc=
Received: by 10.231.54.104 with SMTP id p40mr1866783ibg.39.1313867881206;
        Sat, 20 Aug 2011 12:18:01 -0700 (PDT)
Received: from elie.gateway.2wire.net (adsl-69-209-48-207.dsl.chcgil.sbcglobal.net [69.209.48.207])
        by mx.google.com with ESMTPS id b4sm1454756iba.15.2011.08.20.12.18.00
        (version=SSLv3 cipher=OTHER);
        Sat, 20 Aug 2011 12:18:00 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1313867052-11993-3-git-send-email-divanorama@gmail.com>
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179780>

Dmitry Ivankov wrote:

> --- a/fast-import.c
> +++ b/fast-import.c
> @@ -2802,7 +2802,12 @@ static void cat_blob(struct object_entry *oe, unsigned char sha1[20])
>  	strbuf_release(&line);
>  	cat_blob_write(buf, size);
>  	cat_blob_write("\n", 1);
> -	free(buf);
> +	if (oe && oe->pack_id == pack_id) {
> +		strbuf_attach(&last_blob.data, buf, size, size);
> +		last_blob.offset = oe->idx.offset;
> +		last_blob.depth = oe->depth;
> +	} else
> +		free(buf);
>  }

Neat.  For what it's worth,
Acked-by: Jonathan Nieder <jrnieder@gmail.com>
