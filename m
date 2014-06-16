From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 4/4] commit: Add commit.verbose configuration
Date: Mon, 16 Jun 2014 13:06:45 -0700
Message-ID: <xmqqzjhcpqju.fsf@gitster.dls.corp.google.com>
References: <1402601942-45553-1-git-send-email-caleb@calebthompson.io>
	<1402603225-46240-1-git-send-email-caleb@calebthompson.io>
	<xmqqppic3dko.fsf@gitster.dls.corp.google.com>
	<20140616195057.GB28126@sirius.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Caleb Thompson <caleb@calebthompson.io>
X-From: git-owner@vger.kernel.org Mon Jun 16 22:07:07 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WwdBK-0003Tw-5u
	for gcvg-git-2@plane.gmane.org; Mon, 16 Jun 2014 22:07:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756001AbaFPUGw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Jun 2014 16:06:52 -0400
Received: from smtp.pobox.com ([208.72.237.35]:52390 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755965AbaFPUGv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jun 2014 16:06:51 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 03E4621DB7;
	Mon, 16 Jun 2014 16:06:49 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=CFTmwTRAI9TpZI36znBGinQRy+Y=; b=dTIEcw
	XZe9qgH4aarQ19hUtG4Kty1KAbix1FczoHXvkeRue15MwObzMnCessluPHUHrEZ7
	mWnytUKkKPR+XpScFKchf2lCQoerbZ5KbGH05hMmGREdyuQYVvy8v9tDfeuquo7h
	0kj8TIiowbUzYK1QnHuXAcVTrIkP4H2v8h9A0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Krg8XZOA3CFt4lwknMrVyya3UJFjBQvM
	BmEPibb8uhpdO5MXkFqgbMUNd0IfNwvhRSgjjCxLRsVCCiPD9LoX5xktmsRpitzU
	F2SwKWc58kV0qS8cDyIox9ZPGzGuoUHjRIGhFLHPI7E0ZbPL3JMfy77AU8OhWBPT
	MmgVD65/T9I=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id EB97E21DB6;
	Mon, 16 Jun 2014 16:06:48 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 8ED4D21DB0;
	Mon, 16 Jun 2014 16:06:44 -0400 (EDT)
In-Reply-To: <20140616195057.GB28126@sirius.local> (Caleb Thompson's message
	of "Mon, 16 Jun 2014 14:50:57 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: BD48CF36-F591-11E3-8BB4-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251813>

Caleb Thompson <caleb@calebthompson.io> writes:

> On Fri, Jun 13, 2014 at 10:48:55AM -0700, Junio C Hamano wrote:
>> Caleb Thompson <caleb@calebthompson.io> writes:
>>
>> > diff --git a/t/t7507-commit-verbose.sh b/t/t7507-commit-verbose.sh
>> > index 35a4d06..402d6a1 100755
>> > --- a/t/t7507-commit-verbose.sh
>> > +++ b/t/t7507-commit-verbose.sh
>> > @@ -7,6 +7,10 @@ write_script check-for-diff <<-'EOF'
>> >		exec grep '^diff --git' "$1"
>> >  EOF
>> >
>> > +write_script check-for-no-diff <<-'EOF'
>> > +	exec grep -v '^diff --git' "$1"
>> > +EOF
>>
>> This lets grep show all lines that are not "diff --git" in the
>> input, and as usual grep exits success if it has any line in the
>> output.
>>
>>     $ grep -v '^diff --git' <<\EOF ; echo $?
>>     diff --git
>>     a
>>     EOF
>>     a
>>     0
>>     $ exit
>>
>> What are we testing, exactly?
>
> Good catch. It worked when I switched check-for-diff from
> check-for-no-diff, but I didn't try to make check-for-no-diff fail
> independently, so I apologize.

No need to apologize at all.  None of us (including this reviewer)
is perfect and that is why we review patches by each other.

> This version removes the the beginning of a line starting with
> "diff --git" from the string,...

Again, what are we testing, exactly?

We do not want to see "^diff --git" in the output file, in other
words, we want to make sure "^diff --git" does not appear in the
output.

So

        write_script check-for-no-diff <<-\EOF
        ! grep '^diff --git' "$@"
	EOF

should be the most natural way to express what we are testing, no?
