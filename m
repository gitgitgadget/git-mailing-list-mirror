From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH 0/4] Honor core.deltaBaseCacheLimit during index-pack
Date: Sun, 13 Jul 2008 22:27:18 -0400 (EDT)
Message-ID: <alpine.LFD.1.10.0807132220570.12484@xanadu.home>
References: <20080713011512.GB31050@spearce.org>
 <1216001267-33235-1-git-send-email-spearce@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <gitster@pobox.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Stephan Hennig <mailing_list@arcor.de>,
	Andreas Ericsson <ae@op5.se>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Jul 14 04:28:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KIDnv-0004uv-MI
	for gcvg-git-2@gmane.org; Mon, 14 Jul 2008 04:28:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754476AbYGNC1k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Jul 2008 22:27:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754454AbYGNC1k
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Jul 2008 22:27:40 -0400
Received: from relais.videotron.ca ([24.201.245.36]:52724 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754062AbYGNC1j (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Jul 2008 22:27:39 -0400
Received: from xanadu.home ([66.131.194.97]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0K3Z005H85HIM3I0@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Sun, 13 Jul 2008 22:27:19 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <1216001267-33235-1-git-send-email-spearce@spearce.org>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88367>

On Sun, 13 Jul 2008, Shawn O. Pearce wrote:

> This should resolve the obscene memory usage of index-pack when
> resolving deltas for very large files.
> 
> Shawn O. Pearce (4):
>   index-pack: Refactor base arguments of resolve_delta into a struct
>   index-pack: Chain the struct base_data on the stack for traversal
>   index-pack: Track the object_entry that creates each base_data
>   index-pack: Honor core.deltaBaseCacheLimit when resolving deltas

Well... 

I don't like this.  Not your patch, but rather the direction this whole 
thing took in the first place, and now we have to bolt extra complexity 
on top.

I have the feeling this is not the best approach, especially since many 
long delta chains are going deep and all those intermediate objects are 
simply useless once the _only_ delta child has been resolved and 
therefore could be freed right away instead.

But I have to sleep on it first.


Nicolas
