From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH] contrib/vim: simplify instructions for old vim support
Date: Thu, 10 Jan 2013 12:54:27 -0800
Message-ID: <20130110205427.GG16532@google.com>
References: <50EEA34B.7070102@gmail.com>
 <20130110113958.GA17137@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Manlio Perillo <manlio.perillo@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jan 10 21:54:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TtP9J-0007Ne-Mi
	for gcvg-git-2@plane.gmane.org; Thu, 10 Jan 2013 21:54:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755055Ab3AJUye (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Jan 2013 15:54:34 -0500
Received: from mail-da0-f53.google.com ([209.85.210.53]:49012 "EHLO
	mail-da0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754546Ab3AJUyd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Jan 2013 15:54:33 -0500
Received: by mail-da0-f53.google.com with SMTP id x6so418753dac.26
        for <git@vger.kernel.org>; Thu, 10 Jan 2013 12:54:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=CuHh5NXzoVoIuljIDtkSz2ISj7gyMXFsol5YrejhaSc=;
        b=rTjJmyOOYnPw2dDBFVaXKYhS3rCyTYrphyNBILqHOAQ8Wav7pMp1uTZZA2YAfSvArP
         /swu4gKs+1ayvNijeAWIW8CiGZg1/acMkAF5L+1t/bDyETtFS38XoSP0K/XuH4688X5t
         ImAm/7JOsZ0W99zp9Sok+koI/y5K66ALTGBOPmwxm0kWpc4p/8/og4vghsz+tIcCiF9k
         A63AbHuAm9A2fjx32GoqFafQmefYrMHFcqegNXcviOrZ2qmMrcBWEb5qbNqpqSyi0obN
         35StOylC1grod+cuu6F1SnxKb13cP/O6Z+5vPUkG1euw/JZkGDCSorTQE9cJxrvbUU+e
         ZPJQ==
X-Received: by 10.68.235.1 with SMTP id ui1mr55101799pbc.138.1357851272615;
        Thu, 10 Jan 2013 12:54:32 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPS id c2sm1625761pay.34.2013.01.10.12.54.30
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 10 Jan 2013 12:54:31 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20130110113958.GA17137@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213151>

Rely on the upstream filetype.vim instead of duplicating its rules in
git's instructions for syntax highlighting support on pre-7.2 vim
versions.

The result is a shorter contrib/vim/README.  More importantly, it lets
us punt on maintenance of the autocmd rules.

So now when we fix the upstream gitsendemail rule in light of commit
eed6ca7, new git users stuck on old vim reading contrib/vim/README can
automagically get the fix without any further changes needed to git.

Once the world has moved on to vim 7.2+ completely, we can get rid of
these instructions, but for now if they are this simple it's
effortless to keep them.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Jeff King wrote:

> I'd argue that we should just remove contrib/vim at this point. It has
> no actual files in it, only pointers to vim.org for pre-7.2 vim users.

I think that's reasonable.  Of course we can still discuss enhancements
to the vim support on this list, but ultimately it's easiest to
distribute and document such work upstream in the usual way for vim
plugins.

How about this patch?

 contrib/vim/README | 16 +++-------------
 1 file changed, 3 insertions(+), 13 deletions(-)

diff --git a/contrib/vim/README b/contrib/vim/README
index fca1e17..8f16d06 100644
--- a/contrib/vim/README
+++ b/contrib/vim/README
@@ -17,16 +17,6 @@ To install:
 
   1. Copy these files to vim's syntax directory $HOME/.vim/syntax
   2. To auto-detect the editing of various git-related filetypes:
-	$ cat >>$HOME/.vim/filetype.vim <<'EOF'
-	autocmd BufNewFile,BufRead *.git/COMMIT_EDITMSG    setf gitcommit
-	autocmd BufNewFile,BufRead *.git/config,.gitconfig setf gitconfig
-	autocmd BufNewFile,BufRead git-rebase-todo         setf gitrebase
-	autocmd BufNewFile,BufRead .msg.[0-9]*
-		\ if getline(1) =~ '^From.*# This line is ignored.$' |
-		\   setf gitsendemail |
-		\ endif
-	autocmd BufNewFile,BufRead *.git/**
-		\ if getline(1) =~ '^\x\{40\}\>\|^ref: ' |
-		\   setf git |
-		\ endif
-	EOF
+
+	$ curl http://ftp.vim.org/pub/vim/runtime/filetype.vim |
+		sed -ne '/^" Git$/, /^$/ p' >>$HOME/.vim/filetype.vim
-- 
1.8.1
