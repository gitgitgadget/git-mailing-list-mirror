From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 2/4] git-cherry-pick: Add keep-redundant-commits
 option
Date: Tue, 17 Apr 2012 08:42:52 -0700
Message-ID: <7v3982pdoj.fsf@alter.siamese.dyndns.org>
References: <1333136922-12872-1-git-send-email-nhorman@tuxdriver.com>
 <1334342707-3326-1-git-send-email-nhorman@tuxdriver.com>
 <1334342707-3326-3-git-send-email-nhorman@tuxdriver.com>
 <20120415104212.GC6263@ecki>
 <20120416153827.GC13366@hmsreliant.think-freely.org>
 <20120416221018.GB5606@ecki>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Neil Horman <nhorman@tuxdriver.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>, Phil Hord <phil.hord@gmail.com>
To: Clemens Buchacher <drizzd@aon.at>
X-From: git-owner@vger.kernel.org Tue Apr 17 17:43:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SKAYW-0003m5-HJ
	for gcvg-git-2@plane.gmane.org; Tue, 17 Apr 2012 17:43:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752874Ab2DQPmz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Apr 2012 11:42:55 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41624 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752022Ab2DQPmz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Apr 2012 11:42:55 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 93FCC543B;
	Tue, 17 Apr 2012 11:42:54 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=GKPxw1mWEaQoLvuUQRtVPW940Og=; b=RK1o+L
	zbRXo+Kow+tNxAW3YR1r1ML7zWwwBlJnATjF2jzDr1DDBpbPlLUgdrBVj+A8cxX+
	fo8pI1S4g6HeCKVzsjKvg0bPXzdIFX2g6ZWQzswaQghlKhk/vBP6edUNsLbBU9f9
	PBQGFfyGABt6duOYYjMzr5AHzgGginwkDo0aU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=hnT/Veia/m5HoFYarKQTcQWJSWsm7rlO
	Wpigc8bcjQwfOLcsV8IYJQClwxugGLKWOPAEuX8mAFHoTK9xXEqFGpfTmft+Gw9y
	3ASjyhi48KXTjH6NsdTlsUZ5R2xbUKcEEW2u0Ya8a0iHwPw6bdVpZWCFAGDzLgtH
	yPFugWyiy8Q=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8BF99543A;
	Tue, 17 Apr 2012 11:42:54 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 234835439; Tue, 17 Apr 2012
 11:42:54 -0400 (EDT)
In-Reply-To: <20120416221018.GB5606@ecki> (Clemens Buchacher's message of
 "Tue, 17 Apr 2012 00:10:18 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: FF44AD22-88A3-11E1-91E5-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195765>

Clemens Buchacher <drizzd@aon.at> writes:

> On Mon, Apr 16, 2012 at 11:38:27AM -0400, Neil Horman wrote:
> ...
> Except that the outcome is not the same. With and without your changes,
> git cherry-pick <empty-commit> fails. But with your changes, git
> cherry-pick <commit-will-become-empty> will succeed and do nothing,
> while before it would have failed exactly like git cherry-pick
> <empty-commit>.
>
> So I am not arguing whether failing or skipping is the better default
> behavior. But the legacy behavior is consistent between the empty-commit
> and commit-will-become-empty cases.

Is that particular "consistency" a good one, though?  If you had an empty
commit in the original range, it is a lot more likely that it was an error
that you would want to know about.  You may be the kind of person who
value an empty commit in your history, using it as some kind of a mark in
the history, and in that case you would want to know that it is being
discarded.  On the other hand, if a commit that did something in the
original context turns out to be unnecessary in the replayed context, that
is not something you would ever want to keep in the replayed context, and
erroring out and forcing you to say "yeah, I admit I do not want it" would
just be annoying.

So "consistency" between the two would actually be a mistake that we may
want to "break", I would think.
