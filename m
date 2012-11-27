From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 7/7] push: clarify rejection of update to non-commit-ish
Date: Tue, 27 Nov 2012 09:11:44 -0800
Message-ID: <7vboejnf73.fsf@alter.siamese.dyndns.org>
References: <1353644515-17349-1-git-send-email-chris@rorvick.com>
 <1353644515-17349-8-git-send-email-chris@rorvick.com>
 <7vk3t8ryap.fsf@alter.siamese.dyndns.org>
 <CAEUsAPZq1POKQZd5vZy55nEj2kB4CqgxL9_d_0sQs33P_Gcemg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Angelo Borsotti <angelo.borsotti@gmail.com>,
	Drew Northup <n1xim.email@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Philip Oakley <philipoakley@iee.org>,
	Johannes Sixt <j6t@kdbg.org>,
	Kacper Kornet <draenog@pld-linux.org>,
	Jeff King <peff@peff.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: Chris Rorvick <chris@rorvick.com>
X-From: git-owner@vger.kernel.org Tue Nov 27 18:12:04 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TdOhX-0001fi-4Z
	for gcvg-git-2@plane.gmane.org; Tue, 27 Nov 2012 18:12:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755552Ab2K0RLr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Nov 2012 12:11:47 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39023 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752672Ab2K0RLq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Nov 2012 12:11:46 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 49E0990EF;
	Tue, 27 Nov 2012 12:11:46 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=FIXCFYFnYdYImNZi6ZVDVcscpdU=; b=CtXf1m
	YywqJFY9MZ+JnodM3ugzoi3ODLaWqWb0WXOFdj87iIDRxkB4ro/FNcrlL2qAil/y
	RbBS9VuYnmZqGXn+6wGD1+gd8ebe7DR1G01SWSy/Z3fu7+pPR5qTiXg8RMtqGBd0
	OxYtag5shQLlY/MmXqC4CI59s9MRXoS5Tktws=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=wcrcCHmDJTHarc7dX3DYmgULYBRHp55w
	uKO8rx3PHY86/IxknWwvs4YOZSUWubdKx9ATP4t2Q1FMupSx0XVUszN/oyX53fB+
	y0KNG+uvA3VHMIw6KX+VbZKLZ5yMdTjIlyVh9orqnJ+SNDwyjGhMrd1owzxpXHaE
	v91Pj3TfOTU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 35B2B90EE;
	Tue, 27 Nov 2012 12:11:46 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A11FC90EC; Tue, 27 Nov 2012
 12:11:45 -0500 (EST)
In-Reply-To: <CAEUsAPZq1POKQZd5vZy55nEj2kB4CqgxL9_d_0sQs33P_Gcemg@mail.gmail.com> (Chris
 Rorvick's message of "Mon, 26 Nov 2012 21:52:40 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 85A3B9F0-38B5-11E2-AF91-C2612E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210565>

Chris Rorvick <chris@rorvick.com> writes:

>> With this code, the old must be a commit but new can be a tag that
>> points at a commit?  Why?
>
> The old must not be a tag because fast-forwarding from it is
> potentially destructive; a tag would likely be left dangling in this
> case.  This is not true for the new, though.   I'm not sure
> fast-forwarding from a commit to a tag is useful, but I didn't see a
> reason to prevent it either.   The refs/tags/ hierarchy is excluded
> from fast-forwarding before this check, and refs/heads/ is already
> protected against anything but commits.  So it seems very unlikely
> that someone would accidentally make use of this behavior.
>
> So, fast-forwarding to a tag seemed fairly benign and unlikely to
> cause confusion, so I leaned towards allowing it in case someone found
> a use case for it.

Sounds sensible.

Perhaps some of that thinking behind this change (i.e. earlier
we checked the forwardee was any commit-ish, but the new code only
allows a commit object if it were to be fast-forwarded) belongs to
the log message?

Thanks.
