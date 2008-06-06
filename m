From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Use nonrelative paths instead of absolute paths for
 cloned repositories
Date: Fri, 06 Jun 2008 11:07:19 -0700
Message-ID: <7v7id2v3mw.fsf@gitster.siamese.dyndns.org>
References: <alpine.LNX.1.00.0806052244300.19665@iabervon.org>
 <alpine.DEB.1.00.0806060422310.21190@racer>
 <7viqwmv7ff.fsf@gitster.siamese.dyndns.org>
 <alpine.DEB.1.00.0806061832330.1783@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Daniel Barkalow <barkalow@iabervon.org>, git@vger.kernel.org,
	Greg KH <greg@kroah.com>,
	Andrew Klossner <andrew@cesa.opbu.xerox.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Jun 06 20:08:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K4gMT-00024j-JM
	for gcvg-git-2@gmane.org; Fri, 06 Jun 2008 20:08:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758565AbYFFSHb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Jun 2008 14:07:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758432AbYFFSHa
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Jun 2008 14:07:30 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:37254 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758131AbYFFSH3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jun 2008 14:07:29 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id CD5F03CE9;
	Fri,  6 Jun 2008 14:07:27 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id F22563CE7; Fri,  6 Jun 2008 14:07:21 -0400 (EDT)
In-Reply-To: <alpine.DEB.1.00.0806061832330.1783@racer> (Johannes
 Schindelin's message of "Fri, 6 Jun 2008 18:34:13 +0100 (BST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 6C5081AC-33F3-11DD-96DF-F9737025C2AA-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84095>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> In the longer term, we would inevitably face "when should one use 
>> nonrelative and when should one use absolute?" and we would eventually 
>> have to answer it.  It may turn out that many current users of 
>> "absolute" are better off using "nonrelative", but I suspect we won't 
>> get rid of "absolute" completely, because one of the reasons it avoids 
>> symlinks at great lengths is so that it can check the containment 
>> relationships between paths reliably (e.g. "is this path outside the 
>> repository, in which case we should refuse to add it to the index, and 
>> we use --no-index without being asked when running "diff"").
>> 
>> But using "absolute" for containment comparison is one thing.  Storing 
>> the result of "absolute" is quite another.
>
> The easy way would be to add an option to make_absolute_path(), say 
> "resolve_symlinks".

I am afraid that it does not solve anything.

Be they two separate functions, or a one function that has two different
semantics depending on an option, the API documentation needs to answer
the "when should I use one and when should I use the other" question.

And the hard part is figuring out which of the current "absolute" callers
need to be fixed in a way similar to how Daniel fixed git-clone, and which
of them stay the same.  Perhaps all of the "chdir then getpwd" patterns
need to be looked at and some of them need to be restructured to honor $PWD
better.  I dunno.
