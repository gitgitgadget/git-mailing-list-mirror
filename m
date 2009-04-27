From: =?UTF-8?B?TWljaGHFgg==?= Kiedrowicz <michal.kiedrowicz@gmail.com>
Subject: Re: git grep '(' = segfault
Date: Mon, 27 Apr 2009 20:15:13 +0200
Message-ID: <20090427201513.5d598e3c@gmail.com>
References: <37fcd2780904271046r7740ed42t3c9438e7aa93374@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Dmitry Potapov <dpotapov@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 27 20:15:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LyVMX-0005DA-2p
	for gcvg-git-2@gmane.org; Mon, 27 Apr 2009 20:15:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757071AbZD0SPV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Apr 2009 14:15:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753070AbZD0SPU
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Apr 2009 14:15:20 -0400
Received: from mail-bw0-f163.google.com ([209.85.218.163]:60010 "EHLO
	mail-bw0-f163.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752802AbZD0SPS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Apr 2009 14:15:18 -0400
Received: by bwz7 with SMTP id 7so72370bwz.37
        for <git@vger.kernel.org>; Mon, 27 Apr 2009 11:15:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:in-reply-to:references:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=4cb8DuW5d8QChPzGeME3dxsbOsqHKnpwBEI04tgdUJk=;
        b=DUDmW06pCOmckPp0gIc7dV2T8JzUSTlb5zz9K6zTYYxCvgvMPcTA/YYQBps0iwf4W7
         ABSZgtPBlBotXY9N1/xKvQxhIxvBrJqCa4/lPHBDXo/G3BJm5C2C3KQOVkM+Cl2C3ALr
         fTMEzIsAoI3MS3Hh1rwP6Wo9J4GSOG2yM99nM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer
         :mime-version:content-type:content-transfer-encoding;
        b=jR7vhM0zlXcTfmLIUxrMSNBstm37cWpc3BB5I/7WDzvUQc/Xa72d+iELtraGXueeiJ
         M5CmFRR/HEMwRniWjHKtgmYZbNLQOqo1tXIvzHk3YyAXgncSJf7it6xvwURxJFrSrdKj
         axV+WxBkIDfkv4MmHh1zX+admp65k+07tqyYM=
Received: by 10.86.51.10 with SMTP id y10mr3505066fgy.51.1240856117023;
        Mon, 27 Apr 2009 11:15:17 -0700 (PDT)
Received: from localhost (77-254-94-173.adsl.inetia.pl [77.254.94.173])
        by mx.google.com with ESMTPS id 4sm4811384fge.23.2009.04.27.11.15.16
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 27 Apr 2009 11:15:16 -0700 (PDT)
In-Reply-To: <37fcd2780904271046r7740ed42t3c9438e7aa93374@mail.gmail.com>
X-Mailer: Claws Mail 3.7.1 (GTK+ 2.14.7; x86_64-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117699>

Dmitry Potapov <dpotapov@gmail.com> wrote:

> Hi,
> 
> I have tried a few version of Git and got "Segmentation fault" when
> run:
> 
> $ git grep '('
> 
> I am not very familiar with grep code and don't have time to dig
> into it right now. So, maybe someone else can take a look at it.
> 
> Thanks,
> Dmitry
> --

Try this patch, however I'm not sure if it is correct.

---

diff --git a/grep.c b/grep.c
index f3a27d7..5748355 100644
--- a/grep.c
+++ b/grep.c
@@ -84,10 +84,10 @@ static struct grep_expr *compile_pattern_atom(struct grep_pat **list)
 	case GREP_OPEN_PAREN:
 		*list = p->next;
 		x = compile_pattern_or(list);
-		if (!x)
-			return NULL;
 		if (!*list || (*list)->token != GREP_CLOSE_PAREN)
 			die("unmatched parenthesis");
+		if (!x)
+			return NULL;
 		*list = (*list)->next;
 		return x;
 	default:
