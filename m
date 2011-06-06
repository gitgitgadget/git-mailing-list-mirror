From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Command-line interface thoughts
Date: Sun, 05 Jun 2011 23:16:37 -0700
Message-ID: <7vwrgza3i2.fsf@alter.siamese.dyndns.org>
References: <BANLkTikTWx7A64vN+hVZgL7cuiZ16Eobgg@mail.gmail.com>
 <m339jps1wt.fsf@localhost.localdomain>
 <BANLkTinidLbQ_FcVEiGSK91uXYWaKk7MKA@mail.gmail.com>
 <201106051311.00951.jnareb@gmail.com>
 <BANLkTik+xhd5QQ09QiPSH1bFAndzipKtrw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>, Michael Nahas <mike@nahas.com>,
	git@vger.kernel.org
To: Scott Chacon <schacon@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 06 08:16:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QTT7S-0005ul-Me
	for gcvg-git-2@lo.gmane.org; Mon, 06 Jun 2011 08:16:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752531Ab1FFGQv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jun 2011 02:16:51 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:57080 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752500Ab1FFGQu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Jun 2011 02:16:50 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 9B5CF32E5;
	Mon,  6 Jun 2011 02:18:59 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Sz84+rdOqLJEQjdgbouD9dS7PMI=; b=VJEsCX
	UtjgVi3ziTPHyBUQZtEHzKpUX98zBTSBzItsyi/CkQbt/CEJK1AmybanClvCsQ0K
	L4+sa84ljaxe0GHr32etessf5AmiAmfvcjmGpKs3i9+L1x7dEfure8GBuyddWhwE
	u9clrdL/vRSzDNoqR/i6QYhPFJP43p/A9b0G0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=UZE/nKd1486Uac4sSF/iy9ytgce0fa9l
	duRskklySHMv1LRk2Ly34Cy5O4hU7SNELB6+OTTDJqvAKeBldLsbxJGLGlEZjqPQ
	eY7WzU+NYnhuXoPqCmU8IQ3F6OdFaUImOB1CJCVwaPc/A/82ab6vF35GJ1Z+Gryb
	5ub5s97NSjA=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 3A7CF32E1;
	Mon,  6 Jun 2011 02:18:55 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id E1CB932D7; Mon,  6 Jun 2011
 02:18:49 -0400 (EDT)
In-Reply-To: <BANLkTik+xhd5QQ09QiPSH1bFAndzipKtrw@mail.gmail.com> (Scott
 Chacon's message of "Sun, 5 Jun 2011 11:39:00 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: DB1E53E6-9004-11E0-B02F-EA23C7C1A288-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175092>

Scott Chacon <schacon@gmail.com> writes:

> For example, implementation details aside, I think having something
> like WTREE and NEXT available would help users understand that there
> are these 3 trees that are important and useful in Git and re-inforce
> a very non-SVN style workflow in that manner.

That's a funny thing to say. Working tree may almost always (to put it
another way, "you could make it to") act like a tree, but the index does
not act like a tree at all in more important situations.

For example, how would you design the user experience of "git show NEXT"?
Try to write a transcript (i.e. "The user starts from this state, runs
these commands, and then says 'git show NEXT'. The user will see this."),
covering various corner cases exhaustively, including what would happen
before the first commit, and during a conflicted "pull" or "rebase -i".

It's not just the matter of "internally pretend to run write-tree with
'not committed yet' as a fake commit log message and show it as if it is
an existing commit.

I wouldn't demand "implement 'git show NEXT'" here, nor "implement it
efficiently" here; just designing the user experience is a good first step
to realize that the index does not act like a tree, and I do not think you
should spread such a misconception to the end users.
