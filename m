From: Junio C Hamano <gitster@pobox.com>
Subject: Re: backwards compatibility, was Re: [PATCH v1 1/3] Introduce config
  variable "diff.primer"
Date: Mon, 26 Jan 2009 12:04:20 -0800
Message-ID: <7vd4e96dh7.fsf@gitster.siamese.dyndns.org>
References: <1232904657-31831-1-git-send-email-keith@cs.ucla.edu>
 <1232904657-31831-2-git-send-email-keith@cs.ucla.edu>
 <7v1vurf7lq.fsf@gitster.siamese.dyndns.org>
 <alpine.GSO.2.00.0901251345240.12651@kiwi.cs.ucla.edu>
 <20090126031206.GB14277@sigill.intra.peff.net>
 <alpine.DEB.1.00.0901261154330.14855@racer>
 <20090126111605.GB19993@coredump.intra.peff.net>
 <76718490901260729m21ba140dke157d1d461aed2d5@mail.gmail.com>
 <20090126184829.GA27543@coredump.intra.peff.net>
 <76718490901261149xfedc415j8f5dab677b90d693@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Keith Cascio <keith@cs.ucla.edu>, git@vger.kernel.org
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 26 21:06:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LRXiV-0007ov-Io
	for gcvg-git-2@gmane.org; Mon, 26 Jan 2009 21:05:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753305AbZAZUEb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Jan 2009 15:04:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752391AbZAZUEa
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Jan 2009 15:04:30 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:57539 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751500AbZAZUEa (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Jan 2009 15:04:30 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id D805F93E88;
	Mon, 26 Jan 2009 15:04:28 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id E3E7693E86; Mon,
 26 Jan 2009 15:04:21 -0500 (EST)
In-Reply-To: <76718490901261149xfedc415j8f5dab677b90d693@mail.gmail.com> (Jay
 Soffian's message of "Mon, 26 Jan 2009 14:49:15 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 89D8875C-EBE4-11DD-AD7E-5720C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107265>

Jay Soffian <jaysoffian@gmail.com> writes:

> On Mon, Jan 26, 2009 at 1:48 PM, Jeff King <peff@peff.net> wrote:
>> But then you have that problem that the _user_ is stuck specifying "OK,
>> turn on fancy features." And I don't relish the thought of typing "git
>> diff -J" every time. :)
>
> Well, this issue seems to come up every so often, so the idea would be:
>
> - We're adding a mechanism for scripts to communicate that they need
> plumbing context
> - Start using it in your scripts when calling git if you rely on a
> stable interface
> - In the next major release, git may introduce changes to commands
> which are not clearly plumbing if you haven't adopted the mechanism

Where do all of these nonsense come from?  We are not adding any mechanism
for scripts to say they need plumbing context.  By calling plumbing they
are already asking for stable plumbing behaviour.

The scripts can, if they want to, use newer options updated versions of
the plumbing commands offer, by passing them when they want to.

And the trigger to do so is up to the scripts.  They can get new options
from the end user, or they can peek into user's configuration variables
similar to the diff.primer mentioned earlier in the discussion.

One way could be a new option --screw-me-with=name that can be given to a
plumbing command and tells it pretend as if the command line options
specified by the configuration variable of the given name were given
(e.g. a script runs "git diff-files --screw-me-with=diff.primer").

The important point is that it has to be opt _IN_.
