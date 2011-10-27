From: =?ISO-8859-1?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH] git grep: be careful to use mutices only when they are
 initialized
Date: Thu, 27 Oct 2011 17:27:04 +0200
Message-ID: <4EA97848.9080008@lsrfire.ath.cx>
References: <alpine.DEB.1.00.1110251223500.32316@s15462909.onlinehome-server.info> <7v39ef34in.fsf@alter.siamese.dyndns.org> <7vmxcn1pob.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	msysgit@googlegroups.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Oct 27 17:27:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RJRrX-0006Dw-L7
	for gcvg-git-2@lo.gmane.org; Thu, 27 Oct 2011 17:27:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752509Ab1J0P1S convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 27 Oct 2011 11:27:18 -0400
Received: from india601.server4you.de ([85.25.151.105]:60392 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752251Ab1J0P1S (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Oct 2011 11:27:18 -0400
Received: from [192.168.2.104] (p4FFDAB8C.dip.t-dialin.net [79.253.171.140])
	by india601.server4you.de (Postfix) with ESMTPSA id 83CA32F8034;
	Thu, 27 Oct 2011 17:27:16 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:7.0.1) Gecko/20110929 Thunderbird/7.0.1
In-Reply-To: <7vmxcn1pob.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184296>

Am 26.10.2011 22:08, schrieb Junio C Hamano:
> Junio C Hamano <gitster@pobox.com> writes:
>=20
>> The remainder of this message are hints and random thoughts on poten=
tial
>> follow-up patches that may want to build on top of this patch for fu=
rther
>> clean-ups (not specifically meant for Dscho but for other people on =
both
>> mailing lists).
>> ...
>>  - Could we lose "#ifndef NO_PTHREADS" inside grep_sha1(), grep_file=
(),
>>    and possibly cmd_grep() functions and let the compiler optimize t=
hings
>>    away under NO_PTHREADS compilation?
>=20
> I suspect that the result of the conversion would look a lot cleaner =
if
> the code is first cleaned up to move global variable like skip_first_=
line
> and the mutexes into the grep_opt structure. Without such clean-up, I=
 do
> not think a conversion like this does not add much value.

Each thread get its own copy of the grep_opt struct, but the mutexes an=
d
also skip_first_line must not be duplicated.  They could be moved into =
a
new struct that is pointed to by grep_opt, but I'm not sure it's a win.

Ren=E9
