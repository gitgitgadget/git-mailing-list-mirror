From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/2] Slightly prettier reflog message from checkout
Date: Sun, 16 Jun 2013 19:59:52 -0700
Message-ID: <7vtxkxigrb.fsf@alter.siamese.dyndns.org>
References: <1371317906-3991-1-git-send-email-artagnon@gmail.com>
	<7vmwqqkftv.fsf@alter.siamese.dyndns.org>
	<CALkWK0ki9C9OL36b3j14C-mVMPy07Uj5FXcrfMZJs_g3zBRC9A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 17 05:00:10 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UoPfr-0001hc-El
	for gcvg-git-2@plane.gmane.org; Mon, 17 Jun 2013 05:00:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755819Ab3FQC75 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Jun 2013 22:59:57 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36473 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755783Ab3FQC7z (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Jun 2013 22:59:55 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D2F331E176;
	Mon, 17 Jun 2013 02:59:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=UPeoUYbp21B+ky2uDzJi4DfJDko=; b=FeON8c
	DC/CFjRFK7pkGZviFZcOckztNX7eYVyAWAn5sb8OajJf+rTecG/gkYkZrF6/jnJs
	e5R8BtkJrN0cjFQhiW2E6Wf0Iz+OOMnmblaj0SulDc5MBJRYWH6ZFNe33rFcaLbj
	0t1TiOv+MLc9DfxDzzzTJL3y6vYL3+d1W86Zo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=SQTuWWSHBdwx66//rc9FcWzsOExiRoks
	XpLffnHkdas8waTrjQFpMxieRp3yqek3EnWi7V+LMg6N62F8RIf7m8unujyVB1g/
	CsHaViglvQis0Xbdivis29dRgtCkaTxbfPciSfiv/8rtsPc6qaQDHzpzpCmpv3JS
	TzoCUHNmkCk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CA8791E175;
	Mon, 17 Jun 2013 02:59:54 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 57B6B1E171;
	Mon, 17 Jun 2013 02:59:54 +0000 (UTC)
In-Reply-To: <CALkWK0ki9C9OL36b3j14C-mVMPy07Uj5FXcrfMZJs_g3zBRC9A@mail.gmail.com>
	(Ramkumar Ramachandra's message of "Sun, 16 Jun 2013 14:51:52 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: FC5CCDEC-D6F9-11E2-B7E1-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228035>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> Junio C Hamano wrote:
>> I view the two codepaths touched by these patches the other way
>> around.
>
> I see.  Thanks for the early feedback.  I have some doubts.
>
>> An abbreviated unique SHA-1 you have today may not be unique
>> tomorrow.

> When did we guarantee that the messages written by the reflog are invariant?

That is not the point.  From the proposed log message for your 2/2:

  f855138: checkout: moving from bdff0e3a374617dce784f801b97500d9ba2e4705 to co-reflog
  f855138: checkout: moving from bdff0e3 to co-reflog

The "bdff0e3" may be a unique abbreviation to identify the commit
bdff0e3a374617dce784f801b97500d9ba2e4705 when the reflog entry was
written.  But the latter can become meaningless once you have an
unrelated commit in your history that shares the prefix.

That is the "deliberate loss of information" I saw in the proposal.
Recording full 40-hex does not have to worry about that issue; you
do not even have to argue "but in this case we do not even have to
have unique SHA-1, nobody uses it" vs. "some other codepaths you are
not aware of may want to take advantage and start using it".  In
other words, we will have one less thing we have to worry about.
