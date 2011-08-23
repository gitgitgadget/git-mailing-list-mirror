From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFH] lifetime rule for url parameter to transport_get()?
Date: Tue, 23 Aug 2011 09:50:39 -0700
Message-ID: <7vsjosrs0w.fsf@alter.siamese.dyndns.org>
References: <7vipppt175.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Daniel Barkalow <barkalow@iabervon.org>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 23 18:51:01 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QvuBo-0005Bl-TF
	for gcvg-git-2@lo.gmane.org; Tue, 23 Aug 2011 18:51:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755450Ab1HWQut (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Aug 2011 12:50:49 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44616 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755366Ab1HWQum (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Aug 2011 12:50:42 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C14F34FBB;
	Tue, 23 Aug 2011 12:50:41 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=EjD52OnUID3b197a26Zy6AvE2nE=; b=jtEgRn
	xrhhJcqS+OD4D0DzmTPXthAnAnv7+HvsBWl9EtFLE8eBnUK4Sre2g3VTzSSDXoZU
	pLSQ39JEB5LxMmrmhAXuOXpPwF1VFroTDHDXUA3nSeR8fP3rmonlgu0swoapwwLE
	mBiBOKnaS/IXLkZ5TXiIHHUHDxohWCYQPxumc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=cKn+ABir7ilLJYKkGXBdVzN8pkzPj0Up
	GLLJBpZpJEMdfH3l/+KQte7BpA4a+iFkTXl0etN8k5zMH9XzCpTRcOXlB4n2a7jD
	dsYUqTc7/GOrIn6M6iQLnUrYtOcHbF2fBeCkrJGqo+amVdWI7AsIJ7neE3/1nax/
	M/5MIi4fxYc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B23AE4FBA;
	Tue, 23 Aug 2011 12:50:41 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 03B0E4FB7; Tue, 23 Aug 2011
 12:50:40 -0400 (EDT)
In-Reply-To: <7vipppt175.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Mon, 22 Aug 2011 17:34:54 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 08FF35C4-CDA8-11E0-815C-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179948>

Junio C Hamano <gitster@pobox.com> writes:

> Does anybody remember why we use a copied string of "ref_git_copy" in
> builtin/clone.c::setup_reference()?
>
> 	ref_git = real_path(option_reference);
> 	...
> 	ref_git_copy = xstrdup(ref_git);

It didn't have anything to do with transport/remote layer.

This codepath uses real_path() and optionally mkpath(), both of which
returns a short-lived static buffer to return its findings, and long-term
users are expected to copy it away.

I'll add a comment to that effect in the code.
