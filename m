From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] pretty=format: Avoid some expensive calculations when not needed
Date: Mon, 05 Nov 2007 17:06:25 -0800
Message-ID: <7vejf4kwry.fsf@gitster.siamese.dyndns.org>
References: <Pine.LNX.4.64.0711041912190.4362@racer.site>
	<Pine.LNX.4.64.0711041915290.4362@racer.site>
	<7v8x5cqxn0.fsf@gitster.siamese.dyndns.org>
	<472F7B2F.4050608@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Tue Nov 06 02:06:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IpCu2-0005DN-Uu
	for gcvg-git-2@gmane.org; Tue, 06 Nov 2007 02:06:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755101AbXKFBGh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 5 Nov 2007 20:06:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755093AbXKFBGh
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Nov 2007 20:06:37 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:33257 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755066AbXKFBGg convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 5 Nov 2007 20:06:36 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 0BE0B2F2;
	Mon,  5 Nov 2007 20:06:58 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 8C0BE9296A;
	Mon,  5 Nov 2007 20:06:54 -0500 (EST)
In-Reply-To: <472F7B2F.4050608@lsrfire.ath.cx> (=?utf-8?Q?Ren=C3=A9?=
 Scharfe's message of
	"Mon, 05 Nov 2007 21:21:03 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63606>

Ren=C3=A9 Scharfe <rene.scharfe@lsrfire.ath.cx> writes:

> Junio C Hamano schrieb:
> ...
>> Instead of allocating a separate array and freeing at the end,
>> wouldn't it make more sense to have a bitfield that records what
>> is used by the format string inside the array elements?
>
> How about (ab)using the value field?  Let interp_find_active() mark
> unneeded entries with NULL, and the rest with some cookie.  All table
> entries with non-NULL values need to be initialized.  interp_set_entr=
y()
> needs to be aware of this cookie, as it mustn't free() it.  The cooki=
e
> could be the address of a static char* in interpolate.c.

Sorry, where is this aversion to making the struct a bit larger
coming from?
