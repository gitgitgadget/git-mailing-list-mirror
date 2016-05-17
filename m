From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 3/5] t1500: avoid changing working directory outside of tests
Date: Tue, 17 May 2016 15:48:31 -0700
Message-ID: <xmqqshxgti68.fsf@gitster.mtv.corp.google.com>
References: <20160517193630.10379-1-sunshine@sunshineco.com>
	<20160517193630.10379-4-sunshine@sunshineco.com>
	<xmqqeg90v2ss.fsf@gitster.mtv.corp.google.com>
	<CAPig+cTAgB6DXoEeJaDVy7_J7QiqNOm6AJqZTiSowO6_jqa8_w@mail.gmail.com>
	<20160517215214.GA16905@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Git List <git@vger.kernel.org>,
	Michael Rappazzo <rappazzo@gmail.com>,
	Duy Nguyen <pclouds@gmail.com>,
	SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>,
	Johannes Sixt <j.sixt@viscovery.net>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed May 18 00:48:40 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b2nn5-00087c-U1
	for gcvg-git-2@plane.gmane.org; Wed, 18 May 2016 00:48:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752263AbcEQWsg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 May 2016 18:48:36 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63057 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752122AbcEQWsf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 May 2016 18:48:35 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 001A31D17D;
	Tue, 17 May 2016 18:48:33 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ipacpzNhI+oKbcYOKV2Ycgy3m8o=; b=BWme53
	7SPTNCjZ1JMseb/OOzANgreBCA6jDbVGdkNoSOGkjuRY4mW9qBPtPfVPrd+ZNEJM
	v45BZQNBO44bvkF63lHELYbzi3jPe6p2MYSi0HFEJcFEMzISrcaiMQfwTkRSAayO
	5uW9g1dJnk6C+2PenDNNEHZKRiUfrzefnacPg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=pUQ68ZAzGJhE9vmSF0hBjqDUKyEvcTqZ
	zyZFooIbvcWykEkUXeBlWkQ/E//rvSuq9vqS+sfFh8Ku2iljW8fhTc7NOMx/xYHr
	1xN0GF2sFHLl9B8SdI1ugC8sdV6qo/rdaSQg2QD5uX67sBmLVk/sTnKliHEpxYOe
	59ce6YhTtN8=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id EC0EC1D17C;
	Tue, 17 May 2016 18:48:33 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 68FA01D17B;
	Tue, 17 May 2016 18:48:33 -0400 (EDT)
In-Reply-To: <20160517215214.GA16905@sigill.intra.peff.net> (Jeff King's
	message of "Tue, 17 May 2016 17:52:14 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 7BD22606-1C81-11E6-BE10-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294922>

Jeff King <peff@peff.net> writes:

> On Tue, May 17, 2016 at 04:48:33PM -0400, Eric Sunshine wrote:
>
>> On Tue, May 17, 2016 at 4:37 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> > Eric Sunshine <sunshine@sunshineco.com> writes:
>> >> +                     git ${dir:+-C "$dir"} rev-parse --$o >actual &&
>> >
>> > This is kosher POSIX, but I vaguely recall some shells had trouble
>> > with the SP between -C and "$dir" in the past.  Let's see if anybody
>> > screams; hopefully I am misremembering or buggy shells died out.
>> 
>> I also am bothered by a vague recollection of some issue (possibly
>> involving the internal space and lack of quotes around the entire
>> ${...}), but couldn't remember nor find a reference to the specific
>> details. Perhaps someone reading the patch has a better memory than I.
>
> Probably:
>
>   http://thread.gmane.org/gmane.comp.version-control.git/265094

Yikes, you're right.  Does anybody know if FreeBSD shell is still
buggy?
