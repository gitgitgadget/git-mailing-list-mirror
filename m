From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Individual file snapshots
Date: Fri, 12 Feb 2010 14:14:20 -0800
Message-ID: <7v1vgqksoz.fsf@alter.siamese.dyndns.org>
References: <ron1-CD3223.04030512022010@news.gmane.org>
 <4B75BD06.1010802@lsrfire.ath.cx> <ron1-519083.13253112022010@news.gmane.org>
 <12B5BDAB-DD9C-4CED-9489-0773BF577DF3@silverinsanity.com>
 <ron1-62D136.13570812022010@news.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Ron Garret <ron1@flownet.com>
X-From: git-owner@vger.kernel.org Fri Feb 12 23:14:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ng3mW-0002FZ-Us
	for gcvg-git-2@lo.gmane.org; Fri, 12 Feb 2010 23:14:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755707Ab0BLWOb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Feb 2010 17:14:31 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:45841 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755016Ab0BLWOb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Feb 2010 17:14:31 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id C8EE6978F6;
	Fri, 12 Feb 2010 17:14:27 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=gOA8XLL71vqQmWUg2GT83u/rW2w=; b=SLkkDn
	VEZl3FIpmJjj6QHfbkPBebqFoutNU9HjJ6kudk5k8WHn2WQF2pA0yD6JkBit2E9M
	hoUqUBMlhS0ZmC8QuyrAaCJQUqu9D2mPGRHyZjZgDaNtRqUgtEjZydU+aT0dW+yR
	j5AbjYYi1hq1GYkO3XJgGGmuhnf/AmeWu5rN0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=OVrzyRGsisuzOl4TnPqHrygHbzk2n0Y/
	ctODTY1d6kwjazINMHAYm8/TqYTLZyuJvlRGxCyS8cJwkWXxe9i06w6S3KEyYAOo
	/awViW7HVn4A/lAJkcaEwIHRzT+ZtVUMGmVSzWxRSYCMZrwIMZ+xkugbJS8cGWdO
	ZbShJpA4O5I=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id A071B978F0;
	Fri, 12 Feb 2010 17:14:25 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CA346978E8; Fri, 12 Feb
 2010 17:14:22 -0500 (EST)
In-Reply-To: <ron1-62D136.13570812022010@news.gmane.org> (Ron Garret's
 message of "Fri\, 12 Feb 2010 13\:57\:08 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: FADF36BE-1823-11DF-AE7F-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139756>

Ron Garret <ron1@flownet.com> writes:

>> Or if a series of commits seem to have gone bad:
>> 
>> git commit -a -m "Well, that didn't work."
>> git branch failed-experiment
>> git reset --hard origin/master # or other good state
>> 
>> You can of course replace the -a to commit with the needed "git add <file>" 
>> commands and leave off the -m to leave real messages about why it went bad 
>> using $EDITOR.
>
> That would require a separate branch for every snapshot, no?  I want 
> this to be lightweight.  It's not so much the creation of a zillion 
> branches that bothers me, but having to come up with a new name every 
> time would be a real hassle.

Perhaps "stash"?

Usually stash is used to store "diff between stash@{N}^1 and stash@{N}",
and "stash pop" or "stash apply" are geared toward that usage.  But you
can use it as a way to keep snapshots.  You would be interacting with
the stash differently, though.  E.g.

	git diff stash@{4}
	git diff origin/master stash@{2}
	git checkout stash -- Makefile
