From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH 1/2] add a --delete option to git push
Date: Thu, 13 Aug 2009 23:53:50 -0700
Message-ID: <7vab22ubr5.fsf@alter.siamese.dyndns.org>
References: <1250226349-20397-1-git-send-email-srabbelier@gmail.com>
 <1250226349-20397-2-git-send-email-srabbelier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Jakub Narebski" <jnareb@gmail.com>,
	"Git List" <git@vger.kernel.org>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 14 08:54:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mbqfv-00089z-SQ
	for gcvg-git-2@gmane.org; Fri, 14 Aug 2009 08:54:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754729AbZHNGx6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Aug 2009 02:53:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754718AbZHNGx6
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Aug 2009 02:53:58 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:46616 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754717AbZHNGx6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Aug 2009 02:53:58 -0400
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id F262E91B8;
	Fri, 14 Aug 2009 02:53:58 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E607191B7; Fri, 14 Aug
 2009 02:53:51 -0400 (EDT)
In-Reply-To: <1250226349-20397-2-git-send-email-srabbelier@gmail.com> (Sverre
 Rabbelier's message of "Thu\, 13 Aug 2009 22\:05\:48 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 3E04BD0C-889F-11DE-8EB9-EAC21EFB4A78-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125905>

Sverre Rabbelier <srabbelier@gmail.com> writes:

>     Currently `git push --delete master:master` results in a somewhat
>     cryptic error message. ...

What does "git push --delete name:destination" say?
What does "git push --delete :destination" say?

>     ... It seems unlikely however, that those new
>     to git would use the 'old:new' notation,...

I doubt that assumption is warranted.  I've seen new people on this list
who want to be as specific as possible before they get familiar with the
tool (I guess it is in the same spirit that they like to spell out long
option names instead of short ones).

And I happen to think it is a good discipline, when learning a new tool,
to understand the underlying generic model before advancing to lazy and
useful short-hand.  That's how I teach in my upcoming book.

Your "old:new" demonstrates a fuzzy understanding of the underlying
concept.  They are not <old> nor <new>.  They are <object name> and
<destination>; with this object, update that destination.  And you can
abbreviate when they are textually spelled the same.  I.e. "git push
origin master" is equivalent to "git push origin master:master" because
both sides are spelled 'm a s t e r' the same way.

Having said all that.

I tend to agree with Jeff that it would probably make sense to limit this
new feature to colonless form and error out if you see a refspec with a
colon and --delete at the same time.  Also --delete should imply not
looking at configured refspecs at all.  After all, this is incompatible
with the way git expresses push with refspecs, and trying to mix these two
would lead to confusion.

I do not mean that this new feature is useless nor stupid.  Being able to
say "git push --delete branch1 branch2" matches _a_ mental model (perhaps
Hg inspired one) _very_ naturally.  There are branches on the other side,
and there is a special operation called 'delete' that you can inflict on
them.

But it is a different mental model of how git natively does "push".  In
git model, you give list of instructions <which branch to update with what
commit>, and as a special case "what commit" could be "empty" to signal
deletion, and "push" carries out the instructions.

These are both valid models.  They just do not mix, so let's avoid
confusion by not allowing both at the same time.
