From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Git Large Object Support Proposal
Date: Thu, 19 Mar 2009 16:44:49 -0700
Message-ID: <7vzlfh5b7y.fsf@gitster.siamese.dyndns.org>
References: <d411cc4a0903191514n1e524ebava5895d708a2927c4@mail.gmail.com>
 <7veiwt6t6a.fsf@gitster.siamese.dyndns.org>
 <d411cc4a0903191618x503db946n62d3132eece69175@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git list <git@vger.kernel.org>
To: Scott Chacon <schacon@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 20 00:46:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LkRwS-0003M3-8T
	for gcvg-git-2@gmane.org; Fri, 20 Mar 2009 00:46:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755841AbZCSXo6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Mar 2009 19:44:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756092AbZCSXo6
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Mar 2009 19:44:58 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:34819 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755232AbZCSXo5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Mar 2009 19:44:57 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 3755CA3720;
	Thu, 19 Mar 2009 19:44:54 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 21D7CA371F; Thu,
 19 Mar 2009 19:44:50 -0400 (EDT)
In-Reply-To: <d411cc4a0903191618x503db946n62d3132eece69175@mail.gmail.com>
 (Scott Chacon's message of "Thu, 19 Mar 2009 16:18:54 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: F23C6B46-14DF-11DE-8149-32B0EBB1AA3C-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113865>

Scott Chacon <schacon@gmail.com> writes:

> The point is that we don't keep this data as 'blob's - we don't try to
> compress them or add the header to them, they're too big and already
> compressed, it's a waste of time and often outside the memory
> tolerance of many systems. We keep only the stub in our db and stream
> the large media content directly to and from disk.  If we do a
> 'checkout' or something that would switch it out, we could store the
> data in '.git/media' or the equivalent until it's uploaded elsewhere.

Aha, that sounds like you can just maintain a set of out-of-tree symbolic
links that you keep track of, and let other people (e.g. rsync) deal with
the complexity of managing that side of the world.

And I think you can start experimenting it without any change to the core
datastructures.  In your single-page web site in which its sole html file
embeds an mpeg movie, you keep track of these two things in git:

	porn-of-the-day.html
        porn-of-the-day.mpg -> ../media/6066f5ae75ec.mpg

and any time you want to feed a new movie, you update the symlink to a
different one that lives outside the source-controlled tree, while
arranging the link target to be updated out-of-band.
