From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/7] test patch hunk editing with "commit -p -m"
Date: Mon, 17 Mar 2014 14:33:16 -0700
Message-ID: <xmqqa9cocxyb.fsf@gitster.dls.corp.google.com>
References: <CA+SSzV1LcuTWMGrJrto3cJ13-MxgFsJP6z3zTYjHp=qZGPoraw@mail.gmail.com>
	<1394919750-28432-1-git-send-email-benoit.pierre@gmail.com>
	<1394919750-28432-3-git-send-email-benoit.pierre@gmail.com>
	<xmqqr460ek3k.fsf@gitster.dls.corp.google.com>
	<CA+SSzV3CZjpNaFuf1U1DcPXiKy=rpJH8M2q1xeMvyh9uEHxvOA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Benoit Pierre <benoit.pierre@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 17 22:33:31 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WPfA2-00085t-J7
	for gcvg-git-2@plane.gmane.org; Mon, 17 Mar 2014 22:33:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752697AbaCQVdX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Mar 2014 17:33:23 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63184 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752680AbaCQVdU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Mar 2014 17:33:20 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 39ADE76043;
	Mon, 17 Mar 2014 17:33:19 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=kXY8pTgtOhopb/9Pgqgjx+aT14Y=; b=eFVTzo
	yEuoOacB3MpTnpHr01uQkKI0/sZMY1bYMa15DAZSnK3nIsG2xvqFBc+mNGoyp1P7
	A28uoyuN2pq0BK80pT49kaGVHzlnWxmRPw69vGnX7oGBzYPszFcvXZtY2NEdA0i+
	i/sV6+FrxrpAFI6Nlyp+E/3eoAe4rebCuh+lg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=u+YJdz7DR4IbpRrStpbQgEoVodI6j67J
	Yehadp/WJuISREWQzzW/vP6LFdO7iY2bpYZ9MJjtcqwHLOLwZdGfnHgJVE/rkH1M
	8mZyJDhAxdWeQVXvkNCaQpXSGoy3jBK3j9kVfLBQHjlMQfLuwiigM1X2U6e/nQuO
	G9ZB+yLWQhM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1750676042;
	Mon, 17 Mar 2014 17:33:19 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id EC26A76038;
	Mon, 17 Mar 2014 17:33:17 -0400 (EDT)
In-Reply-To: <CA+SSzV3CZjpNaFuf1U1DcPXiKy=rpJH8M2q1xeMvyh9uEHxvOA@mail.gmail.com>
	(Benoit Pierre's message of "Mon, 17 Mar 2014 20:46:18 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: C1305D7A-AE1B-11E3-9B53-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244289>

Benoit Pierre <benoit.pierre@gmail.com> writes:

> On Mon, Mar 17, 2014 at 7:49 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Benoit Pierre <benoit.pierre@gmail.com> writes:
>>
>>> Add (failing) tests: with commit changing the environment to let hooks
>>> know that no editor will be used (by setting GIT_EDITOR to ":"), the
>>> "edit hunk" functionality does not work (no editor is launched and the
>>> whole hunk is committed).
>>>
>>> Signed-off-by: Benoit Pierre <benoit.pierre@gmail.com>
>>> ---
>>>  t/t7513-commit-patch.sh | 32 ++++++++++++++++++++++++++++++++
>>>  1 file changed, 32 insertions(+)
>>>  create mode 100755 t/t7513-commit-patch.sh
>>>
>>> diff --git a/t/t7513-commit-patch.sh b/t/t7513-commit-patch.sh
>>
>> Again, as I said, I'll rename this to t7514-commit.patch.sh while I
>> queue this.
>
> I assumed the "14" was a typo, will rename, but to
> t7514-commit-patch.sh right? (with 2 '-').

Thanks, yes.  That is how I queued the previous one on 'pu', I
think.
