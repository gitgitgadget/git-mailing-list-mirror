From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 0/2] Make git-svn work with gitdir links
Date: Sun, 20 Jan 2013 17:50:25 -0800
Message-ID: <7vwqv7i9su.fsf@alter.siamese.dyndns.org>
References: <20120308005103.GA27398@dcvr.yhbt.net>
 <1358731322-44600-1-git-send-email-barry.wardell@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Eric Wong <normalperson@yhbt.net>,
	Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>
To: Barry Wardell <barry.wardell@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 21 02:50:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tx6XC-0003Kg-5R
	for gcvg-git-2@plane.gmane.org; Mon, 21 Jan 2013 02:50:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752615Ab3AUBu2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Jan 2013 20:50:28 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60923 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752528Ab3AUBu2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Jan 2013 20:50:28 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6A4CEB795;
	Sun, 20 Jan 2013 20:50:27 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=RECOTCyvrM/C8cWmGysbargOTD8=; b=wvIhYP
	cj9MgegTZZrLDZyMV6oZGqBwLU+nZ3wZFrRzf9fwO+R1hXfEQYdG3x7rOkqwbZOZ
	exH9mF2t2wEIfe9yTFXQi7E8HCBORBd6QDg6/SpF9FVEcU3H9kh+4MywgmLKKi9N
	20WH0jYec+K/2kaF8uMVqIIVgZIwASJ5T6i84=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=kcOg6Wk+3Rt5/EJLWbM8KJVOoVLesmY/
	z+PfXvJObdmbeGTo0qe7IpQl24VT6o11Zw3TYklQ0mrGQFv2i8kbXAIpxwJIE8x1
	Dea/Vtl5rw94r1LTtLSLZIUOVRhwdef+i+r5OFiA4tjJ8ljCfN+hwx/lzvS8um40
	mY7DSyplfI4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5E8C0B794;
	Sun, 20 Jan 2013 20:50:27 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E20F4B793; Sun, 20 Jan 2013
 20:50:26 -0500 (EST)
In-Reply-To: <1358731322-44600-1-git-send-email-barry.wardell@gmail.com>
 (Barry Wardell's message of "Mon, 21 Jan 2013 01:22:00 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: EDA7AC82-636C-11E2-8969-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214072>

Barry Wardell <barry.wardell@gmail.com> writes:

> These patches fix a bug which prevented git-svn from working with repositories
> which use gitdir links.
>
> Changes since v2:
>  - Rebased onto latest master.
>  - Added test case which verifies that the problem has been fixed.
>  - Fixed problems with git svn (init|clone|multi-init).
>  - All git-svn test cases now pass (except two in t9101 which also failed
>    before these patches).
>
> Barry Wardell (2):
>   git-svn: Add test for git-svn repositories with a gitdir link
>   git-svn: Simplify calculation of GIT_DIR

Thanks for your persistence ;-) As this is a pretty old topic, I'll
give two URLs for people who are interested to view the previous
threads:

    http://thread.gmane.org/gmane.comp.version-control.git/192133
    http://thread.gmane.org/gmane.comp.version-control.git/192127

You would want to mark it as test_expect_failure in the first patch
and then flip it to text_expect_success in the second patch where
you fix the breakage?  Otherwise, after applying the first patch,
the testsuite will break needlessly.

I've Cc'ed Eric Wong (git-svn maintainer) and CMN who helped in the
previous round.  If the only issue is the above success/failure one,
I think Eric can tweak the patches while applying them (I didn't
look at the changes carefully myself, by the way).

Thanks.
