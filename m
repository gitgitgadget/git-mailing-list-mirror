From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC] diff --relative: output paths as relative to the
 current subdirectory
Date: Tue, 12 Feb 2008 17:19:29 -0800
Message-ID: <7vhcgdzm8u.fsf@gitster.siamese.dyndns.org>
References: <7vzlu524n9.fsf@gitster.siamese.dyndns.org>
 <alpine.LFD.1.00.0802121531170.2920@woody.linux-foundation.org>
 <7vfxvx211k.fsf@gitster.siamese.dyndns.org>
 <alpine.LFD.1.00.0802121550570.2920@woody.linux-foundation.org>
 <alpine.LFD.1.00.0802121604310.2920@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Feb 13 02:21:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JP6J0-0005dh-F0
	for gcvg-git-2@gmane.org; Wed, 13 Feb 2008 02:20:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753344AbYBMBUQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Feb 2008 20:20:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753262AbYBMBUQ
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Feb 2008 20:20:16 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:59481 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752589AbYBMBUO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Feb 2008 20:20:14 -0500
Received: from a-sasl-quonix.pobox.com (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id C09B732EF;
	Tue, 12 Feb 2008 20:20:10 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.pobox.com (Postfix) with ESMTP id
 DD9DC32DA; Tue, 12 Feb 2008 20:19:32 -0500 (EST)
In-Reply-To: <alpine.LFD.1.00.0802121604310.2920@woody.linux-foundation.org>
 (Linus Torvalds's message of "Tue, 12 Feb 2008 16:09:18 -0800 (PST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73730>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> So I simply don't think that we should assume a working directory for any 
> basic git operation, unless that operation fundamentally needs one because 
> it's only defined for a system with working directories (which is fairly 
> rare, but obviously happens: "git reset --hard", "git pull/merge", "git 
> checkout" etc).

Yeah, but that begs for a larger design-level question.

Instead of treating "diff --relative=drivers/ a..b", as a
special case, shouldn't we have a more general "I may be in a
bare repository, but please pretend that my prefix were this
path" option?

    $ git --prefix=drivers/ diff --relative a..b -- scsi
    $ git --prefix=drivers/scsi log a..b .

Of course, if you are truly in a bare repository and if you did
an operation that wants a work tree, you would get mostly
useless results, e.g.

    $ git --prefix=fs/ diff v2.6.24 -- ext3

will give you tons of whole-file removals.

I suspect that a lot of existing code assumes a non NULL prefix
automatically means we have work tree, which needs to be fixed,
if we go this route, though.
