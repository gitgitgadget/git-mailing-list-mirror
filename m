From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4] submodule: add +<branch> syntax for track to allow
 automatic pulling.
Date: Sat, 10 Jan 2009 17:34:31 -0800
Message-ID: <7vy6xityl4.fsf@gitster.siamese.dyndns.org>
References: <1231553410-7541-1-git-send-email-git@fabian-franz.de>
 <1231553410-7541-2-git-send-email-git@fabian-franz.de>
 <1231553410-7541-3-git-send-email-git@fabian-franz.de>
 <1231553410-7541-4-git-send-email-git@fabian-franz.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, j.sixt@viscovery.net, hjemli@gmail.com
To: Fabian Franz <git@fabian-franz.de>
X-From: git-owner@vger.kernel.org Sun Jan 11 02:36:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LLpFG-0000uD-K2
	for gcvg-git-2@gmane.org; Sun, 11 Jan 2009 02:36:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754229AbZAKBel (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Jan 2009 20:34:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753893AbZAKBel
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Jan 2009 20:34:41 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:40632 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753365AbZAKBek (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Jan 2009 20:34:40 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 190151C2FC;
	Sat, 10 Jan 2009 20:34:39 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 4A4291C188; Sat,
 10 Jan 2009 20:34:32 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 030BCF42-DF80-11DD-B17E-2E3B113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105150>

Fabian Franz <git@fabian-franz.de> writes:

> When the track parameter is set to +<branch>, on update command a
> new branch is created tracking the remote branch (if it does not
> yet exist). Then the branch is checked out and git-pull is run.

Usually a "+" in front of a refspec means "allow forcing non-ff update",
but here it means completely different thing.  The syntax is confusing.

But that aside, I do not know if the semantics of this patch makes sense
to begin with.

Should this really be a persistent property of a submodule?  With your
patch, this is always triggered for modules you did "--track +branch" when
you added them, but (1) not for others you did not say "+" when you added,
and (2) you cannot disable the auto-pull for the ones you did even if you
wanted to.  It feels it might be better to make it a property of one
particular invocation of "update" action, and more generally, the entire
series feels like a very specific hack that is meant to cover/impose your
particular workflow (and not others').

Don't get me wrong.  I do not see any problem in supporing it well, if
that particular workflow is a good workflow and a generally applicable
one.

But I do not think it is documented well enough.  "--track creates one
configuration in the .git/config file" and "update always checks out the
tip of the named branch if such configuration is set" may be fine
descriptions of what each piece does.  The readers will be left puzzled
without an explanation of the bigger picture to understand why it is
(sometimes) a good idea to make these pieces do what they do.
