From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 04/24] t9300 (fast-import): check exit status from upstream
 of pipes
Date: Fri, 24 Sep 2010 02:11:02 -0500
Message-ID: <20100924071102.GE4666@burratino>
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
X-From: git-owner@vger.kernel.org Fri Sep 24 09:13:58 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oz2Ti-0006H4-3N
	for gcvg-git-2@lo.gmane.org; Fri, 24 Sep 2010 09:13:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755744Ab0IXHNt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Sep 2010 03:13:49 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:45040 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754062Ab0IXHNs (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Sep 2010 03:13:48 -0400
Received: by iwn5 with SMTP id 5so2156329iwn.19
        for <git@vger.kernel.org>; Fri, 24 Sep 2010 00:13:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=ljRRlr+UqQOd9rBIgFT+irXFz2BTpDKbaU5nshDeqWU=;
        b=mJ2+x6G8VkOiy23SWtzVwNH6sI2776tkTgkrnAMLCqLU/+cEDyMmg4Ey/NrUFXLYZR
         ZZnEhjqXkzj3NdsX5dMZuIXLqXzdB5rqchPTaUM9o0hwx3pWLyTK+W/w8z/j5B8/obDG
         Q6+e6bjja5rvlf+C1AskuKL4PoxRGDRsDi8EA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=eefBlDHtYJNb6+Fvh1By3hs80kjYBAPjBf1PVqbdSxr/S7WUq7XlUtPHG/yIxFty8Q
         /KkfkiYShmor+5BuYIFYgIRneehqvRVnRwHRdh/irLcOENyVc5IgP65pmH9gj+ROSpgy
         kBSscS82ZtZEKvsJLL9OE9O/Rm0gxoIvCBHqU=
Received: by 10.231.148.20 with SMTP id n20mr3268725ibv.196.1285312428332;
        Fri, 24 Sep 2010 00:13:48 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id r3sm1943472ibk.19.2010.09.24.00.13.47
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 24 Sep 2010 00:13:48 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100924065900.GA4666@burratino>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156938>

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 t/t9300-fast-import.sh |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/t/t9300-fast-import.sh b/t/t9300-fast-import.sh
index 735ac83..47339a3 100755
--- a/t/t9300-fast-import.sh
+++ b/t/t9300-fast-import.sh
@@ -97,7 +97,8 @@ initial
 EOF
 test_expect_success \
 	'A: verify commit' \
-	'git cat-file commit master | sed 1d >actual &&
+	'git cat-file commit master >commit &&
+	sed 1d <commit >actual &&
 	test_cmp expect actual'
 
 cat >expect <<EOF
@@ -107,7 +108,8 @@ cat >expect <<EOF
 EOF
 test_expect_success \
 	'A: verify tree' \
-	'git cat-file -p master^{tree} | sed "s/ [0-9a-f]*	/ /" >actual &&
+	'git cat-file -p master^{tree} >tree &&
+	 sed "s/ [0-9a-f]*	/ /" <tree >actual &&
 	 test_cmp expect actual'
 
 echo "$file2_data" >expect
-- 
1.7.2.3
