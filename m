From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 3/6] clean: read user input with strbuf_getline()
Date: Mon, 22 Feb 2016 11:40:53 -0800
Message-ID: <xmqqtwl05y9m.fsf@gitster.mtv.corp.google.com>
References: <56CA5DBB.8040006@moritzneeb.de> <56CA6264.1040400@moritzneeb.de>
	<CAPig+cSi-4R-a=HVmpCWAZ3kr=yQtJ9GdT-JZ4hJ2kmqg-edVA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Moritz Neeb <lists@moritzneeb.de>, Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Mon Feb 22 20:41:04 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aXwLt-0004R1-5J
	for gcvg-git-2@plane.gmane.org; Mon, 22 Feb 2016 20:41:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752829AbcBVTk5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Feb 2016 14:40:57 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:57644 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752117AbcBVTk5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Feb 2016 14:40:57 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 2650947DBE;
	Mon, 22 Feb 2016 14:40:56 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=nYwW3TnRNbALHh3Vi1yl4azMO4I=; b=hs5NzI
	TeYfFvWqeDbbHQYJkXeyQeUDXHWfzK+6oUkEnSaVT0GG8iFQHxWz9L/zPUBOTysu
	I9B7a/3b7qTZFG4Fk1dOMF+l0Y/MZcqq0QjHBO5FX+XvniP/9CfaobYaSxjalFCq
	nEy/yLM3mnBcEBg6mtbnymI12+4PZmp6Mo+EM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ZSwYcZtZxED3iy2vie37aXyMcvq9pvcC
	btbaRR2Ttl3MY7jKOZphPXYJULhI1ujshnMxEXb6Mgge4SJn732csVUm5nActfSA
	usI27e0GXd2b7d8UJJH6FuhOxKhRIZPKK9TIJksP2syudojzgBiG7ZjwwRVqCIoR
	Zj8mb2Wt25g=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 1DC3947DBD;
	Mon, 22 Feb 2016 14:40:56 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 9639247DBA;
	Mon, 22 Feb 2016 14:40:55 -0500 (EST)
In-Reply-To: <CAPig+cSi-4R-a=HVmpCWAZ3kr=yQtJ9GdT-JZ4hJ2kmqg-edVA@mail.gmail.com>
	(Eric Sunshine's message of "Sun, 21 Feb 2016 21:27:29 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 307D207A-D99C-11E5-B962-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286948>

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Sun, Feb 21, 2016 at 8:20 PM, Moritz Neeb <lists@moritzneeb.de> wrote:
>> The inputs that are read are all answers that are given by the user
>> when interacting with git on the commandline. As these answers are
>> not supposed to contain a meaningful CR it is safe to
>> replace strbuf_getline_lf() can be replaced by strbuf_getline().
>>
>> Before the user input was trimmed to remove the CR. This would be now
>> redundant. Another effect of the trimming was that some (accidentally)
>> typed spaces were filtered. But here we want to be consistent with similar UIs
>> like interactive adding, which only accepts space-less input.
>
> I don't at all insist upon it, but this behavior change feels somewhat
> like it ought to be in its own commit. I'm also not convinced that
> making this consistent with the less forgiving behavior of
> "interactive adding" is desirable (rather the reverse: that that case
> should be more flexible). However, I wasn't following the discussion
> with Junio closely, and perhaps missed you two agreeing that this is
> preferable.

There was no such discussion ;-)

I am not 100% sure if we want to be lenient in reading "yes, please
remove this one", but if we already are loose, I tend to agree that
there is not much point tightening it, especially with a clean-up
topic like this one.

Thanks.
