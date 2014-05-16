From: Jeremiah Mahler <jmmahler@gmail.com>
Subject: [PATCH v2] format-patch --signature-file <file>
Date: Thu, 15 May 2014 18:31:20 -0700
Message-ID: <1400203881-2794-1-git-send-email-jmmahler@gmail.com>
Cc: git@vger.kernel.org, Jeremiah Mahler <jmmahler@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 16 03:32:00 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wl70C-0000tk-2M
	for gcvg-git-2@plane.gmane.org; Fri, 16 May 2014 03:32:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751913AbaEPBb4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 May 2014 21:31:56 -0400
Received: from mail-pa0-f51.google.com ([209.85.220.51]:62757 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751577AbaEPBbz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 May 2014 21:31:55 -0400
Received: by mail-pa0-f51.google.com with SMTP id kq14so1792262pab.24
        for <git@vger.kernel.org>; Thu, 15 May 2014 18:31:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=sQxoj6inZbfopOSH4r8HRsDgjCJ2bPsmRsxmLB10bvY=;
        b=HzWsWPQqziN/bq6QfmnjZsvXqKar8nnW1YWdKRwwiVA1lsleccoXtBMSWD+qlRSrGu
         viOAn5p6y4V34Sd2UqpZVOge7R276CKWx9fwtB6K3Bit+bIXUHq41X8QnJWYasR8xxho
         G28lAtw/gVAKtOLMtarUf7rhVfHxCVWHtm1zmc4BEX50wIh4F53X6+QIrkjy3isbq1im
         2hVBLuun8Vlp0myp6veO6ITY9AWC3puJBoRo9C2o51Gk7GCKBGSY76oSo9yK8jtXSiar
         1vCtQD8wu6FmGN6KOu85yFxld0clJtLFP0o3lAxb7ZCfx8ghHXt/doLHkJ4qWu0BHogo
         UHHw==
X-Received: by 10.69.19.139 with SMTP id gu11mr16756111pbd.36.1400203915125;
        Thu, 15 May 2014 18:31:55 -0700 (PDT)
Received: from hudson (108-76-185-60.lightspeed.frokca.sbcglobal.net. [108.76.185.60])
        by mx.google.com with ESMTPSA id bz4sm11414244pbb.12.2014.05.15.18.31.51
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Thu, 15 May 2014 18:31:53 -0700 (PDT)
X-Google-Original-From: "Jeremiah Mahler" <jeri@hudson>
Received: by hudson (sSMTP sendmail emulation); Thu, 15 May 2014 18:31:50 -0700
X-Mailer: git-send-email 2.0.0.rc2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249270>

On Tue, May 13, 2014 at 09:07:12AM -0700, Jonathan Nieder wrote:
> Hi,
> 
> Jeremiah Mahler wrote:
> 
> >   # from a string
> >   $ git format-patch --signature "from a string" origin
> >
> >   # or from a file
> >   $ git format-patch --signature ~/.signature origin
> 
> Interesting.  But... what if I want my patch to end with
> 
> 	-- 
> 	/home/jrnieder/.signature
> 
> ?  It seems safer to introduce a separate --signature-file option.
> 

It is probably smarter to avoid that corner case entirely.
Good idea.

> [...]
> >  builtin/log.c | 26 ++++++++++++++++++++++++--
> >  1 file changed, 24 insertions(+), 2 deletions(-)
> 
> Tests?
> 

I added a test which checks that a valid patch is produced and that
the signature from the file appears in the output.

> Thanks and hope that helps,
> Jonathan

In addition to addressing the suggestions from Jonathan I also
updated the Documentation.

This solution uses a static buffer to store the signature which does
create a size limitation (1024 bytes).  I considered a solution
using malloc but I could not figure out a clean way of determining when
to free the memory.

Thanks for the help and suggestions.

Jeremiah Mahler (1):
  format-patch --signature-file <file>

 Documentation/git-format-patch.txt |  7 +++++++
 builtin/log.c                      | 24 ++++++++++++++++++++++++
 t/t4014-format-patch.sh            | 13 +++++++++++++
 3 files changed, 44 insertions(+)

-- 
Jeremiah Mahler
jmmahler@gmail.com
http://github.com/jmahler
