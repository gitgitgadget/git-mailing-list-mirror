From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v2 4/4] upload-archive: use start_command instead of fork
Date: Mon, 01 Aug 2011 23:20:52 +0200
Message-ID: <4E3718B4.6090803@kdbg.org>
References: <1311012516-4836-1-git-send-email-kusmabite@gmail.com> <1311012516-4836-5-git-send-email-kusmabite@gmail.com> <7vmxga7zb9.fsf@alter.siamese.dyndns.org> <CABPQNSYtpRpNQVW=QvyfFhmWge5-C+k85bs2EJeK8k0jdfHzrw@mail.gmail.com> <20110728160845.GA14337@sigill.intra.peff.net> <20110728164758.GA15931@sigill.intra.peff.net> <20110728170222.GB15931@sigill.intra.peff.net> <CABPQNSaqyD+rhWPRbtVdnkweuXSycBahKEsasGZkEg3mi4SaxQ@mail.gmail.com> <20110801174603.GB10302@sigill.intra.peff.net> <CABPQNSbyp2hEgXvzo3bMHHxrbc9fQLqaABweqfjP7xQzBUdj6A@mail.gmail.com> <20110801182516.GC10302@sigill.intra.peff.net> <4E371109.7050500@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, Erik Faye-Lund <kusmabite@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Mon Aug 01 23:21:00 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qnzv2-0003AA-Ax
	for gcvg-git-2@lo.gmane.org; Mon, 01 Aug 2011 23:21:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752892Ab1HAVU4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 1 Aug 2011 17:20:56 -0400
Received: from bsmtp4.bon.at ([195.3.86.186]:47273 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752464Ab1HAVUz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Aug 2011 17:20:55 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 25D4D1000F;
	Mon,  1 Aug 2011 23:20:52 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id D0B3219F43D;
	Mon,  1 Aug 2011 23:20:52 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; de; rv:1.9.2.18) Gecko/20110616 SUSE/3.1.11 Thunderbird/3.1.11
In-Reply-To: <4E371109.7050500@lsrfire.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178417>

Am 01.08.2011 22:48, schrieb Ren=C3=A9 Scharfe:
> So git archive gives the right results when writing to a pipe, but
> always the same wrong result when writing directly to a file.

This could indeed be a CRLF issue. archive-tar.c runs gzip to let it
write to the original fd 1 (stdout). gzip is an MSYS program, and MSYS
is "clever" and sets up the channel in text mode (CRLF conversion) if i=
t
is a regular file, but in binary mode if it is a pipe.

Without the gzip filter, git-archive writes to stdout itself. Since we
have set up all our channels in binary mode, we do not suffer from the
same problem for plain tar format.

So, I don't think we can do a lot about it, short of patching MSYS agai=
n...

-- Hannes
