From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [demo/PATCH 1/3] string-list: Document STRING_LIST_INIT_* and
 string_list_init()
Date: Sun, 5 Sep 2010 15:06:34 -0500
Message-ID: <20100905200634.GC14497@burratino>
References: <1283709077-5438-1-git-send-email-tfransosi@gmail.com>
 <20100905200323.GA14497@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Thiago Farina <tfransosi@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 05 22:08:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OsLVy-0004wn-Mf
	for gcvg-git-2@lo.gmane.org; Sun, 05 Sep 2010 22:08:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754435Ab0IEUIa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Sep 2010 16:08:30 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:33547 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754367Ab0IEUI3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Sep 2010 16:08:29 -0400
Received: by iwn5 with SMTP id 5so3527944iwn.19
        for <git@vger.kernel.org>; Sun, 05 Sep 2010 13:08:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=NeTR4y9KNCxhLN8mToZv+uUdEuSkksSSYpQaKQRArSQ=;
        b=APEc5a5WdvqMOf88zGiEAPHxCsSmuFnj45mogdQQYHAkSvHAEsa14uAo7yO4nKsvmZ
         iQc7Wub646YOYyxadusxfTq1D3Z8e7bez/99XWtwClHNInMN09yvuwHQ2UgTAee8wrRg
         pOYzBuwn4mp+YyaARmE9HyKlEbKdyVuJVk8iw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=nFB+BNhTca6/UvTTKNCI2J24GsruSyGdP0YsUPfDmXAhWVV8fuloIX8dnn5gVpB9kh
         9QplkNiWyn6wK1aIPQ0Pw4LRPhCOXCiV9stNIBmRMDiJUfftFlf+h79Du7ZRre6dr17n
         5m8dSAgL+EvT2aGoe7NNS2Y/CgczBX6QPK8Wc=
Received: by 10.231.152.143 with SMTP id g15mr4860465ibw.76.1283717308763;
        Sun, 05 Sep 2010 13:08:28 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id i6sm2113877iba.14.2010.09.05.13.08.28
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 05 Sep 2010 13:08:28 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100905200323.GA14497@burratino>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155481>

Clarify the modern ways to initialize a string_list.  Text roughly
based on the analogous passage from api-strbuf.txt.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 Documentation/technical/api-string-list.txt |   18 +++++++++++-------
 1 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/Documentation/technical/api-string-list.txt b/Documentation/technical/api-string-list.txt
index 3f575bd..0f0e579 100644
--- a/Documentation/technical/api-string-list.txt
+++ b/Documentation/technical/api-string-list.txt
@@ -9,12 +9,17 @@ because it is not specific to paths.
 
 The caller:
 
-. Allocates and clears a `struct string_list` variable.
+. Allocates a `struct string_list` variable
 
-. Initializes the members. You might want to set the flag `strdup_strings`
-  if the strings should be strdup()ed. For example, this is necessary
-  when you add something like git_path("..."), since that function returns
-  a static buffer that will change with the next call to git_path().
+. Initializes the members. A string_list has to be initialized by
+  `string_list_init()` or by `= STRING_LIST_INIT_DUP` or
+  `= STRING_LIST_INIT_NODUP` before it can be used.
++
+Strings in lists initialized with the _DUP variant will be
+automatically strdup()ed on insertion and free()ed on removal.
+For example, this is necessary when you add something like
+git_path("..."), since that function returns a static buffer
+that will change with the next call to git_path().
 +
 If you need something advanced, you can manually malloc() the `items`
 member (you need this if you add things later) and you should set the
@@ -34,10 +39,9 @@ member (you need this if you add things later) and you should set the
 Example:
 
 ----
-struct string_list list;
+struct string_list list STRING_LIST_INIT_NODUP;
 int i;
 
-memset(&list, 0, sizeof(struct string_list));
 string_list_append(&list, "foo");
 string_list_append(&list, "bar");
 for (i = 0; i < list.nr; i++)
-- 
1.7.2.3
