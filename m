From: Junio C Hamano <gitster@pobox.com>
Subject: Re: push not resolving commit-ish?
Date: Thu, 23 May 2013 14:19:40 -0700
Message-ID: <7v38tde6mr.fsf@alter.siamese.dyndns.org>
References: <20130523105310.GA17361@redhat.com>
	<7v8v35fu7n.fsf@alter.siamese.dyndns.org>
	<20130523210920.GB31421@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Michael S. Tsirkin" <mst@redhat.com>
X-From: git-owner@vger.kernel.org Thu May 23 23:19:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UfcvL-0002D5-OP
	for gcvg-git-2@plane.gmane.org; Thu, 23 May 2013 23:19:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759154Ab3EWVTn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 May 2013 17:19:43 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59662 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758563Ab3EWVTn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 May 2013 17:19:43 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A195E22ED1;
	Thu, 23 May 2013 21:19:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=GunfY5V8SvKJXSrgDbUHXaYwFdE=; b=OxqcGJ
	AOtNyq2pK9HjqzEQDRE/BBozcNkpXzGNAqm33a8WsI/wSisLpeNa/jRsjXz5JBjj
	wfZ3kRKUhxko4xsMLIpfOUAoQvU7Ly4kMrsYP/ZXBfKX5cfwxzrU3JpNEawrCUKs
	YKb4RQzrZB4QQC8xDJd5B4XxWD13OzWKoi+6Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=bSBobNMRNI09VkklhQ3vC3QnuQItC4MM
	8u7JgrrOJofjx2lBmsaAOlo2jIKnhY0LaaunsWffOw3XGSabeiEMDK0gENnYmsxI
	l5rYUowF4YxiI6srCyqEKyHkqLyP7LrVnESfhqGCBXavdxLcWLXnA0A9nRQ+TlN1
	ir5uW2179k0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9504522ED0;
	Thu, 23 May 2013 21:19:42 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 09CA922ECF;
	Thu, 23 May 2013 21:19:41 +0000 (UTC)
In-Reply-To: <20130523210920.GB31421@redhat.com> (Michael S. Tsirkin's message
	of "Fri, 24 May 2013 00:09:20 +0300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 7BC3D28E-C3EE-11E2-989C-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225298>

"Michael S. Tsirkin" <mst@redhat.com> writes:

> On Thu, May 23, 2013 at 11:05:00AM -0700, Junio C Hamano wrote:
>> "Michael S. Tsirkin" <mst@redhat.com> writes:
>> 
>> > Looks like push can't resolve tags to commits.
>> > Why is that?
>> 
>> How else would you push a tag out?
>
> Well my reaction is, it seems to figure out it needs a commit and then
> instead of just getting it, it errors out.  Why not just DWIM?

Ahh, that one.

The local branch name hierarchy refs/heads/ is special in that you
cannot have a tag sitting at the tip, so when "push" decides to
update something under refs/heads/ on the receiving end, it may not
be a bad idea to peel it to a commit (and fail if it does not)
before creating a pack and telling the other end what the value of
the updated tip should be, and I do not think it will hurt anybody.

Restriction in the other direction (i.e. "if push does not go to
refs/tags/, unconditionally unwrap") is a no-no, though.
