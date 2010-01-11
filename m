From: Junio C Hamano <gitster@pobox.com>
Subject: Re: How to check new commit availability without full fetch?
Date: Sun, 10 Jan 2010 18:08:01 -0800
Message-ID: <7vk4vpcs1q.fsf@alter.siamese.dyndns.org>
References: <ee2a733e1001100312j786108fct1b4c8abd0acc5afc@mail.gmail.com>
 <alpine.LFD.2.00.1001101501520.10143@xanadu.home>
 <7v8wc5itlc.fsf@alter.siamese.dyndns.org>
 <alpine.LFD.2.00.1001101556490.10143@xanadu.home>
 <ee2a733e1001101736p2f395de6ka05044fe7cca624d@mail.gmail.com>
 <be6fef0d1001101757w7f54c9b2ye58c66179137efb1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: SLONIK.AZ@gmail.com, Nicolas Pitre <nico@fluxnic.net>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 11 03:08:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NU9hc-0001bV-Q3
	for gcvg-git-2@lo.gmane.org; Mon, 11 Jan 2010 03:08:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751142Ab0AKCIO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Jan 2010 21:08:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751259Ab0AKCIO
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Jan 2010 21:08:14 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:42108 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751179Ab0AKCIN (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Jan 2010 21:08:13 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id DAB0D8F93C;
	Sun, 10 Jan 2010 21:08:12 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=fIT/ny98y6Xn5nOW/DfkrwmSyVE=; b=W+7MbY
	5BYNbx/CwH+/YCYnolPnFIaewKjDjPWx81iawkMq+ZTi1DEjhsEoMUkMWsFlJtHW
	OP67iQmK7a54ah9+4CkclRoIWxsSCrVttTS7K3QrFEWrY+dzhsMhbDAUh17zOOcm
	Ri9jyVBgOqUf70zwSbPdiDHWsuXxJWbB4UYHw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=xrpO68jBJAA4sPIDnaolGEcXvM11pBKU
	q73KpwpshgUQHa50aG/KxP8Bh+/5Jispiz6oauCUd9q1t4ruXSE1yAvgW4X3mVAd
	fryw2UNsoZNxgqpWRWZ1NOUynRDRTsV5kWjTvy2/cY9qzt2BUENOEnjmUXAt84Tw
	r1alaxqvjhU=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 952B78F936;
	Sun, 10 Jan 2010 21:08:08 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8F6698F935; Sun, 10 Jan
 2010 21:08:02 -0500 (EST)
In-Reply-To: <be6fef0d1001101757w7f54c9b2ye58c66179137efb1@mail.gmail.com>
 (Tay Ray Chuan's message of "Mon\, 11 Jan 2010 09\:57\:51 +0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 29926CAC-FE56-11DE-9191-9D59EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136597>

Tay Ray Chuan <rctay89@gmail.com> writes:

> By default, when you add a remote (with git remote add), git sets up
> the fetch refspec in your config that looks like
>
>   [remote "foo"]
>     url = git://foo.com/git/foo.git
>     fetch = refs/heads/*:refs/remotes/foo/*
>
> That is to say, branches on the remote repo will be fetched into a
> "safe" area, refs/remotes/foo/, away from the branches that you
> normally work with in refs/heads/.
>
> However, if you have a different config and you're fetching directly
> into refs/heads/, then I can see why you would want to "peek" first
> with --dry-run before fetching.

I don't.  Until all the objects are safely transferred, none of the refs
are updated, whether they are directly slurped into local branch namespace
or remote tracking branch namespace.  So no matter what the configuration
is, interrupted transfer, forced or otherwise, is safe.
