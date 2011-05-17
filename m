From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH 1/3] connect: treat generic proxy processes like ssh processes
Date: Tue, 17 May 2011 22:14:43 +0200
Message-ID: <4DD2D733.3070004@kdbg.org>
References: <20110516063944.GB25731@sigill.intra.peff.net> <20110516064607.GA19078@sigill.intra.peff.net> <4DD181C6.4020104@kdbg.org> <20110517055422.GD10048@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Johan Herland <johan@herland.net>,
	Junio C Hamano <gitster@pobox.com>,
	Shawn Pearce <spearce@spearce.org>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue May 17 22:14:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QMQfS-0005yy-AX
	for gcvg-git-2@lo.gmane.org; Tue, 17 May 2011 22:14:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932217Ab1EQUOw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 May 2011 16:14:52 -0400
Received: from bsmtp4.bon.at ([195.3.86.186]:40739 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S932112Ab1EQUOv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 May 2011 16:14:51 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id AAB9FA7EB0;
	Tue, 17 May 2011 22:10:44 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id 81C8819F3B8;
	Tue, 17 May 2011 22:14:44 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; de; rv:1.9.2.17) Gecko/20110414 SUSE/3.1.10 Thunderbird/3.1.10
In-Reply-To: <20110517055422.GD10048@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173822>

Am 17.05.2011 07:54, schrieb Jeff King:
> On Mon, May 16, 2011 at 09:57:58PM +0200, Johannes Sixt wrote:
>> In my implementation, I xmalloced the pointer array and leaked it.

I noticed that it actually isn't leaked because finish_connect() frees
it. For this reason, I actually have to wonder why your version that
stored a pointer to automatic storage in ->argv worked.

> We also need to worry about the contents of each argv[] element, no? So
> we should be xstrdup()ing the host and port, which point into some
> string which gets passed to us. I didn't trace its provenance but I
> think it is better to be defensive.

I would not worry too much today. Of course, functions other than
start_command() might begin to access ->argv[i] with i > 0 later, but
then we have to audit all users of struct child_process anyway.
Currently, only start_command() uses these values, which is always
called at a time when they are still valid.

-- Hannes
