From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Confused about diff-tree --cc output
Date: Thu, 05 Feb 2009 00:38:24 -0800
Message-ID: <7vmyd1ffcv.fsf@gitster.siamese.dyndns.org>
References: <76718490902041313y44eeb99bya33513bc9818aeb0@mail.gmail.com>
 <7vk585n9x8.fsf@gitster.siamese.dyndns.org>
 <76718490902041949v8fffd17l7cb19d836a3e1887@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 05 09:40:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LUzmB-0001me-TN
	for gcvg-git-2@gmane.org; Thu, 05 Feb 2009 09:40:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757259AbZBEIib (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Feb 2009 03:38:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756875AbZBEIib
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Feb 2009 03:38:31 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:44532 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755891AbZBEIia (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Feb 2009 03:38:30 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id A1A2C96FE9;
	Thu,  5 Feb 2009 03:38:29 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 69DA896FE4; Thu,
  5 Feb 2009 03:38:26 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 5D293908-F360-11DD-926A-8B21C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108539>

Jay Soffian <jaysoffian@gmail.com> writes:

> Is that about right?

Yes, not just about right but it is how it works.

The patch in:

    http://article.gmane.org/gmane.comp.version-control.git/15500

gave the final implementation of the rule.

The rule is that if there are only one or two variations to choose from,
and the result matches one of them, it is not interesting.  Otherwise it
is interesting.

In an octopus where more than two parents disagree, no matter what the
result is, it is interesting.

In an extreme case, even if both parents in a two-parent merge had the
same contents (i.e. only one to choose from), if you amend the merge
result to make it different from it, it becomes interesting.

In your example, two pieces, each of which took everything from one parent
(hence is uninteresting by itself), happened to lie within the context
range.  It is not very interesting, and it automerges cleanly, but it is
rare that these merges happen close together, and that "close miss" is
what makes this case "interesting".

It is exactly the same as the example in the message I referred you to.
In the same thread:

    http://article.gmane.org/gmane.comp.version-control.git/15598

has a very clear explanation about this exact kind of borderline "is it
really interesting?" case.

Also the follow-up to it:

    http://article.gmane.org/gmane.comp.version-control.git/15600

would give you further insights, the most interesting of which is that
what is shown in --cc output does *NOT* have anything to do with "did the
merge result in a manual conflict resolution?"

By the way, the latter message talks about gitk not showing the right
thing, but that was an ancient story.  These days gitk just shows what
diff --cc feeds it and there is no discrepancy between the two.
