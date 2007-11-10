From: =?ISO-8859-1?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH 2/2] --pretty=format: on-demand format expansion
Date: Sat, 10 Nov 2007 17:24:26 +0100
Message-ID: <4735DB3A.2020905@lsrfire.ath.cx>
References: <4733AEA6.1040802@lsrfire.ath.cx> <20071109045040.GC31760@sigill.intra.peff.net> <4734EA4E.8070405@lsrfire.ath.cx> <20071110004635.GA14992@sigill.intra.peff.net> <47359221.7090707@lsrfire.ath.cx> <Pine.LNX.4.64.0711101605560.4362@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Paul Mackerras <paulus@samba.org>,
	Git Mailing List <git@vger.kernel.org>,
	Pierre Habouzit <madcoder@debian.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Nov 10 17:25:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iqt8s-0003MQ-6U
	for gcvg-git-2@gmane.org; Sat, 10 Nov 2007 17:25:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751788AbXKJQYs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 10 Nov 2007 11:24:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751785AbXKJQYs
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Nov 2007 11:24:48 -0500
Received: from static-ip-217-172-187-230.inaddr.intergenia.de ([217.172.187.230]:37103
	"EHLO neapel230.server4you.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751715AbXKJQYr (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 10 Nov 2007 11:24:47 -0500
Received: from [10.0.1.201] (p57B7F8B8.dip.t-dialin.net [87.183.248.184])
	by neapel230.server4you.de (Postfix) with ESMTP id DD6D4873BA;
	Sat, 10 Nov 2007 17:24:45 +0100 (CET)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <Pine.LNX.4.64.0711101605560.4362@racer.site>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64357>

Johannes Schindelin schrieb:
> Hi,
>=20
> On Sat, 10 Nov 2007, Ren=E9 Scharfe wrote:
>=20
>> [...] have cooked up a different one on top of a cleaned up version =
of=20
>> mine.  It plays the dirty trick of reading expansions of repeated=20
>> placeholders from the strbuf..
>=20
> ... which would not work (likely even segfault) if you work with the =
same=20
> private data on different strbufs.
>=20
> But I guess it will not matter much in practice.

Only a single strbuf is used, and the function that copies the data
around, strbuf_adddup(), operates on a single strbuf, only.  Copying
data between two strbufs using strbuf_add() etc. would be safe.

What one should *not* do is this:

	strbuf_add(sb, sb->buf + offset, length);

This leads to problems when the buffer is realloc()ated by strbuf_add()=
=2E

What other things can go wrong?  A segfault would definitely matter..

Thanks,
Ren=E9
