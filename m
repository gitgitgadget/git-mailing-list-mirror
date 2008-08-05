From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Not going beyond symbolic links
Date: Mon, 04 Aug 2008 20:01:10 -0700
Message-ID: <7v3alk17yh.fsf@gitster.siamese.dyndns.org>
References: <20080721002354.GK10151@machine.or.cz>
 <20080721002508.26773.92277.stgit@localhost>
 <7v8wvpm9cl.fsf@gitster.siamese.dyndns.org>
 <7vej5543v5.fsf_-_@gitster.siamese.dyndns.org>
 <alpine.LFD.1.10.0808041719380.3299@nehalem.linux-foundation.org>
 <7v8wvc2seh.fsf@gitster.siamese.dyndns.org>
 <alpine.LFD.1.10.0808041839130.3299@nehalem.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Petr Baudis <pasky@suse.cz>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue Aug 05 05:02:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KQCoc-000121-LJ
	for gcvg-git-2@gmane.org; Tue, 05 Aug 2008 05:02:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758042AbYHEDBX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Aug 2008 23:01:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758038AbYHEDBX
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Aug 2008 23:01:23 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:41171 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758015AbYHEDBV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Aug 2008 23:01:21 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id CEC8653F86;
	Mon,  4 Aug 2008 23:01:18 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 0419053F84; Mon,  4 Aug 2008 23:01:12 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: C6A79070-629A-11DD-99CE-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91416>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> ... Because this is definitely not a black-and-white "one behavior is 
> wrong and one behavior is right".

I wish I could agree with you that this is a feature, but 16a4c61
(read-tree -m -u: avoid getting confused by intermediate symlinks.,
2007-05-10) and 64cab59 (apply: do not get confused by symlinks in the
middle, 2007-05-11) came from real world breakage cases and the root cause
was that we were too lenient to allow such a "feature" that pretends the
symlink not to be there.

Right now, we are being careful only while branch switching and patch
application, but the codepaths that add directly to the index (add and
update-index) are not fixed (or "still has the feature").

I do not see a clean way to keep such a "feature" without hurting users
who suffered the bugs these two commits from May 2007 fixed.
