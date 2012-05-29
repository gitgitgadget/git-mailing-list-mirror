From: Junio C Hamano <gitster@pobox.com>
Subject: Re: How does Git's maintenance policy handle topics that don't start
 from "master?"
Date: Tue, 29 May 2012 16:16:40 -0700
Message-ID: <7vsjei1stj.fsf@alter.siamese.dyndns.org>
References: <m21um2682e.fsf@Spindle.sehlabs.com>
 <7vbol63ccs.fsf@alter.siamese.dyndns.org>
 <m2sjei4pvq.fsf@Spindle.sehlabs.com>
 <7vzk8q1t9r.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Steven E. Harris" <seh@panix.com>
X-From: git-owner@vger.kernel.org Wed May 30 01:16:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SZVeg-0002UL-Qt
	for gcvg-git-2@plane.gmane.org; Wed, 30 May 2012 01:16:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755941Ab2E2XQn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 May 2012 19:16:43 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62629 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755910Ab2E2XQm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 May 2012 19:16:42 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 149309111;
	Tue, 29 May 2012 19:16:42 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Ev1aha48YbzAXVfkPbdxwmT5Gko=; b=O1nNLV
	28v09hNVWTnt4aZsCSn/CsnEtS7Xe4QEuzvjJ3AOAJDqVcM3kLL/mAMnT3dBF4pG
	dD+BrQXCa39X6NjW2etUGGiutvJyqxM4oaILA8dgHOFLM4rY2sfOVJct3QamIxoL
	lCaoovpG5+lLSYN8wkieUfJTvMxspUNTrJzdY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=BAPsueHu4scW/n4RlWL4FP2ajMNAAby9
	Nm+8QtAtgN5ZiEbjgjK7LP9phyzW6ZVu5LJvZ0W1wwHTuAPOB7E+EoxzQpBnYKuH
	9+uXioJ81f9p4tyydo1T95QtrbZI5NDCFuNKvADjb2JTVN8pWkY/oCozmpAjVAjb
	/7tJrhLE1gc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0C6079110;
	Tue, 29 May 2012 19:16:42 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 99431910E; Tue, 29 May 2012
 19:16:41 -0400 (EDT)
In-Reply-To: <7vzk8q1t9r.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Tue, 29 May 2012 16:06:56 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 597620D0-A9E4-11E1-BCC5-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198774>

Junio C Hamano <gitster@pobox.com> writes:

> "Steven E. Harris" <seh@panix.com> writes:
>
>> What about this case, where topics "t1" and "t2" did depart from
>> "master," and are doing well along "next" together as of commit M.
>>
>>   ---o---o---o---o  master
>>       \   \       \
>>        \   o---o---o---M---o---o next
>>         \     /       /
>>          o---o t1    /
>>           \         /
>>            o---o---o t2
>>
>> The Git policy as I understand it prescribes that we merge from the tips
>> of "t1" and "t2" back to master, not from a commit like M. What harm
>> would come from merging from M in this case? Future archaeology of topic
>> provenance?

You would also have to think about what you write to explain that
merge of M into 'master' in the commit log message.  In the above
special case where 'next' happened to have had only t1 and t2 when
you decided to merge to 'master', you could say "Merge t1 and t2 to
achieve X", but in the earlier example (elided), it is not clear
what random bits you are merging with it.

Compared to that, if you merge t1 and t2 separately, you can say "I
am merging t1 topic that does X", and readers of "git log master"
(better yet "git log --first-parent master") would understand that
the master branch after that commit can do X (and everything before
that commit does not).
