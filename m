From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] clone: Fix error message for reference repository
Date: Mon, 08 Apr 2013 10:57:55 -0700
Message-ID: <7vli8sykf0.fsf@alter.siamese.dyndns.org>
References: <1365376629-16054-1-git-send-email-aaron@schrab.com>
 <20130407234810.GG19857@elie.Belkin> <20130408000658.GG27178@pug.qqx.org>
 <7vhajh15w0.fsf@alter.siamese.dyndns.org>
 <20130408145749.GJ27178@pug.qqx.org>
 <7vip3xyr8c.fsf@alter.siamese.dyndns.org>
 <20130408161745.GK27178@pug.qqx.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
To: Aaron Schrab <aaron@schrab.com>
X-From: git-owner@vger.kernel.org Mon Apr 08 19:58:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UPGKU-0006Fr-5N
	for gcvg-git-2@plane.gmane.org; Mon, 08 Apr 2013 19:58:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934847Ab3DHR57 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Apr 2013 13:57:59 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60296 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759861Ab3DHR56 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Apr 2013 13:57:58 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 091D714117;
	Mon,  8 Apr 2013 17:57:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=EivCpK6FMbMDDJ7PDHrJ5Wt0Kig=; b=o9E4oj
	+pG7xrU4/a0uGNU9dFPGu/EyqDw3pbjRx/X5WsAj8QbMXBuI5/7irbGVTxIZotMZ
	ldS6nqUgptOB3roni4Ca6w/P5FI/LNzXh83YqFyTwGWT5/nSWN1mUd1ttgc48qsT
	tCBYJGRCoBXC6Hk0afVmNuZKdeE6a/ScJ4R9E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=YTo93VKYfxNroiGhaoQtdcnuapW/FtDh
	/2gtFSv3GwBcV3lm0JiaC/v28U/AU3EefD1LhSZoFhbntC6NasHWtdqe2He6NRCJ
	zpZISyBTfTvrh0CCq/PAl9JxhelLhzdDcYsTLFD0hZH2g7+ACUGjyweUReFUjLda
	lzTYeCS6H78=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F015C14114;
	Mon,  8 Apr 2013 17:57:57 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4CECD14112; Mon,  8 Apr
 2013 17:57:57 +0000 (UTC)
In-Reply-To: <20130408161745.GK27178@pug.qqx.org> (Aaron Schrab's message of
 "Mon, 8 Apr 2013 12:17:46 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D830D1DA-A075-11E2-AF9F-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220475>

Aaron Schrab <aaron@schrab.com> writes:

> At 08:30 -0700 08 Apr 2013, Junio C Hamano <gitster@pobox.com> wrote:
>>You switch to a version of the superproject with a plain file at
>>dirA/ or there is nothing at dirA.  The checkout will fail and you
>>need to manually rectify the situation [*1*], but after that is
>>done, you do not have any repository at /path/to/super/dirA/.git
>>anymore.
>>
>>That was the reason why I recommended against the practice.
>
> So you're essentially saying you don't want to support using a
> new-world submodule as a reference because using an old-world
> submodule as such is likely to be problematic?

In general I am in favor of resolving a gitfile given to --reference
when clone interprets it, and have it use the location of the real
underlying object store when it grabs objects not in there from the
origin and store the location of the real underlying object store in
the objects/info/alternates of the newly created repository.  But
that is not limited to the gitfile used at the root level of a
submodule checkout.

Blindly using .git at the root level of submodule checkout as a
reference is what I was recommending against as a general
precaution.  You may be dealing with an old-style submodule
checkout.
