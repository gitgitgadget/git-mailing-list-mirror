From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/20] rs/ref-transaction-1 (Re: Transaction patch series overview)
Date: Wed, 27 Aug 2014 15:37:58 -0700
Message-ID: <xmqqwq9tbltl.fsf@gitster.dls.corp.google.com>
References: <CAL=YDWmtitT7kHsZqXmojbv8eKYwKwVn7c+gC180FPQN1uxBvQ@mail.gmail.com>
	<CAL=YDWnd=GNycrPO-5yq+a_g569fZDOmzpat+AWrXd+5+bXDQA@mail.gmail.com>
	<CAL=YDWka47hV2TMcwcY1hm+RhbiD6HD=_ED4zB84zX5e5ABf4Q@mail.gmail.com>
	<CAL=YDWm9VaKUBRAmmybHzOBhAg_VvNc0KMG0W_uTA02YYzQrzA@mail.gmail.com>
	<20140820231723.GF20185@google.com>
	<20140826000354.GW20185@google.com>
	<xmqqlhqbge3a.fsf@gitster.dls.corp.google.com>
	<20140826221448.GY20185@google.com>
	<20140827002804.GA20185@google.com>
	<xmqq1ts1d3jx.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ronnie Sahlberg <sahlberg@google.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 28 00:38:16 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XMlr5-0000IP-K6
	for gcvg-git-2@plane.gmane.org; Thu, 28 Aug 2014 00:38:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935845AbaH0WiK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Aug 2014 18:38:10 -0400
Received: from smtp.pobox.com ([208.72.237.35]:55585 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932603AbaH0WiJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Aug 2014 18:38:09 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 6BC7435488;
	Wed, 27 Aug 2014 18:38:08 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=j89+CZAwvHpL45W/YHmQq5TOnbk=; b=dVLGrd
	wLlEIEUQBVx/2GTmiMR5xJOCMX29/6eeT0hUBuI+amV8S+Zy5JhBRCIsXcTBNtCk
	1wB3tQ8yDmEjC5zk7ak808n8icNROiMrCCN59sN2rDtnXw6giJVWtV0NshpxcWE9
	EXi8F2x+MzkFKcAuCJWCk9x8I2G87NBx2XmDw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=yXFojmaB6nkhgLzo7UoJ/JZfi1PB0foc
	wByiubg2sPreEfNC2sik/FKiXEzgnjJx69on2JGAh+WMEg8nnsvXohXd3hhrNZKI
	NLR5mmOx32+EDxmsm/nKLPX217vasyQqQyOsQ9xginwlStN4YWMsYtLhFRN94jfw
	W1NncYxHe3U=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 614B135487;
	Wed, 27 Aug 2014 18:38:08 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 92DDC35481;
	Wed, 27 Aug 2014 18:38:00 -0400 (EDT)
In-Reply-To: <xmqq1ts1d3jx.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Wed, 27 Aug 2014 14:29:38 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: CCC159B0-2E3A-11E4-BD9E-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256056>

Junio C Hamano <gitster@pobox.com> writes:

> Jonathan Nieder <jrnieder@gmail.com> writes:
>
>> Jonathan Nieder wrote:
>>
>>> This series teaches the tag, replace, commit, cherry-pick,
>>> fast-import, checkout -b, branch, receive-pack, and http-fetch
>>> commands and all update_ref and delete_ref callers to use the ref
>>> transaction API instead of lock_ref_sha1.
>>>
>>> The main user-visible change should be some cosmetic changes to error
>>> messages.  The series also combines multiple ref updates into a single
>>> transaction in 'git http-fetch -w' and when writing tags in
>>> fast-import but otherwise doesn't change the granularity of
>>> transactions.
>>>
>>> Reviewed at https://code-review.googlesource.com/#/q/topic:ref-transaction-1
>
> Thanks.
>
> Will queue, but the some other topics may have to disappear from my
> tree while I try to rebase them on top (or while I wait for you guys
> to send a reroll, making it unnecesary to do the rebase myself).

I managed to rebase all the rs/ref-transaction* topics and pushed
out the result in 'pu'.  Please eyeball the result.

I had to bump nd/multiple-work-trees, which Duy asked to kick out of
'next' earlier, out of 'pu' because I did not want to deal with
conflict resolution that will go to waste when the topic is rerolled
which would happen soon.
