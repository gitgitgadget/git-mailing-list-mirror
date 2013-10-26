From: Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH 0/3] Fix tests on Windows caused by random CRLF output
Date: Sat, 26 Oct 2013 21:17:13 +0200
Message-ID: <cover.1382814437.git.j6t@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: msysgit@googlegroups.com,
	Johannes Sixt <j6t@kdbg.org>
To: git@vger.kernel.org
X-From: msysgit+bncBCJYV6HBKQIM3KVQSMCRUBBWPOZ7Q@googlegroups.com Sat Oct 26 21:17:35 2013
Return-path: <msysgit+bncBCJYV6HBKQIM3KVQSMCRUBBWPOZ7Q@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-lb0-f188.google.com ([209.85.217.188])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCJYV6HBKQIM3KVQSMCRUBBWPOZ7Q@googlegroups.com>)
	id 1Va9Mb-0004ir-Uj
	for gcvm-msysgit@m.gmane.org; Sat, 26 Oct 2013 21:17:33 +0200
Received: by mail-lb0-f188.google.com with SMTP id w6sf276092lbh.5
        for <gcvm-msysgit@m.gmane.org>; Sat, 26 Oct 2013 12:17:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=mime-version:from:to:cc:subject:date:message-id:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe:content-type;
        bh=UnTHHzItlJ3S0k9oq8gwt9B12wo+eaERYta7wtM1/zQ=;
        b=kaYIBRjo3zIYq7u61bhc/LdBK1pAO8ja5jWlM3Ik+SDu5MrlDHzU6UO7dOWisefwDQ
         RF+MtFDYO3WU16wOHd3KIZDQDjRZC7eijinO5kXoaop9mikoLQdx9ELZCOlgNFSN3/w0
         4+S/OzrPutG9GyZQyHyhz6qxg8BsTw+ZWquAYZDg62Z6YOHpNbReWhwIbZxdt/eeD/zz
         ZSZQ5nBLp0FwLETLEY5taOAj9wn1iONfxuyNKaAm8ygnOuuXN5cN+6pAk/2uMHvGfJ5M
         cTTieJM17zWmHxEfBIcS6cqWIUV75NCcV4E3edWKEIzFkkGFwcqXsrx/whcFZOVb/wWp
         0rKQ==
X-Received: by 10.180.221.38 with SMTP id qb6mr34062wic.1.1382815053599;
        Sat, 26 Oct 2013 12:17:33 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.180.88.194 with SMTP id bi2ls294378wib.27.gmail; Sat, 26 Oct
 2013 12:17:32 -0700 (PDT)
X-Received: by 10.180.108.81 with SMTP id hi17mr670570wib.3.1382815052715;
        Sat, 26 Oct 2013 12:17:32 -0700 (PDT)
Received: from bsmtp.bon.at (bsmtp5.bon.at. [195.3.86.187])
        by gmr-mx.google.com with ESMTP id j45si1968979eep.0.2013.10.26.12.17.32
        for <msysgit@googlegroups.com>;
        Sat, 26 Oct 2013 12:17:32 -0700 (PDT)
Received-SPF: neutral (google.com: 195.3.86.187 is neither permitted nor denied by best guess record for domain of j6t@kdbg.org) client-ip=195.3.86.187;
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 3BC2513004A;
	Sat, 26 Oct 2013 21:17:32 +0200 (CEST)
Received: from dx.sixt.local (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id D074D19F60F;
	Sat, 26 Oct 2013 21:17:31 +0200 (CEST)
X-Mailer: git-send-email 1.8.4.33.gd68f7e8
X-Original-Sender: j6t@kdbg.org
X-Original-Authentication-Results: gmr-mx.google.com;       spf=neutral
 (google.com: 195.3.86.187 is neither permitted nor denied by best guess
 record for domain of j6t@kdbg.org) smtp.mail=j6t@kdbg.org
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
X-Google-Group-Id: 152234828034
List-Post: <http://groups.google.com/group/msysgit/post>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit>
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:googlegroups-manage+152234828034+unsubscribe@googlegroups.com>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236765>

When git, the executable, invokes a bash script (hooks, scripted
git commands, ...), bash writes its output with CRLF. This causes
tests to fail because the expected output does not contain CR, only LF.

This fixes the tests by replacing test_cmp with a diff computation
that disregards the CR.

Patch 1 replaces test_cmp with cmp when binary data is compared.
Patch 2 is the actual fix.
Patch 3 removes some work-arounds that are not necessary anymore.

Johannes Sixt (3):
  t5300-pack-object: do not compare binary data using test_cmp
  Windows: a test_cmp that is agnostic to random LF <> CRLF conversions
  tests: undo special treatment of CRLF for Windows

 t/lib-credential.sh          |  4 ---
 t/t5300-pack-object.sh       | 10 +++----
 t/t7407-submodule-foreach.sh |  4 ---
 t/t9001-send-email.sh        |  1 -
 t/test-lib-functions.sh      | 66 ++++++++++++++++++++++++++++++++++++++++++++
 t/test-lib.sh                |  1 +
 6 files changed, 72 insertions(+), 14 deletions(-)

-- 
1.8.4.33.gd68f7e8

-- 
-- 
*** Please reply-to-all at all times ***
*** (do not pretend to know who is subscribed and who is not) ***
*** Please avoid top-posting. ***
The msysGit Wiki is here: https://github.com/msysgit/msysgit/wiki - Github accounts are free.

You received this message because you are subscribed to the Google
Groups "msysGit" group.
To post to this group, send email to msysgit@googlegroups.com
To unsubscribe from this group, send email to
msysgit+unsubscribe@googlegroups.com
For more options, and view previous threads, visit this group at
http://groups.google.com/group/msysgit?hl=en_US?hl=en

--- 
You received this message because you are subscribed to the Google Groups "msysGit" group.
To unsubscribe from this group and stop receiving emails from it, send an email to msysgit+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/groups/opt_out.
