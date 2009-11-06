From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC 0/3] teach fetch --prune
Date: Thu, 05 Nov 2009 23:05:27 -0800
Message-ID: <7vhbt83zgo.fsf@alter.siamese.dyndns.org>
References: <1257484241-27219-1-git-send-email-jaysoffian@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 06 08:05:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N6ItC-0005Ed-Er
	for gcvg-git-2@lo.gmane.org; Fri, 06 Nov 2009 08:05:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752630AbZKFHFb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Nov 2009 02:05:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752619AbZKFHFb
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Nov 2009 02:05:31 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:38632 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752380AbZKFHFa (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Nov 2009 02:05:30 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 8D4B294335;
	Fri,  6 Nov 2009 02:05:34 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Y+71PibtO+dpPK7Ud76IEgCzcTA=; b=mFBnSB
	Up80OvRt9E4c+2sVQxluIaYgfLAHcqcxiLbrZmz65y2n6P2e6wL5AduZaAuPDsc/
	cdspuZq7PM/DKH5IAAfAlvvButaGkRG5Ztn+MQhR3saHmZ+mU+qbouPTpcp/VQY/
	u5/3Y8zMRW3D/PFwQc9PongK8ROVpHsrRrKYc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=k3Bdsi+Dm4BF4ARdfXazTl+K4CERRlTi
	tyqA1aykGgJG1FufYBjI5lHzAnFyzoLKt4MhYStP2s4EP7U8vNF3iEqIiGAXAuop
	7d548/P8Rwi/DGJVmPd5PhGe/LscrcaiE6Ir8KWXfUTv45CoatNmt2P5jr+2M67n
	lgAAH0WhjHA=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 7061694334;
	Fri,  6 Nov 2009 02:05:32 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 2D9C994333; Fri,  6 Nov 2009
 02:05:28 -0500 (EST)
In-Reply-To: <1257484241-27219-1-git-send-email-jaysoffian@gmail.com> (Jay
 Soffian's message of "Fri\,  6 Nov 2009 00\:10\:38 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: C6108BBE-CAA2-11DE-82D4-A67CBBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132276>

Jay Soffian <jaysoffian@gmail.com> writes:

> This is just a start so I can get some feedback. Some things still missing:
>
> 1) "git remote prune <remote>" calls warn_dangling_symref(), but 
> "git fetch --prune" does not. I ran out of time tonight to refactor 
> warn_dangling_symref() to do something more intelligent than just spew to
> stdout (which doesn't get along with fetch, which spews to stderr...).
>
> 2) Perhaps "git remote update --prune" should be refactored to call 
> "git fetch --prune". If so, then fetch should gain a "--prune-only" option
> so that "git remote prune" can just call "got fetch --prune-only".
>
> 3) Perhaps add a config option for users who wish to prune by default.
>
> Thoughts, comments, flames?

I usually refrain from talking about multi-year long term plans, because I
do not have one, but in a longer term (across 1.7.0 boundary and beyond),
the general direction would be:

 - "fetch" will eventually prune by default; I expect we will have a
   configuration option "fetch.autoprune = yes" to allow early adopters to
   let it prune until 1.7.0, and in 1.7.0 we will change the default for
   the configuration variable to "yes", i.e. we prune unless the user
   explicitly declines with "fetch.autoprune = no".

 - In general, "remote" should go back to its roots of being the
   management interface to [remote "nick"] configuration section.  We
   should start planning to remove extra features that were piled on top
   of the original "remote definition management tool".  "update/prune"
   should have been the duty of "fetch" in the first place, but they were
   added to "remote" primarily because it was easier to do so ("remote"
   used to be script but "fetch" was already written in "C").

   This means two things:

   * "remote prune" that only prunes without updating remaining tracking
     will be largely become unnecessary [*1*], once we have a way to tell
     "fetch" to prune at the same time.  As soon as "fetch --prune"
     becomes available, "remote prune" should become an alias to it.  And
     "remote prune" itself should eventually be removed.

   * "remote update" that runs "fetch" for multiple remotes should be
     deprecated and eventually removed.  "remote update" is a band-aid
     that exists only because "fetch" started as a strange chimera between
     plumbing and Porcelain, and we did not want to add too much features
     to it.  "fetch" itself should learn to do the "from multiple places"
     part as a full-fledged Porcelain.

Of course, a removal of a subcommand ("remote update" and "remote prune")
will have to happen way after 1.7.0 boundary, but the above should be the
longer term direction.

Don't worry about keeping the "only prune without updating" misfeature. If
omission of it simplifies what you are trying to do, it is Ok if "git
prune" becomes a synonym to "git update --prune" aka "git fetch --prune"
and starts updating the tracking refs.

[Footnote]

*1* "remote prune" is a band-aid that exists only because "fetch"
currently has no-way to prune at the same time.

One could argue that a user may want to prune _only_ stale refs without
getting the state of remaining refs updated to his tracking refs.  That
certainly is _possible_ with "remote prune", but being possible and being
sensible are two different things.  

What is the reason the user does not want to update a tracking ref that
corresponds to a branch that remains at the remote, when he runs "prune
only" version if it existed?  It cannot be because the branch may have
been rewound and you may lose the only remaining history---the user is
actively asking to prune and is willing to lose the history of stale
branches.

In other words, once we have "fetch --prune" (either default or
optional---the important part is that there is a way to cause fetch to do
this), there is no sane reason to have a separate command that only prunes
without updating the remaining tracking refs.
