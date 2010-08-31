From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 2/2] tests: make test_must_fail fail on missing commands
Date: Tue, 31 Aug 2010 12:26:57 -0500
Message-ID: <20100831172657.GP2315@burratino>
References: <20100831155457.GB11014@sigill.intra.peff.net>
 <20100831155652.GB11530@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jon Seymour <jon.seymour@gmail.com>, git@vger.kernel.org,
	gitster@pobox.com
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Aug 31 19:28:51 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OqUdd-0004vL-V8
	for gcvg-git-2@lo.gmane.org; Tue, 31 Aug 2010 19:28:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753483Ab0HaR2p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 Aug 2010 13:28:45 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:61459 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751309Ab0HaR2o (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Aug 2010 13:28:44 -0400
Received: by fxm13 with SMTP id 13so4108635fxm.19
        for <git@vger.kernel.org>; Tue, 31 Aug 2010 10:28:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=Y7zxD29mXcgLj1EQwa8WyrT92MHrctNWx1EuEDWKM54=;
        b=AM8cF0nCdtkAkxGoUOVuTMWshEQk6M3KA8ZieQiFTmx+bWijVENoiGeizweFCJVePK
         LhwPTuLSiTaCG4G4NutDbHWR8Dox3/kkLrNk8VxnlVMw2thvGP6ndX0EHFUISeDUXOYu
         gJLpHXQgj/RjsDlYOivfjgt66AJ7z0QfolDFY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=c8pCjjGpdfl1m2TFz0BFjj3nN4monU5c90c6IcAfSHEQbhbXCYedP+cea/KbImmFj5
         ZQVxT3/ozuYhMKNJBG0c5G7Ys7mgRArsjYpLiELIplrI+pX4Ba0zhMYNP46jhxeEDgqj
         MwRfi4LoEiPH2JGqNtDfEvy9JFDCf96ALmJ1M=
Received: by 10.223.104.141 with SMTP id p13mr2526399fao.64.1283275723070;
        Tue, 31 Aug 2010 10:28:43 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id k25sm4102252fac.17.2010.08.31.10.28.40
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 31 Aug 2010 10:28:42 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100831155652.GB11530@sigill.intra.peff.net>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154946>

Jeff King wrote:

> The point of it is to run a command that produces failure. A
> missing command is more likely an error in the test script

Makes sense.  Here's the corresponding change for test_might_fail.

-- 8< --
Subject: tests: make test_might_fail fail on missing commands

Detect and report hard-to-notice spelling mistakes like

 test_might_fail "git config --unset whatever"

(the extra quotes prevent the shell from running git as intended;
instead, the shell looks for a "git config --unset whatever" file).

Cc: Jeff King <peff@peff.net>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 t/test-lib.sh |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index 16ceb53..7da490d 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -622,6 +622,9 @@ test_might_fail () {
 	if test $exit_code -gt 129 -a $exit_code -le 192; then
 		echo >&2 "test_might_fail: died by signal: $*"
 		return 1
+	elif test $exit_code = 127; then
+		echo >&2 "test_might_fail: command not found: $*"
+		return 1
 	fi
 	return 0
 }
-- 
1.7.2.2
