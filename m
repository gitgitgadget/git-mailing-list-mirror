From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Feb 2013, #05; Tue, 12)
Date: Tue, 12 Feb 2013 16:34:52 -0800
Message-ID: <7vsj51caqb.fsf@alter.siamese.dyndns.org>
References: <7v621xdql8.fsf@alter.siamese.dyndns.org>
 <CAH5451nPKq8DKwo+Bkxh08N-wqrYCY4BihbvaE14z5iGVA1iZw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "git\@vger.kernel.org" <git@vger.kernel.org>
To: Andrew Ardill <andrew.ardill@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 13 01:35:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U5QJj-000789-2B
	for gcvg-git-2@plane.gmane.org; Wed, 13 Feb 2013 01:35:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759340Ab3BMAez (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Feb 2013 19:34:55 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61817 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757022Ab3BMAez (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Feb 2013 19:34:55 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A3449C5AC;
	Tue, 12 Feb 2013 19:34:54 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=1VPg2VC0lctzP/bj9jJdV8xjpx8=; b=GwgkcG
	NlBmHwxtq8U9bsrZWzuNlmI92bRHj7ceV6nz8S9yloqG5QkAdjAkl86rVfVBjjr1
	Kx8Ec75JAWY1Q0wSNpO1YaN+b//TsK692QUtmp3Xd/ZddNTEwtojjUSEakrWnXE0
	2rznOSavuccCWxF+M9urra6146ZdktQU9aZ9g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=CFGF0xAujXu18zsQhceJ6ifRJ4IanSEg
	KmB87lDH1VwiqSnInEATNX6aM4MQrgPif3/hDoWI88VkKouVO5Ihkqnt8psdZu82
	iPd1zVJ1knUunx1yljW9uZBxn2iGKXX89CV3QNX2lG9+pBpbFt28Xv7gnJsPr1j8
	U6IGOCM+fok=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 964B0C5AB;
	Tue, 12 Feb 2013 19:34:54 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0BEB5C5A5; Tue, 12 Feb 2013
 19:34:53 -0500 (EST)
In-Reply-To: <CAH5451nPKq8DKwo+Bkxh08N-wqrYCY4BihbvaE14z5iGVA1iZw@mail.gmail.com> (Andrew
 Ardill's message of "Wed, 13 Feb 2013 11:21:03 +1100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 2F59B2DC-7575-11E2-87ED-BCD12E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216232>

Andrew Ardill <andrew.ardill@gmail.com> writes:

> On 13 February 2013 11:06, Junio C Hamano <gitster@pobox.com> wrote:
>> * jc/add-delete-default (2012-08-13) 1 commit
>>  - git add: notice removal of tracked paths by default
>>
>>  "git add dir/" updated modified files and added new files, but does
>>  not notice removed files, which may be "Huh?" to some users.  They
>>  can of course use "git add -A dir/", but why should they?
>>
>>  Resurrected from graveyard, as I thought it was a worthwhile thing
>>  to do in the longer term.
>>
>>  Stalled mostly due to lack of responses.
>
> What do you need to progress this?
>
> I have been bitten by this before (the 'huh?' reaction) and think the
> previous discussions and patch look reasonable. Does it need testing?

I _think_ the code does what it claims it does; I do not think that
is what is lacking (more testing would not _hurt_, of course).

> Further input??

The updated behaviour is a departure from the traditional norm, and
it would surprise people who do not expect "git add ." to update the
index for removed paths.  For many of them, it may be a pleasant
surprise, but "many" is not "all".

The change could negatively affect people who expect that removing
files that are not used for their purpose (e.g. a large file that is
unnecessary for their build) will _not_ affect what they get from
"git add ."; obviously they must have trained themselves not to do
"git add -u" or "git commit -a".
