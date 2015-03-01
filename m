From: Junio C Hamano <gitster@pobox.com>
Subject: Re: feature request: excluding files/paths from "git grep"
Date: Sat, 28 Feb 2015 19:06:16 -0800
Message-ID: <xmqqvbilh0wn.fsf@gitster.dls.corp.google.com>
References: <54EDBEC2.8090107@peralex.com>
	<CACsJy8AM=W4f6u_7YpvmfiBwrJjqfJMJoq6CQYfKOh+qD6rF3Q@mail.gmail.com>
	<20150225143116.GA13567@peff.net>
	<xmqqk2z5on72.fsf@gitster.dls.corp.google.com>
	<20150225185128.GA16569@peff.net>
	<xmqqbnkholx9.fsf@gitster.dls.corp.google.com>
	<20150225191108.GA17467@peff.net>
	<20150227100441.GA11861@tsaunders-iceball.corp.tor1.mozilla.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>, Duy Nguyen <pclouds@gmail.com>,
	Noel Grandin <noel@peralex.com>, git <git@vger.kernel.org>
To: Trevor Saunders <tbsaunde@tbsaunde.org>
X-From: git-owner@vger.kernel.org Sun Mar 01 04:06:28 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YRuD5-00061b-CT
	for gcvg-git-2@plane.gmane.org; Sun, 01 Mar 2015 04:06:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752861AbbCADGT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Feb 2015 22:06:19 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:60124 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752462AbbCADGS (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Feb 2015 22:06:18 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id BEAAF3C47C;
	Sat, 28 Feb 2015 22:06:17 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=1WjqoQaEqlv3Q4KVdWO0X1BEx2M=; b=SKwGrkaW38fi10H0GwI7
	H+gkl0wI5rfql5wYnpTb0m1qfp+gfc/8CZPBWnVBOyg5ppOajLj2/3omwSPgntvn
	uvEyxeyX4wHQXjT4VJCUMLrAuLqfdcorhk6A5Fk5q7NK9PoMSRRU5ntvqeaH8D3Y
	ZAjBZJ6RsBNLjLO1O/2g/94=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=oVWAxvgCX64NUnmrcycNevBuv2fKQH+eqhJN4zmNxKN7Fq
	UrmOlK/qQTfcUMnxObi4JlhOJYwNXJRGjh1TfcWtcl6TzXH40R5nS8YeHTucrVe7
	M2M7dR3EwIHKznhf+rTQTVK3xIKfAk5+DFz8jXfIHAOEHPImIrRTh4Sn+GIVw=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id B4DCD3C47A;
	Sat, 28 Feb 2015 22:06:17 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 30A5E3C479;
	Sat, 28 Feb 2015 22:06:17 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: ED7EE7D2-BFBF-11E4-9FEF-29999F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264545>

Trevor Saunders <tbsaunde@tbsaunde.org> writes:

>  There have been cases where I wanted grep to always ignore certain
>  files, but to still get text diffs for those files.  One case is people
>  insist on using ChangeLog files, and another is people who commit
>  generated files of one sort or another.

The attributes are to say "the contents to be stored in this file is
of this nature".  Something inherent to the type of the contents,
and that is why there is no way to countermand them from the command
line.

The "nature of the content" may be "result of comparing two versions
of them textually will never make sense to humans", or "result of
finding substrings in them will never make sense to humans", which
are what "-diff" and hypothetical "-grep" mean, respectively.

"It is inconvenient that I see hits in ChangeLog files when I look
for string BUG" does not make ChangeLog inherently "result of
finding substrings in it never makes sense to humans"-kind of file
type.  Maybe somebody who is playing a role of a coder right now may
not look at existing ChangeLog entries, but when that same person
plays the role of a release manager next day, running grep on older
ChangeLog files may become necessary to find changes related to
recent changes.  For these "per-invocation" differences, attributes
to declare permenent/inherent nature of the contents is much less
suited than per-invocation inclusion/exclusion mechanism based on
pathspecs, I would think.
