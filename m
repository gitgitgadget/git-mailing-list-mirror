From: Junio C Hamano <gitster@pobox.com>
Subject: Re: post-update to stash after push to non-bare current branch
Date: Wed, 18 Jan 2012 14:38:24 -0800
Message-ID: <7vwr8oljq7.fsf@alter.siamese.dyndns.org>
References: <jf70vc$kol$1@dough.gmane.org> <4F171088.4080006@gmail.com>
 <4F1714AD.4090706@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Neal Kreitzinger <neal@rsss.com>, git@vger.kernel.org
To: Neal Kreitzinger <nkreitzinger@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 18 23:38:38 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rne9I-0007bI-N1
	for gcvg-git-2@lo.gmane.org; Wed, 18 Jan 2012 23:38:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753579Ab2ARWi1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Jan 2012 17:38:27 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60456 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751344Ab2ARWi0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Jan 2012 17:38:26 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E0754699D;
	Wed, 18 Jan 2012 17:38:25 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Jw1r3dv/39AWnSnzoXYX/QWett8=; b=LTGQ6C
	4B7hdhhzqUfNip4ST1FB7wZ4QPiL7cLw24gdr/Y3bRyW4h1ChlFdpbmGOGyTi+WG
	dk6NNypnHf6hRmC2fHla5Sk+yQRTLwuhHpcPycHHq4vzy3e36L3KXw5IsUXSjRzT
	RfqCe/azoi0+1x/WPF/lUL1HySsHzAv2y3p4M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=gyI6hy3yun0zdaGvNJWB4x3CT66JtrJe
	cE/Iu65QQl3H31SjZeowCwM4d4nDbqX62MnN4O0olWx4wPvM4V0o6SDybxH5Pffn
	DydV2Z3UKil1lcknUlUfXQvv2MlbIIBetT9Q/lYD9+W9C7Kpf7NLzPB6PFgFLfX/
	Tdjpl7XJQe8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D6D9C699C;
	Wed, 18 Jan 2012 17:38:25 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6DD066999; Wed, 18 Jan 2012
 17:38:25 -0500 (EST)
In-Reply-To: <4F1714AD.4090706@gmail.com> (Neal Kreitzinger's message of
 "Wed, 18 Jan 2012 12:51:25 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 224E6BE8-4225-11E1-95E6-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188770>

Neal Kreitzinger <nkreitzinger@gmail.com> writes:

> hooks/post-update is:
>
> git stash save
> echo "worktree+index of non-bare remote current branch stashed for safety"
> git reset --hard
> echo "git-reset --hard on current remote branch to ensure clean state"
>
> message is echoed, but git-reset --hard does not appear to have really
> worked. (git 1.7.1)

Have you checked where in the filesystem hierarchy that script is run
(hint: pwd)?

Also it is unclear why you keep saying "stash". What kind of changes are
you expecting to be saved to the stash? Will they be changes that are not
source controlled that you would rather not to see? In other words, after
running "stash" every time somebody pushes and having accumulated many
stash entries, when do you plan to pop these stashed changes?

I would have expect that such a repository to reject a push if the working
tree is dirty, and run checkout in post-update, though.
