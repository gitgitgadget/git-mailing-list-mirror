From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Symmetric of rebase / more intelligent cherry-pick
Date: Tue, 11 Oct 2011 14:28:18 -0700
Message-ID: <7vty7fdxql.fsf@alter.siamese.dyndns.org>
References: <20111011155444.GB14417@capsaicin.mamane.lu>
 <7v8vorfhhu.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Lionel Elie Mamane <lionel@mamane.lu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 11 23:28:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RDjsE-0007cW-7X
	for gcvg-git-2@lo.gmane.org; Tue, 11 Oct 2011 23:28:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750959Ab1JKV2W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Oct 2011 17:28:22 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46315 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750791Ab1JKV2V (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Oct 2011 17:28:21 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C03A853B6;
	Tue, 11 Oct 2011 17:28:20 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=N/jnzMM1vv6ol+DvItzbdc3Asl4=; b=mLcgxI
	/UzhGhqaoClQF/47+g7jOSxRCofIn7RrLUiOATSpiuOhELNWln/vVyzGvws/9+k7
	IfVycImOELMnDtmvDqKuZDqYVTrCM44IyZNYTfkhOLR8bkC/9UDNay+BlMWjKCL+
	f9lI/F14gbTYyVW9Qwn0UC2feXaACdHQfO7ow=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Zr7rZxgMW96MmU9AkgZhK/c71Hhncyv8
	nCSXsl+nX4I1pxupjndSEwKZOxedVWe/pv3O3c/uNGl+lN8/3FWsethOltb0iIN9
	WyelDAVgpRqCgsbZkYWxTIljBv4cI5rMWUErwNtfNngLrVyH65jkSf7AixRHWkR+
	HoAP05b5Kjs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B809153B5;
	Tue, 11 Oct 2011 17:28:20 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 37FC253B4; Tue, 11 Oct 2011
 17:28:20 -0400 (EDT)
In-Reply-To: <7v8vorfhhu.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Tue, 11 Oct 2011 12:36:13 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F0E74D5E-F44F-11E0-8A92-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183328>

Junio C Hamano <gitster@pobox.com> writes:

> Lionel Elie Mamane <lionel@mamane.lu> writes:
>
>> git cherry-pick ..UPSTREAM
>> *nearly* does what I want, except that it lacks rebase's intelligence
>> of skipping commits that do the same textual changes as a commit
>> already in the current branch.
>
> I think in the longer term "--ignore-if-in-upstream" that is known only to
> format-patch, which is the true source the intelligence of rebase you
> observed comes from, should be factored out into a helper function that
> can be used to filter output from get_revision() in other commands, or
> perhaps get_revision() itself might want to learn it.

We actually have half of that filtering in "--cherry-pick" that was
introduced in d7a17ca (git-log --cherry-pick A...B, 2007-04-09).

Perhaps the recent cherry-pick that allows multiple commits to be picked
should use that option (i.e. a "log --cherry-pick --right-only ..@{u}"
equivalent) when coming up with which commits to apply?
