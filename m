From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH bg/format-patch-p-noop] log-tree: always add --- marker
 when options are patch and a stat
Date: Tue, 03 Nov 2009 23:26:36 -0800
Message-ID: <7vljimkaxf.fsf@alter.siamese.dyndns.org>
References: <1257283456-7007-1-git-send-email-bebarino@gmail.com>
 <7vy6mmltz9.fsf@alter.siamese.dyndns.org>
 <20091104063612.GA24263@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Stephen Boyd <bebarino@gmail.com>, git@vger.kernel.org,
	=?utf-8?Q?Bj?= =?utf-8?Q?=C3=B6rn?= Gustavsson 
	<bgustavsson@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Nov 04 08:26:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N5aGc-000763-2v
	for gcvg-git-2@lo.gmane.org; Wed, 04 Nov 2009 08:26:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751281AbZKDH0n (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Nov 2009 02:26:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751273AbZKDH0n
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Nov 2009 02:26:43 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:34310 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750930AbZKDH0m (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Nov 2009 02:26:42 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id A176791D38;
	Wed,  4 Nov 2009 02:26:47 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=u1/VKKkIdW+OkUWTf1IWWsis0Rw=; b=r0fIrh
	TOktmybwxuiz+lCs3ibcOPWjjcJVTfHkhev5XDHGdrpyn4m0xhdn0Z0Y7MYsujON
	8Dv1W+0r43h+S/+lOKOtduiZ0agyMFafA4weGW+kGqnErpo+YT9EduiK/C4daHbl
	P0bqaXmSXS2lGAGBu0KckwUnJz4r4jolJVRd4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=rEBL6766by1buzY/3Wvt7Hbg1FNgctA3
	yUhXHtDqQqdF+GtFQKSUh9NjJiHxNYJilgB/1YfpyCHMFlHmhMZB8RhltJf4tf8z
	XYu2FO6YOuYKfgEt5UqyjAGu2lBv12Y0fx6eMcn8n+i6ObUtrbs0TVEvOhvUymRP
	w+RkiWK2/VI=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 69B6C91D36;
	Wed,  4 Nov 2009 02:26:43 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id E100D91D35; Wed,  4 Nov 2009
 02:26:37 -0500 (EST)
In-Reply-To: <20091104063612.GA24263@coredump.intra.peff.net> (Jeff King's
 message of "Wed\, 4 Nov 2009 01\:36\:13 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 66CC07A4-C913-11DE-BB1D-A67CBBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132052>

Jeff King <peff@peff.net> writes:

> On Tue, Nov 03, 2009 at 09:49:46PM -0800, Junio C Hamano wrote:
>
>> Even though I personally find the stat information very useful, I would be
>> happier if somebody reverts the bg/format-patch-p-noop series and instead
>> fixes the regression caused by 68daa64, and does so without touching any
>> output from the low-level plumbing like diff-tree that may be used by
>> scripts.
>
> I agree that 68daa64 is a hack (and I even noted in the commit log that
> "-p" is now a no-op).

Correct, and thanks---it was not your fault and I didn't mean to blame
you.  If anything it was mine.

> The problem is that we don't have the one critical
> bit of information in cmd_format_patch that we do in diff_opt_parse: was
> the format set explicitly, or was it a side-effect of -U (or --binary,
> or maybe others).

The appoarch your "how about this" takes feels right.  We did discuss "set
of hardwired defaults specific to the individual commands, that are masked
by set of defaults read from the config, that are in turn masked by set of
command line options", but I do not think that level of complexity is worth
for this "is it -U<n> or -p" issue.

> My test case checks the current output (i.e., missing dashes). I think
> it should probably have dashes, but that should be fixed in a separate
> patch.

Agreed.
