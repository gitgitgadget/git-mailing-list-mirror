From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/7] sequencer: handle single-commit pick as special case
Date: Tue, 15 Nov 2011 13:58:21 -0800
Message-ID: <7v62ilujya.fsf@alter.siamese.dyndns.org>
References: <1321181181-23923-1-git-send-email-artagnon@gmail.com>
 <1321181181-23923-4-git-send-email-artagnon@gmail.com>
 <7vpqgvmwtl.fsf@alter.siamese.dyndns.org>
 <CALkWK0krTY+szqPrE9wxwfK76VBbFXh_Xaz8EyWZayLa_SFQTw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 15 22:58:32 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RQR1R-0006qA-R4
	for gcvg-git-2@lo.gmane.org; Tue, 15 Nov 2011 22:58:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757400Ab1KOV6Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Nov 2011 16:58:25 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35464 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751217Ab1KOV6Y (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Nov 2011 16:58:24 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9EB80625B;
	Tue, 15 Nov 2011 16:58:23 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=5bfYZVMSf8TwOm/X7nD886fIupo=; b=qfbKP9
	eR/PLevxsf6RWNw4i6EQn17r/YCcFB5JZRGK8X2HxhvU283G7Mc4SxXd2y9x09cx
	ukOAzAfdLbjE1tKjKYfgEIcnDg1Jw1KsZ6jrqfjciCewJrrGSIrmnREnmPGmywVs
	jTmPY1Z1LakeiJwDgUTJLOK1iUICxqAcy9sWM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=E3vuzwrUD6A1G9lD+05CmKrYUbIyFxeW
	SIWCe7FoZm3wQH59WRkB5o52VIhHFd267PY9obsOKHfUmIPgp+5dfuP0QHryO1T9
	MJ/TLvm7QR33aPaet2G6f+RX9RhpEKyt8juZwRe13V/Bd3HwLQZF1qreltkDnjgS
	QiHjI7fOU+o=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8D662625A;
	Tue, 15 Nov 2011 16:58:23 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 031046254; Tue, 15 Nov 2011
 16:58:22 -0500 (EST)
In-Reply-To: <CALkWK0krTY+szqPrE9wxwfK76VBbFXh_Xaz8EyWZayLa_SFQTw@mail.gmail.com>
 (Ramkumar Ramachandra's message of "Tue, 15 Nov 2011 14:17:08 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: EFE7864E-0FD4-11E1-B121-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185492>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> Hi Junio,
>
> Junio C Hamano writes:
>> Ramkumar Ramachandra <artagnon@gmail.com> writes:
>>> [...]
>> [...]
>> I do not see an inconsistency here, let alone any "glaring" one.
>
> Yeah, my commit message is totally misleading and unclear.  Yes, all
> the operations make sense to you and me; for a new user who doesn't
> understand how Git works, it's completely inconsistent at a very
> superficial level, no?  The sequence of operations he has to execute
> depends on:
> 1. If he literally specified a single commit or a commit range on the
> command-line.

But we are already in agreement on this point, I think. Didn't I say:

  It is a different story if the sequence were like this:

      $ git cherry-pick foo
      ... conflict happens
      $ edit problematicfile
      $ git add problematicfile
      $ git cherry-pick --continue
      ... This should notice CHERRY_PICK_HEAD and record it.
      ... After that, there is nothing remaining to be done.

  In other words, the user said "I want to replay this commit", the command
  couldn't finish it by itself and asked the user to help resolving the
  conflict, the user resolved and told the command to continue. The command
  should continue recording the result.

  And if "continue" does not work in this sequence, that is a bug worth
  fixing.

in the message you are responding to?

> 2. In the case of multi-commit picking, there's an additional layer of
> decision making: did the conflict occur in the last commit in the
> range?

Again, it would be the same thing. If the implementation forces that
decision, that would be a bug, no?

My understanding is that multi-commit form of cherry-pick and revert
intended to allow two forms of "user done helping and telling the command
to continue" at any stage, be it the first, in the middle, or the last
operation in a series:

 - User resolves, adds and commits, and then tells the command to
   continue. The command notices that the user has committed, and goes on
   to the next task; or

 - User resolves, adds, and then tells the command to continue. The
   command notices that the user has not committed, makes a commit and
   goes on to the next task.

I think "rebase -i" works the same way and both are valid ways to tell the
command to continue.

Now, multi-commit form of cherry-pick/revert _may_ be buggy (I do not use
that form often myself to know if this is the case, though) and may only
allow one or the other depending on which commit in the series the user is
asked to help, but if that is the case it is a bug in the implementation
of the multi-commit form done back in v1.7.2 timeframe.
