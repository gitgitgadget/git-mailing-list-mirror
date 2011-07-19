From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [GSoC update] Sequencer for inclusion v2
Date: Tue, 19 Jul 2011 11:47:36 -0700
Message-ID: <7vbowq9kfr.fsf@alter.siamese.dyndns.org>
References: <1311095876-3098-1-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jeff King <peff@peff.net>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 19 20:47:56 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QjFKl-0000AJ-Gv
	for gcvg-git-2@lo.gmane.org; Tue, 19 Jul 2011 20:47:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751289Ab1GSSrk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Jul 2011 14:47:40 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63213 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750933Ab1GSSrj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jul 2011 14:47:39 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BCCB93CFB;
	Tue, 19 Jul 2011 14:47:38 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=i6jsJ/zsjqiNm9BW5/NEx/h5OVk=; b=QPhXTP
	y0D4dADwiai0B3kb/2/I0ovcmvztgikomjSsJwudq9cN920IlbCDjoR9crIjn3Du
	vGoaBDECRF8Ke+sKmHF0FTT834L7NlgxF8k0OK/fTEhpHCfa9ioM1P2Ahz1rfshn
	1E2Q/4Mggl1xzi/nY9oFvXMCzH9z1n1/RoQR4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=uS1iELGDsZgoiGmQRL2o5kGFIx+RBi5g
	OXe/bLJQBY6hn7dNy/DF9N6FzV9AWwBmvA1PeO4BUlRTzjMvPfFt8mIOWDTWSkAf
	BaJhl4SOtOpu4JVwHR7YdppnMopqg7A2Y5yeN7ZjY7opqBpxiveGvdnqANReWslp
	Td0JN7OVgEQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B4C523CFA;
	Tue, 19 Jul 2011 14:47:38 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4C02C3CF9; Tue, 19 Jul 2011
 14:47:38 -0400 (EDT)
In-Reply-To: <1311095876-3098-1-git-send-email-artagnon@gmail.com> (Ramkumar
 Ramachandra's message of "Tue, 19 Jul 2011 22:47:38 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 932CABF0-B237-11E0-9756-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177491>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

>>> +                     if (!cur->next)
>>> +                             /*
>>> +                              * An error was encountered while
>>> +                              * picking the last commit; the
>>> +                              * sequencer state is useless now --
>>> +                              * the user simply needs to resolve
>>> +                              * the conflict and commit
>>> +                              */
>>> +                             remove_sequencer_state();
>>>                       return res;
>>> +             }
>>>       }
>>
>> It may be useless for --continue, but wouldn't --abort need some clue on
>> what you were doing?
> ...
> Conclusion: Making "git commit" remove the sequencer state is WRONG.

Why not choose to not to clean it at all?  Then "rebase --continue" and
its equivalent to cherry-pick, rebase and any sequence command) can (and
have to anyway) notice that there is nothing more to do, remove the state
directory and state "there is nothing more to do".

You could make it even easier to use for people by tweaking "a sequence
state directory for an operation you earlier started still exists" logic
to see if everything is done, but I would say that is icing on the cake.
