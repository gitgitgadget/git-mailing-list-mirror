From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git clone stable-2.6.25.y fails over HTTP
Date: Wed, 04 Jun 2008 21:12:42 -0700
Message-ID: <7vabi05xl1.fsf@gitster.siamese.dyndns.org>
References: <200806041511.m54FBPL9006783@pogo.cesa.opbu.xerox.com>
 <20080604154523.GA25747@kroah.com>
 <7vr6bdxh3l.fsf@gitster.siamese.dyndns.org>
 <20080605040315.GA21798@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andrew Klossner <andrew@cesa.opbu.xerox.com>, git@vger.kernel.org
To: Greg KH <greg@kroah.com>
X-From: git-owner@vger.kernel.org Thu Jun 05 06:13:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K46rC-00055M-6V
	for gcvg-git-2@gmane.org; Thu, 05 Jun 2008 06:13:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751096AbYFEEMx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Jun 2008 00:12:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751118AbYFEEMx
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Jun 2008 00:12:53 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:37023 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751068AbYFEEMw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Jun 2008 00:12:52 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 9D0232B6F;
	Thu,  5 Jun 2008 00:12:50 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id C5E932B6D; Thu,  5 Jun 2008 00:12:46 -0400 (EDT)
In-Reply-To: <20080605040315.GA21798@kroah.com> (Greg KH's message of "Wed, 4
 Jun 2008 21:03:15 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: A990ECBC-32B5-11DD-8B9A-F9737025C2AA-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83852>

Greg KH <greg@kroah.com> writes:

> On Wed, Jun 04, 2008 at 10:09:02AM -0700, Junio C Hamano wrote:
>
>> A quick fix is obviously to remove the extra prefix but it makes me wonder
>> how these two "stable" repositories were prepared differently.  Could this
>> be a regression in "git clone"?  Or perhaps you "clone -s"'s Linus's
>> repository slightly differently between them?
>
> That's odd.
>
> Chris was the one that created the .24 tree and I created the .25 tree,
> so we must have done so differently, sorry.

No need to be sorry.  Thanks for raising the issue up.

I think I have one possible explanation.  When "git clone" was rewritten
in C some time ago, it started to dereference symlinks, and newer git
would dereference /pub -> /home/ftp/pub when you do:

	git clone -s --bare /pub/scm/linux/kernel/git/torvalds/linux-2.6/ linux-2.6.2x.y

while the scripted version used to keep /pub/scm path.

A bit further digging is necessary to make sure if we can fix this easily,
but I suspect this is worth fixing.
