From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [BUG] bugs in clean, status, bisect, and send-email
Date: Wed, 24 Feb 2010 20:09:50 -0800
Message-ID: <7v1vgaq7ld.fsf@alter.siamese.dyndns.org>
References: <ca433831002241928hef29dadu39f93bc1a8460331@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git list <git@vger.kernel.org>
To: Mark Lodato <lodatom@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 25 05:10:07 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NkV36-0001qo-Tb
	for gcvg-git-2@lo.gmane.org; Thu, 25 Feb 2010 05:10:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932146Ab0BYEJ7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Feb 2010 23:09:59 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:64593 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932077Ab0BYEJ6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Feb 2010 23:09:58 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 0B27A9C709;
	Wed, 24 Feb 2010 23:09:58 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=GgVy2Q73nQvVpl+9Fo0gJ9YZATg=; b=SMB8JV
	prrpSdUvyrLIp9YebnvdnI+IDe+xLwbXBQscEojMSzI0tqGm8nEMfeGFnw4EEpc2
	ybSTHBtbjVF+1Ts4KA9cunv7tSFdomvmkEwwUWrUws9MTL1vvZdSBKjNOr2SLs3G
	jPFtmkPvEyzATaAyXbZPEsluHsKt/z9yZkDZg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=R6Pn6LZJmVVaqJiWvVlQaGhUCH9tVgyx
	GowBZIKfgb1+gchh57GzDbb4L6scxSDO1HPlVvbbV60gx4CbjLFUYZFwQWbpu1ZC
	VN0WfPjORLXD/93ILhEHZmYfGZXNL/+JD4FbI13PP9cZ5oT8wS7ZKO1kWGKEG7l1
	ReSqG1HfrNE=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id DD8B69C707;
	Wed, 24 Feb 2010 23:09:55 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0D6AF9C706; Wed, 24 Feb
 2010 23:09:52 -0500 (EST)
In-Reply-To: <ca433831002241928hef29dadu39f93bc1a8460331@mail.gmail.com>
 (Mark Lodato's message of "Wed\, 24 Feb 2010 22\:28\:41 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: A1A59120-21C3-11DF-B295-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141025>

Mark Lodato <lodatom@gmail.com> writes:

> 2. git-status globs only match untracked files, not staged or unmodified

I am reasonably sure that this is related to a n issue we discussed on
"git add" vs "git add -u" recently.

In short, you cannot expect glob style pathspecs to work for an operation
that involves running diff internally.  You can guess that "To be
committed" is computed by internally running "diff --cached".

Currently globbing style pathspec are supported as an added bonus to only
some commands (e.g. "grep", "ls-files", "add" but not "add -u").  You can
also guess that "Untracked" is computed by internally running "ls-files".

In the meantime, limit yourself to leading path style pathspecs.
