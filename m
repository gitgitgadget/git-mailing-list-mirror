From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] pull: drop confusing prefix parameter of die_on_unclean_work_tree()
Date: Mon, 14 Mar 2016 10:11:13 -0700
Message-ID: <xmqqbn6hassu.fsf@gitster.mtv.corp.google.com>
References: <974d0bfed38e8aa410e97e05022bc5dbbd78d915.1457615785.git.johannes.schindelin@gmx.de>
	<xmqqr3fidxs3.fsf@gitster.mtv.corp.google.com>
	<xmqqk2ladx36.fsf@gitster.mtv.corp.google.com>
	<alpine.DEB.2.20.1603141410590.4690@virtualbox>
	<xmqqfuvtav5k.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Paul Tan <pyokagan@gmail.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Mar 14 18:11:27 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1afW1Z-0004Eh-8k
	for gcvg-git-2@plane.gmane.org; Mon, 14 Mar 2016 18:11:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753248AbcCNRLT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Mar 2016 13:11:19 -0400
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:60399 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753196AbcCNRLQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Mar 2016 13:11:16 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 4AE304C30D;
	Mon, 14 Mar 2016 13:11:15 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=UmY03MAWMGVZcc207uWJL2AYX0s=; b=coIS0B
	satBNT4sF5OzClJFFxB4Nzb3LW9kBGDK2OI94lKlSt0k/EBg0QxxcutZIZaacZRx
	hmE3MmYfNXMdi/v8wvar1GAR0H7AAN24dR9A++KnDUjYpaKU+n2S+mWKiE3pfkZ9
	srWLi3jYhWP/ci+9jny95yFbOHfn22mPZMCas=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=puIhuM8b977yIVt7jgAbBun88ZcYSF50
	QO4nOoz2ISPu7d4gHWbjORBww4mAros37hnpfE2HI/hPvYLWxIYC7Q+wprGz8+a2
	uDHL/d5VtfuU3DJPm2gP42LBq03YQiFr6iiNw65zlwEOJQKVXUuuz04aDV94swjS
	o4oc/6PymSk=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 42AA94C30C;
	Mon, 14 Mar 2016 13:11:15 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id BB56A4C30B;
	Mon, 14 Mar 2016 13:11:14 -0400 (EDT)
In-Reply-To: <xmqqfuvtav5k.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Mon, 14 Mar 2016 09:20:23 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: C22947EE-EA07-11E5-B69D-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288790>

Junio C Hamano <gitster@pobox.com> writes:

> For the purpose of letting "git pull --rebase" make sure that there
> is no difference between the index and the working tree, we'd want a
> tree-wide diff, so we do not want to limit the diff with pathspec.
> Not passing "prefix" to init_revisions() _is_ the right thing.

Oh, sorry, I think it is me who uses confusing phrasing, not your
reading skills.  What I meant by the above was:

 - We do want tree-wide diff.

 - We do not want to limit to a subtree.

 - Passing prefix to init_revisions() mean "if we have pathspec,
   they are relative to this prefix".

 - That may hint to the reader that the diff we are going to run may
   be limited to some subset to the tree, which is not what we are
   doing.

 - Hence, we should pass NULL to init_revisions() to make it
   explicit that we are not limiting.

 - And the part of your patch to pass NULL to init_revisions() is
   correct.

But the function itself should take prefix, even if it is not going
to use it to call init_revisions(), because it makes it possible to
do a better reporting later.
