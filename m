From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 3/3] fetch: reduce duplicate in ref update status lines
Date: Fri, 03 Jun 2016 13:53:40 -0700
Message-ID: <xmqqtwhangdn.fsf@gitster.mtv.corp.google.com>
References: <20160522112019.26516-1-pclouds@gmail.com>
	<20160603110843.15434-1-pclouds@gmail.com>
	<20160603110843.15434-4-pclouds@gmail.com>
	<575199E7.7000503@xiplink.com>
	<xmqqh9dap5jk.fsf@gitster.mtv.corp.google.com>
	<5751E1C1.8080507@xiplink.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	git@vger.kernel.org, Jeff King <peff@peff.net>
To: Marc Branchaud <marcnarc@xiplink.com>
X-From: git-owner@vger.kernel.org Fri Jun 03 22:54:25 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b8w6S-0007gZ-8L
	for gcvg-git-2@plane.gmane.org; Fri, 03 Jun 2016 22:54:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422672AbcFCUxr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Jun 2016 16:53:47 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58525 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752469AbcFCUxo (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Jun 2016 16:53:44 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 360D921775;
	Fri,  3 Jun 2016 16:53:42 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=EoCBoIIRQOVJlBqZiCTBmJ5DczY=; b=DCVwiX
	AhMp9/lzHfKvg8Qe0+nZYx1KSfDm8JEnt7bemTTgfQo2vxRLBWrZFH5dVvyS8SY2
	0Of7tV6E69RYGB17/dXvJ4Q1sHXO8VxQFHUPIsY6aabY79DMWArA1EwG3ttQ1C6E
	TqLmNHLea1O3R2NsD9pMQJSEN4ihMRa3yeSrI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Bnho6nmalOrjYQWs+lDlpR6hz63K9aSJ
	75cr1tqjmk0GPO+b2TtH8JPiWzlxiUXOFYG78zl8eUVzUD9r8u8EWw0u051LAlu/
	5jbQ+jp2OjWjPIoNsoDQvDSp+gh6JRehPrMQoT2vBPBJzYIWg7TwKVMtDYR/6GXh
	JECtGOodsBE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 2E9C921774;
	Fri,  3 Jun 2016 16:53:42 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id BC40E21773;
	Fri,  3 Jun 2016 16:53:41 -0400 (EDT)
In-Reply-To: <5751E1C1.8080507@xiplink.com> (Marc Branchaud's message of "Fri,
	3 Jun 2016 16:00:01 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 410D8750-29CD-11E6-87DE-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296372>

Marc Branchaud <marcnarc@xiplink.com> writes:

>>>   * [new branch]      2nd-index -> pclouds/2nd-index
>>>   * [new branch]      some-kind-of-long-ref-name
>>>                                 -> pclouds/some-kind-of-long-ref-name
>>>   * [new branch]      3nd-index -> pclouds/3nd-index
> ...
> I think aligning it with the -> on the other lines makes the most
> aesthetic sense.
>
> Are you worried that the right-hand-side ref might still wrap?

Not really.

Given that we reserve some fixed screen real estate on the left hand
side for the sign and explanation (like [new branch]) and 4 columns
in the middle for " -> ", we have around 80-25=55 columns to work
with to fit "2nd-index" and such twice plus "pclouds/" once.
Assuming that remote names are not overly long (say, around 10
columns), that leaves about 20-25 columns for the branch name
proper.

By punting on the effort to find a readable format that does not
repeat the same info twice, we are sending a signal to the users
that they cannot use a meaningful sentence as the name of a branch
name; they need to stay within a relatively short (i.e. 1/4 of a
line width) branch name, to avoid triggering this multi-line
behaviour.

The same 55 columns minus remote name, e.g. around 40 columns, could
have been used to express the branch name once, if we managed to
find a non-redundant format.

That is what bothers me somewhat.
