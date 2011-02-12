From: xiaozhu <xiaozhu@gmail.com>
Subject: a bug about format-patch of multibyte characters comment
Date: Sat, 12 Feb 2011 19:13:15 +0900
Message-ID: <4D565D3B.7060808@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 12 11:13:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PoCTv-00036j-FL
	for gcvg-git-2@lo.gmane.org; Sat, 12 Feb 2011 11:13:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752217Ab1BLKNW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Feb 2011 05:13:22 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:38983 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750739Ab1BLKNU (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Feb 2011 05:13:20 -0500
Received: by iyj8 with SMTP id 8so3231121iyj.19
        for <git@vger.kernel.org>; Sat, 12 Feb 2011 02:13:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:message-id:date:from:user-agent:mime-version:to
         :subject:content-type:content-transfer-encoding;
        bh=2vJd7X+7LqjV2wKe92p+vgSqTdnSbf9TMj7+m4cDB6M=;
        b=PU49F7SSeJEUB/YDYKTZ7KW8aUOdX8yXWGMiIM0ILo7iiabRyqcgLu11XnaOOMuABt
         mmrY1WGAHQk8jl2KCfGIT1EukvAXtDj2bdURW30VlB/HC3OAd+je7aH+ulcihZQzIngd
         Pfzn/XRn9Mc3+9wghGiV8DjZc/Fc2pH4KaPRI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:subject
         :content-type:content-transfer-encoding;
        b=DIj8y2W1EMCVKqTHIllY9l84iMYXeTQIw6wbIxrUfU33Rq3fFKjNS5Z7/4+zNM5167
         l0e5vzG112ueLa7DLMCXwH7z6+sEzE7hYifFK9GJlqyHYnwaTgroGvxgmRqXyZYQdZ9c
         gBUohQRQGl8vOgXuyztC74yKrC1ob9fyT7V8g=
Received: by 10.42.178.135 with SMTP id bm7mr2009510icb.101.1297505599850;
        Sat, 12 Feb 2011 02:13:19 -0800 (PST)
Received: from [192.168.11.57] (softbank126036243176.bbtec.net [126.36.243.176])
        by mx.google.com with ESMTPS id ca7sm342250icb.0.2011.02.12.02.13.18
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 12 Feb 2011 02:13:19 -0800 (PST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.1; en-US; rv:1.9.2.13) Gecko/20101207 Thunderbird/3.1.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166606>

Hi,

I found a bug when I use format-patch to export a patch which contains comment with
some multibyte characters. I also found the relation source, but I can't understand
the source clearly, so I think I need a help to know how can I fix it.

At first, the symptom.

I commit a fix to my repository with comment like following:
-----------------------------------------------------
XXXXXXXXXXXX
YYYYYY
-----------------------------------------------------

two lines of multibyte language comment.

then I use format-patch to export this fix, I get a patch file like following:

------------------------------------------------------------------------------
 From d3532c3263a02a2367a3aa5c9cc3f0bd738b79b1 Mon Sep 17 00:00:00 2001
From: xz <xz>
Date: Fri, 11 Feb 2011 21:30:35 +0900
Subject: [PATCH] =?UTF-8?q?=E6=97=A5=E6=9C=AC=E8=AA=9E=E3=81=8C=E5=A4=A7=E4=B8=88=E5=A4=AB
=20=E6=94=B9=E8=A1=8C=E3=81=99=E3=82=8B?=
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

---
  testfile.txt |    4 +++-
  1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/testfile.txt b/testfile.txt
index 1e5d832..da982fd 100644
--- a/testfile.txt
+++ b/testfile.txt
@@ -1 +1,3 @@
-sadfasdf
\ No newline at end of file
+sadfasdf

..........

-------------------------------------------------------------------------------

If I use am to apply this patch, am can't analyze the comment correctly, then the
committed comment will become
"=?UTF-8?q?=E6=97=A5=E6=9C=AC=E8=AA=9E=E3=81=8C=E5=A4=A7=E4=B8=88=E5=A4=AB".

Above is the symptom.

Then I did some try, I modify the comment to 3 lines:
-----------------------------------------------------
XXXXXXXXXXXX

YYYYYY
-----------------------------------------------------

add a empty line, then I get a patch like following:
------------------------------------------------------------------------------
 From d3532c3263a02a2367a3aa5c9cc3f0bd738b79b1 Mon Sep 17 00:00:00 2001
From: xz <xz>
Date: Fri, 11 Feb 2011 21:30:35 +0900
Subject: [PATCH] =?UTF-8?q?=E6=97=A5=E6=9C=AC=E8=AA=9E=E3=81=8C=E5=A4=A7=E4=B8=88=E5=A4=AB?=
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

YYYYYY
---
  testfile.txt |    4 +++-
  1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/testfile.txt b/testfile.txt
index 1e5d832..da982fd 100644
--- a/testfile.txt
+++ b/testfile.txt
@@ -1 +1,3 @@
-sadfasdf
\ No newline at end of file
+sadfasdf

..........

-------------------------------------------------------------------------------

this patch will be applied successfully. So I know the problem is about the subject creating.
I search the source, then I found the following function at "pretty.c:655":

const char *format_subject(struct strbuf *sb, const char *msg,
			   const char *line_separator)
{
	int first = 1;

	for (;;) {
		const char *line = msg;
		int linelen = get_one_line(line);

		msg += linelen;
		
		if (!linelen || is_empty_line(line, &linelen))
			break;

		if (!sb)cat
			continue;
		strbuf_grow(sb, linelen + 2);
		if (!first)
			strbuf_addstr(sb, line_separator);
		strbuf_add(sb, line, linelen);
		first = 0;
	}
	return msg;
}

At first I want to know: Does this function means that always add the first line
of comment to the argument sb, then return the rest? Is there any other thing that I
didn't considered?

I found 4 place where to call this function, I think there is no problem about 3
of them, but I don't know is there any other problem to the rest one which is
at "pretty.c:931".

At last, if what I think is correct, I plan to fix it as following:

const char *format_subject(struct strbuf *sb, const char *msg,
			   const char *line_separator)
{
	int first = 1;

	//for (;;) {
		const char *line = msg;
		int linelen = get_one_line(line);

		msg += linelen;
		
		if (!linelen || is_empty_line(line, &linelen)) return msg;
			//break;

		if (!sb) return msg;
			//continue;
		strbuf_grow(sb, linelen + 2);
		if (!first)
			strbuf_addstr(sb, line_separator);
		strbuf_add(sb, line, linelen);
		first = 0;
	//}
	return msg;
}

I dont't think it is necessary to have a loop here, so I want to remove
the loop. Is there anybody can confirm my fix for me?
