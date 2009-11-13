From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: Git in next is broken
Date: Fri, 13 Nov 2009 11:54:30 -0500 (EST)
Message-ID: <alpine.LFD.2.00.0911131152120.16711@xanadu.home>
References: <alpine.LFD.2.00.0911121513470.16711@xanadu.home>
 <4AFC8960.9090808@lsrfire.ath.cx>
 <alpine.LNX.2.00.0911122239150.6967@reaper.quantumfyre.co.uk>
 <alpine.LFD.2.00.0911122345450.16711@xanadu.home>
 <alpine.LNX.2.00.0911130910150.17726@reaper.quantumfyre.co.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: =?ISO-8859-15?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>,
	git@vger.kernel.org
To: Julian Phillips <julian@quantumfyre.co.uk>
X-From: git-owner@vger.kernel.org Fri Nov 13 17:54:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N8zPz-0005a0-2B
	for gcvg-git-2@lo.gmane.org; Fri, 13 Nov 2009 17:54:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755601AbZKMQy0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Nov 2009 11:54:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755318AbZKMQyZ
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Nov 2009 11:54:25 -0500
Received: from relais.videotron.ca ([24.201.245.36]:16083 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753924AbZKMQyZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Nov 2009 11:54:25 -0500
Received: from xanadu.home ([66.130.28.92]) by VL-MO-MR005.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KT20082G4AUUD00@VL-MO-MR005.ip.videotron.ca> for
 git@vger.kernel.org; Fri, 13 Nov 2009 11:54:30 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <alpine.LNX.2.00.0911130910150.17726@reaper.quantumfyre.co.uk>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132838>

On Fri, 13 Nov 2009, Julian Phillips wrote:

> On Thu, 12 Nov 2009, Nicolas Pitre wrote:
> 
> > Without the "ref_map = next" there is no change: glibc still complains
> > about corruption and abort the execution.  With the "ref_map = next"
> > then git simply segfaults.
> 
> I was half right about "ref_map = next", I had forgotten about setting prev in
> the for(...).  For me, the following fixes it on MacOS (I don't have time to
> test on Linux right now):
> 
> diff --git a/remote.c b/remote.c
> index 4f9f0cc..6195a58 100644
> --- a/remote.c
> +++ b/remote.c
> @@ -754,6 +754,8 @@ void ref_remove_duplicates(struct ref *ref_map)
>                         prev->next = ref_map->next;
>                         free(ref_map->peer_ref);
>                         free(ref_map);
> +                       ref_map = prev; // Keep the same prev.
> +                       continue;
>                 }
> 
>                 item = string_list_insert(ref_map->peer_ref->name, &refs);

Yep, this fixes it for me on Linux too.  Please resend to Junio with my 
ACK.


Nicolas
