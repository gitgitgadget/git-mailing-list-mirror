From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH] Fix path prefixing in grep_object
Date: Mon, 26 Aug 2013 21:07:33 -0700
Message-ID: <xmqqhaebhj3u.fsf@gitster.dls.corp.google.com>
References: <1377394558-371-1-git-send-email-hordp@cisco.com>
	<CABURp0qG7Nnjpp17MAO7Ltwf51EsswZ3GcT-qyt14Vs1tc9pGw@mail.gmail.com>
	<xmqqa9k6moif.fsf@gitster.dls.corp.google.com>
	<20130825042314.GE2882@elie.Belkin>
	<xmqqk3jal4t7.fsf@gitster.dls.corp.google.com>
	<xmqqfvtwkjp8.fsf@gitster.dls.corp.google.com>
	<CABURp0oGMTEgX3TKKEMAOxe6T0=uij+bAyc+5u0x_UHwEPo3CQ@mail.gmail.com>
	<xmqqr4dgifp5.fsf@gitster.dls.corp.google.com>
	<CABURp0odEGgZO1yWFgXS+akPb4wJHiTLoQcmqBd00oYnPZ77vA@mail.gmail.com>
	<xmqqbo4kicsm.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>, Phil Hord <hordp@cisco.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: Phil Hord <phil.hord@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 27 06:07:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VEAZB-0002rM-Am
	for gcvg-git-2@plane.gmane.org; Tue, 27 Aug 2013 06:07:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752788Ab3H0EHh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Aug 2013 00:07:37 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46762 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752213Ab3H0EHg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Aug 2013 00:07:36 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2B9A5362F7;
	Tue, 27 Aug 2013 04:07:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=FERKjWFG4Qc70bIvVlICX0BcGko=; b=W65UN/
	y9F5H+66QjQQ/czF+4x55Tr6BkNeSdRTSYyvBITeiGhZJ7MrMGMYaMMtdpkdG3Lv
	nEanUaUmWTbC6pD98LlwCbFlsnp87zY9n/4g9talFdn0pJbsUv2SyKyNU5tdcKid
	aER+pTDY/RaOctX4FUfneTfcURRE0dcChosgY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Ls4F2YeeZfkhAqLKPtzTeIj0E7Jd2vK0
	n+SEascibyPLWAD8qTXkrwh4VAz93USK4A3+zXrLm+v9tm+axlYcYZPYR4+dWs/Z
	psVXL8IwI4TcUg3OIPD08VFpk8Xj3zRnT4unx3DbuM3YK/wf3os17sXiKQTrxOp+
	4uKEwqJmX9w=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2073A362F6;
	Tue, 27 Aug 2013 04:07:36 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 883AF362F4;
	Tue, 27 Aug 2013 04:07:35 +0000 (UTC)
In-Reply-To: <xmqqbo4kicsm.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Mon, 26 Aug 2013 10:26:17 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 345AAC44-0ECE-11E3-974B-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233047>

Junio C Hamano <gitster@pobox.com> writes:

> Not necessarily.  If the user is asking the question in a more
> natural way (I want to see where in 'next' branch's tip commit hits
> appear, by the way, I know I am only interested in builtin/ so I'd
> give pathspec as well when I am asking this question), the output
> does give <commit> <colon> <path>, so it is more than coincidence.

This part needs to be qualified.  "Natural" is of course in the eyes
of beholder.  If we assume that your #1 holds true (i.e. the tuple
<in which tree object are we reporting, what path we saw hits> is
important and merging them into one <in what blob we saw hits> lose
information), then it is natural to ask "inside origin/master tree,
where do I have hits?  By the way, I am only interested in builtin/"
and get "origin/master:builtin/pack-objects.c" as an answer (this is
from your earlier example), than asking "inside origin/master:builtin
tree, where do I have hits?"

If we do not consider #1 is false and the tree information can be
discarded, then it does not matter if we converted the colon after
origin/master to slash when we answer the latter question, and the
latter question stops being unnatural.

> ...
> but it might be a good change to allow A:B:C to be parsed as a
> proper extended SHA-1 expression and make it yield
>
> 	git rev-parse $(git rev-parse $(git rev-parse A):B):C
>
> Right now, "B:C" is used as a path inside tree-ish "A", but I think
> we can safely fall back, when path B:C does not appear in tree-ish
> A, to see if path B appears in it and is a tree, and then turn it
> into a look-up of path C in that tree A:B.

And if we want to keep the <tree, path> tuple, but still want to
make it easier to work with the output, allowing A:B:C to be parsed
as an extended SHA-1 expression would be a reasonable solution, not
a work-around. The answer is given to the question asked in either
way (either "in origin/master, but limited to these pathspecs" or
"in the tree origin/master:builtin/") without losing information,
but the issue you had is that the answer to the latter form of
question is not understood by the object name parser, which I
personally think is a bug.
