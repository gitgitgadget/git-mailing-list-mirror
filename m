From: Junio C Hamano <gitster@pobox.com>
Subject: Re: How to keep different version numbers in different branches?
Date: Mon, 05 Apr 2010 12:17:40 -0700
Message-ID: <7vwrwlogiz.fsf@alter.siamese.dyndns.org>
References: <hpcscv$umg$3@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Stephen Kelly <steveire@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 05 21:17:55 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nyro2-0002yp-Ld
	for gcvg-git-2@lo.gmane.org; Mon, 05 Apr 2010 21:17:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755979Ab0DETRu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Apr 2010 15:17:50 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:51189 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755663Ab0DETRt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Apr 2010 15:17:49 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id E028CA86D8;
	Mon,  5 Apr 2010 15:17:47 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=kWOF84AEG7CxKyl8CcWlCSvRQ+w=; b=q2sqPo
	TWOJDLj8nnYGsUjmoYQOuYUajJyH6JwB23k0jBmR/HeceILbbUlESxkdBDQGF19X
	eQiKi50BkiFnQtv5+0cwzPFJfU2DyKkPyK9PAjVMQiRVFwwo3k06auuW1AVGK1ZC
	la1F7I17Il0Blle4JryFL4uuGTizDO1jxxJuo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Ig4MGRTZ3NVVK7w4W2Q5FoIXip7HiJEN
	11pnCZX7b036yf2U9o7e1lHGy9A2xvNHv5peKVpeXd9IV7u6yURKhKg+o8STVmkF
	r9sZzqpLoTurbQQHInDpGG0if6EIsMJ+XETyvaNrPQid4PH0K5dp3CFmCoS6pZkF
	9MdhLN1gdL8=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 7124BA86D7;
	Mon,  5 Apr 2010 15:17:45 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4DE75A86D6; Mon,  5 Apr
 2010 15:17:42 -0400 (EDT)
In-Reply-To: <hpcscv$umg$3@dough.gmane.org> (Stephen Kelly's message of
 "Mon\, 05 Apr 2010 16\:34\:07 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: EA149E22-40E7-11DF-A61A-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144051>

Stephen Kelly <steveire@gmail.com> writes:

> However, now I have changes in my maintenance branch (0.1) which should not 
> be merged into master (that is, the commits which change the version 
> number). 
>
> How are you supposed to handle that with git? Simply merge and resolve the 
> conflict on master by keeping its version number? Am I missing some other 
> way of doing it here?

Others already have commented on this.  The basic idea is avoid hardcoded
versions in the tracked contents.

Having said that, I do have a few instances of something similar in
git.git itself: GIT-VERSION-GEN script and the RelNotes symlink that
points at Documentation/RelNotes-$v.txt file.  Every time I merge from
maint to master after either side starts preparing for the next release, I
get a conflict and resolve, favoring what is in the 'master'.  It always
is trivial and is not annoying to be any problem, though.

> Additionally, I have some stuff currently in master that should not be in 
> the 0.1 release, but should be in the 0.2 release. If I branch and then 
> remove those files from the 0.1 branch, a merge will then remove them from 
> master too? How do I keep them on master but delete them on 0.1 and still be 
> able to merge from 0.1 into master?

You do not have to fork maint-0.1 branch from the tip of the master.  In
the earlier parts of the master branch there must be a point where
everything before are for 0.1 and all things after that are not, and you
fork from there.  After that, queue changes that are applicable to both to
the 0.1 branch and merge that to 'master' as necessary, while queueing
changes not for 0.1 to 'master'.
