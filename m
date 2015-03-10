From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4] rev-list: refuse --first-parent combined with --bisect
Date: Tue, 10 Mar 2015 16:12:18 -0700
Message-ID: <xmqqoao0xx9p.fsf@gitster.dls.corp.google.com>
References: <1425827005-9602-1-git-send-email-me@ikke.info>
	<1425934575-19581-1-git-send-email-me@ikke.info>
	<xmqqa8zkzeq5.fsf@gitster.dls.corp.google.com>
	<20150310225509.GA5442@vps892.directvps.nl>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Kevin Daudt <me@ikke.info>
X-From: git-owner@vger.kernel.org Wed Mar 11 00:12:28 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YVTK6-0000md-4y
	for gcvg-git-2@plane.gmane.org; Wed, 11 Mar 2015 00:12:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751026AbbCJXMV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Mar 2015 19:12:21 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:55717 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750707AbbCJXMU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Mar 2015 19:12:20 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id F3F493EE27;
	Tue, 10 Mar 2015 19:12:19 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ga5aoh3TtKElbYqr9AFDsonYHD0=; b=tzjdX+
	GRno0+V7MWF5Bg+wdQ70nI5uPj54h1R0u11JPZLeCJFl29mXGHfpa0H8PLmClkG0
	ZOr34c/z7vFRiBp3Ai/GQyNmS7whiiVBsbtB3/400jZHUauUpHikjbDOMjiqYBv0
	aQh2kJc/aqoR4FDQqNuZkx6NkhlGfljeYjp/c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=XuGK4BtsgkzkBYsfRpledvQgw47t85MO
	GFOEAWMIJ1tTuPBywAIw/m18cSs/2MVXTrJBMwSFqVwiDhr49eoffaDwgOUEUCCp
	W3Ievet1lX45jJ6zHh7ojO8ZsvoIY75gDS6hz+EN6dpJFHTDSX4y8YDTi50XR8RI
	ihTBbdh2ybQ=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id EC4C83EE25;
	Tue, 10 Mar 2015 19:12:19 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 59D333EE21;
	Tue, 10 Mar 2015 19:12:19 -0400 (EDT)
In-Reply-To: <20150310225509.GA5442@vps892.directvps.nl> (Kevin Daudt's
	message of "Tue, 10 Mar 2015 23:55:09 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: E66D5826-C77A-11E4-BACA-29999F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265280>

Kevin Daudt <me@ikke.info> writes:

> git log --bisect seems to do something different then git rev-list
> --bisect
>
> From git-log(1):
>
>     Pretend as if the bad bisection ref refs/bisect/bad was listed and
>     as if it was followed by --not and the good bisection refs
>     refs/bisect/good-* on the command line.
>
> This seems to just add addition refs to the log command, which seems
> unrelated to what rev-list --bisect does.
>
> So I don't see why git log --bisect --first-parent should be prohibited
> (unless this combination doesn't make sense on itself).

Well, but think if your "unless" holds true or not yourself first
and then say "I do not think this combination doesn't make sense",
if you truly mean "I don't see why ... should be prohibited".

What does such a command line _mean_?  It tells us this:

    Define a set by having the "bad" ref as a positive end, and
    having all the "good" refs as negative (uninteresting) boundary.

That is a way to show commits that are reachable from the bad one
and excluding the ones that are reachable from any of the known-good
commits.  The area of the graph in the current bisection that
contains suspect commits.

Now, what does it mean to pull only the first-parent chain starting
from the bad one in such a set in the first place?  What does the
resulting set of commits mean?
