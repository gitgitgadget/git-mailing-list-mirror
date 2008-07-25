From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-reset: Let -q hush "locally modified" messages
Date: Fri, 25 Jul 2008 15:07:34 -0700
Message-ID: <7vej5hr521.fsf@gitster.siamese.dyndns.org>
References: <1217018948-32475-1-git-send-email-s-beyer@gmx.net>
 <7vwsj9r722.fsf@gitster.siamese.dyndns.org>
 <20080725213853.GD13539@leksak.fem-net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Carlos Rica <jasampler@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Stephan Beyer <s-beyer@gmx.net>
X-From: git-owner@vger.kernel.org Sat Jul 26 00:08:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KMVSw-0007UA-Jx
	for gcvg-git-2@gmane.org; Sat, 26 Jul 2008 00:08:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751951AbYGYWHp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jul 2008 18:07:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751942AbYGYWHp
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Jul 2008 18:07:45 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:51817 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751938AbYGYWHo (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jul 2008 18:07:44 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 7568E3CDEC;
	Fri, 25 Jul 2008 18:07:42 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id EF7293CDE2; Fri, 25 Jul 2008 18:07:36 -0400 (EDT)
In-Reply-To: <20080725213853.GD13539@leksak.fem-net> (Stephan Beyer's message
 of "Fri, 25 Jul 2008 23:38:53 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 1A5A6FBA-5A96-11DD-BA57-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90129>

Stephan Beyer <s-beyer@gmx.net> writes:

> Junio C Hamano wrote:
> ...
>> Files being "locally modified" is not and error, so I think it is in line
>> with the spirit of what -q is meant to do.
>> 
>> It is an interface change, though.
>
> Yes, as "needs update" -> "locally modified" was.
>
> However, scripts, that rely on filenames when doing -q (whyever),
> will break.

I was not worried about scripts.  "reset" is a Porcelain, and it is Ok for
the scripts to use it and rely on what it does (e.g. "git reset HEAD^"
will move the HEAD one commit back and match your index to it), but they
should not be depending on its output to be parsable.  Perhaps it is Ok
for them to detect if there is any change by observing if it spits out
anything, but that is about it.  So the earlier change to use "locall
modified" does not really matter in that sense, but squelching the output
altogether is a change with bigger impact.  With your patch, we declare
that the scripts should not assume anything about its output.

I was more worried about expectation from human users.  We used to get a
reminder of the paths that are different from the HEAD/index, even with
the "-q" option, in the form of human-readable list of paths.  Your patch
changes that.

Having said all that (the only reason I said the above is not because I
think this particular interface change is a big deal, but because I wanted
to explain what kind of interface change I do and do _not_ care about when
we talk about Porcelain), when the user explicitly gives "-q" to the
command, I think it is Ok to assume that the user does not want to hear
anything back.  I do not see any fundamental problem with your patch in
that sense.

It still is an interface change, though ;-)
