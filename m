From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFD] minor frustration in 'git add' pathname completion
Date: Thu, 24 Mar 2016 15:55:40 -0700
Message-ID: <xmqqy4975vv7.fsf@gitster.mtv.corp.google.com>
References: <xmqqr3ez7dqw.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kaUPf=kBCuH__8BahjM3WjSGaijiQr05pMKe+TNdg3W9w@mail.gmail.com>
	<xmqqbn637cpe.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kYDWJDDJ+doy3NcZH_dqbbFE8U2UHZjnYYTo5R9GTsghQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "git\@vger.kernel.org" <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Thu Mar 24 23:55:49 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ajEAN-0000z9-US
	for gcvg-git-2@plane.gmane.org; Thu, 24 Mar 2016 23:55:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751416AbcCXWzo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Mar 2016 18:55:44 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:65299 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751208AbcCXWzn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Mar 2016 18:55:43 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id CF3474E160;
	Thu, 24 Mar 2016 18:55:41 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=iA7VygJHfqrk7EDMs5t2CZLe/sA=; b=iLBa2b
	E1yKkiIPaqBYQ3+lk7htrvbW7nP8v8/vR4obEe248xEvN6XAP91adnlCLUhmZ9Ik
	CZfRM3+MUTPjX7CqDEuXEwUZeyj5Cdzq4rQtCeu9NKBdWCo0nhnGZi3Az7k3r2X5
	dv82lDaQQ8oD1P2g/GqculrlSyiNbb3a9aawI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=wuoBvizTJCFNZyt9vOqhAnkMuIdtXmmh
	PLJaV6s6yeHOgPNzQ8ZoWQsp/ejxWbhjB15xoZTeIJ4Bg8FhX8/yuXzQSdwm7WbR
	0nLQbJQj3KBaGqdnZq0X3kBfeMZujnSUZCm14dr5kHKRLN6xul3/CPI4tvK2XRBX
	zZTkrLx3o1c=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id C78B14E15F;
	Thu, 24 Mar 2016 18:55:41 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 52E9D4E15D;
	Thu, 24 Mar 2016 18:55:41 -0400 (EDT)
In-Reply-To: <CAGZ79kYDWJDDJ+doy3NcZH_dqbbFE8U2UHZjnYYTo5R9GTsghQ@mail.gmail.com>
	(Stefan Beller's message of "Thu, 24 Mar 2016 15:40:19 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 888719A8-F213-11E5-A544-E95C6BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289818>

Stefan Beller <sbeller@google.com> writes:

>> If I were to explicitly ignore that file, then even though I know
>> whats-cooking.txt is not ignored,
>>
>>    $ git add whats-coo<HT>
>>
>> would not offer anything.  I'd be left scratching my head, wondering
>> if I mistyped the early part of the filename (e.g. "wahts-coo<HT>"?).
>
> Well, git add cannot do anything with either of the files, so why would
> it offer to complete to one of them?
>
> In an ideal world it would tell you whats-cooking.txt doesn't need
> adding and whats-cooking.txt+ is ignored locally so excluded from
> being added.

Exactly my point that you omitted from your quoting ;-)

Because the completion cannot give such an explanation, the
behaviour gives an unnecessary confusion to the user.  If it offered
whats-cooking.txt as a candidate, at least the behaviour would make
sense to the user.  "Doesn't need adding" is quite different from
"must not be added". In other words, "git add A && git add A" does
not hurt, but "git add A~" would because the latter would only makes
you see unnecessary error message ("You need -f if you really mean
it").
