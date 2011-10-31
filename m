From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Reference has invalid format: check maybe a bit to harsh?
Date: Mon, 31 Oct 2011 12:54:31 -0700
Message-ID: <7vty6pos20.fsf@alter.siamese.dyndns.org>
References: <60007404.ge1WXNp2Qn@soybean>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Peter Oberndorfer <kumbayo84@arcor.de>
X-From: git-owner@vger.kernel.org Mon Oct 31 20:54:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RKxwN-0003sD-Vy
	for gcvg-git-2@lo.gmane.org; Mon, 31 Oct 2011 20:54:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754764Ab1JaTye (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Oct 2011 15:54:34 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45572 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751579Ab1JaTyd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Oct 2011 15:54:33 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E3D7D6312;
	Mon, 31 Oct 2011 15:54:32 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=BMwzx5va2G4ZlDFUSFzhLVKLTa8=; b=oZWQpG
	sHVPAkpn6NeNdv9gHj2VHKy/MmKHKfMkL6MsCkzJjSCUY6csbbXTYX4sK35KGoJH
	BC+74kgdx/SlsuMVvV4M5KCeHOoaMWIKHFmYgFpZpgzBS1rvUIxgU50ZEUmYbSQQ
	UCUHly9bS7uX/G0FXEET0Bi5f3UsSDLnXxVF8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=NKSKKW3LFSejJTQGcmBnXOE+S4wzChUq
	7oRup7YwxQil8i+mL585ndoSsCPF9r/fEpHFb/6SnRbBu37qLywxlCfMrZKFEEwV
	uK3bAS8a9tnH2pLy1KH0XyY9hZwKKmDPHZ4FizcWkq7GaeO9LIto6+hN1a9JcBYF
	qboERFA5l6A=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D9CB66311;
	Mon, 31 Oct 2011 15:54:32 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6EB036310; Mon, 31 Oct 2011
 15:54:32 -0400 (EDT)
In-Reply-To: <60007404.ge1WXNp2Qn@soybean> (Peter Oberndorfer's message of
 "Mon, 31 Oct 2011 20:14:25 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 26C00240-03FA-11E1-BD2D-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184517>

Peter Oberndorfer <kumbayo84@arcor.de> writes:

> The invalid refs(about 30, loose and packed) containing a ':' were created by 
> stgit a long time ago(Dec 2006)

I think even back then colon was one of the forbidden letters in a
refname. Of course, it is entirely possible that broken third-party tools
may have created such file that is not a ref in .git/refs hierarchy by
hand, and we may not be carefully rejecting such broken refs for a long
time.

    ... Goes and asks "git blame" ...

03feddd (git-check-ref-format: reject funny ref names., 2005-10-13)
started disallowing control characters and other characters that are used
for range operators and the separator between LHS and RHS of refspecs,
further tightened by 6828399 (Forbid pattern maching characters in
refnames., 2005-12-15).

> But i'm just wondering if dieing when seeing a single invalid ref might be a 
> bit too harsh since no git tools can be used anymore on this repo at all.

I agree that we would want to give users an escape hatch.  That is, if we
can make something like this to work:

    c=$(git rev-parse --force refs/patches/obd_development/blah:_vari...)
    git update-ref refs/patches/obd_development/blah--various-improvements $c

I think we would be in a good shape.
