From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] commit: make default of "cleanup" option configurable
Date: Wed, 09 Jan 2013 07:56:59 -0800
Message-ID: <7vhamq8i44.fsf@alter.siamese.dyndns.org>
References: <1357676176-30019-1-git-send-email-ralf.thielow@gmail.com>
 <20130109072952.GC6503@elie.Belkin>
 <CAN0XMO+t2gu9UKJFVXAxt91-hUUhMqqmMoop88KYp0vo3x6c_g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
To: Ralf Thielow <ralf.thielow@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 09 16:57:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tsy1s-0002jk-R3
	for gcvg-git-2@plane.gmane.org; Wed, 09 Jan 2013 16:57:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932086Ab3AIP5E (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Jan 2013 10:57:04 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44025 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757857Ab3AIP5C (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jan 2013 10:57:02 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2C4FCA53B;
	Wed,  9 Jan 2013 10:57:02 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=SaksPFU7a7m5T31Cbf9iWVIvBvE=; b=Do27t0
	3eEEWBstE2jXWuB03HxQf0yuwkxwnR5kkolXSXMDHoPnGNLqiWJzGzNtcfHVmD7r
	lK2lJipYiJF0M6XgpEClTkELn1FIFv1VTXAOnf9Kz2k1csZwhZhIEqzcFWrSWC1S
	YmJ2ySe3Lv5Bmun8E9lPs9y8OKKTLwNQE22qk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=EXG5BQvjdhL7C/N4dJ9A0FftEOHb3SBl
	WEkVPzvvAoR0EzNCrw3UnFrl4RQQfv1U9wjgL00AK8U8y9Y42LYp7JHCkPIa5Uww
	Q8igCMAJ9BY4c+TSGol6GLFxV2PlFJk/rx0FKawihgBElhRfm5e5IHlzrNTkH2W7
	TwB6SiuSi/o=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 20D9AA538;
	Wed,  9 Jan 2013 10:57:02 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 880BFA532; Wed,  9 Jan 2013
 10:57:01 -0500 (EST)
In-Reply-To: <CAN0XMO+t2gu9UKJFVXAxt91-hUUhMqqmMoop88KYp0vo3x6c_g@mail.gmail.com> (Ralf
 Thielow's message of "Wed, 9 Jan 2013 09:16:17 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 34A855E2-5A75-11E2-9D62-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213064>

Ralf Thielow <ralf.thielow@gmail.com> writes:

> It's actually my own usecase :). The bugtracker I'm using is able
> to create relationships between issues and related commits. It
> expects that a part of the commit message contains the issue number
> in format "#<issueId>". So I need to use a cleanup mode different
> from "default" to keep the commentary.

This is orthogonal to the patch in question, but in your particular
case, I wonder if it is a workable solution to indent #<bugid> in
your message, which won't be stripped away.

I also wonder, as a longer term alternative (which would require a
lot of code auditing and some refactoring), if it is useful to have
an option and/or configuration that lets you configure the "comment
in log message editor" character from the default "#" to something
else.  "git -c log.commentchar=% commit" may start the log message
editor with something like this in it:

    % Please enter the commit message for your changes. Lines starting
    % with '%' will be ignored, and an empty message aborts the commit.

Naturally, setting log.commentchar to "none" would disable stripping
of any commented lines if such a feature existed, and stop issuing
these helpful comments altogether, but still strip excess blank
lines and trailing whitespaces.

I wouldn't seriously suggest it as I am not sure if the usefulness
of such a feature would outweigh the cost of coding it, though; at
least not at this point yet.
