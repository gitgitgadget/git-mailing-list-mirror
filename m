From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 4/6] t7406: Just-cloned checkouts update to the gitlinked hash with 'reset'
Date: Thu, 16 Jan 2014 12:24:11 -0800
Message-ID: <xmqqa9evzndg.fsf@gitster.dls.corp.google.com>
References: <20140114224246.GA13271@book.hvoigt.net>
	<09008c79ecc7d4fd92131b4049a25e65db92a30d.1389837412.git.wking@tremily.us>
	<xmqqmwivzq7n.fsf@gitster.dls.corp.google.com>
	<20140116193212.GV2647@odin.tremily.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git <git@vger.kernel.org>, Jens Lehmann <Jens.Lehmann@web.de>,
	Francesco Pretto <ceztko@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Jonathan Nieder <jrnieder@gmail.com>
To: "W. Trevor King" <wking@tremily.us>
X-From: git-owner@vger.kernel.org Thu Jan 16 21:24:21 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W3tUD-0006VS-8M
	for gcvg-git-2@plane.gmane.org; Thu, 16 Jan 2014 21:24:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751914AbaAPUYQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Jan 2014 15:24:16 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35586 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751892AbaAPUYO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Jan 2014 15:24:14 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D6350621A5;
	Thu, 16 Jan 2014 15:24:13 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=EZ9P+5bG8zyOpayZW/O2jgIvm0A=; b=g9wgSn
	qbnyv2Cw8FdlksDBnhbuYV5FXMYECg1c6h7IhqvyFPu1dTxn9BmZLDVpiCJlwWw1
	2/f1mVMXTOgX+zaFG9O6vCPCq5Gu/BVFMZZACuYw9J11jmkMkhu8DmZeemkfNOjJ
	MTrvTk76QpuRRKi/Jd7SYuQoThtt6bewibZAc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=g/gXNB02eS80Te3G8aVL4SDQNIuxMlxa
	oVu5wsVZqV5BcIneQKroUhNkmZ9+jlr/qoyzbleOkJr2a0IFDa81tSZUMMHTCU05
	lDXkuqgOsIsARWnIP7JvgxU5FIKIk29H1ge4nFwm3HpzUE31Df543uZi42jMVlg+
	d8YwYqUoKuc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BDA57621A4;
	Thu, 16 Jan 2014 15:24:13 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0E3D66219F;
	Thu, 16 Jan 2014 15:24:12 -0500 (EST)
In-Reply-To: <20140116193212.GV2647@odin.tremily.us> (W. Trevor King's message
	of "Thu, 16 Jan 2014 11:32:12 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 29D89734-7EEC-11E3-8334-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240530>

"W. Trevor King" <wking@tremily.us> writes:

> On Thu, Jan 16, 2014 at 11:22:52AM -0800, Junio C Hamano wrote:
>> "W. Trevor King" <wking@tremily.us> writes:
>> 
>> > To preserve the local branch, for situations where we're not on a
>> > detached HEAD.
>> >
>> > Signed-off-by: W. Trevor King <wking@tremily.us>
>> > ---
>> 
>> This should be a part of some other change that actually changes how
>> this "git submodule update" checks out the submodule, no?
>
> Sure, we can squash both this test fix and the subsequent new test
> patch into patch #3 in v5.  I was just splitting them out because
> backwards compatibility was a concern, and separate patches makes it
> easy for me to explain why the results changed here without getting
> lost in patch #3's implementation details.

On the contrary, if we had this as part of patch #3, it would have
helped reviewing the patch itself, as that would have served as one
more clue to illustrate the effect that is externally visible to end
users.

Besides, having them separate will break bisection.
