From: zzs <zzs213@126.com>
Subject: gitweb highligh generate illegal char when the content had utf-8
 chars
Date: Thu, 4 Aug 2011 13:31:23 +0800
Message-ID: <20110804053123.GA13198@greatfirst.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 04 08:00:38 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qoqyz-0001XB-I5
	for gcvg-git-2@lo.gmane.org; Thu, 04 Aug 2011 08:00:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750815Ab1HDGAd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Aug 2011 02:00:33 -0400
Received: from m15-111.126.com ([220.181.15.111]:36914 "EHLO m15-111.126.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750773Ab1HDGAb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Aug 2011 02:00:31 -0400
X-Greylist: delayed 1866 seconds by postgrey-1.27 at vger.kernel.org; Thu, 04 Aug 2011 02:00:31 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=Received:Date:From:To:Subject:Message-ID:
	MIME-Version:Content-Type:Content-Disposition:User-Agent; bh=Emi
	+IOPR/nKPe7A+h4wzANNvFEak8i1Dzqwdt5bUOHc=; b=Z1kdyq5u74xBU0IDdZb
	5l6DjtGMfyuGdV7JSLFN21tFpP9P8eEUt5Y0J58LZ19Rreq7HNqi/QO4XNCvlWME
	efiaDO7SReUKUsciKzLICRUh4JZ5SSXyd50gktCXW02HjxGDxGdywP8NOW2vx5fU
	zrIRNXPmYlZ/wMrke0uXGD50=
Received: from localhost (unknown [119.6.72.17])
	by smtp1 (Coremail) with SMTP id C8mowKDbn00sLjpO73bXAg--.2197S2;
	Thu, 04 Aug 2011 13:29:17 +0800 (CST)
X-Coremail-DSSMTP: 119.6.72.17
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-CM-TRANSID: C8mowKDbn00sLjpO73bXAg--.2197S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7Jw1xCrWUCw47ZFWDtFWrZrb_yoW3CrbEqF
	WjyF43GF4jvr1agr4jvFnxGr13JFWxZFn3Xw15XF45u342q3WUJw4DG3y7Xry7XrnrCFy3
	Gw1qqF45Ar4jkjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUngzVUUUUUU==
X-CM-SenderInfo: x22vjiat6rjloofrz/1tbiZxKRGU3AIp76LwAAsZ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178701>

When my C file had some utf-8 comments, gitweb highlight generate
illegal chars.

So I hacked gitweb.cgi, like this:

---------------------------
diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index dab89f2..48def38 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -6465,7 +6465,7 @@ sub git_blob {
                        $nr++;
                        $line = untabify($line);
                        printf qq!<div class="pre"><a id="l%i" href="%s#l%i" class="linenr">%4i</a> %s</div>\n!,
-                              $nr, esc_attr(href(-replay => 1)), $nr, $nr, $syntax ? $line : esc_html($line, -nbsp=>1);
+                              $nr, esc_attr(href(-replay => 1)), $nr, $nr, $syntax ? to_utf8($line) : esc_html($line, -nbsp=>1);
                }
        }
        close $fd
---------------------------


And it works.

But I wonder is this the rigtht solution.

Anybody help me?

-- 
Best Regards
zzs
