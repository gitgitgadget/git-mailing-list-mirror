From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: [PATCH v2 0/3] cherry-abbrev
Date: Sat, 20 Mar 2010 19:55:26 +0100
Message-ID: <1269111329-5896-1-git-send-email-kusmabite@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: rene.scharfe@lsrfire.ath.cx, gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 20 19:56:42 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nt3qj-0007H6-2P
	for gcvg-git-2@lo.gmane.org; Sat, 20 Mar 2010 19:56:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750935Ab0CTS4h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Mar 2010 14:56:37 -0400
X-Warning: Original message contained 8-bit characters, however during
	   the SMTP transport session the receiving system did not announce
	   capability of receiving 8-bit SMTP (RFC 1651-1653), and as this
	   message does not have MIME headers (RFC 2045-2049) to enable
	   encoding change, we had very little choice.
X-Warning: We ASSUME it is less harmful to add the MIME headers, and
	   convert the text to Quoted-Printable, than not to do so,
	   and to strip the message to 7-bits.. (RFC 1428 Appendix A)
X-Warning: We don't know what character set the user used, thus we had to
	   write these MIME-headers with our local system default value.
Received: from mail-ew0-f216.google.com ([209.85.219.216]:45107 "EHLO
	mail-ew0-f216.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751753Ab0CTS4e (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Mar 2010 14:56:34 -0400
Received: by ewy8 with SMTP id 8so297132ewy.28
        for <git@vger.kernel.org>; Sat, 20 Mar 2010 11:56:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=ayfoLkdoNPPIPHyi1+S958KxeAtIeKOEc6XfoBDNhcg=;
        b=FFjd/kQXIZ3fnx2/dyhXRZZ1RveHXMsl3OElHBVLEtSGyM2+TldmMXbLElNZ7s3Frl
         bMuQQ93X7T276VLKxhxqadW9qrh9Pk6hLkIocStvQ0kXQ7AtyQF/7sivRGPfVfTZAglz
         /A3XVlZ6WQeOYbPboIpZZVmGkSxLyRUJfvUYw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=UhWA1Iukpof5T7Q2NbXlGKvQg9Zk2BAcQiM/8Xjiekr00ezg0/XmAcsC4K3W2cdo1/
         gAi0VeA/1wyRlCibIDPK25V/7TpqKkycIYavmC+vZcNMhhtc8qy5/pY5rKfmDxNt+6G6
         iizWD0PRl3l3Ibs2NHzGTx0jc1EkqZS6ikaW0=
Received: by 10.213.46.133 with SMTP id j5mr1590074ebf.32.1269111392395;
        Sat, 20 Mar 2010 11:56:32 -0700 (PDT)
Received: from localhost (cm-84.215.188.225.getinternet.no [84.215.188.225])
        by mx.google.com with ESMTPS id 15sm1711381ewy.0.2010.03.20.11.56.31
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 20 Mar 2010 11:56:31 -0700 (PDT)
X-Mailer: git-send-email 1.7.0.2.456.g64f24
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142736>

This is the second round of ef/cherry-abbrev.

1/3 is the same as last round, but with the corrections suggested
by Ren=E9 Scharfe.

2/3 isn't strictly needed, but it makes two call-sites for f_u_a
more consistent with the others.

3/3 fixes the gains back the performance that was lost in 2/3:

Best of five runs of "git ls-tree v1.6.5" in a loop:

without 3/3:
real        0m0.082s
user        0m0.040s
sys         0m0.036s

with 3/3:
real        0m0.074s
user        0m0.040s
sys         0m0.040s

Erik Faye-Lund (3):
  cherry: support --abbrev option
  ls: remove redundant logic
  find_unique_abbrev: early out without a memcpy

 builtin/log.c      |   39 +++++++++++++++++++++------------------
 builtin/ls-files.c |    7 ++-----
 builtin/ls-tree.c  |    6 ++----
 sha1_name.c        |    4 ++--
 4 files changed, 27 insertions(+), 29 deletions(-)
