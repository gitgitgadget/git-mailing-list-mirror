From: Karsten Blees <karsten.blees@gmail.com>
Subject: [PATCH v2] Documentation/i18n.txt: clarify character encoding support
Date: Wed, 01 Jul 2015 21:10:47 +0200
Message-ID: <55943B37.40101@gmail.com>
References: <557C9161.6020703@gmail.com>	<xmqqmw01ltid.fsf@gitster.dls.corp.google.com>	<557EA421.5050706@gmail.com> <xmqqr3pa5aix.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Cc: Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 01 21:10:58 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZANPN-0008WA-NI
	for gcvg-git-2@plane.gmane.org; Wed, 01 Jul 2015 21:10:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753029AbbGATKy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Jul 2015 15:10:54 -0400
Received: from mail-wi0-f172.google.com ([209.85.212.172]:36799 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751985AbbGATKv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Jul 2015 15:10:51 -0400
Received: by widjy10 with SMTP id jy10so66057932wid.1
        for <git@vger.kernel.org>; Wed, 01 Jul 2015 12:10:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=pvVMQ/mV7E0RVq/K+1tLsq5x7jD0+4HAr8ihxGFzwGA=;
        b=TKd9D8jGp25sbvjnbX2C0/rPOecvJJ4Vp9tilI5Ln1JskLbrAjLnFpknrvYa0b1deh
         bxbUIo1uYz7lEW3kRYIPKZs7WGKb8hXMEyhM+oxkgW5sKuKrhXjheUisLPlmY8Dai3hb
         jKvMxKmlfge1UJdouOMevYFJJn7TU0EW9hwdXE16PhGhIH4zJ/uhs7YNjRhBEMOGj3Iu
         uBR2TsedbHLaUkbgkV3hb97tSLZNi0b9xoNS624iOCrS+MZ2sLEfxi4tTHyv/T76f0CN
         PkhrIhYLubFxDr85E3S21HjSOmmvK2Va230Lqcb8FXocevM7VLYfP5o0Ex5tKUXCUEeb
         olrA==
X-Received: by 10.180.77.200 with SMTP id u8mr9512786wiw.70.1435777850239;
        Wed, 01 Jul 2015 12:10:50 -0700 (PDT)
Received: from [10.1.116.51] (ns.dcon.de. [77.244.111.149])
        by mx.google.com with ESMTPSA id v3sm23382983wiz.14.2015.07.01.12.10.48
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 Jul 2015 12:10:49 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.3.0
In-Reply-To: <xmqqr3pa5aix.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273188>

As a "distributed" VCS, git should better define the encodings of its core
textual data structures, in particular those that are part of the network
protocol.

That git is encoding agnostic is only really true for blob objects. E.g.
the 'non-NUL bytes' requirement of tree and commit objects excludes
UTF-16/32, and the special meaning of '/' in the index file as well as
space and linefeed in commit objects eliminates EBCDIC and other non-ASCII
encodings.

Git expects bytes < 0x80 to be pure ASCII, thus CJK encodings that partly
overlap with the ASCII range are problematic as well. E.g. fmt_ident()
removes trailing 0x5C from user names on the assumption that it is ASCII
'\'. However, there are over 200 GBK double byte codes that end in 0x5C.

UTF-8 as default encoding on Linux and respective path translations in the
Mac and Windows versions have established UTF-8 NFC as de-facto standard
for path names.

Update the documentation in i18n.txt to reflect the current status-quo.

Signed-off-by: Karsten Blees <blees@dcon.de>
---

Sorry for the delay, got swamped with other stuff...

Am 17.06.2015 um 22:45 schrieb Junio C Hamano:
> 
> ... I am OK to describe "pathnames are mangled into UTF-8 NFC on
> certain filesystems" as a warning.  I am OK if we encourage the use
> of UTF-8, especially if a project wants to be forward looking
> (i.e. it may currently be a monoculture but may become cross
> platform in the future).  I just do not want to see us saying "you
> *must* encode your path in UTF-8 NFC".
> 
...
> Yes, that is exatly what I said, isn't it?  "Use whatever works for
> your project, we do not dictate."


IMO we *have* to clearly specify an encoding. This freedom of choice
you're proclaiming just does not work in reality.

E.g. Git for Windows prior to 1.7.10 recorded file names in Windows
system encoding, which was perfectly legitimate according to the
documentation. Yet we had numerous bug reports regarding file name
encoding problems (you couldn't even share repos across different
Windows versions, let alone with Linux / Mac / JGit...).

You cannot simply tell users that this is because of Git's superior,
flexible design and its their own fault...except of course if you
want them to switch to VCSes that *do* properly define their file
formats and network protocols - such as subversion or bazaar.
(sorry for the sarcasm, couldn't resist)

I think its important to realize that specifying an encoding is
*not* a limitation - on the contrary: it *enables* us to do things
that would be impossible if file names were just "uninterpreted
sequences of non-NUL bytes". This includes features that are so
fundamental that we take them for granted, e.g. displaying file
names using *real* characters rather than just octal escapes.


I've rewritten the path name paragraph to better describe the
problems to expect with legacy encodings. I hope you like this
version better.

Of course, it would be nice to hear other opinions as well - this
probably shouldn't be a discussion between the two of us :-)

Karsten



 Documentation/i18n.txt | 33 +++++++++++++++++++++++----------
 1 file changed, 23 insertions(+), 10 deletions(-)

diff --git a/Documentation/i18n.txt b/Documentation/i18n.txt
index e9a1d5d..2dd79db 100644
--- a/Documentation/i18n.txt
+++ b/Documentation/i18n.txt
@@ -1,18 +1,31 @@
-At the core level, Git is character encoding agnostic.
-
- - The pathnames recorded in the index and in the tree objects
-   are treated as uninterpreted sequences of non-NUL bytes.
-   What readdir(2) returns are what are recorded and compared
-   with the data Git keeps track of, which in turn are expected
-   to be what lstat(2) and creat(2) accepts.  There is no such
-   thing as pathname encoding translation.
+Git is to some extent character encoding agnostic.
 
  - The contents of the blob objects are uninterpreted sequences
    of bytes.  There is no encoding translation at the core
    level.
 
- - The commit log messages are uninterpreted sequences of non-NUL
-   bytes.
+ - Path names are encoded in UTF-8 normalization form C. This
+   applies to tree objects, the index file, ref names, as well as
+   path names in command line arguments, environment variables
+   and config files (`.git/config` (see linkgit:git-config[1]),
+   linkgit:gitignore[5], linkgit:gitattributes[5] and
+   linkgit:gitmodules[5]).
++
+Note that Git at the core level treats path names simply as
+sequences of non-NUL bytes, there are no path name encoding
+conversions (except on Mac and Windows). Therefore, using
+non-ASCII path names will mostly work even on platforms and file
+systems that use legacy extended ASCII encodings. However,
+repositories created on such systems will not work properly on
+UTF-8-based systems (e.g. Linux, Mac, Windows) and vice versa.
+Additionally, many Git-based tools simply assume path names to
+be UTF-8 and will fail to display other encodings correctly.
+
+ - Commit log messages are typically encoded in UTF-8, but other
+   extended ASCII encodings are also supported. This includes
+   ISO-8859-x, CP125x and many others, but _not_ UTF-16/32,
+   EBCDIC and CJK multi-byte encodings (GBK, Shift-JIS, Big5,
+   EUC-x, CP9xx etc.).
 
 Although we encourage that the commit log messages are encoded
 in UTF-8, both the core and Git Porcelain are designed not to
-- 
2.4.3.windows.1.1.g87477f9
