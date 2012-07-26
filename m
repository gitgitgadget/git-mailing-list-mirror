From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Test "t/t7502-commit.sh" failed
Date: Thu, 26 Jul 2012 09:34:27 -0700
Message-ID: <7vtxwu8orw.fsf@alter.siamese.dyndns.org>
References: <CANYiYbHbMw1HpvoCr4yBbWF=Q9Hoc1Zsq3-WoTrx4aQg7R0e4g@mail.gmail.com>
 <20120726130348.GA965@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jiang Xin <worldhello.net@gmail.com>,
	Git List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jul 26 18:34:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SuR1a-0007BC-Bc
	for gcvg-git-2@plane.gmane.org; Thu, 26 Jul 2012 18:34:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752494Ab2GZQed (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Jul 2012 12:34:33 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48452 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752437Ab2GZQeb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jul 2012 12:34:31 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 07A897821;
	Thu, 26 Jul 2012 12:34:30 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=lTqnYJlZYyfmX/iOXySudNDDb3c=; b=XkKFAw
	zUsj+UbAFPJuLmcVD3eE8TmvPxF5gciMePdjRpXzwtp5PGrOEMvlqhS3jzrKT2BK
	zoHWFUMd/e6cpz/zP6whQGjbj9FEUQc9Ff47jcIC81o2IgQuBGNWUfRrurJ11Yqn
	8W0Yf3AccPMK0IRtZJPMGq1y7AxlLfEolN/iY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=xMGm+BLDJCishyyuO5OpK/Pnzzl4+BFt
	jbI/FSdAWRxe18x3lp1/rAgP5kwFM7m3QyJoSStl3xVUo7z5habWIOG59OFmixON
	HbSXaCT3jDtV/KApw6Mu1oTrWnEyGYC+jmdrNZRV63kcBALQcFTxPMqDtzhvqh/3
	xhiKCoWeDGM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E99B87820;
	Thu, 26 Jul 2012 12:34:29 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4C80E781F; Thu, 26 Jul 2012
 12:34:29 -0400 (EDT)
In-Reply-To: <20120726130348.GA965@sigill.intra.peff.net> (Jeff King's
 message of "Thu, 26 Jul 2012 09:03:49 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C570620E-D73F-11E1-9C13-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202274>

Jeff King <peff@peff.net> writes:

> On Thu, Jul 26, 2012 at 02:27:52PM +0800, Jiang Xin wrote:
> ...
>> not ok - 21 committer is automatic
>> #
>> #
>> #               echo >>negative &&
>> #               (
>> #                       sane_unset GIT_COMMITTER_EMAIL &&
>> #                       sane_unset GIT_COMMITTER_NAME &&
>> #                       # must fail because there is no change
>> #                       test_must_fail git commit -e -m "sample"
>> #               ) &&
>> #               head -n 8 .git/COMMIT_EDITMSG | \
>> #               sed "s/^# Committer: .*/# Committer:/" >actual
>> #               test_i18ncmp expect actual
>> #
>
> Hmm. It doesn't fail here, but that is probably because I have my name
> set properly in /etc/passwd. I think the test is bogus, though. From the
> results you report:
>
>> Contents of file expect:
>> 
>>     sample
>> 
>>     # Please enter the commit message for your changes. Lines starting
>>     # with '#' will be ignored, and an empty message aborts the commit.
>>     #
>>     # Author:    A U Thor <author@example.com>
>>     # Committer:
>>     #
>> 
>> Contents of file actual:
>> 
>>     sample
>
> The test is expecting us to write out the commit template for the user
> to edit. But the whole point of f20f387 is to fail early, before we ask
> the user to edit the template. So the test is trying to check that we
> wrote _something_ into the Committer field, even though that something
> would not necessarily be used to make the commit object (because the
> code path for the commit object is going to be much stricter).
>
> I am not sure that the test is really all that useful. The point seems
> to be that we fall back to some kind of system-based ident, but that is
> not portable.

I think the point is to make sure that the "# Committer:" line is
given to the reader to remind that we took the codepath that comes
up with a committer ident by using untrustworthy heuristics.  You
are correct that the usefulness of the value of system-based ident
varies between systems (that is why it is stripped out with sed),
though.

You earlier gave a reason why f20f387 (commit: check committer identity
more strictly, 2012-07-23) does not have a test for it; I think the
same reason applies why this test is unworkable.

A related tangent; all the test vectors in this script seems to be
too wide, and we probably would want to narrow them for what each
test wants to see.  For example, the test in question only wants to
see "# Committer: <some system based ident>" and it does not matter
if the template was rewritten in future versions of Git so that it
does not begin with "# Please enter...".  Similarly, the one
previous only wants to see "# Author: <different from committer>".
