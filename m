From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] Avoid allocating 0 bytes, was Re: [PATCH 4/4] git-compat-util.h: dietlibc-friendly x{malloc,realloc,calloc}
Date: Fri, 30 Dec 2005 15:00:35 -0800
Message-ID: <20051230230035.GA7165@mail.yhbt.net>
References: <20051224121007.GA19136@mail.yhbt.net> <20051224121454.GC3963@mail.yhbt.net> <7v3bkis631.fsf@assigned-by-dhcp.cox.net> <20051224211546.GG3963@mail.yhbt.net> <Pine.LNX.4.63.0512261916440.8435@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 31 00:01:03 2005
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EsTF6-0007Hy-8r
	for gcvg-git@gmane.org; Sat, 31 Dec 2005 00:01:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964920AbVL3XAk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 30 Dec 2005 18:00:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964929AbVL3XAk
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Dec 2005 18:00:40 -0500
Received: from hand.yhbt.net ([66.150.188.102]:21644 "EHLO mail.yhbt.net")
	by vger.kernel.org with ESMTP id S964920AbVL3XAk (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 30 Dec 2005 18:00:40 -0500
Received: by mail.yhbt.net (Postfix, from userid 500)
	id 402997DC005; Fri, 30 Dec 2005 15:00:35 -0800 (PST)
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0512261916440.8435@wbgn013.biozentrum.uni-wuerzburg.de>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14119>

Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> diff --git a/index-pack.c b/index-pack.c
> index d4ce3af..2927632 100644
> --- a/index-pack.c
> +++ b/index-pack.c
> @@ -103,7 +103,7 @@ static void *unpack_entry_data(unsigned 
>  	unsigned long pack_limit = pack_size - 20;
>  	unsigned long pos = *current_pos;
>  	z_stream stream;
> -	void *buf = xmalloc(size);
> +	void *buf = xmalloc(size ? size : 1);
>  
>  	memset(&stream, 0, sizeof(stream));
>  	stream.next_out = buf;

This is the only one I've managed to hit upon further use the past week
of usage.  No way to break out of the function, either, because
current_pos needs to be updated (and it is changed despite a zero-byte
blob object being in my repository).

-- 
Eric Wong
