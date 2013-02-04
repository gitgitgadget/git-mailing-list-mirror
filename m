From: Ted Zlatanov <tzz@lifelogs.com>
Subject: Re: [PATCH] git-send-email: add ~/.authinfo parsing
Date: Mon, 04 Feb 2013 16:08:52 -0500
Organization: =?utf-8?B?0KLQtdC+0LTQvtGAINCX0LvQsNGC0LDQvdC+0LI=?= @
 Cienfuegos
Message-ID: <8738xbu6qj.fsf@lifelogs.com>
References: <2f93ce7b6b5d3f6c6d1b99958330601a5560d4ba.1359486391.git.mina86@mina86.com>
	<7vvcafojf4.fsf@alter.siamese.dyndns.org>
	<20130130074306.GA17868@sigill.intra.peff.net>
	<xa1tmwvk9gy1.fsf@mina86.com> <878v74vwst.fsf@lifelogs.com>
	<20130204201040.GA13272@sigill.intra.peff.net>
	<87a9rju8l7.fsf@lifelogs.com>
	<20130204205911.GA13186@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Michal Nazarewicz <mina86@mina86.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Krzysztof Mazur <krzysiek@podlesie.net>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Feb 04 22:09:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U2THx-0007qj-8V
	for gcvg-git-2@plane.gmane.org; Mon, 04 Feb 2013 22:09:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755017Ab3BDVIy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Feb 2013 16:08:54 -0500
Received: from z.lifelogs.com ([173.255.230.239]:40313 "EHLO z.lifelogs.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754954Ab3BDVIy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Feb 2013 16:08:54 -0500
Received: from heechee (c-65-96-148-157.hsd1.ma.comcast.net [65.96.148.157])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: tzz)
	by z.lifelogs.com (Postfix) with ESMTPSA id EFA4ADE0CA;
	Mon,  4 Feb 2013 21:08:52 +0000 (UTC)
X-Face: bd.DQ~'29fIs`T_%O%C\g%6jW)yi[zuz6;d4V0`@y-~$#3P_Ng{@m+e4o<4P'#(_GJQ%TT= D}[Ep*b!\e,fBZ'j_+#"Ps?s2!4H2-Y"sx"
In-Reply-To: <20130204205911.GA13186@sigill.intra.peff.net> (Jeff King's
	message of "Mon, 4 Feb 2013 15:59:11 -0500")
User-Agent: Gnus/5.130006 (Ma Gnus v0.6) Emacs/24.3.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215420>

On Mon, 4 Feb 2013 15:59:11 -0500 Jeff King <peff@peff.net> wrote: 

JK> On Mon, Feb 04, 2013 at 03:28:52PM -0500, Ted Zlatanov wrote:
JK> You might want to map this to "port" in .autoinfo separately if it's
JK> available.
>> 
>> That would create the following possibilities:
>> 
>> * host example.com:31337, protocol https
>> * host example.com:31337, protocol unspecified
>> * host example.com, protocol https
>> * host example.com, protocol unspecified

JK> Possibilities for .netrc, or for git? Git will always specify the
JK> protocol.

Possibilities for the netrc data.  How clever do we want to be with
taking 31337 and mapping it to the "protocol"?  My preference is to be
very simple here.

JK> What I was more wondering (and I know very little about .netrc, so this
JK> might not be a possibility at all) is a line like:

JK>   host example.com port 5001 protocol https username foo password bar

JK> To match git's representation on a token-by-token basis, you would have
JK> to either split out git's "host:port" pair, or combine the .netrc's
JK> representation to "example.com:5001".

Currently, we map both the "port" and "protocol" netrc tokens to the
credential helper protocol's "protocol".  So this will have undefined
results.  To do what you specify could be pretty simple: we could do a
preliminary scan of the tokens, looking for "host X port Y" where Y is
an integer, and rewriting the host to be "X:Y".  That would be clean and
simple, unless the user breaks it with "host x:23 port 22".  Let me know
if you agree and I'll do.

Ted
