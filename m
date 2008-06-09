From: Junio C Hamano <gitster@pobox.com>
Subject: Re: squashing patches
Date: Mon, 09 Jun 2008 12:34:44 -0700
Message-ID: <7vprqqh06j.fsf@gitster.siamese.dyndns.org>
References: <20080607220101.GM31040@leksak.fem-net>
 <20080609114550.GA8079@leksak.fem-net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Joerg Sommer <joerg@alea.gnuu.de>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Christian Couder <chriscool@tuxfamily.org>
To: Stephan Beyer <s-beyer@gmx.net>
X-From: git-owner@vger.kernel.org Mon Jun 09 21:36:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K5nAM-0001XT-JF
	for gcvg-git-2@gmane.org; Mon, 09 Jun 2008 21:36:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753378AbYFITfH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Jun 2008 15:35:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752700AbYFITfH
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Jun 2008 15:35:07 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:44130 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752630AbYFITfG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Jun 2008 15:35:06 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 1CF1512CF;
	Mon,  9 Jun 2008 15:35:03 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id D0E9112BE; Mon,  9 Jun 2008 15:34:53 -0400 (EDT)
In-Reply-To: <20080609114550.GA8079@leksak.fem-net> (Stephan Beyer's message
 of "Mon, 9 Jun 2008 13:45:50 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 27F137B2-365B-11DD-9E2A-F9737025C2AA-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84411>

Stephan Beyer <s-beyer@gmx.net> writes:

> So I wonder if file --squash is useful, too, or even --squash as an
> general option. The latter means that you could squash merge commits
> into other commits, too.
>
> We've also discussed the non-atomic approach of doing something like
> 	pick ( a b c d )	# or another syntax for that
> for picking multiple commits into one.
> In my current point of view, this does not seem right, as it:
>  - is not atomic ;), and...
>  - Well, the approach could be used for "file ( a b c d )", too,
>    but it doesn't help for squashing commits AND patches.
>
> Comments? Opinions? Ideas?

I actually expected that the primitive command sequence the backward
compatible "edit" would expand to would be a pair, "pick" followed by
"pause".  Whenever the sequencer sees "pause", it does not do anything but
reports the current HEAD and gives the control back to the user, so that
the user can do amend or whatever before telling you to --continue.

Similarly, I expected the backward-compatible "squash" to expand to a
pair, "pick" followed by "zucchini 2".  Whenever the sequencer sees
"zucchini <n>", it prepares a commit log to describe the top <n> commits,
resets HEAD back by <n> commits, and gives control to your editor.

About the other parts in your original message:

 - The "tag" command looked a little out of place;

 - I would have called your "file" command "patch" (we might want to have
   another file related operation later).

 - The --author option presumably would be to lie about the authorship but
   without taking it from an existing commit.  (1) Don't you need to have
   an option similar to -C option of "git-commit"?  (2) Don't you need to
   also be able to lie about the author timestamp?
