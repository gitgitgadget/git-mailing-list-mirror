From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: bad object
Date: Wed, 22 Apr 2009 17:00:01 -0400
Message-ID: <20090422210001.GI9541@fieldses.org>
References: <20090422184842.GC9541@fieldses.org> <7vbpqo31fx.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 22 23:01:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LwjZb-0001Tn-NN
	for gcvg-git-2@gmane.org; Wed, 22 Apr 2009 23:01:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753585AbZDVVAF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Apr 2009 17:00:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753153AbZDVVAF
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Apr 2009 17:00:05 -0400
Received: from mail.fieldses.org ([141.211.133.115]:60954 "EHLO
	pickle.fieldses.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752967AbZDVVAE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Apr 2009 17:00:04 -0400
Received: from bfields by pickle.fieldses.org with local (Exim 4.69)
	(envelope-from <bfields@fieldses.org>)
	id 1LwjY1-0003UO-GP; Wed, 22 Apr 2009 17:00:01 -0400
Content-Disposition: inline
In-Reply-To: <7vbpqo31fx.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117259>

On Wed, Apr 22, 2009 at 12:58:42PM -0700, Junio C Hamano wrote:
> "J. Bruce Fields" <bfields@fieldses.org> writes:
> 
> > Just today operations started warning:
> >
> > 	error: Could not read 4e69489a0ac11a9b62a25923975bfc370a30eae5
> >
> > This is Documentation/networking/baycom.txt from
> > 518e6540831c69422faecceee8f964bd439ac9d0 (pre-2.6.13), which is easy
> > enough to find from another repository and fix the problem.
> >
> > But I'm curious--how do I find out what pack file that object should be
> > in, and what the corruption looks like?
> 
> The former you should be able to read from either "verify-pack -v" or
> "show-index" output.

Thanks.  So:

bfields@pig:~/local/linux-2.6$ git verify-pack -v .git/objects/pack/pack-691dbdb94f881bc07a0befa45f288466bde6207b
error: Packfile index for .git/objects/pack/pack-691dbdb94f881bc07a0befa45f288466bde6207b.pack SHA1 mismatch
error: packed 000000e0199ffeffffffd143feffd143feff00c0 from .git/objects/pack/pack-691dbdb94f881bc07a0befa45f288466bde6207b.pack is corrupt
.git/objects/pack/pack-691dbdb94f881bc07a0befa45f288466bde6207b.pack: bad

I don't have another copy of the pack 691dbdb94....  I guess I could run
git-unpack-objects and see what it produces for the bad blob?

--b.

> After finding the offset for the object data in the
> pack, a bit of "dd seek=" would be needed to extract the data.
> 
> >
> > This is the third time I've found corruption in a repository on this
> > laptop, so I'm a little suspicious of the hardware.  (The second time I
> > reported here: http://marc.info/?l=git&m=121968278319668&w=2.)
> >
> > --b.
