From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] t9200: avoid grep on non-ASCII data
Date: Tue, 23 Feb 2016 14:55:11 -0800
Message-ID: <xmqqio1fxcj4.fsf@gitster.mtv.corp.google.com>
References: <20160219193310.GA1299@sigill.intra.peff.net>
	<cover.1456075680.git.john@keeping.me.uk>
	<42c95c23bffcbb526aaae302f80667867d164876.1456075680.git.john@keeping.me.uk>
	<CAPig+cQkcUPD5+0rUPkKCcJSzRC0NkuRYKHmW54eZ041PqaqmQ@mail.gmail.com>
	<20160221234345.GB14382@river.lan>
	<20160222222503.GD18522@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: John Keeping <john@keeping.me.uk>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Git List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Feb 23 23:55:23 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aYLrW-0007rD-6N
	for gcvg-git-2@plane.gmane.org; Tue, 23 Feb 2016 23:55:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755502AbcBWWzP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Feb 2016 17:55:15 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:52862 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755269AbcBWWzO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Feb 2016 17:55:14 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 725A248036;
	Tue, 23 Feb 2016 17:55:13 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=j+ob+wb8gqJjzG1Fsn7sPfjQQk4=; b=kMKxCf
	E4IRtpq7gce01b3Cz3E0S9sNRSHsR3CHkWLutyfk2715Bw/km+tFWTJN2vT7/O0W
	QqVucLHnJ6WceI4qsVY7gPROifvuJ1wPpvsyvRtvQAucFfxbZtyoAxDUi8CRnTEl
	APIwRfT0awiHqO0EYV5w1I8J9SZSVyb+NcS90=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=XhaAXuyFdrFb6RMpz/XgZppm2/qqt7Rw
	hzwWcuUgtVxsNFU6P1GD8nsI129vWIk8GDN0ddqcHYAcndWWQ+GKonVrKsuLjDr8
	MXyfh3IgFPIlziyHhoEFJkEuiXbwjeCnPzongsKDMN0ERpyzm52p0qAn4um3dDZ0
	4soKPe3TOC8=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 5C68D48035;
	Tue, 23 Feb 2016 17:55:13 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id B49C748034;
	Tue, 23 Feb 2016 17:55:12 -0500 (EST)
In-Reply-To: <20160222222503.GD18522@sigill.intra.peff.net> (Jeff King's
	message of "Mon, 22 Feb 2016 17:25:04 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 7F16CEAE-DA80-11E5-9E65-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287136>

Jeff King <peff@peff.net> writes:

> On Sun, Feb 21, 2016 at 11:43:45PM +0000, John Keeping wrote:
>
>> On Sun, Feb 21, 2016 at 04:15:31PM -0500, Eric Sunshine wrote:
>> > On Sun, Feb 21, 2016 at 12:32 PM, John Keeping <john@keeping.me.uk> wrote:
>> > > GNU grep 2.23 detects the input used in this test as binary data so it
>> > > does not work for extracting lines from a file.  We could add the "-a"
>> > > option to force grep to treat the input as text, but not all
>> > > implementations support that.  Instead, use sed to extract the desired
>> > > lines since it will always treat its input as text.
>> > >
>> > > Signed-off-by: John Keeping <john@keeping.me.uk>
>> > > ---
>> > > diff --git a/t/t9200-git-cvsexportcommit.sh b/t/t9200-git-cvsexportcommit.sh
>> > > @@ -35,7 +35,7 @@ exit 1
>> > >  check_entries () {
>> > >         # $1 == directory, $2 == expected
>> > > -       grep '^/' "$1/CVS/Entries" | sort | cut -d/ -f2,3,5 >actual
>> > > +       sed -ne '\!^/!p' "$1/CVS/Entries" | sort | cut -d/ -f2,3,5 >actual
>> > 
>> > This works with BSD sed, but double negatives are confusing. Have you
>> > considered this instead?
>> > 
>> >     sed -ne '/^\//p' ...
>> 
>> What do you mean double negatives?  Do you mean using "!" as an
>> alternative delimiter?  I find changing delimters is normally simpler
>> than following multiple levels of quoting for escaping slashes, although
>> in this case it's simple enough that it doesn't make much difference.
>
> I agree that changing delimiters is much nicer than backslashes. But I
> wonder if using "!" is more confusing than it needs to be, given its
> other meanings.
>
> I dunno. I admit that the backslash threw me off, too (since it needs
> escaped in interactive shells, I first assumed that's what was going
> on). Using backslash to select the delimiter was new to me. I've usually
> seen:
>
>   s!/foo/!/bar/!
>
> which is arguably a little more clear. Too bad we cannot do:
>
>   m!/foo!
>
> which I think reads better. Oh well. Maybe:
>
>   sed -ne '\#^/#p'
>
> would be more readable, but I'm just bikeshedding at this point.  The
> grep invocation really was the most clear. :-/

Eric's '/^\//' was the most straight-forward and easiest to see what
is going on, I would think.
