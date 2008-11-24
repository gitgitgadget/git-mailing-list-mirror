From: Deskin Miller <deskinm@umich.edu>
Subject: [RFC PATCH 0/4] Teach git fetch to verify signed tags automatically
Date: Sun, 23 Nov 2008 22:23:16 -0500
Message-ID: <1227497000-8684-1-git-send-email-deskinm@umich.edu>
Cc: Deskin Miller <deskinm@umich.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 24 04:25:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L4S4I-00061G-EC
	for gcvg-git-2@gmane.org; Mon, 24 Nov 2008 04:24:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751681AbYKXDX1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Nov 2008 22:23:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751723AbYKXDX1
	(ORCPT <rfc822;git-outgoing>); Sun, 23 Nov 2008 22:23:27 -0500
Received: from yw-out-2324.google.com ([74.125.46.28]:20323 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751586AbYKXDX0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Nov 2008 22:23:26 -0500
Received: by yw-out-2324.google.com with SMTP id 9so761603ywe.1
        for <git@vger.kernel.org>; Sun, 23 Nov 2008 19:23:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:sender;
        bh=2OkrI+0lKP8NEMj6BkKL3uqofpm8kR71I1sZiDYKxnA=;
        b=CaJKXlBd3oOfbKLf5nhHvR7n1Ys4wSBXzXffNz9EV0qJLGVxFHLybBcw2gvnpXdW/N
         w+gaJfyK5FMtpScDEWtpRp3Ny8urzlfHGWSo6/UpmYOMC3MwKYQWFsI58xnXRSXnkVt4
         DcAzhvP/sskNbkk/gp0FZxKQV8QrS2kJ8IR4w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:sender;
        b=iEYYyJIvpTl5P0HvCBbodw2trxlqGk6i4O0TSWdjCLIVVzi4T7oMXyTQoHM4hrmLwE
         s8VcF35oscqm/YDvAW7xQKZaMpC98lW82T+VI4BL7txbrCWdu/mjEKwIH1wvS0BeXqOY
         wvcj1iCMozDzqBEBwoSghGJ1O6O2qj+QGMwis=
Received: by 10.151.39.2 with SMTP id r2mr6171360ybj.203.1227497005732;
        Sun, 23 Nov 2008 19:23:25 -0800 (PST)
Received: from localhost.localdomain ([152.160.57.162])
        by mx.google.com with ESMTPS id a13sm6706484rnc.12.2008.11.23.19.23.24
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 23 Nov 2008 19:23:25 -0800 (PST)
X-Mailer: git-send-email 1.6.0.4.770.ga8394
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101585>

It struck me a while back when I fetched a new tagged release from git.git that
if I wanted to verify the tag's signature, I'd have to issue another command to
do so.  Shouldn't git be able to do that for me automatically, when it fetches
signed tags?  Now it does.  Also, 'git remote update' gets this for free.

Individual commit messages explain things reasonably well, I hope; here are a
few points for discussion:

-Is refactoring builtin-verify-tag.c the right thing to do?
-Now that the SIGPIPE ignoring is occurring at a lower level, should it be
 removed from cmd_verify_tag?
-Output format: good, bad, ugly?
-What to do if a tag is found to have a bad signature?

Deskin Miller (4):
  Refactor builtin-verify-tag.c
  verify-tag.c: ignore SIGPIPE around gpg invocation
  verify-tag.c: suppress gpg output if asked
  Make git fetch verify signed tags

 Makefile             |    2 +
 builtin-fetch.c      |   25 +++++++++++----
 builtin-verify-tag.c |   61 ++----------------------------------
 t/t7004-tag.sh       |   37 ++++++++++++++++++++++
 verify-tag.c         |   84 ++++++++++++++++++++++++++++++++++++++++++++++++++
 verify-tag.h         |   10 ++++++
 6 files changed, 155 insertions(+), 64 deletions(-)
 create mode 100644 verify-tag.c
 create mode 100644 verify-tag.h
