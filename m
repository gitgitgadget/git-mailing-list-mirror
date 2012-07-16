From: tuxdna <tuxdna@gmail.com>
Subject: Bug: fatal: patch fragment without header at line
Date: Mon, 16 Jul 2012 19:06:51 +0530
Message-ID: <CAK5QfLMs6CMCTtZ3woQfMim1ssYLKEURAMv8+FgqrKJ7otNcnw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=14dae93408a3b8c9b004c4f28550
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 16 15:37:04 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SqlTy-0001e7-02
	for gcvg-git-2@plane.gmane.org; Mon, 16 Jul 2012 15:37:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753499Ab2GPNgx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Jul 2012 09:36:53 -0400
Received: from mail-gg0-f174.google.com ([209.85.161.174]:44069 "EHLO
	mail-gg0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751611Ab2GPNgw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jul 2012 09:36:52 -0400
Received: by gglu4 with SMTP id u4so4972819ggl.19
        for <git@vger.kernel.org>; Mon, 16 Jul 2012 06:36:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=tjRfg4g/BRHi5ueV6JfbhBdDqyI1QNz2r+8nJ6tfjhI=;
        b=T5DMoThWx5Gygj0U/nYVZnKnrJsFekYIbknQmnfWuKhPBGHp821vkjxcFVpb1O92e8
         v/2TV7gtO1SA4ePgfAa2o55EZNBuFk8ocyQ5S3GIut5q49fUvbDrzrtfBdDMVfcwPRgk
         5tVyAiBSdkC981Kr6lIVdSQww+lT3816a9zOhBGCzFX8O4jAY5BfQPXtUT4e7HzFur04
         jtzjhO9ZrnDnU/ko1Nz1q1eA4FQBWv8Avb4oB3g8IjOO7aO+iBsIsv3T6EN/I2QZUFtk
         DYVxRIOAyZjpxYwCZkTnchs2Ef8bxzksfHOfQpIBZ/1+RUSmu4Vqg3aogcZ9okuTvrkY
         tCWQ==
Received: by 10.50.181.136 with SMTP id dw8mr5273152igc.31.1342445811452; Mon,
 16 Jul 2012 06:36:51 -0700 (PDT)
Received: by 10.64.54.40 with HTTP; Mon, 16 Jul 2012 06:36:51 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201519>

--14dae93408a3b8c9b004c4f28550
Content-Type: text/plain; charset=ISO-8859-1

Git version: git-1.7.7.6-1.fc16.x86_64

I am getting an error with a patch that I am applying to a git repository.
I have created a test case for this issue that I am facing.

$ git apply --check 0001-modified-README.patch
fatal: patch fragment without header at line 7: @@ -635,9 +635,7 @@
some_function()

Clearly line 7 appears to be a patch but it isn't. It is the part of
email body or the patch context.
To my understanding, the patch should always be identified whenever
the patch block starts
with a "diff --git", which is line 21 as below:

     1	From aa3acc563af0422e6a9f4afc432b7fabdf845d81 Mon Sep 17 00:00:00 2001
     2	From: Saleem Ansari <tuxdna@gmail.com>
     3	Date: Mon, 16 Jul 2012 17:42:58 +0530
     4	Subject: [PATCH] modified README
     5	
     6	
     7	@@ -635,9 +635,7 @@ some_function()
     8	
     9	
    10	-       # a comment here
    11	+       not a comment
    12	
    13	
    14	
    15	thats all folks
    16	
    17	---
    18	 README |    1 +
    19	 1 files changed, 1 insertions(+), 0 deletions(-)
    20	
    21	diff --git a/README b/README
    22	index ce01362..d294257 100644
    23	--- a/README
    24	+++ b/README
    25	@@ -1 +1,2 @@
    26	 hello
    27	+this is a readme
    28	--
    29	1.7.7.6
    30	

Apart from changing the patch itself, how else can I work-around this problem?

Steps to create and verify the testcase:

# Create a temporary directory
mkdir /tmp/bug
cd /tmp/bug
git init .
echo "hello" > README
git commit -m "Initial commit"

# create a test branch for verification later
git checkout -b test

# make changes into a different branch
git checkout -b bugger
echo "this is a readme" > README
git commit -m "modified README"
git format-patch HEAD^ # this will generate 0001-modified-README.patch
# Now inside the patch email body add some random patch which should break
# or download the attachment ( 0001-modified-README.patch )

/tuxdna

--14dae93408a3b8c9b004c4f28550
Content-Type: application/octet-stream; name="0001-modified-README.patch"
Content-Disposition: attachment; filename="0001-modified-README.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_h4pl08d20

RnJvbSBhYTNhY2M1NjNhZjA0MjJlNmE5ZjRhZmM0MzJiN2ZhYmRmODQ1ZDgxIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBTYWxlZW0gQW5zYXJpIDx0dXhkbmFAZ21haWwuY29tPgpEYXRl
OiBNb24sIDE2IEp1bCAyMDEyIDE3OjQyOjU4ICswNTMwClN1YmplY3Q6IFtQQVRDSF0gbW9kaWZp
ZWQgUkVBRE1FCgoKQEAgLTYzNSw5ICs2MzUsNyBAQCBzb21lX2Z1bmN0aW9uKCkKCgotICAgICAg
ICMgYSBjb21tZW50IGhlcmUKKyAgICAgICBub3QgYSBjb21tZW50CgoKCnRoYXRzIGFsbCBmb2xr
cwoKLS0tCiBSRUFETUUgfCAgICAxICsKIDEgZmlsZXMgY2hhbmdlZCwgMSBpbnNlcnRpb25zKCsp
LCAwIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL1JFQURNRSBiL1JFQURNRQppbmRleCBjZTAx
MzYyLi5kMjk0MjU3IDEwMDY0NAotLS0gYS9SRUFETUUKKysrIGIvUkVBRE1FCkBAIC0xICsxLDIg
QEAKIGhlbGxvCit0aGlzIGlzIGEgcmVhZG1lCi0tIAoxLjcuNy42Cgo=
--14dae93408a3b8c9b004c4f28550--
