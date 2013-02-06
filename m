From: Ted Zlatanov <tzz@lifelogs.com>
Subject: Re: [PATCH] git-send-email: add ~/.authinfo parsing
Date: Wed, 06 Feb 2013 09:47:08 -0500
Organization: =?utf-8?B?0KLQtdC+0LTQvtGAINCX0LvQsNGC0LDQvdC+0LI=?= @
 Cienfuegos
Message-ID: <87a9rho5xv.fsf@lifelogs.com>
References: <2f93ce7b6b5d3f6c6d1b99958330601a5560d4ba.1359486391.git.mina86@mina86.com>
	<7vvcafojf4.fsf@alter.siamese.dyndns.org>
	<20130130074306.GA17868@sigill.intra.peff.net>
	<7v6226pdb7.fsf@alter.siamese.dyndns.org>
	<xa1tpq0dpo89.fsf@mina86.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org, Krzysztof Mazur <krzysiek@podlesie.net>
To: Michal Nazarewicz <mina86@mina86.com>
X-From: git-owner@vger.kernel.org Wed Feb 06 15:47:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U36Hl-0000UJ-CW
	for gcvg-git-2@plane.gmane.org; Wed, 06 Feb 2013 15:47:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755730Ab3BFOrO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Feb 2013 09:47:14 -0500
Received: from z.lifelogs.com ([173.255.230.239]:49890 "EHLO z.lifelogs.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756515Ab3BFOrK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Feb 2013 09:47:10 -0500
Received: from heechee (c-65-96-148-157.hsd1.ma.comcast.net [65.96.148.157])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: tzz)
	by z.lifelogs.com (Postfix) with ESMTPSA id 738DBDE0E3;
	Wed,  6 Feb 2013 14:47:09 +0000 (UTC)
X-Face: bd.DQ~'29fIs`T_%O%C\g%6jW)yi[zuz6;d4V0`@y-~$#3P_Ng{@m+e4o<4P'#(_GJQ%TT= D}[Ep*b!\e,fBZ'j_+#"Ps?s2!4H2-Y"sx"
In-Reply-To: <xa1tpq0dpo89.fsf@mina86.com> (Michal Nazarewicz's message of
	"Wed, 06 Feb 2013 14:26:46 +0100")
User-Agent: Gnus/5.130006 (Ma Gnus v0.6) Emacs/24.3.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215578>

On Wed, 06 Feb 2013 14:26:46 +0100 Michal Nazarewicz <mina86@mina86.com> wrote: 

MN> On Wed, Feb 06 2013, Junio C Hamano <gitster@pobox.com> wrote:
>> I see a lot of rerolls on the credential helper front, but is there
>> anybody working on hooking send-email to the credential framework?

MN> I assumed someone had, but if not I can take a stab at it.  I'm not sure
MN> however how should I map server, server-port, and user to credential
MN> key-value pairs.  I'm leaning towards

MN> 	protocol=smtp
MN> 	host=<smtp-server>:<smtp-port>
MN> 	user=<user>

MN> and than netrc/authinfo helper splitting host to host name and port
MN> number, unless port is not in host in which case protocol is assumed as
MN> port.

That would work (with my PATCHv6 of the netrc credential helper) as
follows:

1) just host

host=H

maps to

machine H login Y password Z

2) host + protocol smtp

host=H
protocol=smtp

maps to any of:

machine H port smtp login Y password Z
machine H protocol smtp login Y password Z

3) host:port + protocol smtp

host=H:25
protocol=smtp

maps to any of:

machine H port 25 protocol smtp login Y password Z
machine H:25 port smtp login Y password Z
machine H:25 protocol smtp login Y password Z

That's my understanding of what we discussed with Peff and Junio about
token mapping.  Note we don't split the input host, but instead say "if
token 'port' is numeric, append it to the host token" on the netrc side.

Does that sound reasonable?  If yes, I can add it to the testing
Makefile for the netrc credential helper, to make sure it's clearly
stated and tested.

Ted
