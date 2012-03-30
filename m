From: J Robert Ray <jrobertray@gmail.com>
Subject: rebase -p loses amended changes
Date: Fri, 30 Mar 2012 14:31:24 -0700
Message-ID: <CADb3U=4DNt7Jnzq4eW-K+W1_sEfMgL6MxqY6qmPaJZagiFdmmg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=0015175cd10c2af7a704bc7c913e
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 30 23:41:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SDja2-0001Tw-Oz
	for gcvg-git-2@plane.gmane.org; Fri, 30 Mar 2012 23:41:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936159Ab2C3Vlp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Mar 2012 17:41:45 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:54786 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S936143Ab2C3Vbr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Mar 2012 17:31:47 -0400
Received: by bkcik5 with SMTP id ik5so1004088bkc.19
        for <git@vger.kernel.org>; Fri, 30 Mar 2012 14:31:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=sXFEo3tmrd/db1nJQnUpIVNRMb6cu147aPOK/tOaQ2g=;
        b=br+M+SKWfNKjOvzO0zmjgxCBAK4SiiENTjkUnaDtwJxR9VskMTjpghiMa400f8ofji
         k1uVLqBcfOS4OhXzURBTSEeA9wk763+7Ui1ElFD+CGHMC5VUe/thMS7q/HnXlGVD0jSe
         TKM1hwOuqcG0AmGou7ZupSZ8g4SNol5prmju45HQjiAqsj61nfeo6x82nPwsvkaHTSBm
         8anclqmdCJGdfmDqRo3p2nT6tqG5aVqA/E7PzUkHucQOMtVHDNzHiIo4qQR1jJxs2Zxb
         VXLBScDV4roy7lRVE0WYIv67izUq5Q0lv3PfnXH6hUZMqp87L0moDXmO/WD4uu0R2I8n
         Wxsg==
Received: by 10.204.150.82 with SMTP id x18mr27943bkv.10.1333143104321; Fri,
 30 Mar 2012 14:31:44 -0700 (PDT)
Received: by 10.204.116.135 with HTTP; Fri, 30 Mar 2012 14:31:24 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194413>

--0015175cd10c2af7a704bc7c913e
Content-Type: text/plain; charset=ISO-8859-1

I've found that 'rebase -p' can discard changes from a merge commit
when it recreates the merge.

If a merge is amended to add changes to a file unaffected by the
merge, these changes are lost after a rebase. Attached is a script to
demonstrate the problem.

I've tested the script against git 1.7.9.5.

I'll outline the steps starting from an empty repo.

1. Create a file (a) with some contents, then create three branches
from this point, "mod-a," "mod-b," and "master-copy."

2. In "mod-a," modify a.

3. In "mod-b," create a different file (b).

4. Merge (--no-ff) "mod-a" onto master.

5. Amend the merge with a modification to a.

6. Merge (--no-ff) "mod-b" onto "master-copy."

7. Rebase -p master onto "master-copy."

Notice the change to "a" from step #5 is now gone. "a" reverts to the
pre-amended version after step #4.

I assume this isn't expected behavior and is a bug.

--0015175cd10c2af7a704bc7c913e
Content-Type: application/x-sh; name="rebase-p.sh"
Content-Disposition: attachment; filename="rebase-p.sh"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_h0fqwdhj1

IyEvYmluL3NoCgpybSAtcmYgcmViYXNlLXAKbWtkaXIgcmViYXNlLXAKY2QgcmViYXNlLXAKCmdp
dCBpbml0CgplY2hvICJhIiA+IGEKZ2l0IGFkZCBhCmdpdCBjb21taXQgLW0gJ2FkZCBhJwoKZ2l0
IGJyYW5jaCBtb2QtYQpnaXQgYnJhbmNoIG1vZC1iCmdpdCBicmFuY2ggbWFzdGVyLWNvcHkKCiMg
dGhpcyBzdGVwIGlzIHVubmVjZXNzYXJ5CmdpdCBjaGVja291dCBtb2QtYQplY2hvICJtb3JlIGEi
ID4+IGEKZ2l0IGFkZCBhCmdpdCBjb21taXQgLW0gJ21vZGlmaWVkIGEnCgpnaXQgY2hlY2tvdXQg
bWFzdGVyCmdpdCBtZXJnZSAtLW5vLWZmIG1vZC1hIC1tICdtZXJnZSBtb2QtYScKZWNobyAidGhp
cyBjaGFuZ2Ugd2lsbCBiZSBsb3N0IiA+PiBhCmdpdCBhZGQgYQpnaXQgY29tbWl0IC0tYW1lbmQg
LUMgSEVBRAoKIyBDb21tZW50IHRoaXMgc2VjdGlvbiBhbmQgdGhlIGJ1ZyBpcyBub3QgdHJpZ2dl
cmVkLgpnaXQgY2hlY2tvdXQgbW9kLWIKZWNobyAiYiIgPj4gYgpnaXQgYWRkIGIKZ2l0IGNvbW1p
dCAtbSAnYWRkIGInCgpnaXQgY2hlY2tvdXQgbWFzdGVyLWNvcHkKZ2l0IG1lcmdlIC0tbm8tZmYg
bW9kLWIgLW0gJ21lcmdlIG1vZC1iJwoKZ2l0IGNoZWNrb3V0IG1hc3RlcgplY2hvICJDb250ZW50
cyAnYScgYmVmb3JlIHJlYmFzZSAtcDoiCmVjaG8gIi0tLS0tLS0tLS0tLS0tLS0tLSIKY2F0IGEK
ZWNobyAiLS0tLS0tLS0tLS0tLS0tLS0tIgpnaXQgcmViYXNlIC1wIG1hc3Rlci1jb3B5CmVjaG8g
IkNvbnRlbnRzIG9mICdhJyBhZnRlciByZWJhc2UgLXA6IgplY2hvICItLS0tLS0tLS0tLS0tLS0t
LS0iCmNhdCBhCmVjaG8gIi0tLS0tLS0tLS0tLS0tLS0tLSIK
--0015175cd10c2af7a704bc7c913e--
