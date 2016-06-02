From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] fetch: better alignment in ref summary
Date: Thu, 02 Jun 2016 09:16:40 -0700
Message-ID: <xmqqk2i7va53.fsf@gitster.mtv.corp.google.com>
References: <20160522112019.26516-1-pclouds@gmail.com>
	<20160522112019.26516-2-pclouds@gmail.com>
	<20160526051820.GE6756@sigill.intra.peff.net>
	<CACsJy8B1PXhSNSu-p5vdk7crHsy7cKisxJ0rtZXsknrZorx+Ug@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>, Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 02 18:17:08 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b8VIk-0004kG-Gk
	for gcvg-git-2@plane.gmane.org; Thu, 02 Jun 2016 18:16:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753500AbcFBQQu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Jun 2016 12:16:50 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53421 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752251AbcFBQQt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Jun 2016 12:16:49 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 81C782150B;
	Thu,  2 Jun 2016 12:16:43 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=mwKMcJNbRHq5ANb0cJEtIpUSI38=; b=U/7XLs
	mjAPNQYaokMs9DOfU1xyB7XPlrkKIxP7khtPQLtwvaHYV1v6Rt9WHU8/e5B3C2Rc
	n8f4e0BS2eViO13wnqDA/Mp54dyNqiV9r5L3Ex9bw4eVIES/MZXoF2fFWuFfN8e6
	1KaaeDByFkk2hYkVV3EHvbLFqu8onfd9wdtZw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=PVt/DDkRjIC4OSghn1gMRp3XUXVI7sH4
	OwZYRr3GkyntPrkZYOdfLKk9X4KOONDxYCdrYhprY8DUlsYJNls5Q/F1SiHTANmn
	/OIQMEpWhbY5VaiZ1zU4/FLSw8vyJ5prokfQwokto4dak814ho79BQd8pPwnIUyU
	qseM2eYbhNs=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 7AE4F2150A;
	Thu,  2 Jun 2016 12:16:43 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 06ACD21509;
	Thu,  2 Jun 2016 12:16:42 -0400 (EDT)
In-Reply-To: <CACsJy8B1PXhSNSu-p5vdk7crHsy7cKisxJ0rtZXsknrZorx+Ug@mail.gmail.com>
	(Duy Nguyen's message of "Thu, 2 Jun 2016 20:58:27 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 6518E216-28DD-11E6-B814-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296212>

Duy Nguyen <pclouds@gmail.com> writes:

> On Mon, May 23, 2016 at 7:58 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> That is, I wonder if the above can become something like:
>>
>>> From github.com:pclouds/git
>>>  * [new branch]      { -> pclouds/}2nd-index
>>>  * [new branch]      { -> pclouds/}3nd-index
>>>  * [new branch]      { -> pclouds/}file-watcher
>>>  ...
>
> for context of the following quote...
>
> On Thu, May 26, 2016 at 12:18 PM, Jeff King <peff@peff.net> wrote:
>> I do agree with Junio that we could probably improve the output quite a
>> bit by not showing each refname twice in the common case. I don't quite
>> find the "{ -> origin/}whatever" particularly pretty, but something like
>> that which keeps the variable bits at the end would make this problem
>> just go away.
>
> I tried it out. It's a bit hard to read at the "/}" boundary. Color
> highlight might help. But it occurs to me, could we extend refspec a
> bit to allow "foo/bar:base/..." be be equivalent of
> "foo/bar:base/foo/bar". Then fetch output could become
>
>>>  * [new branch]      2nd-index:pclouds/...
>>>  * [new branch]      3nd-index:pclouds/...
>>>  * [new branch]      file-watcher:pclouds/...
>
> It might be a tiny bit better, and a forced update could be displayed
> with a prefix '+'. Hmm?

I do not find that "..." particularly more readable, but that
probably is very subjective.  It is much less copy&pastable, when
compared to pasting "pclouds/}2nd-index" and then removing "}".
