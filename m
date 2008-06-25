From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] pack.indexversion config option now defaults to 2
Date: Wed, 25 Jun 2008 14:49:20 -0400 (EDT)
Message-ID: <alpine.LFD.1.10.0806251442500.2979@xanadu.home>
References: <alpine.LFD.1.10.0806250025130.2979@xanadu.home>
 <alpine.LFD.1.10.0806242130450.22069@hp.linux-foundation.org>
 <7vd4m66rfp.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Linus Torvalds <torvalds@linux-foundation.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 25 20:50:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBa4Q-00076I-IX
	for gcvg-git-2@gmane.org; Wed, 25 Jun 2008 20:50:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753275AbYFYStW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Jun 2008 14:49:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753171AbYFYStW
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Jun 2008 14:49:22 -0400
Received: from relais.videotron.ca ([24.201.245.36]:33310 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753128AbYFYStV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jun 2008 14:49:21 -0400
Received: from xanadu.home ([66.131.194.97]) by VL-MO-MR005.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0K31007KB89L8KC0@VL-MO-MR005.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 25 Jun 2008 14:48:57 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <7vd4m66rfp.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86318>

On Tue, 24 Jun 2008, Junio C Hamano wrote:

> For the other "usedeltabaseoffset" change, I think the insn in the
> documentation Nico added is reasonable:
> 
> +	By default, linkgit:git-repack[1] creates packs that use
> +	delta-base offset. If you need to share your repository with
> +	git older than version 1.4.4, either directly or via a dumb
> +	protocol such as http, then you need to set this option to
> +	"false" and repack. Access from old git versions over the
> +	native protocol are unaffected by this option.
> 
> except perhaps that the "set false and repack" should be clarified
> further, perhaps like:
> 
> 	... then you need to set this option to "false" and repack using
> 	git that is newer than (and including) v1.5.0.

Actually the first release to support this is v1.4.4 not v1.5.0.

> I am basing the above 1.5.0 on description of b6945f5 (git-repack:
> repo.usedeltabaseoffset, 2006-10-13).

$ git describe --contains b6945f5
v1.4.4-rc1~77^2~2

> On the "indexVersion" change, the documentation reads:
> 
> pack.indexVersion::
> 	Specify the default pack index version.  Valid values are 1 for
>  	legacy pack index used by Git versions prior to 1.5.2, and 2 for
>  	the new pack index with capabilities for packs larger than 4 GB
>  	as well as proper protection against the repacking of corrupted
> +	packs.  Version 2 is the default.  Note that version 2 is enforced
> +	and this config option ignored whenever the corresponding pack is
> +	larger than 2 GB.
> 
> which lacks the recovery insn (and it is int strictly the fault of this
> patch, but we should have done this when we introduced the v2 idx).  I
> think a separate paragraph after the above would be necessary and
> sufficient:
> 
> 	If you have an ancient git that does not understand the version 2
> 	`*.idx` file, cloning or fetching over a non native protocol
> 	(e.g. "http" and "rsync") which will copy both `*.pack` file and
> 	corresponding `*.idx` file from the other side may give you a
> 	repository that cannot be accessed with your old git.  If the
> 	`*.pack` file is smaller than 2 GB, however, you can use
> 	`git-index-pack` on the `*.pack` to regenerate the `*.idx` file.

Looks fine to me.  Will you amend the patches or do you want me to 
repost them?


Nicolas
