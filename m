From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/5] Document details of transport function APIs
Date: Wed, 25 Mar 2009 11:03:09 -0700
Message-ID: <7vmyb95vky.fsf@gitster.siamese.dyndns.org>
References: <alpine.LNX.1.00.0903242303250.19665@iabervon.org>
 <7v63hy9k0l.fsf@gitster.siamese.dyndns.org>
 <alpine.LNX.1.00.0903251142470.19665@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Wed Mar 25 19:06:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LmXTg-0002oK-KE
	for gcvg-git-2@gmane.org; Wed, 25 Mar 2009 19:05:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756326AbZCYSDR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Mar 2009 14:03:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755673AbZCYSDQ
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Mar 2009 14:03:16 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:40981 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755575AbZCYSDQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Mar 2009 14:03:16 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 46778A5B90;
	Wed, 25 Mar 2009 14:03:14 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 44F5FA5B8D; Wed,
 25 Mar 2009 14:03:10 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 35CD0EF2-1967-11DE-AB67-32B0EBB1AA3C-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114632>

Daniel Barkalow <barkalow@iabervon.org> writes:

>> > +	 * If, in the process, the transport determines that the
>> > +	 * remote side actually responded to the push by updating the
>> > +	 * ref to a different value, the transport should modify the
>> > +	 * new_sha1 in the ref. (Note that this is a matter of the
>> > +	 * remote accepting but rewriting the change, not rejecting it
>> > +	 * and reporting that a different update had already taken
>> > +	 * place)
>> > +	 **/
>> 
>> It this even a sane thing to allow?  How would it interact with the
>> "pretend we immediately turned around and fetched them into the remote
>> tracking branches" local updates we usually do?
>
> We already allow a git server to rewrite refs with a hook when it gets 
> them, and we record the pre-rewriting value. This allows the transport to 
> propagate the post-rewriting value back (if it can get it), and we'd 
> update the tracking branches with what the server actually did instead of 
> what we asked it to (i.e., we do what we would do if we really did turn 
> around and fetch them immediately).

But how are you guaranteeing that objects necessary to complete the
history the remote end re-written are already available on the local end?
Do you have a reverse object transfer phase now in send-pack protocol?

Otherwise I am afraid that you are corrupting the local repository.
