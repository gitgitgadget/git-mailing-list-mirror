From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Premerging topics
Date: Wed, 24 Apr 2013 00:14:57 -0700
Message-ID: <7vppxkflhq.fsf@alter.siamese.dyndns.org>
References: <CALWbr2wocjqs1mpa+yuQ_Zw8m+SX24q6Pby3E3v3-jd-0w1pvQ@mail.gmail.com>
	<CALKQrgfO9fd+EEA=Vwe94tJbxkX89uDmMHm9rj6L=d4x7JJjaQ@mail.gmail.com>
	<CALWbr2x5HDU2t7hpSCkZnuKjTJ1KxYC0v50wsDPT0fm4LyvzWw@mail.gmail.com>
	<CALKQrgeGPo--cYoGZ30nSfASh4CPzqGXQojkG9Ve96NFr+LrjA@mail.gmail.com>
	<7vzjwofpht.fsf@alter.siamese.dyndns.org>
	<CALKQrgd8jZQ__rnAT3wbfx-Y6mg-vrTdam53nS2ya2c=yMcS6Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Antoine Pelisse <apelisse@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Jeff King <peff@peff.net>, git <git@vger.kernel.org>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Wed Apr 24 09:15:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UUtv5-0006WL-Px
	for gcvg-git-2@plane.gmane.org; Wed, 24 Apr 2013 09:15:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757520Ab3DXHPE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Apr 2013 03:15:04 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36739 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757489Ab3DXHPA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Apr 2013 03:15:00 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6622614E3F;
	Wed, 24 Apr 2013 07:14:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=GGubsJOx4WwehOkDyganbzLJAWk=; b=jSotRs
	vyaOpOpe11pWkCm2040hW/9y63u2xtyhW7eNSGrbUx3rtXE6bVsr9wV0ptvLrcHw
	gPT6lJcKvEold3V7nuE8G4qpLz4nikDkHjFYSdPQUqCYyh9M9LPUGC6WjMfJfW3n
	NESCbjrBGgj03HKr2bBgWIP3oKPTzdlFHkQXk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=VqqlIaTnysisiLgW3HRJOTjlpiSuFT6t
	BJtONl+zOYZ/33Fk5w6+qoyMNpaoa1P+XfpzoZykrpw8m4ZddBviI8mTE805yeNG
	mWCXpaXKESANxAxd1Sbd5l3QUctIRlcdrwxUsM0NLr1hjrm+lxRxbiNqiQL/wZM+
	T988p4epGxg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5CE5B14E3C;
	Wed, 24 Apr 2013 07:14:59 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BA69814E3B;
	Wed, 24 Apr 2013 07:14:58 +0000 (UTC)
In-Reply-To: <CALKQrgd8jZQ__rnAT3wbfx-Y6mg-vrTdam53nS2ya2c=yMcS6Q@mail.gmail.com>
	(Johan Herland's message of "Wed, 24 Apr 2013 08:22:18 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: AC317C20-ACAE-11E2-BE5B-BCFF4146488D-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222228>

Johan Herland <johan@herland.net> writes:

> This raises the same question I recently asked Antoine: For a given
> prepackaged merge <X,Y>, do we assume that it only resolves conflicts
> between the changes introduced in commit X vs. changes introduced in
> commit Y, or do we assume that it resolves conflicts between the
> histories leading up to X and Y, respectively? In other words, does
> <X,Y> _supercede_ earlier pre-merges between the histories leading up
> to X and Y?

That is an interesting question.  There are largely two cases.

When you replayed M---F to produce N---F', there may have been no
textual or semantic conflict.  Which means that there were no new
reason between A--X and B--Y that necessitates an evil merge.  A
later merge between a descendant of X (but not Y) and a descendant
of Y (but not X) can cherry pick the same <A,B> (M---F) on top of a
mechanical merge,

On the other hand, you may have had either a textual or a semantic
conflict when replaying <A,B> on N, and you had to fix up F' for it
to be the correct resolution of merge between X and Y.

  ---o---o---A---o---X
      \               \
       \               N---F'
        \             /
         o---B---o---Y

In such a case, you do want to record the fixed N---F' as the
prepackaged resolution for <X,Y>.  Any time later when somebody is
on a branch that has X (but not Y) and merges a branch that has Y
(but not X), that N---F' should be the one to cherry-pick on top of
a mechanical merge O between S and T.  What <A,B> (M---F) did is
superseded if you are going to replay <X,Y>.

  ---o---o---A---o---X----------S
      \       \       \          \
       \       M--F    N---F'     O---F''
        \     /       /          /
         o---B---o---Y----------T

You can tell that by noticing that A is an ancestor of X and B is an
ancestor of Y.  As you said, this is a good way to reduce the number
of prepackaged evil merges that need to be considered.
