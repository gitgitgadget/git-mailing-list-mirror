From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v8 0/2] Submodule object path
Date: Thu, 10 Sep 2015 18:10:13 -0700
Message-ID: <xmqqoah9222y.fsf@gitster.mtv.corp.google.com>
References: <1438725925-3689-1-git-send-email-max@max630.net>
	<1441922231-18270-1-git-send-email-max@max630.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jens Lehmann <Jens.Lehmann@web.de>, Duy Nguyen <pclouds@gmail.com>,
	Jeff King <peff@peff.net>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Stefan Beller <sbeller@google.com>, git@vger.kernel.org
To: Max Kirillov <max@max630.net>
X-From: git-owner@vger.kernel.org Fri Sep 11 03:10:51 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZaCrT-0002hN-OO
	for gcvg-git-2@plane.gmane.org; Fri, 11 Sep 2015 03:10:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751069AbbIKBKR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Sep 2015 21:10:17 -0400
Received: from mail-pa0-f45.google.com ([209.85.220.45]:33266 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750827AbbIKBKP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Sep 2015 21:10:15 -0400
Received: by pacex6 with SMTP id ex6so58520132pac.0
        for <git@vger.kernel.org>; Thu, 10 Sep 2015 18:10:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=dvCTcV4JH+3EVdyBbmjcIRAZoyo9cTr9stlKq+1HHYA=;
        b=RDTGCP03ZRY+CftAVQXLLjgDAXgQOzOzAeWbDTrurdADV/aNW7BFJp7VbqZFtxfBFn
         1C995TqxTviZ4c3QMg/r/VvuHWqkNOG8kEhKjv3yZTQQY7ZpRgYxeYlxCUpFpagPhbiv
         y9pQom5N4tJ18rkBVoX8+1KMzc++9iwIKtw4uJByNalDToA+txgYP1v3zTqV5k1zl4DA
         xq31ilg/w9x2pPZmwvqBVmCBz73j+uxHXoXAYsR4uak+JB8/JD6AuYWIKX0uV88nZHAi
         zyHivBnHOhitdwyoW8TD6limsNkUO+4M5qF42xPKlb8fSCu5RCFWemoquZKcsZs+pWcf
         cPlw==
X-Received: by 10.66.189.194 with SMTP id gk2mr81288168pac.4.1441933815155;
        Thu, 10 Sep 2015 18:10:15 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:7504:ea92:c75a:a933])
        by smtp.gmail.com with ESMTPSA id nv2sm14269735pbb.83.2015.09.10.18.10.14
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 10 Sep 2015 18:10:14 -0700 (PDT)
In-Reply-To: <1441922231-18270-1-git-send-email-max@max630.net> (Max
	Kirillov's message of "Fri, 11 Sep 2015 00:57:09 +0300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277650>

Max Kirillov <max@max630.net> writes:

> * There are more conflicts in pu with [1], not sure
>   what should I do about it.
>
> [1] http://thread.gmane.org/gmane.comp.version-control.git/276628

I do not think conflicts got any worse than before.  Between the
result of merging this round and the previous one to 'pu', the only
difference in path.c that conflicts with [1] I see is essentially a
no-op (the diff attached at the end of this essage).

When I push the updated 'pu' out, could you please check

    $ git log --oneline --first-parent origin/master..origin/pu

to find the place your topic is merged (I am planning to make it
"3af7cd6 Merge branch 'mk/submodule-gitdir-path' into pu", but
please do not rely on the exact commit object name; I may have to
redo the integration if I find some breakages caused by this or any
other topic), and then eyeballing (call that merge $m) output of

    $ git diff $m^ $m

to see if there is anything I screwed up?

Thanks.


diff --git a/path.c b/path.c
index 776d8f0..2725bc3 100644
--- a/path.c
+++ b/path.c
@@ -466,11 +466,11 @@ static void do_submodule_path(struct strbuf *buf, const char *path,
 
 	strbuf_vaddf(buf, fmt, args);
 
-	if (get_common_dir_noenv(&git_submodule_common_dir, git_submodule_dir.buf)) {
+	if (get_common_dir_noenv(&git_submodule_common_dir, git_submodule_dir.buf))
 		update_common_dir(buf, git_submodule_dir.len, git_submodule_common_dir.buf);
-	}
 
 	strbuf_cleanup_path(buf);
+
 	strbuf_release(&git_submodule_dir);
 	strbuf_release(&git_submodule_common_dir);
 }
