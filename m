From: Nicolas Pitre <nico@cam.org>
Subject: Re: Understanding version 4 packs
Date: Sat, 24 Mar 2007 19:24:17 -0400 (EDT)
Message-ID: <alpine.LFD.0.83.0703241913110.18328@xanadu.home>
References: <20070324202356.GA20734@bohr.gbar.dtu.dk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Peter Eriksen <s022018@student.dtu.dk>
X-From: git-owner@vger.kernel.org Sun Mar 25 00:24:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HVFb9-0000ln-G7
	for gcvg-git@gmane.org; Sun, 25 Mar 2007 00:24:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932908AbXCXXYT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 24 Mar 2007 19:24:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932910AbXCXXYT
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Mar 2007 19:24:19 -0400
Received: from relais.videotron.ca ([24.201.245.36]:55834 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932908AbXCXXYS (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Mar 2007 19:24:18 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JFF00LSJL0HWRS0@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Sat, 24 Mar 2007 19:24:18 -0400 (EDT)
In-reply-to: <20070324202356.GA20734@bohr.gbar.dtu.dk>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43023>

On Sat, 24 Mar 2007, Peter Eriksen wrote:

> There is a new tree type called OBJ_DICT_TREE, which looks something
> like the following:
> 
> +-----------------+------------------------------------------------+----
> |  Table offset   |  SHA-1 of the blob corresponding to the path.  | ...
> +-----------------+------------------------------------------------+----
>       6 bytes                     20 bytes

Actually it is a 2-byte index in the path table, and a 4-byte index in a 
common SHA1 table.  So each tree entry is 6 bytes total.

> These new tree objects will remain uncompressed in the pack file, but
> sorted with, and deltaed against other tree objects. All normal tree
> objects are converted to OBJ_DICT_TREE when packing, and are converted
> back on the fly to callers who need an ordinary OBJ_TREE.

Right.

> The index (.idx) files are extended to have a 4 byte pointer to the
> offset of this file name table in the pack file for easy lookup.

Right.  And it will lose the SHA1 entries since they are already 
available in the pack.

> There is something similar with a table of common strings in commit
> objects (e.g. author and timezone), and a new object OBJ_DICT_COMMIT,
> but I have not understood that quite yet.
> 
> Is there something, I have gotten wrong with regards to my
> understanding?

I don't think so.  Note that the code is still a work in progress and 
the resulting pack/index is not yet fully conform to the format we 
envisaged.


Nicolas
