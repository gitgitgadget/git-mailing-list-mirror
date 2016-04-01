From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 3/4] format-patch: introduce --base=auto option
Date: Fri, 01 Apr 2016 09:36:58 -0700
Message-ID: <xmqqd1q9jnf9.fsf@gitster.mtv.corp.google.com>
References: <1458723147-7335-1-git-send-email-xiaolong.ye@intel.com>
	<1458723147-7335-4-git-send-email-xiaolong.ye@intel.com>
	<xmqqbn65caqi.fsf@gitster.mtv.corp.google.com>
	<20160324041925.GB26582@yexl-desktop>
	<xmqq37rfajy1.fsf@gitster.mtv.corp.google.com>
	<20160401050749.GA25392@yexl-desktop>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, fengguang.wu@intel.com, ying.huang@intel.com,
	philip.li@intel.com, julie.du@intel.com
To: Ye Xiaolong <xiaolong.ye@intel.com>
X-From: git-owner@vger.kernel.org Fri Apr 01 18:37:14 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1am24M-0005l7-HP
	for gcvg-git-2@plane.gmane.org; Fri, 01 Apr 2016 18:37:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751724AbcDAQhE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Apr 2016 12:37:04 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:63188 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750887AbcDAQhD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Apr 2016 12:37:03 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 8FC7D4EE2C;
	Fri,  1 Apr 2016 12:37:00 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=smcSdKbJHsG62I7G2dk/MHdog3A=; b=Kqhnqw
	jxuEeB9zJNT5/LQ7OWCR0u/zvVvzT1Vbu+LR8uSj81Zw1Ny3+RG3TongiGXXW/b6
	P55wuslXpXrTU+nsu1eFAj/4YdNNniSIG0P9YE9uO+dEp0vpNoPRJPvpYC1LHNuf
	/kgYtlx+4kRMh3/wclto1q47WkoEjhoeTvbGo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=yYdoFVpGGa8EiXdYFgX4ZFxhLkiBsHas
	vGranblLbPK7cF9bbC3kraOu4xQtCajQ7TIsfdbziqDb2kXuXZSKsqCHUcVk1HPM
	JRv7DQKzYVDoNJg/Znmstzb7vQ03Xj8Xae9iLSBdFrJ7tZf3f3TPH5D9TcY2SnCU
	ungMOsuTzX8=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 5EEC64EE2B;
	Fri,  1 Apr 2016 12:37:00 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id B19124EE2A;
	Fri,  1 Apr 2016 12:36:59 -0400 (EDT)
In-Reply-To: <20160401050749.GA25392@yexl-desktop> (Ye Xiaolong's message of
	"Fri, 1 Apr 2016 13:07:49 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: F4B29106-F827-11E5-B1A2-45AF6BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290557>

Ye Xiaolong <xiaolong.ye@intel.com> writes:

> For the info starts with "base-commit: <xxx> ...", robot would know it
> is reliable base commit, it would just checkout it and apply the prerequisite
> patches and patchset for the work.
>
> For the info starts with "parent-commit: <xxx>; parent-patch-id: <xxx>",
> there are 3 situations 0day robot would need to handle:

It all depends on how you are computing this "parent-commit" thing.
When I reviewed the patch that implemented the fallback, my
impression was that it wasn't computing anything relevant, but just
was picking one of the random commit nearby in the history.

Assuming that it is not the case, and it is computing something
sensible, then I still do not see a point in marking these guessed
ones differently as "parent-commit" (not "base-commit").  After all,
a "base-commit" that was explicitly specified by the user can be
something that is inappropriate (e.g. the user may have thought the
base was a well-known one when his work was built on top of an early
draft of the patch that was later tweaked), so recipients of the
patch series need to be prepared to deal with a bogus base anyway.

> 2) parent commit is well-known in-flight patch, since 0day maintains the
>    database of in-flight patches indexed by their patch-ids and
>    commit-ids(of the git tree mentioned below), it also exports a git tree
>    which holds all in-flight patches, where each patchset map to a new branch:
>
>    https://github.com/0day-ci/linux/branches
>
>    0day will find that patch in database by parent patch id, then do the
>    checkout and apply work.

If a user starts from some solid base, applies a well-known
in-flight series, and builds his series on it and sends his series
out, and the base is identified by the patch-id of the last patch of
the in-flight series, then from that "parent patch-id" the robot can
find a commit that is the result of applying the same in-flight
series on top of some other solid base, as there is no coordination
between the user and 0day-ci system.  I would imagine that the
difference between the bases do matter--otherwise you wouldn't be
building this elaborate "base-commit" system that rejects the notion
that it is not sufficient for patches to textually apply cleanly and
insists that they have to be applied to exactly one known state.

So, I am not sure why you think "patch-id" is a good way to identify
the commit to be based on.

> In practice, most developers may not feed exact commit id by --base=<xxx>
> regularly when using git format-patch, this "showing parent commit" solution
> could save developers' energy and reach a high coverage in the meantime.

So, while I understand the desire and wish, I am not convinced "as a
fallback, use parent patch-id and guess where to apply" is a good
apprach to make the wish come true.
