From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH v2 0/4] --word-regex sanity checking and such
Date: Sat, 18 Dec 2010 17:17:50 +0100
Message-ID: <cover.1292688058.git.trast@student.ethz.ch>
References: <254678.14296.qm@web110704.mail.gq1.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Scott Johnson <scottj75074@yahoo.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Matthijs Kooijman <matthijs@stdin.nl>, <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Dec 18 17:18:06 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PTzTx-0004bM-7p
	for gcvg-git-2@lo.gmane.org; Sat, 18 Dec 2010 17:18:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756797Ab0LRQSA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Dec 2010 11:18:00 -0500
Received: from edge20.ethz.ch ([82.130.99.26]:55122 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756419Ab0LRQR7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Dec 2010 11:17:59 -0500
Received: from CAS21.d.ethz.ch (172.31.51.111) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.1.218.12; Sat, 18 Dec
 2010 17:17:52 +0100
Received: from localhost.localdomain (217.162.250.31) by CAS21.d.ethz.ch
 (172.31.51.111) with Microsoft SMTP Server (TLS) id 14.1.218.12; Sat, 18 Dec
 2010 17:17:57 +0100
X-Mailer: git-send-email 1.7.3.4.789.g74ad1
In-Reply-To: <254678.14296.qm@web110704.mail.gq1.yahoo.com>
X-Originating-IP: [217.162.250.31]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163916>

I wrote:
> * [4/4] I stole the html test from Scott's mail, and some of the rest
>   from various Wikibooks sources on "Hello World" in each language,
>   usually extended by a bit of code that tests the world-splitting
>   power.  I hope this is ok with Scott and the Copyright overlords.
>   There are only so many ways to spell "Hello World", and only so many
>   languages I know myself.

I decided to play it safe, and removed these parts.  In addition I
extended the bulk tests to a C operator table and some forms of
literals for the C-style languages so as to catch issues with
non-matches.  This showed that the python regex had the same typo as
the ruby one. *blush*

Scott's problem still remains:

Scott Johnson wrote:
> Turns out to be system-dependent. I built v1.7.3.3 from source on three 
> different boxes and only one of them is broken.
[...]
> Fedora Core release 6 (Zod)

I briefly considered installing FC6 on a VM, but my VirtualBox is
broken and I'm having a hard time finding a FC6 installation medium.
Right now the only other systems I have are darwin 10.5 and RHEL5.5,
and the test works on both.

So in the absence of any way of testing this, someone with a breaking
system will have to investigate.  I think it's worth including the
series anyway, since the regexes give wrong results in the case of
match failures, and we would want users to know about this.


Thomas Rast (4):
  diff.c: pass struct diff_words into find_word_boundaries
  diff.c: implement a sanity check for word regexes
  userdiff: fix typo in ruby and python word regexes
  t4034: bulk verify builtin word regex sanity

 Documentation/config.txt |    8 ++++
 diff.c                   |  104 +++++++++++++++++++++++++++++++++++++++++----
 diff.h                   |    1 +
 t/t4034-diff-words.sh    |   85 +++++++++++++++++++++++++++++++++++++-
 t/t4034/bibtex/expect    |   15 +++++++
 t/t4034/bibtex/post      |   10 ++++
 t/t4034/bibtex/pre       |    9 ++++
 t/t4034/cpp/expect       |   36 ++++++++++++++++
 t/t4034/cpp/post         |   19 ++++++++
 t/t4034/cpp/pre          |   19 ++++++++
 t/t4034/csharp/expect    |   35 +++++++++++++++
 t/t4034/csharp/post      |   18 ++++++++
 t/t4034/csharp/pre       |   18 ++++++++
 t/t4034/fortran/expect   |   10 ++++
 t/t4034/fortran/post     |    5 ++
 t/t4034/fortran/pre      |    5 ++
 t/t4034/html/expect      |    8 ++++
 t/t4034/html/post        |    3 +
 t/t4034/html/pre         |    3 +
 t/t4034/java/expect      |   36 ++++++++++++++++
 t/t4034/java/post        |   19 ++++++++
 t/t4034/java/pre         |   19 ++++++++
 t/t4034/objc/expect      |   35 +++++++++++++++
 t/t4034/objc/post        |   18 ++++++++
 t/t4034/objc/pre         |   18 ++++++++
 t/t4034/pascal/expect    |   35 +++++++++++++++
 t/t4034/pascal/post      |   18 ++++++++
 t/t4034/pascal/pre       |   18 ++++++++
 t/t4034/php/expect       |   35 +++++++++++++++
 t/t4034/php/post         |   18 ++++++++
 t/t4034/php/pre          |   18 ++++++++
 t/t4034/python/expect    |   34 +++++++++++++++
 t/t4034/python/post      |   17 +++++++
 t/t4034/python/pre       |   17 +++++++
 t/t4034/ruby/expect      |   34 +++++++++++++++
 t/t4034/ruby/post        |   17 +++++++
 t/t4034/ruby/pre         |   17 +++++++
 t/t4034/tex/expect       |    9 ++++
 t/t4034/tex/post         |    4 ++
 t/t4034/tex/pre          |    4 ++
 userdiff.c               |    4 +-
 41 files changed, 842 insertions(+), 13 deletions(-)
 create mode 100644 t/t4034/bibtex/expect
 create mode 100644 t/t4034/bibtex/post
 create mode 100644 t/t4034/bibtex/pre
 create mode 100644 t/t4034/cpp/expect
 create mode 100644 t/t4034/cpp/post
 create mode 100644 t/t4034/cpp/pre
 create mode 100644 t/t4034/csharp/expect
 create mode 100644 t/t4034/csharp/post
 create mode 100644 t/t4034/csharp/pre
 create mode 100644 t/t4034/fortran/expect
 create mode 100644 t/t4034/fortran/post
 create mode 100644 t/t4034/fortran/pre
 create mode 100644 t/t4034/html/expect
 create mode 100644 t/t4034/html/post
 create mode 100644 t/t4034/html/pre
 create mode 100644 t/t4034/java/expect
 create mode 100644 t/t4034/java/post
 create mode 100644 t/t4034/java/pre
 create mode 100644 t/t4034/objc/expect
 create mode 100644 t/t4034/objc/post
 create mode 100644 t/t4034/objc/pre
 create mode 100644 t/t4034/pascal/expect
 create mode 100644 t/t4034/pascal/post
 create mode 100644 t/t4034/pascal/pre
 create mode 100644 t/t4034/php/expect
 create mode 100644 t/t4034/php/post
 create mode 100644 t/t4034/php/pre
 create mode 100644 t/t4034/python/expect
 create mode 100644 t/t4034/python/post
 create mode 100644 t/t4034/python/pre
 create mode 100644 t/t4034/ruby/expect
 create mode 100644 t/t4034/ruby/post
 create mode 100644 t/t4034/ruby/pre
 create mode 100644 t/t4034/tex/expect
 create mode 100644 t/t4034/tex/post
 create mode 100644 t/t4034/tex/pre

-- 
1.7.3.4.789.g74ad1
