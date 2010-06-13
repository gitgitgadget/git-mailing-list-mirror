From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH] send-email: ask about and declare 8bit mails
Date: Sun, 13 Jun 2010 17:09:55 +0200
Message-ID: <201006131709.55335.trast@student.ethz.ch>
References: <201006121211.12870.trast@student.ethz.ch> <cebe57bb68b5e8ea445e560bbe6305c915ce8a1c.1276354971.git.trast@student.ethz.ch> <7vljakfc64.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>, Michael Witten <mfwitten@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jun 13 17:10:07 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ONop3-0003hj-Eg
	for gcvg-git-2@lo.gmane.org; Sun, 13 Jun 2010 17:10:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753972Ab0FMPJ7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Jun 2010 11:09:59 -0400
Received: from gwse.ethz.ch ([129.132.178.237]:17820 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752261Ab0FMPJ6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Jun 2010 11:09:58 -0400
Received: from CAS02.d.ethz.ch (129.132.178.236) by gws00.d.ethz.ch
 (129.132.178.237) with Microsoft SMTP Server (TLS) id 8.2.254.0; Sun, 13 Jun
 2010 17:09:56 +0200
Received: from thomas.localnet (217.162.250.31) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.2.254.0; Sun, 13 Jun
 2010 17:09:55 +0200
User-Agent: KMail/1.13.3 (Linux/2.6.31.12-0.2-desktop; KDE/4.4.3; x86_64; ; )
In-Reply-To: <7vljakfc64.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149050>

Junio C Hamano wrote:
>  (2) otherwise, if there is an 8-bit encoding involved in the paths,
>      perhaps mark the entire message as 8-bit (binary???).
> 
> I have this suspicion that (2) is very rare (you cannot transmit such a
> patch as a plain text message reliably afaict, so it is not done in
> practice), and we would probably need to make a separate patchfile for
> groups of paths in each encoding and attach them as MIME multiparts (ugh).

So IIUC this would be the main/first obstacle?  Seeing as we seem to
do fine here but you both say 8bit is not reliable.  (According to
Wikipedia[*] all the big names support it though...)

Perhaps Quoted-Printable would work with minimal effort?  We could
leave it to send-email to do all the quoting, mailsplit or am all the
unquoting and we retain (mostly) the readability of the original
patches.

That still doesn't solve the problem that we might send (invalid utf8)
binary data declared as utf8.  I suppose to work around that, a more
elaborate approach like

>  (0) use the attributes mechanism to allow projects to mark paths with
>      encoding.  E.g.
> 
> 	# everything in UTF-8 unless otherwise specified...
>         * encoding=UTF-8
>         Documentation/zh_CN/* encoding=big5
> 
>  (1) for each patch, find the paths involved, and if their encodings are
>      the same, perhaps promote that as the encoding used for the entire
>      message;

is needed.


[*] http://en.wikipedia.org/wiki/8BITMIME#8BITMIME

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
