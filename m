From: Nicolas Pitre <nico@cam.org>
Subject: Re: A look at some alternative PACK file encodings
Date: Thu, 07 Sep 2006 13:32:47 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0609071322010.18635@xanadu.home>
References: <20060907090756.30111.qmail@science.horizon.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: gitzilla@gmail.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 07 19:32:57 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GLNkF-0000E7-QW
	for gcvg-git@gmane.org; Thu, 07 Sep 2006 19:32:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751777AbWIGRct (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 7 Sep 2006 13:32:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751779AbWIGRct
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Sep 2006 13:32:49 -0400
Received: from relais.videotron.ca ([24.201.245.36]:45721 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP
	id S1751777AbWIGRcs (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Sep 2006 13:32:48 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0J5800GY6GQNWW20@VL-MH-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 07 Sep 2006 13:32:48 -0400 (EDT)
In-reply-to: <20060907090756.30111.qmail@science.horizon.com>
X-X-Sender: nico@xanadu.home
To: linux@horizon.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26647>

On Thu, 7 Sep 2006, linux@horizon.com wrote:

> > Support for 'thin' packs would pretty much require mixing IDs and
> > (relative) offsets in the same pack file.
> 
> An alternative would be to create a small "placeholder" object that
> just gives an ID, then refer to it by offset.
> 
> That would avoid the need for an id/offset bit with every offset,
> and possibly save more space if the same object was referenced
> multiple times.

Well... I'm using object type 6 for deltas with offset reference 
(instead of object type 7 that is delta with sha1 reference).  So 
there is no extra bit needed and no backward compatibility breakage.

There could be of course a new object type which payload is only a sha1 
that deltas type 6 reference. But that can be introduced at a later date 
if it turns out to be worthwhile (i.e. the actual saving in real use 
scenarios is worth the (small but still) added complexity).

> And it just seems simpler.

Well I would not say so.  Simply prefixing a delta with the sha1 of its 
base object cannot be simpler when streaming out a pack.


Nicolas
