From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] Bugfix: grep: Do not colorize output when -O is set
Date: Fri, 2 Jul 2010 14:21:02 -0500
Message-ID: <20100702192102.GA6585@burratino>
References: <1278064941-30689-1-git-send-email-ayiehere@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitster@pobox.com, git@vger.kernel.org, johannes.schindelin@gmx.de
To: Nazri Ramliy <ayiehere@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 02 21:21:41 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OUlnw-0007NX-EE
	for gcvg-git-2@lo.gmane.org; Fri, 02 Jul 2010 21:21:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759890Ab0GBTVe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Jul 2010 15:21:34 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:45409 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759853Ab0GBTVd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Jul 2010 15:21:33 -0400
Received: by iwn7 with SMTP id 7so3565244iwn.19
        for <git@vger.kernel.org>; Fri, 02 Jul 2010 12:21:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=VvdhW8KRv/WI7IvH6/JWhsqZBVAkoazinH+66sMV4ps=;
        b=SG3d158kKCeHpbBESRw+D0hVAL1V/pA/htq1EOKyPR1QBTWopj05qVvfEDbE1gXhvO
         jO+jA5HHlYh+BKdZT+RSbOc4+vVNCTp+G1oZBB23pMA+k3danH2j8UONHlW9I8hIpMQK
         PxenYVIjy44sfr9i2eTbyoQFu5NQ9gwDWNLY8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=fPg4AA6ahQYacZs8qWkRGI8/R12EiOhLeaYMf/20AoOMXf3hgNl5xvOAI2abgbOlBf
         bLkkwb8N1VufWq2Hoi7efld4QA/+nmXKtJHBozctC5AChAhOQiKMU94Pycwozruo1z58
         zHQmRtNlj9Kkx6uiDh+AsC/3BLqGhe8i/KXq0=
Received: by 10.231.31.7 with SMTP id w7mr781720ibc.83.1278098492389;
        Fri, 02 Jul 2010 12:21:32 -0700 (PDT)
Received: from burratino (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id x6sm4342931ibb.5.2010.07.02.12.21.31
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 02 Jul 2010 12:21:31 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1278064941-30689-1-git-send-email-ayiehere@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150154>

Hi Nazri,

Nazri Ramliy wrote:

> When color.ui is set to auto, "git grep -Ovi foo" breaks due to the
> presence of color escape sequences.

I tried the following test without your patch, and it seemed to pass
without trouble.  What am I doing wrong?

diff --git a/t/t7811-grep-open.sh b/t/t7811-grep-open.sh
index c110441..d47c054 100755
--- a/t/t7811-grep-open.sh
+++ b/t/t7811-grep-open.sh
@@ -125,6 +125,24 @@ test_expect_success 'modified file' '
 	test_cmp empty out
 '
 
+test_expect_success 'copes with color.ui' '
+	rm -f actual &&
+	echo grep.h >expect &&
+	git config color.ui always &&
+	test_when_finished "git config --unset color.ui" &&
+	git grep -O'\''printf "%s\n" >actual'\'' GREP_AND &&
+	test_cmp expect actual
+'
+
+test_expect_success 'copes with color.grep' '
+	rm -f actual &&
+	echo grep.h >expect &&
+	git config color.grep always &&
+	test_when_finished "git config --unset color.grep" &&
+	git grep -O'\''printf "%s\n" >actual'\'' GREP_AND &&
+	test_cmp expect actual
+'
+
 test_expect_success 'run from subdir' '
 	rm -f actual &&
 	echo grep.c >expect &&
