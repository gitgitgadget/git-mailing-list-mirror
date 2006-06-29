From: Junio C Hamano <junkio@cox.net>
Subject: Re: CFT: merge-recursive in C (updated)
Date: Wed, 28 Jun 2006 19:41:23 -0700
Message-ID: <7vzmfwy97w.fsf@assigned-by-dhcp.cox.net>
References: <81b0412b0606270848v2253209aw52466de632ab25c1@mail.gmail.com>
	<Pine.LNX.4.63.0606271830210.29667@wbgn013.biozentrum.uni-wuerzburg.de>
	<20060627223249.GA8177@steel.home>
	<81b0412b0606280234x7d07fbbck7887b5214d98bf91@mail.gmail.com>
	<20060629002547.GA27507@steel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 29 04:41:31 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FvmTB-00065t-3E
	for gcvg-git@gmane.org; Thu, 29 Jun 2006 04:41:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751358AbWF2ClZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 28 Jun 2006 22:41:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751390AbWF2ClZ
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Jun 2006 22:41:25 -0400
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:5251 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S1751358AbWF2ClZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Jun 2006 22:41:25 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060629024124.IBID12581.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 28 Jun 2006 22:41:24 -0400
To: Alex Riesen <raa.lkml@gmail.com>
In-Reply-To: <20060629002547.GA27507@steel.home> (Alex Riesen's message of
	"Thu, 29 Jun 2006 02:25:47 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22833>

fork0@t-online.de (Alex Riesen) writes:

> this broke t6022-merge-rename.sh (the second test). It produces an
> index with this:
>
> .../t/trash$ git-diff-index white
> :100644 100644 2d603156dc5bdf6295c789cac08e3c9942a0b82a 0000000000000000000000000000000000000000 M      B
> :100644 100644 ba41fb96393979b22691106b06bf5231eab57b85 0000000000000000000000000000000000000000 M      N
>
> whereas git-merge-recursive (and the previous version, without pipe):
>
> .../t/trash$ git-diff-index white
> :100644 100644 2d603156dc5bdf6295c789cac08e3c9942a0b82a 0000000000000000000000000000000000000000 M      B
>
> I can see that "git update-index --add" is somehow different from a
> pipe to "git update-index --index-info", but not very clear. Does this
> "zero-sha1" mean that the file "N" is not in the index?

When diff-index and diff-files compare a tree entry or an index
entry with a file in the working tree, they do not compute the
blob hash value for the file in the working tree.  0{40} is used
on the RHS in such a case.  When the working tree file matches
the corresponding index entry, then we know RHS matches what is
in the index, so both sides have the blob hash value.
