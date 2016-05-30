From: Mike Hommey <mh@glandium.org>
Subject: Re: [PATCH 2/2] strbuf: allow to use preallocated memory
Date: Tue, 31 May 2016 06:56:52 +0900
Message-ID: <20160530215652.GA6456@glandium.org>
References: <20160530103642.7213-1-william.duclot@ensimag.grenoble-inp.fr>
 <20160530103642.7213-3-william.duclot@ensimag.grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, simon.rabourg@ensimag.grenoble-inp.fr,
	francois.beutin@ensimag.grenoble-inp.fr,
	antoine.queru@ensimag.grenoble-inp.fr,
	matthieu.moy@grenoble-inp.fr, mhagger@alum.mit.edu
To: William Duclot <william.duclot@ensimag.grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon May 30 23:57:19 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b7VBV-0002kl-D6
	for gcvg-git-2@plane.gmane.org; Mon, 30 May 2016 23:57:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1162550AbcE3V5J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 May 2016 17:57:09 -0400
Received: from ns332406.ip-37-187-123.eu ([37.187.123.207]:55518 "EHLO
	glandium.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1162321AbcE3V5E (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 May 2016 17:57:04 -0400
Received: from glandium by zenigata with local (Exim 4.87)
	(envelope-from <mh@glandium.org>)
	id 1b7VB6-0001wT-NL; Tue, 31 May 2016 06:56:52 +0900
Content-Disposition: inline
In-Reply-To: <20160530103642.7213-3-william.duclot@ensimag.grenoble-inp.fr>
X-GPG-Fingerprint: 182E 161D 1130 B9FC CD7D  B167 E42A A04F A6AA 8C72
User-Agent: Mutt/1.6.0 (2016-04-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295934>

>  struct strbuf {
> +	unsigned int flags;
>  	size_t alloc;
>  	size_t len;
>  	char *buf;
>  };

Depending whether the size of strbuf matters, it /might/ be worth
considering some packing here. malloc() usually returns buffers that can
contain more data than what is requested. Which means allocation sizes
could be rounded and that wouldn't change the amount of allocated
memory. On glibc malloc_usable_size(malloc(1)) apparently returns 24.
On jemalloc, it's 4 or 8. It's in the same ballbark with many
allocators.

So, it would be possible to round alloc such that it's always a multiple
of, say, 4, and stick flags in the low, unused bits.

Whether it's worth doing is another question.

Mike
