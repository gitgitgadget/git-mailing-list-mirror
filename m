From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 3/4] git-cherry-pick: Add test to validate new options
Date: Mon, 16 Apr 2012 09:35:12 -0700
Message-ID: <7vvckzws73.fsf@alter.siamese.dyndns.org>
References: <1333136922-12872-1-git-send-email-nhorman@tuxdriver.com>
 <1334342707-3326-1-git-send-email-nhorman@tuxdriver.com>
 <1334342707-3326-4-git-send-email-nhorman@tuxdriver.com>
 <20120415093933.GB6263@ecki>
 <20120416161431.GD13366@hmsreliant.think-freely.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Clemens Buchacher <drizzd@aon.at>, git@vger.kernel.org,
	Jeff King <peff@peff.net>, Phil Hord <phil.hord@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Neil Horman <nhorman@tuxdriver.com>
X-From: git-owner@vger.kernel.org Mon Apr 16 18:35:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SJotf-0006XD-6O
	for gcvg-git-2@plane.gmane.org; Mon, 16 Apr 2012 18:35:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754215Ab2DPQfR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Apr 2012 12:35:17 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57313 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754058Ab2DPQfQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Apr 2012 12:35:16 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D64FA7FD0;
	Mon, 16 Apr 2012 12:35:15 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=lPezY8as7IUxmRL19U1hwtQkmho=; b=WloSUj
	to0lkKxF6VrGwHJaAMo5pbqQj4hmokw22BWu8UTj/3OG2bqAiYcJ+Xd1VUoHVsiX
	3D5T3wMi3+pue6grCaV3AfFZVLxrFw1Bo9Tl833ZdAlVz2FsdpGT5Qvubgej0QWe
	djzIyyeVQGndxtEH4wbPyENXNqHoTefsWJjtM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=alJWQqixkd5lgFkKeE76VXbab7Mo76sY
	w2h+cbDNEWLbDjszJs55gzr1GxQYT9aqosqEUKy1J7+BRpqt00MFKHUnzBoyqXim
	7kaj1B8vTyqv8Nyu1G7jiIcPZk/mtONAqIZtCN3q4QBXvW7f6WvE3c+tYLFGLM1T
	YBOpl9vj7WI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CD5707FCF;
	Mon, 16 Apr 2012 12:35:15 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 50A6F7FCE; Mon, 16 Apr 2012
 12:35:14 -0400 (EDT)
In-Reply-To: <20120416161431.GD13366@hmsreliant.think-freely.org> (Neil
 Horman's message of "Mon, 16 Apr 2012 12:14:31 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 248D43A4-87E2-11E1-A52A-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195662>

Neil Horman <nhorman@tuxdriver.com> writes:

> On Sun, Apr 15, 2012 at 11:39:35AM +0200, Clemens Buchacher wrote:
> ...
>> > +test_expect_success 'cherry pick an empty non-ff commit with --allow-empty' '
>> > +	git checkout master && {
>> > +		git cherry-pick --allow-empty empty-branch2
>> > +	}
>> > +'
>> > +
>> > +test_expect_success 'cherry pick with --keep-redundant-commits' '
>> > +	git checkout master && {
>> > +		git cherry-pick --keep-redundant-commits HEAD^
>> > +	}
>> > +'
>> 
>> And the expected result is that the HEAD commit is not removed, right?
>> You should check for that as well.
>> 
>> Also, please checkout empty-branch2^0 first, in order to make the test
>> independent of its predecessor.
>
> Not sure I follow what your saying here.  The expected result with both of these
> tests is that a new commit is created, referencing the current HEAD as the new
> HEAD's parent.

If the request were "checkout master^0 first" I would understand.  The
precondition for the second test will be different depending on the first
one succeeds or not.  Perhaps that is what Clemens meant?
