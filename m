From: SZEDER =?utf-8?b?R8OhYm9y?= <szeder@ira.uka.de>
Subject: Re: [PATCH v2 3/5] t1500: avoid changing working directory outside
 of tests
Date: Wed, 18 May 2016 01:06:09 +0200
Message-ID: <20160518010609.Horde.sM8QUFek6WMAAwho56DDob8@webmail.informatik.kit.edu>
References: <20160517193630.10379-1-sunshine@sunshineco.com>
 <20160517193630.10379-4-sunshine@sunshineco.com>
 <xmqqeg90v2ss.fsf@gitster.mtv.corp.google.com>
 <CAPig+cTAgB6DXoEeJaDVy7_J7QiqNOm6AJqZTiSowO6_jqa8_w@mail.gmail.com>
 <20160517215214.GA16905@sigill.intra.peff.net>
 <xmqqshxgti68.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed; DelSp=Yes
Cc: Jeff King <peff@peff.net>, Eric Sunshine <sunshine@sunshineco.com>,
	Git List <git@vger.kernel.org>,
	Michael Rappazzo <rappazzo@gmail.com>,
	Duy Nguyen <pclouds@gmail.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Stefan Beller <sbeller@google.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 18 01:06:37 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b2o4T-0007jJ-5V
	for gcvg-git-2@plane.gmane.org; Wed, 18 May 2016 01:06:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752154AbcEQXGd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 May 2016 19:06:33 -0400
Received: from iramx2.ira.uni-karlsruhe.de ([141.3.10.81]:37394 "EHLO
	iramx2.ira.uni-karlsruhe.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751796AbcEQXGc (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 17 May 2016 19:06:32 -0400
Received: from irawebmail.ira.uni-karlsruhe.de ([141.3.10.230] helo=webmail.ira.uka.de)
	by iramx2.ira.uni-karlsruhe.de with esmtps port 25 
	iface 141.3.10.81 id 1b2o4F-0003fa-LB; Wed, 18 May 2016 01:06:23 +0200
Received: from apache by webmail.ira.uka.de with local (Exim 4.84_2)
	(envelope-from <szeder@ira.uka.de>)
	id 1b2o41-0003ts-PC; Wed, 18 May 2016 01:06:09 +0200
Received: from x4db1c689.dyn.telefonica.de (x4db1c689.dyn.telefonica.de
 [77.177.198.137]) by webmail.informatik.kit.edu (Horde Framework) with HTTP;
 Wed, 18 May 2016 01:06:09 +0200
In-Reply-To: <xmqqshxgti68.fsf@gitster.mtv.corp.google.com>
User-Agent: Horde Application Framework 5
Content-Disposition: inline
X-ATIS-AV: ClamAV (iramx2.ira.uni-karlsruhe.de)
X-ATIS-Timestamp: iramx2.ira.uni-karlsruhe.de 1463526383.
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294923>


Quoting Junio C Hamano <gitster@pobox.com>:

> Jeff King <peff@peff.net> writes:
>
>> On Tue, May 17, 2016 at 04:48:33PM -0400, Eric Sunshine wrote:
>>
>>> On Tue, May 17, 2016 at 4:37 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>>> Eric Sunshine <sunshine@sunshineco.com> writes:
>>>>> +                     git ${dir:+-C "$dir"} rev-parse --$o >actual &&
>>>>
>>>> This is kosher POSIX, but I vaguely recall some shells had trouble
>>>> with the SP between -C and "$dir" in the past.  Let's see if anybody
>>>> screams; hopefully I am misremembering or buggy shells died out.
>>>
>>> I also am bothered by a vague recollection of some issue (possibly
>>> involving the internal space and lack of quotes around the entire
>>> ${...}), but couldn't remember nor find a reference to the specific
>>> details. Perhaps someone reading the patch has a better memory than I.
>>
>> Probably:
>>
>>  http://thread.gmane.org/gmane.comp.version-control.git/265094

And ea10b60c910e (Work around ash "alternate value" expansion bug,
2009-04-18) as well.

    http://thread.gmane.org/gmane.comp.version-control.git/116816

> Yikes, you're right.  Does anybody know if FreeBSD shell is still
> buggy?

git-submodule.sh contains a few offending constructs:

	git submodule--helper update-clone ${GIT_QUIET:+--quiet} \
		${wt_prefix:+--prefix "$wt_prefix"} \
		${prefix:+--recursive-prefix "$prefix"} \
		${update:+--update "$update"} \
		${reference:+--reference "$reference"} \
		${depth:+--depth "$depth"} \
		"$@" || echo "#unmatched"
	} | {

They were added recently in 48308681b072 (git submodule update: have
a dedicated helper for cloning, 2016-02-29), which is not in any
release yet, perhaps that's why noone complained yet.
