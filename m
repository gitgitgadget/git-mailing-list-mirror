From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH jk/remove-deprecated] stop installing git-tar-tree link
Date: Mon, 2 Dec 2013 15:37:10 -0800
Message-ID: <20131202233710.GB29959@google.com>
References: <cover.1384098226.git.john@keeping.me.uk>
 <d29327f6eb6e999ef31c3130ad2bab712a5d280b.1384098226.git.john@keeping.me.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Tue Dec 03 00:37:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vnd3H-0006x8-9s
	for gcvg-git-2@plane.gmane.org; Tue, 03 Dec 2013 00:37:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753287Ab3LBXhP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Dec 2013 18:37:15 -0500
Received: from mail-yh0-f50.google.com ([209.85.213.50]:52527 "EHLO
	mail-yh0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752952Ab3LBXhN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Dec 2013 18:37:13 -0500
Received: by mail-yh0-f50.google.com with SMTP id b6so9559117yha.37
        for <git@vger.kernel.org>; Mon, 02 Dec 2013 15:37:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=JR9BoY8deFVGAMVCm7BMfn3C9E4SmMXV9Vubb5whr4Y=;
        b=aEQijuBdBiqAwh7LvNO6/4jwe5IKkzbKlyWnpkcXjWFzDiPo9qswkzXwD0d1WIS5JA
         Y4nBMNowKh8xQKpTT9DH8VrzrkYq8kpfx1c7IdMukK4RfVHcXkpP7/lRI4litW6YI8jJ
         hKm6BGI2Jw+pipG5pEVAkGjDFcO8jfNq0cLgNwgz7LZvFOooZpcdTq10N+yvlSMr9NQ9
         2lPix/cEcQ0V9eSOXrlO1HEPRNihp+UqqKShNJ7T1VOqdwLS/djwY1SF8YM9grljMcdo
         Mjwe46Tdofru3Im5GR/v1d4qp6kXe/dEzWjgDgVsUa5VIWGKVQvaPMeAyokIhiIQPAb/
         IC6g==
X-Received: by 10.236.92.138 with SMTP id j10mr3420057yhf.70.1386027433374;
        Mon, 02 Dec 2013 15:37:13 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id q44sm84936696yhg.10.2013.12.02.15.37.12
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 02 Dec 2013 15:37:12 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <d29327f6eb6e999ef31c3130ad2bab712a5d280b.1384098226.git.john@keeping.me.uk>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238661>

When the built-in "git tar-tree" command (a thin wrapper around "git
archive") was removed in 925ceccf (tar-tree: remove deprecated
command, 2013-11-10), the build continued to install a non-functioning
git-tar-tree command in gitexecdir by mistake:

	$ PATH=$(git --exec-path):$PATH
	$ git-tar-tree -h
	fatal: cannot handle tar-tree internally

The list of links in gitexecdir is populated from BUILTIN_OBJS, which
includes builtin/tar-tree.o to implement "git get-tar-commit-id".
Rename the get-tar-commit-id source file to builtin/get-tar-commit-id.c
to reflect its purpose and fix 'make install'.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Hi,

John Keeping wrote:

>  builtin/tar-tree.c                     | 62 -------------------------

Here's a quick fixup on top.  Thoughts?

Thanks,
Jonathan

 Makefile                                    | 3 +--
 builtin/{tar-tree.c => get-tar-commit-id.c} | 0
 2 files changed, 1 insertion(+), 2 deletions(-)
 rename builtin/{tar-tree.c => get-tar-commit-id.c} (100%)

diff --git a/Makefile b/Makefile
index 504931f..37beb73 100644
--- a/Makefile
+++ b/Makefile
@@ -586,7 +586,6 @@ BUILT_INS += git-cherry$X
 BUILT_INS += git-cherry-pick$X
 BUILT_INS += git-format-patch$X
 BUILT_INS += git-fsck-objects$X
-BUILT_INS += git-get-tar-commit-id$X
 BUILT_INS += git-init$X
 BUILT_INS += git-merge-subtree$X
 BUILT_INS += git-show$X
@@ -929,6 +928,7 @@ BUILTIN_OBJS += builtin/fmt-merge-msg.o
 BUILTIN_OBJS += builtin/for-each-ref.o
 BUILTIN_OBJS += builtin/fsck.o
 BUILTIN_OBJS += builtin/gc.o
+BUILTIN_OBJS += builtin/get-tar-commit-id.o
 BUILTIN_OBJS += builtin/grep.o
 BUILTIN_OBJS += builtin/hash-object.o
 BUILTIN_OBJS += builtin/help.o
@@ -980,7 +980,6 @@ BUILTIN_OBJS += builtin/show-ref.o
 BUILTIN_OBJS += builtin/stripspace.o
 BUILTIN_OBJS += builtin/symbolic-ref.o
 BUILTIN_OBJS += builtin/tag.o
-BUILTIN_OBJS += builtin/tar-tree.o
 BUILTIN_OBJS += builtin/unpack-file.o
 BUILTIN_OBJS += builtin/unpack-objects.o
 BUILTIN_OBJS += builtin/update-index.o
diff --git a/builtin/tar-tree.c b/builtin/get-tar-commit-id.c
similarity index 100%
rename from builtin/tar-tree.c
rename to builtin/get-tar-commit-id.c
-- 
1.8.4.1
