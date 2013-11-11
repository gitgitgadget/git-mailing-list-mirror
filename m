From: Ken Tanzer <ken.tanzer@gmail.com>
Subject: git rm / format-patch / am fails on my file: patch does not apply
Date: Sun, 10 Nov 2013 18:39:10 -0800
Message-ID: <CAD3a31XPKsnuNE+szw7xgvaDrcxhKZ2jTDHKzTwdwtnCwFb_0w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Philip Oakley <philipoakley@iee.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 11 03:40:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VfhQ0-0002AL-Pv
	for gcvg-git-2@plane.gmane.org; Mon, 11 Nov 2013 03:40:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751123Ab3KKCjw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Nov 2013 21:39:52 -0500
Received: from mail-pa0-f53.google.com ([209.85.220.53]:51831 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751003Ab3KKCju (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Nov 2013 21:39:50 -0500
Received: by mail-pa0-f53.google.com with SMTP id kx10so4677938pab.40
        for <git@vger.kernel.org>; Sun, 10 Nov 2013 18:39:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:cc:content-type;
        bh=jUhJ6RYSjPh2GgTtH5T3vNTjke2MlWwIzOz8knk5fVg=;
        b=HNP7Hr7BLO+sDAUmNAQJ4dw6/8SVWthSv2NB1iRsHNE7wzDI8+ONj+T9PUCDhNNcWt
         h6xofhDISKN9HuGgzdHjgAwOmy9qEsZrEfoOJ3SvDrt5hbXZX8Vfo0kDu+ZnpconeYSR
         vWfQ1T0L5VxOqxdlcm8xh6hjDv8l9BKEvV0OC2T898k/BXRgr4YGzQxQe3anscPqYXAm
         mDrE9oH2C0HN7jsLh2xL+RwSal7MiHQJybsp6cpqMJ3A8opQ9vvVMpmBTuAw7eGJmpJN
         gQnZps2jQ+GZJrEqp5VKtOLnYHxnxjSGwSQH+N195sVLa5UZ+7EiV8q8pYwgDXnBpOXR
         o7Ow==
X-Received: by 10.68.180.131 with SMTP id do3mr27946386pbc.34.1384137590259;
 Sun, 10 Nov 2013 18:39:50 -0800 (PST)
Received: by 10.66.227.170 with HTTP; Sun, 10 Nov 2013 18:39:10 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237595>

I originally posted about this to the git-users list
(https://groups.google.com/forum/#!topic/git-users/G5D0bldEbTo).  If
this would normally be expected to work:

git add <file>
git commit
git rm <file>
git commit
git format-patch HEAD~1
git reset --hard HEAD~1
git am 0001*patch

then I'm having a problem with at least one (maybe more) file I have
in a repository that seems like a bug.  Even if I copy it to a new
repository, it will still fail, so it seems something about how git
handles the file, which "file" reports as:

ASCII text, with very long lines, with CRLF, CR, LF line terminators

I've confirmed with the following test case on three machines, so it
seems reproducible:

mkdir temp_test_case
cd temp_test_case
git init
# my file.  Sorry--couldn't find a saner link!
wget -O jquery-ui-1.8.custom.min.js
http://sourceforge.net/p/agency/code/ci/9358ea4dbe8e1540ec0b8bebfc7770f1bf8be0ec/tree/jquery-ui-1.8.custom.min.js?format=raw
git add jquery-ui-1.8.custom.min.js
git commit -m 'Adding jquery-ui'
git rm jquery-ui-1.8.custom.min.js
git commit -m 'Removing jquery-ui'
git format-patch HEAD~1
git reset --hard HEAD~1
git am 0001*

The last command reports the following:

Applying: Removing jquery-ui
error: patch failed: jquery-ui-1.8.custom.min.js:1
error: jquery-ui-1.8.custom.min.js: patch does not apply
Patch failed at 0001 Removing jquery-ui
The copy of the patch that failed is found in:
   /home/user/newtest2/temp_test_case/.git/rebase-apply/patch
When you have resolved this problem, run "git am --resolved".
If you prefer to skip this patch, run "git am --skip" instead.
To restore the original branch and stop patching, run "git am --abort".

Let me know if I can provide more information, or am missing something
obvious!  Thanks.

Ken
