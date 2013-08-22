From: Junio C Hamano <gitster@pobox.com>
Subject: Re: t3010 broken by 2eac2a4
Date: Thu, 22 Aug 2013 14:16:29 -0700
Message-ID: <xmqqbo4pqvde.fsf@gitster.dls.corp.google.com>
References: <82078845-3AB9-4B36-9130-039CC33C8A7A@gernhardtsoftware.com>
	<xmqqbo4qu3g4.fsf@gitster.dls.corp.google.com>
	<CAPig+cQHTvmTWvGfg1Z3KfBrPD+QbSEbYBYz6XWT3KKu3-+jyQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Brian Gernhardt <brian@gernhardtsoftware.com>,
	"git\@vger.kernel.org List" <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Thu Aug 22 23:16:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VCcFD-0005vi-Md
	for gcvg-git-2@plane.gmane.org; Thu, 22 Aug 2013 23:16:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753891Ab3HVVQg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Aug 2013 17:16:36 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55635 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753528Ab3HVVQf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Aug 2013 17:16:35 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 16D513B7CD;
	Thu, 22 Aug 2013 21:16:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=T3AVnr7vdsC8RRn785aXyAkrAq8=; b=eQaauy
	WPc6DAPpAwsavl0K9DOpzIMnI3BUdjNb5fUTfD5lPxjS6kItTYzvV1ZRVnCUj/+l
	T8WhRCACj3N9bINkTuefdG3nXMSv2AbLnR7V6OD4ukonawZeIz/QH2quauAi6E9v
	CcND0JWC9DDxrrwrDEyChtBrVNDP1qHGvb/EY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=rVQUjmLlhijO+H987Uce5kg9r3dVmt1n
	/e/aC+ns+YddRrIwhyCPWdj9kWlVbjth//5tooCMmaSjHrbdKIxk6OGgk4XkjY9j
	eA9ftdCY4hMJgpuIPss+82OHeEXJz90I/eGYCrc7YkOWHfY+GXZOzsKjJJgd8U8T
	f9cPmizj1iM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A52AC3B7CA;
	Thu, 22 Aug 2013 21:16:33 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 68F293B7C3;
	Thu, 22 Aug 2013 21:16:32 +0000 (UTC)
In-Reply-To: <CAPig+cQHTvmTWvGfg1Z3KfBrPD+QbSEbYBYz6XWT3KKu3-+jyQ@mail.gmail.com>
	(Eric Sunshine's message of "Thu, 22 Aug 2013 16:54:10 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 1E556396-0B70-11E3-B8E1-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232778>

Eric Sunshine <sunshine@sunshineco.com> writes:

> I can confirm this failure on OS X, however, I am somewhat confused by
> the follow-up t3010 changes in 3c56875176390eee. Are the t3010 changes
> supposed to fail without 2eac2a4cc4bdc8d7 applied? For me, on Linux,
> the tests succeed whether 2eac2a4cc4bdc8d7 is applied or not. On OS X,
> the tests succeed without 2eac2a4cc4bdc8d7 but fail with it applied.

The 2eac2a4c (ls-files -k: a directory only can be killed if the
index has a non-directory, 2013-08-15) is NOT a correctness fix.

It is an optimization to avoid scanning directories that are known
not to be killed when "ls-files -k" is asked to list killed
paths. The original code without the patch is correct already; it
just is too inefficient because it scans all the directories.  It is
not surprising if the test added by 3c568751 (t3010: update to
demonstrate "ls-files -k" optimization pitfalls, 2013-08-15) passes
without 2eac2a4c.

As its log message explains, 3c568751 (t3010: update to demonstrate
"ls-files -k" optimization pitfalls, 2013-08-15) is to catch a case
where an earlier "something like this" patch (which is the draft for
2eac2a4c) posted to the list would have broken.  That draft patch
was correct only for the case where the top-level directory is
killed, but was broken when a subdirectory (e.g. pathx/ju) is
killed.
