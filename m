From: Ted Zlatanov <tzz@lifelogs.com>
Subject: Re: [PATCHv6] Add contrib/credentials/netrc with GPG support
Date: Mon, 25 Feb 2013 11:24:02 -0500
Organization: =?utf-8?B?0KLQtdC+0LTQvtGAINCX0LvQsNGC0LDQvdC+0LI=?= @
 Cienfuegos
Message-ID: <87621guztp.fsf@lifelogs.com>
References: <87ehgvua6h.fsf@lifelogs.com>
	<20130204211726.GB13186@sigill.intra.peff.net>
	<87mwvjsqjc.fsf_-_@lifelogs.com>
	<7vvca6u47f.fsf@alter.siamese.dyndns.org>
	<87k3qmr8yc.fsf@lifelogs.com>
	<7vhalqsfkf.fsf@alter.siamese.dyndns.org>
	<8738xaqy40.fsf_-_@lifelogs.com>
	<7vip66qu0u.fsf@alter.siamese.dyndns.org>
	<7vtxpqnwiv.fsf@alter.siamese.dyndns.org>
	<876226p97h.fsf_-_@lifelogs.com>
	<20130208061855.GA11892@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Feb 25 17:24:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UA0qt-0005g0-11
	for gcvg-git-2@plane.gmane.org; Mon, 25 Feb 2013 17:24:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751424Ab3BYQYH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Feb 2013 11:24:07 -0500
Received: from z.lifelogs.com ([173.255.230.239]:47053 "EHLO z.lifelogs.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750963Ab3BYQYE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Feb 2013 11:24:04 -0500
Received: from heechee (c-65-96-148-157.hsd1.ma.comcast.net [65.96.148.157])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: tzz)
	by z.lifelogs.com (Postfix) with ESMTPSA id DAEDE205FF;
	Mon, 25 Feb 2013 16:24:02 +0000 (UTC)
X-Face: bd.DQ~'29fIs`T_%O%C\g%6jW)yi[zuz6;d4V0`@y-~$#3P_Ng{@m+e4o<4P'#(_GJQ%TT= D}[Ep*b!\e,fBZ'j_+#"Ps?s2!4H2-Y"sx"
In-Reply-To: <20130208061855.GA11892@sigill.intra.peff.net> (Jeff King's
	message of "Fri, 8 Feb 2013 01:18:55 -0500")
User-Agent: Gnus/5.130006 (Ma Gnus v0.6) Emacs/24.3.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217063>

On Fri, 8 Feb 2013 01:18:55 -0500 Jeff King <peff@peff.net> wrote: 

>> +	# the following check is copied from Net::Netrc, for non-GPG files
>> +	# OS/2 and Win32 do not handle stat in a way compatable with this check :-(

JK> s/compatable/compatible/

This is from the Net::Netrc module.  Fixed in my commit but eh...

JK> You mention os/2 and Win32 here, but the check has more:

>> +	unless ($gpgmode || $options{insecure} ||
>> +		$^O eq 'os2'
>> +		|| $^O eq 'MSWin32'
>> +		|| $^O eq 'MacOS'
>> +		|| $^O =~ /^cygwin/) {

JK> Does MacOS really not handle stat? Or is this old MacOS, not OS X?

This is all out of Net::Netrc, and yes, it's pre-Mac OS X.  I think it's
safe to leave as is, but I can remove OS/2 and MacOS if you prefer.

JK> So this will convert:
JK>   machine foo port smtp
JK> in the netrc into (protocol => "smtp", host => "foo"), but:
JK>   machine foo port 25
JK> into (protocol => undef, host => "foo:25"), right? That makes sense to
JK> me.

Yes.  test.pl checks that host=foo doesn't find the above, as well.

JK> I don't know if you want to take the hit of relying on Git.pm (it is
JK> nice for the helper to be totally standalone and copy-able), but one
JK> obvious possible refactor would be to use the credential read/write
JK> functions recently added there. I'm OK with not doing that, though.

JK> It may also be worth building on top of the regular git test harness.
JK> It's more work, but the resulting code (and the output) will be much
JK> more readable.

At least for now let's leave it standalone.  When and if it moves into
the core, we can change it to use the core's Git.pm and test suite.  The
code and the tests are small enough that I think using Perl's Test
module makes the most sense right now.

JK> Printf? Bleh, isn't this supposed to be perl? :P

What?  Was I supposed to use formats?!?!

JK> You are depending on whatever the user has in their ~/.netrc, no?
JK> Wouldn't it make more sense to ship a sample netrc and run all of the
JK> tests with "-f netrc.example"?

Yes.  See test.netrc.

Thanks
Ted
