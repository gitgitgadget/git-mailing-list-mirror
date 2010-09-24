From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 06/24] t9300 (fast-import): use test_cmp in place of test
 $(foo) = $(bar)
Date: Fri, 24 Sep 2010 02:12:37 -0500
Message-ID: <20100924071237.GG4666@burratino>
References: <20100701031819.GA12524@burratino>
 <20100701054849.GA14972@burratino>
 <20100817170216.GA14491@kytes>
 <20100905031528.GA2344@burratino>
 <20100905032253.GB2344@burratino>
 <20100924065900.GA4666@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	David Barr <david.barr@cordelta.com>,
	Sam Vilain <sam@vilain.net>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 24 09:15:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oz2VN-0006ru-0D
	for gcvg-git-2@lo.gmane.org; Fri, 24 Sep 2010 09:15:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756618Ab0IXHP3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Sep 2010 03:15:29 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:54668 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755819Ab0IXHP3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Sep 2010 03:15:29 -0400
Received: by iwn5 with SMTP id 5so2157465iwn.19
        for <git@vger.kernel.org>; Fri, 24 Sep 2010 00:15:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=gHHwwCpc7c71uNbMHmqi2qWMYPlkUdidlOleEQGvFC4=;
        b=i/moQhtmrhkHyPe6ywz3bjd5sSWx+6j6P19zaIjgdnaXnQI+7bAfWgTDiwmldi+pPu
         lPh98s0x/yNeJlvdKJvQY/ETYLkp73Co5ZbiYCr9xhoisq0Nes9y3xZvEbtNTupLNEjR
         52RvpFeISWz4dJIcetJUeizPjbOWld4PwLVl0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=QEbCrFJl8TmacwgzRv+eqw7RiUVBBOEg1n2aaPwUK6WsUltP9rCGibb4scErVrUN2p
         mhz/inYZX7LeMTddAXNQ9HuR6Di5/Qp0KAHmQ7Ow8JqBRwlYmXiF0HAQJdvde5X5FcwM
         4mGCH1B52vQZO1Crzz09S/L59UNVepjoYIbUk=
Received: by 10.231.148.20 with SMTP id n20mr3271001ibv.196.1285312528698;
        Fri, 24 Sep 2010 00:15:28 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id r3sm1949335ibk.7.2010.09.24.00.15.28
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 24 Sep 2010 00:15:28 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100924065900.GA4666@burratino>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156940>

This has two benefits: it ensures that the exit status from the
output-producing commands is checked and it produces more helpful
output when the output does not match and tests are being run with -v.

Cc: Shawn O. Pearce <spearce@spearce.net>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 t/t9300-fast-import.sh |   13 ++++++-------
 1 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/t/t9300-fast-import.sh b/t/t9300-fast-import.sh
index c113ddf..8d418e4 100755
--- a/t/t9300-fast-import.sh
+++ b/t/t9300-fast-import.sh
@@ -184,15 +184,14 @@ test_expect_success \
 test_expect_success \
 	'A: verify pack' \
 	'verify_packs'
-cat >expect <<EOF
-:000000 100755 $zeroes $file2_id A	copy-of-file2
-EOF
-git diff-tree -M -r master verify--import-marks >actual
 test_expect_success \
 	'A: verify diff' \
-	'compare_diff_raw expect actual &&
-	 test `git rev-parse --verify master:file2` \
-	    = `git rev-parse --verify verify--import-marks:copy-of-file2`'
+	'echo ":000000 100755 $zeroes $file2_id A	copy-of-file2" >expect &&
+	 echo $file2_id >expect.copy &&
+	 git diff-tree -M -r master verify--import-marks >actual &&
+	 git rev-parse --verify verify--import-marks:copy-of-file2 >actual.copy &&
+	 compare_diff_raw expect actual &&
+	 test_cmp expect.copy actual.copy'
 
 test_expect_success 'A: export marks with large values' '
 	test_tick &&
-- 
1.7.2.3
