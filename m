From: Junio C Hamano <gitster@pobox.com>
Subject: Re: t6200: avoid path mangling issue on Windows
Date: Fri, 19 Apr 2013 14:22:21 -0700
Message-ID: <7va9ouz04y.fsf@alter.siamese.dyndns.org>
References: <1365348344-1648-1-git-send-email-ralf.thielow@gmail.com>
	<1365348344-1648-2-git-send-email-ralf.thielow@gmail.com>
	<516F95D1.5070209@viscovery.net>
	<7v38un93br.fsf@alter.siamese.dyndns.org>
	<5170DA96.9000300@viscovery.net>
	<7vr4i632fp.fsf@alter.siamese.dyndns.org> <51719F18.3020508@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ralf Thielow <ralf.thielow@gmail.com>, git@vger.kernel.org
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Fri Apr 19 23:22:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UTIlK-0003Up-7b
	for gcvg-git-2@plane.gmane.org; Fri, 19 Apr 2013 23:22:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933494Ab3DSVW0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Apr 2013 17:22:26 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55226 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932804Ab3DSVWZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Apr 2013 17:22:25 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 14C46180B9;
	Fri, 19 Apr 2013 21:22:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ZruTpbeMZW3OT+fmveviqy1AWv8=; b=J5r24s
	QKMKSkOB/VwGGI37Jl7E+DRbiBw33w+DZgwKVkeKUolh1KvOrVTAfKypkylK1Z4r
	yOX0NW8X/XnJc3bDPFwKvUxtKiO01OKL8j4cWxqMee+8wtZU2P5geQHHQIeyspHl
	dHX0KChdo6WjvsxmIqe+UsDhtYqn0YJlj4aQc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=U73JOQaziVqmjLXoL4HV9eLh1eI0jsiw
	IrrStGUbR8kaHLfDXlFk5ZKzJ5hyh7rFdoH+uRNUSyeJIlYoGNLs1JwiSTRmhT6e
	45mY741x7ZNpZcOfuI8itdvNOEWiZiVdtTB+zydH0BGuOCeq59hjpFoP2EBiDLVw
	P5mnkSgeUVE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 04D9B180B8;
	Fri, 19 Apr 2013 21:22:24 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 770A1180B5;
	Fri, 19 Apr 2013 21:22:23 +0000 (UTC)
In-Reply-To: <51719F18.3020508@kdbg.org> (Johannes Sixt's message of "Fri, 19
	Apr 2013 21:46:32 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 39F161D6-A937-11E2-AB66-BCFF4146488D-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221821>

Johannes Sixt <j6t@kdbg.org> writes:

> A patch auther whose first instinct is to write 'foo=/' will never write
> 'foo=x', let alone 'foo="""/"""'. Someone will have to discover the
> issue eventually and write a patch to fix it, and someone will have to
> apply it.

That is a separate issue.  Didn't I say I'll apply it as-is at the
very beginning?

Our _tests_ can afford to use an unrealistic setting like

    git -c core.commentchar="x" fmt-merge-msg

to work it around, because the tests do not _care_ how the final
outcome looks like. It only cares what we specified gets used.

But a _real user_ who wants to use a slash there has no way of doing
so.  It is still not realistic, as it is more likely that she would
want to use a double-slash, but that would not fit in a commentchar,
and she is a lot more likely to have it in the configuration file,
but I wouldn't imagine that there are things other than "-c var=val"
that are more commonly given on the command line that share the same
pain point as this one.

That is what I meant by "feels painful to the users" and wondered if
bash on Windows can be more helpful to them.
