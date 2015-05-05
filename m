From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] prefix_path(): Unconditionally free result of prefix_path
Date: Tue, 05 May 2015 11:09:11 -0700
Message-ID: <xmqq8ud2ew1k.fsf@gitster.dls.corp.google.com>
References: <1430766714-22368-1-git-send-email-sbeller@google.com>
	<20150505032158.GA23587@peff.net>
	<CAGZ79kZjeG8UG5ALE-KSO52fD5gJk4xks=VtSV9bHQVA=ST+5Q@mail.gmail.com>
	<xmqqr3qvdizd.fsf@gitster.dls.corp.google.com>
	<20150505175612.GA9709@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Stefan Beller <sbeller@google.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue May 05 20:09:30 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YphHc-0000tn-Vg
	for gcvg-git-2@plane.gmane.org; Tue, 05 May 2015 20:09:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965999AbbEESJS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 May 2015 14:09:18 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:55538 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S965997AbbEESJP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 May 2015 14:09:15 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id A41C14DF9E;
	Tue,  5 May 2015 14:09:14 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=G2Xf1+xD44PU0vsWTMRChgE/+Po=; b=rkInY4
	Wl46UdxIHrQIZn2ayI+ghaWh9BUPIY+jReomsjLbRLiAGNlXMBSQxaEKasy5Dbpc
	Q5zJhV9z088PiSLmbElZWXG6XIgp0N30f8jGT8JlpNP9INKFIgLLcUHkAYRzBZt0
	0R6ZoxKhVfz0PzQKGi9VJhJ/CfB870cC39chc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=bQFnpUlbzJFuEt/NYoWTlvw/mjaQOVnn
	kQQwFMCsIbkrclxi5q2GJkzgCb/c9ZxczhN+sEkwmsCvs7H3bPZUnKwXHxheuf/n
	FNU4+kyMcPlsupudNkHs6qP1vkrDoOYoXWsuKaBL8INy7GLOLKVnLDvPS14iGsWW
	cIV8HSRAbdM=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 8FEB24DF9D;
	Tue,  5 May 2015 14:09:14 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C3A054DF9C;
	Tue,  5 May 2015 14:09:12 -0400 (EDT)
In-Reply-To: <20150505175612.GA9709@peff.net> (Jeff King's message of "Tue, 5
	May 2015 13:56:12 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: D5B03D5C-F351-11E4-BAC1-83E09F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268411>

Jeff King <peff@peff.net> writes:

>> >>   1. in blame, we assign the result to a const char that may also point
>> >>      straight into to argv, but we never actually free either way
>> 
>> The return value from add_prefix() that is what prefix_path()
>> returned eventually becomes scoreboard.path that needs to be kept
>> during the lifetime of the process, and I think there isn't much
>> point doing the "free() immediately before exiting".
>
> Yeah, sorry, I meant to say that more explicitly, but clearly didn't. I
> think it is fine as-is.

Yeah, sorry, I didn't mean "You are wrong and here is why".  I was
merely agreeing with you.

Thanks for running grep over the codebase to check possible
remaining problems.
