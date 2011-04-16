From: Junio C Hamano <gitster@pobox.com>
Subject: Re: textconv not invoked when viewing merge commit
Date: Fri, 15 Apr 2011 23:10:44 -0700
Message-ID: <7v39lid8uz.fsf@alter.siamese.dyndns.org>
References: <201104111912.47547.kumbayo84@arcor.de>
 <4DA415AB.9020008@drmicha.warpmail.net>
 <20110414190901.GA1184@sigill.intra.peff.net>
 <7vipughbxh.fsf@alter.siamese.dyndns.org>
 <7vd3kohb5n.fsf@alter.siamese.dyndns.org>
 <7v8vvcha2s.fsf@alter.siamese.dyndns.org>
 <20110414202356.GB6525@sigill.intra.peff.net>
 <vpq62qg3sxy.fsf@bauges.imag.fr> <7v7havckgg.fsf@alter.siamese.dyndns.org>
 <20110416014758.GB23306@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Peter Oberndorfer <kumbayo84@arcor.de>,
	Git List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Apr 16 08:11:08 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QAyip-0007JZ-5C
	for gcvg-git-2@lo.gmane.org; Sat, 16 Apr 2011 08:11:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751122Ab1DPGLB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Apr 2011 02:11:01 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:52948 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750821Ab1DPGLA (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Apr 2011 02:11:00 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 85EE329E6;
	Sat, 16 Apr 2011 02:12:57 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=yPefdJ9qgZTxy1W0cD7d2hZIv2A=; b=U7LUPk
	drlO9jJ6eCzjyrT71ryGlxycEmC2tuokPJX0pjKwAn1ymYlAsIRxH+U3qFhkwJIo
	3XZy3G5Cgw04XZ24DjgWvXrsU1uYU059cJbG93glc6dIltW0kYH92X7m5fXZwxDU
	dhcp4UogFUSbmo9D0mPN+AQ9c7yG4rb9XiJPQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=u/TXmH6uIXREZ4jmK9K+ZfnIly9+zTbF
	D/yUqv4Baokn8iCdtv0V2d9JcffQjdenFdTOtRsZhCo/fdE4/Z6M05xXA7i+j/mb
	uRYlOT0Y6DMxJC2TLuXcy0EmWkjSw/1tw1EIbAmE9ikza+Sj/JO0edu97Lj1LQ6D
	CquFVjejX0o=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 3014C29E5;
	Sat, 16 Apr 2011 02:12:52 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 73AD729E4; Sat, 16 Apr 2011
 02:12:45 -0400 (EDT)
In-Reply-To: <20110416014758.GB23306@sigill.intra.peff.net> (Jeff King's
 message of "Fri, 15 Apr 2011 21:47:59 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8FA8F330-67F0-11E0-B641-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171659>

Jeff King <peff@peff.net> writes:

>> > Well, I know no tool parsing combined diff actually, so it's indeed a
>> > hypothetical case.
>> 
>> And the ones that have been parsing cdiff wouldn't have done anything good
>> before this change on such a binary blob anyway, no?
>
> No, but we can view the proposed change as fixing a bug for such a tool
> Whereas turning it into:
>
>   --Binary blob XXX
>   + Binary blob YYY
>    +Binary blob ZZZ
>
> is codifying ambiguous output, and making the tool forever broken.

Of course, if we did this for a plumbing command and when the user did not
ask for --textconv, I would agree with your argument.  Such an output
makes it impossible to tell between the text files that had these lines
and binary files.

What I am suggesting is to make any binary file use a fallback textconv
"Binary blob $SHA-1", when the --textconv option is given from the command
line and no textconv filter is configured for the path, in any textconv
aware commands consistently, not limited to -c/--cc under discussion.

With the current codebase, such a change *would* break a bog-standard,
two-way "git diff" for a binary file; we do want to see the traditional
"Binary files differ" by not using the fallback textconv, but we cannot
tell if the --textconv option was explicitly given from the command line
with the test used in Michael's patch (i.e. ALLOW_TEXTCONV), because we
set the bit by default for Porcelain commands.  And showing "-Binary X"
followed by "-Binary Y" is simply wrong and ambiguous, of course, in such
a case.  We need to be able to tell if an explicit --textconv was given or
we have ALLOW_TEXTCONV merely because we are running a Porcelain.

But I suspect that isn't something we cannot fix---we can just use another
bit to record that in the command line parser.

Once that is fixed, I don't think giving "Binary files differ" when the
line-counter script reads from a plumbing command that was invoked
explicitly with the --textconv command is any better than giving the above
three lines.  For a two-way merge, it does not matter much, but when
viewing a merge with three or more parents, -c/--cc output that shows
which sets of parents had the same blobs would be useful for humans (and
tools) than a single "Binary files differ" output that does not tell any
details.  The line-counter script would be counting "forever broken" data
when you feed your JPEG collection with exif extracting textconv filter
anyway, and I do not necessarily think it would make things worse to give
a fallback textconv filter to binary files that do not have one defined.
