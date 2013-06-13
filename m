From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] rebase -i: write better reflog messages for start
Date: Thu, 13 Jun 2013 09:55:40 -0700
Message-ID: <7va9muvtkj.fsf@alter.siamese.dyndns.org>
References: <1370881332-9231-1-git-send-email-artagnon@gmail.com>
	<1370881332-9231-4-git-send-email-artagnon@gmail.com>
	<7v8v2hizpc.fsf@alter.siamese.dyndns.org>
	<CALkWK0mmSKDH2vrz4a8Qb8=++NSAp2x5mCUEuLpPo9HLfmgFLw@mail.gmail.com>
	<CALkWK0=o0OxTjim=+qoBhpHkWQoVWLWjkJPqknPbr29T5ax46Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 13 18:55:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UnAoO-0002Q3-Bs
	for gcvg-git-2@plane.gmane.org; Thu, 13 Jun 2013 18:55:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758654Ab3FMQzn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Jun 2013 12:55:43 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64926 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753221Ab3FMQzn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Jun 2013 12:55:43 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 925132672D;
	Thu, 13 Jun 2013 16:55:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=G3eEQSXzCUwaQH59XPv/4Pz9cfQ=; b=wAIC2A
	SaC27fwKOuFASSd716tvSt05BtHbgyczO5qwQmRH750HO8fcCxpx1j1u4KJGwIom
	TSnmWaiw2t0PvihV96Jwu4f4cSUY3GhwqpEBkiUgHF8m+fT8U9z72wb3TE8V7GAw
	RSlzXF96vZf9nHXqek+J+6rXoShyqWQpbMJr8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=VeCtxT3WgqvpOL2EUiaTdRJ6aomUkWrZ
	Yu7KoX04f6BtxKRye2UL1I/qNMJvqcIYgmEy2lhRbK7HGvJRrtUUdwBOxbd/yQRB
	/8V0tr7XlLQ8vAAcGS9hycDf4/O1Zd5c2smudTd3LZA2ZgRtVrLSD6HL5PY8GCq2
	ieIqFW+qAC4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 897A12672B;
	Thu, 13 Jun 2013 16:55:42 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BF91026729;
	Thu, 13 Jun 2013 16:55:41 +0000 (UTC)
In-Reply-To: <CALkWK0=o0OxTjim=+qoBhpHkWQoVWLWjkJPqknPbr29T5ax46Q@mail.gmail.com>
	(Ramkumar Ramachandra's message of "Thu, 13 Jun 2013 16:02:54 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 14E7ADE4-D44A-11E2-A95B-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227747>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> Ramkumar Ramachandra wrote:
>> t/status-help.  Looks seriously unrelated, and I'm breaking my head
>> over it.  Any clues?
>
> Damn it!  A recent commit is responsible for this avalanche in test
> breakages: b397ea (status: show more info than "currently not on any
> branch", 2013-03-13).  It re-implements a backward version of
> grab_nth_branch_switch(): grab_1st_switch() essentially _relies_ on
> the random unintended pollution that rebase writes to the reflog to
> print a more useful (?) status :/

After "git checkout v1.3.0", it is reasonable to expect that you can
tell what you checked out and what state you are in.  If you then
made a few commits or resetted to some other commit, it is debatable
if "detached from v1.3.0" is useful or the subtle difference between
"detached at" vs "detached from" is confusing.

But what does it have to do with rebase polluting the reflog?
