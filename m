From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [ANNOUNCE] Git 1.7.10-rc3
Date: Thu, 29 Mar 2012 14:22:31 -0700
Message-ID: <7vbonfqezs.fsf@alter.siamese.dyndns.org>
References: <7vd37wv77j.fsf@alter.siamese.dyndns.org>
 <20120329095236.GA11911@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Mar 29 23:22:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SDMnm-00078d-Sw
	for gcvg-git-2@plane.gmane.org; Thu, 29 Mar 2012 23:22:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760020Ab2C2VWe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Mar 2012 17:22:34 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35498 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933223Ab2C2VWd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Mar 2012 17:22:33 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E0D667DBE;
	Thu, 29 Mar 2012 17:22:32 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=/jE9DgVbVQnPkdlcYRhTi5Hafjo=; b=gT/G17
	5IH+fNW1UoFbSurrJL3pG47MXO+DN8btYm4oy5nPkUHI/BgMXPIm7agwwqibPP6N
	a4/Zebp1xBG9P2NPV2IRx0NQxZIUTP+stcg0tLObfiPcFdwfPsmU/z8sc52l8XGJ
	4TpnTcbXVK8Kar02YB8BbL9tJkOMASEwX46+o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=S7hAdlodYw34igPX3SwPDwebkcbhdxzx
	BVrrt4B/W2y/b532V1FbSs1p2QTFDlXh0GNcI/VrEvsX+n9DLqRTD652tnLZ8Mmf
	xH1xymzI7G4Di9HR7Z94mUu1dVCBtbz8ema4yj9KCwmie265tTIuCsNdgpCsaD0g
	t9uju8ZaSqs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D855B7DBD;
	Thu, 29 Mar 2012 17:22:32 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 69C127DBC; Thu, 29 Mar 2012
 17:22:32 -0400 (EDT)
In-Reply-To: <20120329095236.GA11911@sigill.intra.peff.net> (Jeff King's
 message of "Thu, 29 Mar 2012 05:52:36 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 4BD343E2-79E5-11E1-9493-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194295>

Jeff King <peff@peff.net> writes:

> On Wed, Mar 28, 2012 at 12:47:12PM -0700, Junio C Hamano wrote:
>
>>  * When you do not tell which branches and tags to push to the "git push"
>>    command in any way, the command used "matching refs" rule to update
>>    remote branches and tags with branches and tags with the same name you
>>    locally have.  In future versions of Git, this will change to use the
>>    "upstream" rule to update the branch at the remote you would "pull"
>>    from into your current branch with your local current branch.  The
>>    release after 1.7.10 will start issuing a warning about this change,
>>    to encourage you to tell the command what to push out, e.g. by setting
>>    push.default configuration.
>
> Did we decide that "upstream" will be the new rule in future versions? I
> still have some misgivings about that (versus "current"), but I thought
> the only decision we were settling now was whether to change at all.

I counted the AOL me-too on "upstream" vs "current" ;-)

Seriously speaking, I think we have enough time to make sure that
"upstream" errors out with an appropriate advice when:

 - The user says "git push" (no remote, no refspec) on a branch without
   any tracking set; or

 - The user says "git push $remote" (either remote nick or url, no
   refspec) when there is no "remote.$remote.push" and the current branch
   does not have tracking set to that remote (includes the cases where it
   does not have any tracking set, and where it has tracking set to
   different remote).

Once that happens, there no longer is a reason "current" is more suitable
for beginners, I would think.

The "easy to understand for beginners" explanation for "upstream" becomes:

  Nothing is pushed until you explicitly say what is pushed where, and you
  can say that by either:

   - setting remote.$remote.push;
   - setting branch.$current.merge; or
   - saying it on the command line.

Compared to this, the "easy to understand for beginners" explanation for
"current" which is "The current is pushed to the other end with the same
name", may still be far easier to understand, but much less useful.
