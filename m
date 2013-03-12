From: Junio C Hamano <gitster@pobox.com>
Subject: Re: difftool -d symlinks, under what conditions
Date: Tue, 12 Mar 2013 13:38:26 -0700
Message-ID: <7vk3pc73r1.fsf@alter.siamese.dyndns.org>
References: <CAJELnLGq_oLBiNHANoaE7iEiA6g4fXX0PtJbqPFi4PQ+5LLvnA@mail.gmail.com>
 <CAJDDKr4mTc8-FX7--pd7j0vUbdk_1+KU0YniKEhRdee6SaS-8Q@mail.gmail.com>
 <CAJELnLEL8y0G3MBGkW+YDKtVxX4n4axJG7p0oPsXsV4_FRyGDg@mail.gmail.com>
 <CAJELnLGOK5m-JLwgfUdmQcS1exZMQdf1QR_g-GB_UhryDw3C9w@mail.gmail.com>
 <20130312190956.GC2317@serenity.lan>
 <CAJDDKr7S0ex1RvZS0QeBXxAuqcKrQJzhZeJP0MoMGmpGXyMOrA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matt McClure <matthewlmcclure@gmail.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>,
	Tim Henigan <tim.henigan@gmail.com>,
	John Keeping <john@keeping.me.uk>
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 12 21:39:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UFVyL-0005Lc-3A
	for gcvg-git-2@plane.gmane.org; Tue, 12 Mar 2013 21:38:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933528Ab3CLUia (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Mar 2013 16:38:30 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36550 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933519Ab3CLUi3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Mar 2013 16:38:29 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D7552A38B;
	Tue, 12 Mar 2013 16:38:28 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=GLSHV0jI9l4GBECO1vMWfebJ/tI=; b=V/7ihm
	sjLhB9Q7mRvR/hawXAAEJcdJc/4a//18Vxr+s+H1RvWZ8+mnct5n+YzWQ8PJp2sG
	8fhEqAf1le8+x+wZ4356FEAwZTyAI46d35wI+8uEUmABnYIMMtoWytJxwiNhja5P
	bvjqa1tt4s67w63BTxUoMuinK2SRvlq6TeBsU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=NxBYBEeP6XtOI+BaU85KxiQvLGN1s0w0
	jAXfU6BMZTNcXLlK84kNrx+9NUZmJON+G4bUuDVjJ+cjdIHYf2Mu+qFzL3Bk2A7E
	xyg8y4e66L0pHLbJgoyV22Fv4PtRAok6gEHbnK3UyhhAI6UengOEXcPJOlAIcNE8
	YITLiUr+L1Y=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CC3E4A389;
	Tue, 12 Mar 2013 16:38:28 -0400 (EDT)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3C417A386; Tue, 12 Mar 2013
 16:38:28 -0400 (EDT)
In-Reply-To: <CAJDDKr7S0ex1RvZS0QeBXxAuqcKrQJzhZeJP0MoMGmpGXyMOrA@mail.gmail.com> (David
 Aguilar's message of "Tue, 12 Mar 2013 12:23:52 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: CB852DCC-8B54-11E2-A4A6-26A52E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217991>

David Aguilar <davvid@gmail.com> writes:

> Interesting approach.  While this does get the intended behavior
> for difftool, I'm afraid this would be a grave regression for
> existing "git diff --raw" users who cannot have such behavior.

The 0{40} in RHS of --raw output is to say that we do not know what
object name the contents at the path hashes to.

If you run "git diff HEAD^" for a path that is different between
HEAD and the index for which you do not have a local change in the
working tree, we have to show the path (because it is different
between the working tree and HEAD^), but we know the object name for
copy in the working tree, simply because we know it matches what is
in the index.  Showing 0{40} on the RHS in such a case loses
information, making us say "We don't know" when we perfectly well
know.  That is a regression.

If the user is allowed to touch any random file in the working tree,
I do not see a workable solution other than John Keeping's follow-up
patch to make symlinks of all paths involved.
