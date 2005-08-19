From: Marco Costalba <mcostalba@yahoo.it>
Subject: Fix git-mailinfo to understand empty commit messages
Date: Fri, 19 Aug 2005 00:59:41 -0700 (PDT)
Message-ID: <20050819075941.89094.qmail@web26308.mail.ukl.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 19 10:03:45 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E61n2-0002XC-Fa
	for gcvg-git@gmane.org; Fri, 19 Aug 2005 09:59:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964916AbVHSH7r (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 19 Aug 2005 03:59:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964918AbVHSH7r
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Aug 2005 03:59:47 -0400
Received: from web26308.mail.ukl.yahoo.com ([217.146.176.19]:43909 "HELO
	web26308.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S964916AbVHSH7q (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Aug 2005 03:59:46 -0400
Received: (qmail 89096 invoked by uid 60001); 19 Aug 2005 07:59:41 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.it;
  h=Message-ID:Received:Date:From:Subject:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=bH4pQP0o9c3+ALIHYD0PxrqZtlo4I+veiA7OuPKH66RFMMCj7lC5xwR2YL7wRqiXEfm5zQ3lWTVbwtRUIS3USAp4XtwgGeHONwSSDEF0Gsa5SnxA55hFcOzJUdIA/S3Sjik4atj2Rn8NEFF0aAXiLMeAR2SoTAwftAMwUZ5EaU8=  ;
Received: from [151.42.100.234] by web26308.mail.ukl.yahoo.com via HTTP; Fri, 19 Aug 2005 00:59:41 PDT
To: junkio@cox.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

In case of empty messages git-mailinfo ignores the "---"
line adding dirty stuff in commit message otherwise empty

Signed-off-by: Marco Costalba <mcostalba@yahoo.it>

---

 tools/mailinfo.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

1ebfddf05e4655811157028091d03dfce39cc4f0
diff --git a/tools/mailinfo.c b/tools/mailinfo.c
--- a/tools/mailinfo.c
+++ b/tools/mailinfo.c
@@ -273,6 +273,12 @@ int main(int argc, char ** argv)
 	}
 	while (1) {
 		int len = read_one_header_line(line, sizeof(line), stdin);
+		/* Check for empty messages */
+		if (!memcmp("---", line, 3)) {
+			line[len] = '\n';
+			handle_rest();
+			break;
+		}
 		if (!len) {
 			handle_body();
 			break;




		
____________________________________________________
Start your day with Yahoo! - make it your home page 
http://www.yahoo.com/r/hs 
 
