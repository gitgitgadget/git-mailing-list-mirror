From: Piotr Krukowiecki <piotr.krukowiecki@gmail.com>
Subject: A better git diff --word-diff (--word-diff-regex) ?
Date: Mon, 19 Mar 2012 10:44:31 +0100
Message-ID: <CAA01CsrJ12LmNYe6ujnDsZecJcGc8mFaB=1GC8-RZzvMYbYuUw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Mar 19 10:44:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S9Z8m-0002sq-Vg
	for gcvg-git-2@plane.gmane.org; Mon, 19 Mar 2012 10:44:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758688Ab2CSJoc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Mar 2012 05:44:32 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:38345 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755987Ab2CSJob (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Mar 2012 05:44:31 -0400
Received: by iagz16 with SMTP id z16so9220231iag.19
        for <git@vger.kernel.org>; Mon, 19 Mar 2012 02:44:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=cpAkRH0sd0rrbF4ZekW9zEuweeVz7aPQPOS2/DTmvbE=;
        b=LWCjLri1s10YCIgstXLBsCkZm5teGQImnGrCljqSss1pEvHo/z3C/DoyWurcdt9sIc
         7pYp26nxRwQioaa0R8s/GL5Q/sH2azmasIrg6JmTL6uB4jDkN8JZkR4vqPNBS1KTMhe3
         aPQcIcutmwk3oQfX1xvtxo6UztBP+qlb80M7c+e1paJugwkfpTPtIbBHuuXB8B/bp3n3
         GzRrvu3D7WZNqqAVGfXB3olaJePJFEUIz3urhBAPMdDi/Or3HQf62+ZaEyUQVPIlRrpW
         zNZZG53F8zcjJP1PW2WyCOrgfaiW+nzIsL4P7jYuHwT0KGsjaz8xiHVvY1NgoyvqMJ3z
         I1xg==
Received: by 10.50.161.232 with SMTP id xv8mr5654923igb.9.1332150271202; Mon,
 19 Mar 2012 02:44:31 -0700 (PDT)
Received: by 10.50.170.40 with HTTP; Mon, 19 Mar 2012 02:44:31 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193420>

Hi,

is there a way to configure --word-diff to be a more programming
language friendly? For example if I add one parameter to a function
declaration, I'd like to see only the addition of the parameter as the
change. But currently it shows much more.

For example if
  void foo(int x);
is changed to
  void foo(int x, int y);
I'd like to see only ",int y" as the change, not "x, int y);".

I think I'd like to ignore all white spaces and tokenize text on word
boundaries and see the diff between the tokens. This way if I e.g. add
a missing ";" it'll be shown as the only change.


$ echo 'void foo(int x);' > foo.c && git add foo.c && git commit -m "foo"
[master (root-commit) 5af60cb2] foo
 1 files changed, 1 insertions(+), 0 deletions(-)
 create mode 100644 foo.c

$ echo 'void foo(int x, int y);' > foo.c && git diff --word-diff
diff --git a/foo.c b/foo.c
index 42a5d4e9..289eb233 100644
--- a/foo.c
+++ b/foo.c
@@ -1 +1 @@
void foo(int [-x);-]{+x, int y);+}


Thanks,
-- 
Piotr Krukowiecki
