From: Junio C Hamano <gitster@pobox.com>
Subject: Re: fact-import: failed to apply delta
Date: Tue, 10 Feb 2009 15:15:09 -0800
Message-ID: <7vtz71khoi.fsf@gitster.siamese.dyndns.org>
References: <alpine.LNX.1.00.0902101226580.19665@iabervon.org>
 <20090210191220.GT30949@spearce.org>
 <alpine.LNX.1.00.0902101427300.19665@iabervon.org>
 <20090210201203.GU30949@spearce.org>
 <alpine.LNX.1.00.0902101520240.19665@iabervon.org>
 <20090210212539.GV30949@spearce.org>
 <alpine.LNX.1.00.0902101628140.19665@iabervon.org>
 <20090210213612.GW30949@spearce.org>
 <7vprhqkjrr.fsf@gitster.siamese.dyndns.org>
 <7vfxillxiu.fsf@gitster.siamese.dyndns.org>
 <20090210230950.GX30949@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Daniel Barkalow <barkalow@iabervon.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Feb 11 00:16:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LX1qQ-0002IB-50
	for gcvg-git-2@gmane.org; Wed, 11 Feb 2009 00:16:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756466AbZBJXPU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Feb 2009 18:15:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756391AbZBJXPT
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Feb 2009 18:15:19 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:47932 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755593AbZBJXPS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Feb 2009 18:15:18 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 7C8A59875E;
	Tue, 10 Feb 2009 18:15:17 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id EE3969875A; Tue,
 10 Feb 2009 18:15:10 -0500 (EST)
In-Reply-To: <20090210230950.GX30949@spearce.org> (Shawn O. Pearce's message
 of "Tue, 10 Feb 2009 15:09:50 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: ADF23DDC-F7C8-11DD-9F11-8B21C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109340>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> What more can I really say here other than maybe this?
>
> diff --git a/fast-import.c b/fast-import.c
> index 03b13e0..7bfb563 100644
> --- a/fast-import.c
> +++ b/fast-import.c
> @@ -1204,6 +1204,12 @@ static void *gfi_unpack_entry(
>  		 */
>  		p->pack_size = pack_size + 20;
>  	}
> +	/* DANGER, WILL ROBINSON DANGER !!!!
> +	 *
> +	 * unpack_entry() wasn't meant to be called the way we are
> +	 * about to call it right here.  Be very careful, any sort
> +	 * of assumption is probably wrong.
> +	 */
>  	return unpack_entry(p, oe->offset, &type, sizep);
>  }

Yuck ;-).

>> By the way, strictly speaking, you need to release the delta_base_cache
>> entries that is based on pack_data and nothing else, no?
>
> Right.
>
> But the hiccup of a checkpoint in terms of overall performance is
> such a huge amount (due to needing to re-read the entire pack to
> compute its final checksum) that the loss of the delta_base_cache
> is pretty much a drop in the bucket here.
>
> I can go back and add in a struct packed_git* and filter to only
> those entries in the cache, but it doesn't seem worth it to me.

Nah, that was not a suggestion but a question.

The patch can and should go to maint, right?
