From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH] quote.h: simplify the inclusion
Date: Tue, 4 Jan 2011 18:36:34 -0600
Message-ID: <20110105003634.GA5128@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 05 01:36:50 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PaHMu-0000L8-Hx
	for gcvg-git-2@lo.gmane.org; Wed, 05 Jan 2011 01:36:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751691Ab1AEAgn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 4 Jan 2011 19:36:43 -0500
Received: from mail-yi0-f66.google.com ([209.85.218.66]:37157 "EHLO
	mail-yi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751371Ab1AEAgn convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 4 Jan 2011 19:36:43 -0500
Received: by yic24 with SMTP id 24so2023063yic.1
        for <git@vger.kernel.org>; Tue, 04 Jan 2011 16:36:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:mime-version:content-type:content-disposition
         :content-transfer-encoding:user-agent;
        bh=gzYipmkAoNrMFdf5d84fHjGWEa6rpOEUkYLP0BNdd+4=;
        b=DciZpMSyV/nl/uo/z1P6KzkeCPiGJ5So6vWY1oYW3pk/odZAkLI1EJDZTR56KfQu6U
         tj0thQwJsQN3afbavttGTS8KW7twO6WJiW0K9HIunfc4We67cU10VXLNylisLXoOXr4Z
         d83knxJSoqG+RmlMv2ZQ9oNvIaoM3kp23px5c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:mime-version:content-type
         :content-disposition:content-transfer-encoding:user-agent;
        b=bkdGP9STmoED87Y8YBa816XrEAySlRDGbllar1WDng/WXYJvZIWzLeN8I2NCpkU4aZ
         O2nbay6VBC9FwOyclO/0jHW0eWH4kshh9m20vjPYusmCWye4cWF5hh6zbaLedRPCOXap
         melXC2FRPmbOpjxEp63Bd4P/kVWJrpg5TUa/8=
Received: by 10.147.41.9 with SMTP id t9mr7628350yaj.20.1294187802240;
        Tue, 04 Jan 2011 16:36:42 -0800 (PST)
Received: from burratino (adsl-69-209-72-219.dsl.chcgil.ameritech.net [69.209.72.219])
        by mx.google.com with ESMTPS id f73sm13409698yhc.4.2011.01.04.16.36.40
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 04 Jan 2011 16:36:40 -0800 (PST)
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164532>

Attempting to include quote.h without first including strbuf.h results
in warnings:

 ./quote.h:33:33: warning: =E2=80=98struct strbuf=E2=80=99 declared ins=
ide parameter list
 ./quote.h:33:33: warning: its scope is only this definition or declara=
tion, which is probably not what you want
 ./quote.h:34:34: warning: =E2=80=98struct strbuf=E2=80=99 declared ins=
ide parameter list
 ...

Add a toplevel declaration for struct strbuf to avoid this.

While at it, stop including system headers from quote.h.  git source
files already need to include git-compat-util.h sooner to ensure the
appropriate feature test macros are defined.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Noticed while trying to use quote.h in a source file without strbufs.

 quote.h |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/quote.h b/quote.h
index 38003bf..024e21d 100644
--- a/quote.h
+++ b/quote.h
@@ -1,8 +1,7 @@
 #ifndef QUOTE_H
 #define QUOTE_H
=20
-#include <stddef.h>
-#include <stdio.h>
+struct strbuf;
=20
 /* Help to copy the thing properly quoted for the shell safety.
  * any single quote is replaced with '\'', any exclamation point
--=20
1.7.4.rc0
