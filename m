From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Try harder to find a remote when on a detached HEAD or
 non-tracking branch.
Date: Mon, 18 Jun 2012 10:33:48 -0700
Message-ID: <7vaa004j9f.fsf@alter.siamese.dyndns.org>
References: <1340038866-24552-1-git-send-email-marcnarc@xiplink.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jens Lehmann <Jens.Lehmann@web.de>
To: marcnarc@xiplink.com
X-From: git-owner@vger.kernel.org Mon Jun 18 19:33:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sgfpr-0005Qm-Pe
	for gcvg-git-2@plane.gmane.org; Mon, 18 Jun 2012 19:33:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752747Ab2FRRdw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Jun 2012 13:33:52 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57255 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752450Ab2FRRdv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Jun 2012 13:33:51 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BE95E85F9;
	Mon, 18 Jun 2012 13:33:50 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Oj/LJ1cO1T9b4+kf1d2OhqHuvz8=; b=fpp3wc
	3lIWSixC9BHgH/i6yOLCoooqvMuEP7mT7BfjOdftK9ieBZshpllnUZ2/fX5BtWib
	ooIQ0Ea2ayyBjFPjkwHcX36PHbdyuvher1ZuYxoJo3+J34uTmCdMkHZju+ihe/SO
	NvRMPShqnX092wWYEJH0NfwO6MT0pU5kORXdg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=A+vwYekA+u/+zAX8mL3noFa8HlQfFy2v
	L4nlClygVCF95r6qGuH1pZ7oY1OJUHn8xmND9aF7DnfuqhvBpnqURJte6gDZ5hUA
	L/fSNsnOmplC7lFDZLXwYyBPEK6Pxp026oiBhexH3DAczoTU+PiZBSPXR91D/uJG
	7RSdsiOO7uM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B55F685F8;
	Mon, 18 Jun 2012 13:33:50 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4C17D85F7; Mon, 18 Jun 2012
 13:33:50 -0400 (EDT)
In-Reply-To: <1340038866-24552-1-git-send-email-marcnarc@xiplink.com>
 (marcnarc@xiplink.com's message of "Mon, 18 Jun 2012 13:01:06 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C4437E4E-B96B-11E1-B095-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200148>

marcnarc@xiplink.com writes:

> From: Marc Branchaud <marcnarc@xiplink.com>
>
> get_default_remote() tries to use the checked-out branch's 'remote' config
> value to figure out the remote's name.  This fails if there is no currently
> checked-out branch (i.e. HEAD is detached) or if the checked-out branch
> doesn't track a remote.  In these cases and the function would just fall
> back to "origin".
>
> Instead, let's use the first remote listed in the configuration, and fall
> back to "origin" only if we don't find any configured remotes.

I admit that I wouldn't do anything that relies on any remote to be
used while on detached head myself, so in that sense I am a biased
audience, but guessing (or not guessing and blindly assuming
'origin') feels wrong, and trying even harder to come up with an
even wilder guess feels even more wrong.

Shouldn't we be erroring out instead?
