From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-status for submodules
Date: Fri, 21 Nov 2008 06:56:15 -0800
Message-ID: <7vabbtqga8.fsf@gitster.siamese.dyndns.org>
References: <20081120033615.GA21128@foursquare.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Chris Frey <cdfrey@foursquare.net>
X-From: git-owner@vger.kernel.org Fri Nov 21 15:57:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L3XSA-0003TH-8p
	for gcvg-git-2@gmane.org; Fri, 21 Nov 2008 15:57:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753308AbYKUO4e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Nov 2008 09:56:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753292AbYKUO4e
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Nov 2008 09:56:34 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:53061 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751909AbYKUO4d (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Nov 2008 09:56:33 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id C63611739A;
	Fri, 21 Nov 2008 09:56:31 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 7158C1732A; Fri,
 21 Nov 2008 09:56:17 -0500 (EST)
In-Reply-To: <20081120033615.GA21128@foursquare.net> (Chris Frey's message of
 "Wed, 19 Nov 2008 22:36:15 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 95635C8C-B7DC-11DD-A5E0-F83E113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101531>

Chris Frey <cdfrey@foursquare.net> writes:

> I'm using git 1.6.0.4 and trying to make submodules work for me.  The
> init/add/update steps are a bit tedious, but workable.  The problem I have
> is when I make a change in a submodule, then git-status does not show
> the change.

My understanding is that this is exactly by design.  The supermodule
tracks which commit in the subproject is bound to the tree location.

A mere act of changing something in the subproject directory is just a
single, incomplete step to create a new commit in the subproject and will
not be seen by the superproject's status.  Instead of this workflow:

> 	cd super
> 	vi newsuper
> 	vi existing_file
> 	cd sub
> 	vi newsub
> 	cd ..
> 	git status

the submodule support is geared toward supporting this layout:

	- "super" has a subproject X at "sub"

        - When you do a real work on the subproject X, you do so as if
          there is no supermodule.  IOW, subproject X has to be able to
          stand on its own.

One extreme case is you have a(nother) clone of subproject X that is
independent from "super", do the real work there and create new commit,
and update the subproject X inside "super".  In such a workflow, "super"
will never see an intermediate state between commits in the subproject
directory.



	
