From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH, RFC] Fix build problems related to profile-directed
 optimization
Date: Thu, 02 Feb 2012 16:58:09 -0800
Message-ID: <7vvcnou40u.fsf@alter.siamese.dyndns.org>
References: <1328209417-8206-1-git-send-email-tytso@mit.edu>
 <7vvcnpuhpo.fsf@alter.siamese.dyndns.org> <20120202201226.GA1032@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Andi Kleen <ak@linux.intel.com>,
	Clemens Buchacher <drizzd@aon.at>
To: Ted Ts'o <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Fri Feb 03 01:58:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rt7Tl-0001TV-BX
	for gcvg-git-2@plane.gmane.org; Fri, 03 Feb 2012 01:58:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754605Ab2BCA6M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Feb 2012 19:58:12 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51195 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753570Ab2BCA6L (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Feb 2012 19:58:11 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 38E896761;
	Thu,  2 Feb 2012 19:58:11 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=E8nZQ0CaMAxzi6hDlRWhQG+r8bw=; b=K1KfDB
	AmD/pASLzHuvNxmyC7cHtPuNUwoloPxCSaijakwPkH0vEK1O2282QSDalKxq+XK2
	cErxg4lOeLFCWwa3/PJ0+wXmHG+nKlYhHdTqviuv2auR9Yt/EQVQu/A33DVWtH0T
	YFLAj/SW4mJrL7YWl+OudaeE85/iVaFtKmIcE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Lan1+h42Z0ja+0+L/u8QUu4FGZGS9PO5
	CK7QbMcQ1TDkKd1KHWH5+5HmWDcxtQGarDzZruiccu5W9LhzfQSJOEt87kQ/FTmu
	aWi9+wSlDI8idC021LWgFw1WaBI2NCMhNJRYmKpBVPeySF/rcX9zm1ex+Q5s3sGE
	BJ1hjJ5Cqa4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3089A6760;
	Thu,  2 Feb 2012 19:58:11 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 90B80675F; Thu,  2 Feb 2012
 19:58:10 -0500 (EST)
In-Reply-To: <20120202201226.GA1032@thunk.org> (Ted Ts'o's message of "Thu, 2
 Feb 2012 15:12:26 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 246FD860-4E02-11E1-8D79-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189725>

Ted Ts'o <tytso@mit.edu> writes:

> ...
> At least in theory, it should be possible to have something which
> supports both PROFILE_GEN/PROFILE_USE as well as a combined
> PROFILE_BUILD.
>
> The hard part is that PROFILE_BUILD requires a multi-pass process; you
> need to build with one set of CFLAGS, then run the sample workload to
> get the data for your feedback directed optimizations, and then re-run
> the build with another set of CFLAGS.

Yeah, I can see how that forces us to some kludgy solution, but I tend to
agree that the separation between GEN/USE is a good thing.

> I think what we could to check
> for PROFILE_BUILD, and if it is set, do the first PROFILE_GEN / make
> test commands as part of the top-level Makefile's all: rule, and then
> do the normal build after that.

Yeah, something like that would emulate the "make profile-all" well enough
for people not to notice the change while giving us the flexibility of
GEN/USE separation. I kinda like it.

Thanks.
