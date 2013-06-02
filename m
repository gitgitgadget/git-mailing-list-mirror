From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git clone depth of 0 not possible.
Date: Sun, 02 Jun 2013 12:14:04 -0700
Message-ID: <7vsj10nx4z.fsf@alter.siamese.dyndns.org>
References: <1357581996-17505-1-git-send-email-stefanbeller@googlemail.com>
	<20130108062811.GA3131@elie.Belkin>
	<7vip78go6b.fsf@alter.siamese.dyndns.org>
	<CACsJy8D9+KHT=YfU0+rPCbs+AwxQOpfKzPChDhk8d-MMkRzZug@mail.gmail.com>
	<7vvcb8f6aw.fsf@alter.siamese.dyndns.org>
	<20130528091812.GG25742@login.drsnuggles.stderr.nl>
	<7va9nf2fyp.fsf@alter.siamese.dyndns.org>
	<20130530082322.GW25742@login.drsnuggles.stderr.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Duy Nguyen <pclouds@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Stefan Beller <stefanbeller@googlemail.com>,
	schlotter@users.sourceforge.net, Ralf.Wildenhues@gmx.de,
	git@vger.kernel.org
To: Matthijs Kooijman <matthijs@stdin.nl>
X-From: git-owner@vger.kernel.org Sun Jun 02 21:14:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UjDjW-0005oH-Nn
	for gcvg-git-2@plane.gmane.org; Sun, 02 Jun 2013 21:14:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755695Ab3FBTOJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Jun 2013 15:14:09 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61757 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755666Ab3FBTOG (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Jun 2013 15:14:06 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5E5DF24BB1;
	Sun,  2 Jun 2013 19:14:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=A4OFIhs0sOuSB2RV9PnHJ/rPSgc=; b=mVN5H2
	79euCQvzZjf+nw0MiFKlk+pmoTsRUNQQCjI98ne8IgshS+Hv5+vtK2a+OvbkL/MU
	wOJsAcdzUaEp7HPfPVGquum9FOJ1ngVJk5yM7X8jVeDnNJrDesHflYfdk3HST6nB
	X41FKVIznt9jORSb4UNh1LaAJ2MXRD0tFdIgU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=i88c5dxSVWkODfRhDwopyy7LsNONkc+t
	Vl6cE+eafcqz6KchM4nhQ5wFYIME52ZJmODP4nvSUCF2I+rh4kUghrqYEvG3krx/
	pbTj/AWqvhfXi6P7JkiZxXEIvYSZ2t21NFBDqvT18KyrObmVqgGjPa1GVUDEeCE+
	RraWYt36pZw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 55A4924BB0;
	Sun,  2 Jun 2013 19:14:06 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B597524BAD;
	Sun,  2 Jun 2013 19:14:05 +0000 (UTC)
In-Reply-To: <20130530082322.GW25742@login.drsnuggles.stderr.nl> (Matthijs
	Kooijman's message of "Thu, 30 May 2013 10:23:22 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 97F40236-CBB8-11E2-AE62-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226173>

Matthijs Kooijman <matthijs@stdin.nl> writes:

>> Doing it "correctly" (in the shorter term) would involve:
>
> Given below suggestion, I take it you don't like what Jonathan proposed
> (changing the meaning of the deepen parameter in the protocol so that
> the server effectively decides how to interpret --depth)?

Correct.

> We can implement these two in current git already, since they only
> add to the protocol, not break it in an incompatible manner, right?

Correct.

>>  - teaching the requestor that got --depth=N from the end user to
>>    pay attention to the new capability in such a way that:
>> 
>>    - when talking to an old sender (i.e. without the off-by-one
>>      fix), send N-1 for N greater than 1.  Punt on N==1;
>> 
>>    - when talking to a fixed sender, ask to enable the capability,
>>      and send N as is (including N==1).
> And these should wait for git2, since they change the meaning of the
> --depth parameter? Or is this change ok for current git as well?

My suggestion was based on the understanding that everybody agreed
that the current behaviour of --depth=1 to have one extra commit
behind the shallow "snapshot" aka "poor-man's tarball", is a *bug*
to be fixed, so I didn't mean it as a "backward incompatible change"
at all.

> What do you mean by "punt" exactly?

As old senders can only send a history with 2 or more commits deep,
it would be sensible for the receiver to warn the user that we are
buggily asking for one more than the user asked for to the sender,
and fetch history with two commits.  It would be a regression to
error it out.


>> In the longer term, I think we should introduce a better deepening
>> mechanism.  Cf.
> Even when there will be a better deepening mechanism, the above is still
> useful (passing --depth=1 serves to get just a single commit without
> history, which is a distinct usecase from deepening the history of an
> existing shallow repository).

Correct.  That is why I said "in the longer term, we should
introduce".  Did I say "introduce and replace with it"?
