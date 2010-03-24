From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] Make xmalloc and xrealloc thread-safe
Date: Wed, 24 Mar 2010 13:28:14 -0700
Message-ID: <20100324202814.GA24830@spearce.org>
References: <20100323173114.GB4218@fredrik-laptop> <20100323184309.GA31668@spearce.org> <4c8ef71003231421u789c4332h461c066add0ec7b1@mail.gmail.com> <alpine.LFD.2.00.1003231945480.31128@xanadu.home> <4c8ef71003240823o7cd733bn5f19699305c94cba@mail.gmail.com> <alpine.LFD.2.00.1003241133430.694@xanadu.home> <ec874dac1003241122s3d592f26n1b23d23144939218@mail.gmail.com> <alpine.LFD.2.00.1003241435300.694@xanadu.home> <ec874dac1003241257r3cad86c9q1af84d3732e23ca8@mail.gmail.com> <alpine.LFD.2.00.1003241613020.694@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Fredrik Kuivinen <frekui@gmail.com>, git@vger.kernel.org,
	Johannes Sixt <j6t@kdbg.org>
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Wed Mar 24 21:28:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NuXBg-0003NZ-2L
	for gcvg-git-2@lo.gmane.org; Wed, 24 Mar 2010 21:28:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932313Ab0CXU2S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Mar 2010 16:28:18 -0400
Received: from mail-pz0-f194.google.com ([209.85.222.194]:58442 "EHLO
	mail-pz0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751221Ab0CXU2R (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Mar 2010 16:28:17 -0400
Received: by pzk32 with SMTP id 32so1255734pzk.4
        for <git@vger.kernel.org>; Wed, 24 Mar 2010 13:28:17 -0700 (PDT)
Received: by 10.114.186.29 with SMTP id j29mr5504719waf.99.1269462497048;
        Wed, 24 Mar 2010 13:28:17 -0700 (PDT)
Received: from localhost (george.spearce.org [209.20.77.23])
        by mx.google.com with ESMTPS id 21sm310221iwn.7.2010.03.24.13.28.15
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 24 Mar 2010 13:28:16 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.1003241613020.694@xanadu.home>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143119>

Nicolas Pitre <nico@fluxnic.net> wrote:
> Note: there was a dubious usage of fd when calling release_pack_memory() 
> in xmmap() which is now removed.
...
> @@ -100,7 +112,7 @@ void *xmmap(void *start, size_t length,
>  	if (ret == MAP_FAILED) {
>  		if (!length)
>  			return NULL;
> -		release_pack_memory(length, fd);
> +		try_to_free_routine(length);

This isn't dubious!  The fd passed here is to prevent the pack
release code from closing this fd right before we try to mmap it.
Its an actual bug fix that I had to write years ago, check the
history of that section of code...  :-)

-- 
Shawn.
