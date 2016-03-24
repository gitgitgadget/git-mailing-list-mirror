From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 3/4] format-patch: introduce --base=auto option
Date: Thu, 24 Mar 2016 10:01:58 -0700
Message-ID: <xmqq37rfajy1.fsf@gitster.mtv.corp.google.com>
References: <1458723147-7335-1-git-send-email-xiaolong.ye@intel.com>
	<1458723147-7335-4-git-send-email-xiaolong.ye@intel.com>
	<xmqqbn65caqi.fsf@gitster.mtv.corp.google.com>
	<20160324041925.GB26582@yexl-desktop>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, fengguang.wu@intel.com, ying.huang@intel.com,
	philip.li@intel.com, julie.du@intel.com
To: Ye Xiaolong <xiaolong.ye@intel.com>
X-From: git-owner@vger.kernel.org Thu Mar 24 18:02:13 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aj8eB-0001LA-MB
	for gcvg-git-2@plane.gmane.org; Thu, 24 Mar 2016 18:02:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752313AbcCXRCH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Mar 2016 13:02:07 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:54624 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751034AbcCXRCD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Mar 2016 13:02:03 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 5E0F54BF2D;
	Thu, 24 Mar 2016 13:02:01 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=lJvuwhi0Rd8pLfDGd3Hl7uk+X5A=; b=B3tpqD
	ylydnzwEgcJ99LER4aO/rkkrZnNZX/Vzhi6aZqllU03iEeOP/5uB5zJ+Lp+x7WOD
	TlMd50GXxM7sW3Urt73X1G6L5GPj5ee1ca7sMcHZ7mJKXwehk7+dUGe13pnv9aHn
	PZUqQVbONbGEwV7Hgb+kX9jaeMbQcMMXQ96SM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=KlUzvqGTfgMSBwaeeW2LPbnHyJHTjsb/
	Cmhx+/1CykeNh+Uy+bpbBdlhVn1KC7k6nTQL34QmvjP3kKO3DFTHd8xStUzWBjwx
	lpN8gE3CfjuRJe5ZnQYEaIkkFNcvZItbsCNi9kg8YsQX0xMAAcHthfuB4EBApYRc
	+SjU2r0z4hg=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 1EC474BF2C;
	Thu, 24 Mar 2016 13:02:01 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id D7F124BF29;
	Thu, 24 Mar 2016 13:01:59 -0400 (EDT)
In-Reply-To: <20160324041925.GB26582@yexl-desktop> (Ye Xiaolong's message of
	"Thu, 24 Mar 2016 12:19:25 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 1F8EC36E-F1E2-11E5-A8AF-EB7E6AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289763>

Ye Xiaolong <xiaolong.ye@intel.com> writes:

> On Wed, Mar 23, 2016 at 11:25:41AM -0700, Junio C Hamano wrote:
>>I also do not see the point of showing "parent id" which as far as I
>>can see is just a random commit object name and show different
>>output that is not even described what it is.  It would be better to
>
> Here is our consideration:
> There is high chance that branch_get_upstream will retrun NULL(thus we
> are not able to get exact base commit), since developers may checkout
> branch from a local branch or a commit and haven't set "--set-upstream-to"
> to track a remote branch, in this case, we want to provide likely useful
> info(here is parent commit id and patch id)

I do not agree with that reasoning at all, primarily because your
"likely useful" is not justfied.

Could you explain what makes you think that it is "likely" that the
commit that matches "parent commit id" is available to the recipient
of the patch?

Whatever the reason is, if it _is_ likely, then I do not see a point
in spending cycle to do get-upstream and merge-base, or giving an
option to the user to explicitly specify the base.  Given that this
series does these things, I'd have to conclude your "likely useful"
is "might possibly turn out to be useful in some cases if you are
lucky but is no way reliable" at best.

Rather than throwing an unreliable information in the output and
blindly proceeding, I'd think you would want to error out and tell
the user to explicitly give the base without producing the patch
output.  That way, you will not get patches with unreliable
information.

Suggesting to use set-upstream-to when you give that error message
may also be helpful.
