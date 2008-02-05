From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/4] git-commit: Refactor creation of log message.
Date: Mon, 04 Feb 2008 17:39:33 -0800
Message-ID: <7vzluggp0q.fsf@gitster.siamese.dyndns.org>
References: <2885c7896ba72adee6bc5c9e2210a8881904f601.head.git.bonzini@gnu.org>
	<14fc1ba3f94a773ab2e5b8cdf0c230962f32180d.1200933409.git.bonzini@gnu.org>
	<alpine.LSU.1.00.0802041646461.7372@racer.site>
	<47A747EB.9020909@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Paolo Bonzini <bonzini@gnu.org>
X-From: git-owner@vger.kernel.org Tue Feb 05 02:40:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JMCnH-00061w-Oi
	for gcvg-git-2@gmane.org; Tue, 05 Feb 2008 02:40:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756044AbYBEBjn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Feb 2008 20:39:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755768AbYBEBjn
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Feb 2008 20:39:43 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:55909 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753732AbYBEBjm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Feb 2008 20:39:42 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 1DD4041F6;
	Mon,  4 Feb 2008 20:39:40 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 7A4CD41F5;
	Mon,  4 Feb 2008 20:39:35 -0500 (EST)
In-Reply-To: <47A747EB.9020909@gnu.org> (Paolo Bonzini's message of "Mon, 04
	Feb 2008 18:14:19 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72611>

Paolo Bonzini <bonzini@gnu.org> writes:

> Johannes Schindelin wrote:
>>
>> On Mon, 21 Jan 2008, Paolo Bonzini wrote:
>>
>>> This means that: 1) the commit may be aborted after editing the message
>>> if there is a problem writing out the tree object (slight disadvantage);
>>
>> I consider this more than a slight disadvantage.  I regularly take
>> ages coming up with a good commit message, because I think that the
>> overall time balance is better with me spending more time on the
>> message, but every reader spending less time to guess what I meant.
>>
>> So I would be quite annoyed to edit a message, only to find out that
>> for whatever reason the commit was not successful.
>
> Just to make it clearer, the piece of code that would have to fail,
> for the behavior to change, is this:

I suspect Dscho was worried about the case where he says "git
commit", types message and then write-tree finds out that the
index is still unmerged and the tree cannot be written out.

And I'd be majorly annoyed if the "slight disadvange" was about
that.

>         discard_cache();
>         read_cache_from(index_file);
>         if (!active_cache_tree)
>                 active_cache_tree = cache_tree();
>         if (cache_tree_update(active_cache_tree,
>                               active_cache, active_nr, 0, 0) < 0) {
>                 rollback_index_files();
>                 die("Error building trees");
>         }

I think this _could_ error out if your index is unmerged.

However, if you have other code to error out early upon unmeregd
index before you collect the message from the editor, I think
you are Ok.
