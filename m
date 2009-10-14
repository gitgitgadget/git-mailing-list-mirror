From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: git hang with corrupted .pack
Date: Wed, 14 Oct 2009 14:39:23 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0910141435040.20122@xanadu.home>
References: <20091014042249.GA5250@hexapodia.org>
 <20091014142351.GI9261@spearce.org>
 <alpine.LFD.2.00.0910141208170.20122@xanadu.home>
 <20091014161259.GK9261@spearce.org>
 <alpine.LFD.2.00.0910141234540.20122@xanadu.home>
 <20091014180302.GL9261@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <gitster@pobox.com>,
	Andy Isaacson <adi@hexapodia.org>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Oct 14 21:54:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1My9w0-0008I1-Ac
	for gcvg-git-2@lo.gmane.org; Wed, 14 Oct 2009 21:54:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759078AbZJNTqI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Oct 2009 15:46:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753694AbZJNTqI
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Oct 2009 15:46:08 -0400
Received: from relais.videotron.ca ([24.201.245.36]:53678 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753512AbZJNTqH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Oct 2009 15:46:07 -0400
Received: from xanadu.home ([66.130.28.92]) by VL-MR-MR002.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-8.01 (built Dec 16 2008; 32bit))
 with ESMTP id <0KRI00BQOP5NGNF0@VL-MR-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 14 Oct 2009 14:39:23 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <20091014180302.GL9261@spearce.org>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130328>

On Wed, 14 Oct 2009, Shawn O. Pearce wrote:

> Junio, can you please squash this in?
> 
> diff --git a/t/t5303-pack-corruption-resilience.sh b/t/t5303-pack-corruption-resilience.sh
> index 5132d41..5f6cd4f 100755
> --- a/t/t5303-pack-corruption-resilience.sh
> +++ b/t/t5303-pack-corruption-resilience.sh
> @@ -275,4 +275,13 @@ test_expect_success \
>       git cat-file blob $blob_2 > /dev/null &&
>       git cat-file blob $blob_3 > /dev/null'
>  
> +test_expect_success \
> +    'corrupting header to have too small output buffer fails unpack' \
> +    'create_new_pack &&
> +     git prune-packed &&
> +     printf "\262\001" | do_corrupt_object $blob_1 0 &&
> +     test_must_fail git cat-file blob $blob_1 > /dev/null &&
> +     test_must_fail git cat-file blob $blob_2 > /dev/null &&
> +     test_must_fail git cat-file blob $blob_3 > /dev/null'
> +
>  test_done
> 
> -- 

I confirm this test without the fix reproduces the infinite loop (and 
does stall the test suite).


Nicolas
