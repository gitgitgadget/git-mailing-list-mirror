From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 00/33] Yet more preparation for reference backends
Date: Mon, 09 May 2016 14:05:04 -0700
Message-ID: <xmqqinynt01r.fsf@gitster.mtv.corp.google.com>
References: <cover.1462550456.git.mhagger@alum.mit.edu>
	<1462824758.24478.37.camel@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Michael Haggerty <mhagger@alum.mit.edu>, Jeff King <peff@peff.net>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>, git@vger.kernel.org
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Mon May 09 23:08:53 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1azsMc-0001nN-Pm
	for gcvg-git-2@plane.gmane.org; Mon, 09 May 2016 23:05:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751441AbcEIVFJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 May 2016 17:05:09 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55605 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751036AbcEIVFI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 May 2016 17:05:08 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 214881869C;
	Mon,  9 May 2016 17:05:07 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=tkJna7sVSeQ8m3QO/rdnqUywALA=; b=QNY4rL
	5aaHAnMg/VnuaNkBmPfuSv5GrtIuS8SRaitEvLS/iQ0/CoCS851uMUD+f1mxlW1u
	X8qbe3YCQKjEFXPk4hdeWT7Px5m4iwFuM2hWxBCFeSuyyVU9X5COQRsEmRm8mFVc
	LVILRhE1ddiduuOmklnuX/I3q305/rJLsaME4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=YlosgAJBOZXw3dkqvgL6WBkL8DKK+FDe
	4ti0DT9gFwxQubzeA/60j0bdW/ascNnZ4u3bwbjuLKU4V1BnSJQbWACOWeXta88k
	0FOG5k40o9nMEE7wupnRutc68usC0Is8fmZUfYpBnko8TdQDlsdk9grfs8etPuBN
	rAkTRzyQmfw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 194D01869A;
	Mon,  9 May 2016 17:05:07 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id D22E218698;
	Mon,  9 May 2016 17:05:05 -0400 (EDT)
In-Reply-To: <1462824758.24478.37.camel@twopensource.com> (David Turner's
	message of "Mon, 09 May 2016 16:12:38 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: B47A746C-1629-11E6-9A8E-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294070>

David Turner <dturner@twopensource.com> writes:

> On Fri, 2016-05-06 at 18:13 +0200, Michael Haggerty wrote:
>> Thanks to David, Junio, and Peff for their comments on v1 of this
>> patch series [1]. I think I have addressed all of the points that
>> were
>> brought up. Plus I fixed a pre-existing bug that I noticed myself
>> while adding some more tests; see the first bullet point below for
>> more information.
>> 
>> Changes between v1 and v2:
>> 
>> * Prefixed the patch series with three new patches that demonstrate
>>   and fix some bugs in reference resolution that I noticed while
>>   inspecting this series:
>> 
>>   * "t1404: demonstrate a bug resolving references" -- this
>>     demonstrates a bug that has existed since at least 2.5.0.
>>   * "read_raw_ref(): don't get confused by an empty directory"
>>   * "commit_ref(): if there is an empty dir in the way, delete it"
>
> I generally like to put the bug fixes before the tests for those fixes
> (so that bisect on the complete suite works).  But maybe the git policy
> is different.

The Git policy only asks not to break bisection.

As long as patch that adds a new test that comes before a patch that
fixes the issue marks the new test with test_expect_failure, and a
later patch that fixes the issue turns it into test_expect_success,
bisection would not break.

The "demonstrate an existing breakage first" order makes it slightly
easier to review and follow a long series, as it forces the reviewer
to see the issue first and think about possible avenues to solve it
for themselves, before seeing a paticular solution.  For a trivial
single-issue fix, it is not necessary (including a fix and a test to
protect the fix from future breakage in the same patch is a norm).
