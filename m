From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4] rev-list: refuse --first-parent combined with --bisect
Date: Mon, 16 Mar 2015 14:05:48 -0700
Message-ID: <xmqqr3sops9f.fsf@gitster.dls.corp.google.com>
References: <1425827005-9602-1-git-send-email-me@ikke.info>
	<1425934575-19581-1-git-send-email-me@ikke.info>
	<xmqqa8zkzeq5.fsf@gitster.dls.corp.google.com>
	<20150310225509.GA5442@vps892.directvps.nl>
	<xmqqoao0xx9p.fsf@gitster.dls.corp.google.com>
	<20150311184512.GB5442@vps892.directvps.nl>
	<xmqqsidb5m2r.fsf@gitster.dls.corp.google.com>
	<20150316163306.GB11832@vps892.directvps.nl>
	<xmqqbnjsrcyz.fsf@gitster.dls.corp.google.com>
	<065AE7977A54488198B39564E3E174E6@PhilipOakley>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "Kevin Daudt" <me@ikke.info>, <git@vger.kernel.org>,
	Christian Couder <chriscool@tuxfamily.org>
To: "Philip Oakley" <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Mon Mar 16 22:06:04 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YXcD0-0003tE-Bu
	for gcvg-git-2@plane.gmane.org; Mon, 16 Mar 2015 22:05:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755359AbbCPVFx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Mar 2015 17:05:53 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:56486 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754572AbbCPVFv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Mar 2015 17:05:51 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id B237A41F20;
	Mon, 16 Mar 2015 17:05:50 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ZEm96DlaCcKvVRNR57jS0CUxhbQ=; b=JacSo+
	D3GX4g3Cy7dbUnhgx5A8r/Z+3vcxsA/CGB7eDvflIAri6OSFXvg95h6fTjUQfA3T
	O/j+bNiHdKEBCHRoONzUUVNaJ+/9Mp+nNwerL8StO5DKlUfpA9u2LBqZvMabsHLv
	K9XiFNCgNjDVLkxbMKdwTUo2xASGVm9MbuasQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=mQdufuf9BuqU65oP8U5hH3Ujb6qG/ghB
	zWS87wvD1XQ4qw9GYaXZiPBtk4G7Riffb1C9HzjqdQh9Rikmv/NmKiqVJ1lEVABq
	9vNs75QhciQav0vi64MStM475JmqP4nTfAs1ESUa1XRlNO48G2UefyuMSbNV0nz3
	d65lwHpCXUE=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id A876641F1F;
	Mon, 16 Mar 2015 17:05:50 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 00D6941F1E;
	Mon, 16 Mar 2015 17:05:50 -0400 (EDT)
In-Reply-To: <065AE7977A54488198B39564E3E174E6@PhilipOakley> (Philip Oakley's
	message of "Mon, 16 Mar 2015 20:25:13 -0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 3954E96A-CC20-11E4-9769-A2259F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265596>

"Philip Oakley" <philipoakley@iee.org> writes:

> From: "Junio C Hamano" <gitster@pobox.com>
>
>> Hence, if you have a history that looks like this:
>>
>>
>>   G...1---2---3---4---6---8---B
>>                    \
>>                     5---7---B
>>
>> it follows that 4 must also be "bad".  It used to be good long time
>> ago somewhere before 1, and somewhere along way on the history,
>> there was a single breakage event that we are hunting for.  That
>> single event cannot be 5, 6, 7 or 8 because breakage at say 5 would
>> not explain why the tip of the upper branch is broken---its breakage
>> has no way to propagate there.  The breakage must have happened at 4
>> or before that commit.
>
> Is it not worth at least confirming the assertion that 4 is bad before
> proceding, or at least an option to confirm that in complex scenarios
> where the fault may be devious.

That raises a somewhat interesting tangent.

Christian seems to be forever interested in bisect, so I'll add him
to the Cc list ;-)

There is no way to give multiple "bad" from the command line.  You
can say "git bisect start rev rev rev..." but that gives only one
bad and everything else is good.  And once you specify one of the
above two bad ones (say, the child of 8), then we will not even
offer the other one (i.e. the child of 7) as a candidate to be
tested.  So in that sense, "confirm that 4 is bad before proceeding"
is a moot point.

However, you can say "git bisect bad <rev>" (and "git bisect good
<rev>" for that matter) on a rev that is unrelated to what the
current bisection state is.  E.g. after you mark the child of 8 as
"bad", the bisected graph would become

   G...1---2---3---4---6---8---B

and you would be offered to test somewhere in the middle, say, 4.
But it is perfectly OK for you to respond with "git bisect bad 7",
if you know 7 is bad.

I _think_ the current code blindly overwrites the "bad" pointer,
making the bisection state into this graph if you do so.

   G...1---2---3---4
                    \
                     5---B

This is very suboptimal.  The side branch 4-to-7 could be much
longer than the original trunk 4-to-the-tip, in which case we would
have made the suspect space _larger_, not smaller.

We certainly should be able to take advantage of the fact that the
current "bad" commit (i.e. the child of 8) and the newly given "bad"
commit (i.e. 7) are both known to be bad and mark 4 as "bad" instead
when that happens, instead of doing the suboptimal thing the code
currently does.
