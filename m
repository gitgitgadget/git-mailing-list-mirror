From: Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCH v6 0/2]  Implement the GIT_TRACE_CURL environment variable
Date: Fri, 20 May 2016 10:37:06 +0000
Message-ID: <20160520103708.38308-1-gitter.spiros@gmail.com>
Cc: Elia Pinto <gitter.spiros@gmail.com>
To: git@vger.kernel.org, tboegi@web.de, ramsay@ramsayjones.plus.com,
	gitster@pobox.com, sunshine@sunshineco.com, peff@peff.net
X-From: git-owner@vger.kernel.org Fri May 20 12:38:10 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b3hok-0006QP-KF
	for gcvg-git-2@plane.gmane.org; Fri, 20 May 2016 12:38:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933048AbcETKhu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 May 2016 06:37:50 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:36267 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933035AbcETKhs (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 May 2016 06:37:48 -0400
Received: by mail-wm0-f66.google.com with SMTP id w143so27897524wmw.3
        for <git@vger.kernel.org>; Fri, 20 May 2016 03:37:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=pouxUCHYqpEmAHCoZzL7T00YroqiJwp007tBoisMcWc=;
        b=d4OOPo1MtRHKwmhm1VL65YIMZLFDo6znVqDGVx4mTWoXUYmAueYMzJlBke8iZoO9xQ
         puiR/mcfsMRnio3xut/9qMsjAznFF9cm0niP5i8dkLG0Jz5EPB27DyMHzx5oDDJIPTeO
         nsEhosmdEk4CMxj/zrrZbaQMJ/cdXo+7JjjgHOOThT5vN3hNQ03Fx5NuGcK7QS1GUNpx
         CfIPOBcSR8oCjvbzmiGYAcZF/aX0t+t0VOasx03fKgrsSwognOGCMR0s0Iomn8f/EhNv
         QF5zEmRzlXxfxd3iqiRJdB2eoEQvm3VPdOjmxa0vEvDQegDoOYgKqNjX0uZoQYUIyGDw
         CF7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=pouxUCHYqpEmAHCoZzL7T00YroqiJwp007tBoisMcWc=;
        b=ZNS7PnUglMnHPjzrQhdrOLfIvzRw4aqD/qFaBdOrid/OuggMPw04oYdP3SGzwweFmQ
         wctz8LmbPpKOvs+V1h8g3CE8xfynQ3TCdxuVBPl7zXvnoHp708c8ZJK62oehMK1fVkgA
         hjyPDmyR48OVzk4C8Pu/+EFFiKC7rnRQEpj5NOi58xoDjY100ll4yjt+iYKIKoJo+p58
         ZY7EuUw1On4CxghR83faYNp83AxDNeUDdGp6u/xqooJUsI2LRPT9Iw7oqD/b/zDB9c4h
         Y8DCvtacroDcxSn4ZMRw5sO9gK1XlMj7olhE3QmYRO7vyK7lV5eirlcOEmm6jhjdzsXm
         HYWw==
X-Gm-Message-State: AOPr4FVyp52E07VWjCoQlD0svcHv0h7VFMe0M7jCICQUKSYkTKXsGjCjFCscOGWaEWGDvA==
X-Received: by 10.28.223.86 with SMTP id w83mr2979287wmg.95.1463740667126;
        Fri, 20 May 2016 03:37:47 -0700 (PDT)
Received: from ubuntu2pinto.pd5x2phgis1evm2itoce0l41ib.ax.internal.cloudapp.net ([23.101.69.192])
        by smtp.gmail.com with ESMTPSA id k127sm1372659wmf.21.2016.05.20.03.37.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 20 May 2016 03:37:46 -0700 (PDT)
X-Mailer: git-send-email 2.8.2.435.g7c6234f.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295159>

This is the sixty version but in reality is the complete rewriting of the patches discussed here
(here called V1)

$gmane/290520
$gmane/290521

*Changes from V5
($gmane/293236)

- don't export curl_trace anymore. Define it static
- fix a minor cleanup (style) in setup_curl_trace
- and, finally, i rewrote completely curl_dump, separating it
into two functions (one for http header and one for the http data),
hoping for a coherent implementation with curl --ascii-trace output
but easier to read than the previous implementation that
used a hard-to-read double-loop.

 
*Changes from V4
($gmane/292867)

-  add a better abstraction with the routine setup_curl_trace
-  curl_dump : drop the noex parameter, define nopriv boolean as int
-  use decimal constant where appropiate
-  fix multi-line comment
-  redo the authorization header skip with a replace of possible sensitive data.
   We prefer to print only:
       09:00:53.238330 http.c:534              => Send header: Authorization:  <redacted>
   intested of
       09:00:53.238330 http.c:534              => Send header: Authorization:  Basic(o other scheme) <redacted>
   as it was done in the original proposed suggestion by Jeff King.
   This is because i think it's better not to print even the authorization scheme.
   We add also the (previously missing) proxy-authorization case
-  curl_dump: fix strbuf memory leak

as suggested by Jeff King
($gmane/292891)
($gmane/292892)

In this series i keep the original curl_dump parsing code, even though it is
objectively difficult to read. This is because the same code is used internally by curl
to do "ascii-trace" and is also reported in the libcurl code examples and test.
I think this may make maintenance of code easier in the future (libcurl
new dev, new features and so on)

Of course if the maintainer (or other) believes it is really necessary
to rewrite the above code to accept the patches i will do.

*Changes from V3
($gmane/292040)

- add missing static to curl_dump
- reorder the patch order
- tried to fix all (but i am not sure) the problems reported by Julio ($gmane/292055)
- * squash the documentation with the http.c commit.
  * in the trace prefix each line to indicate it is about sending a header, and drop the
    initial hex count
  * auto-censor Authorization headers by default

    as suggested by Jeff King ($gmane/292074)

*Changes from V2
($gmane/291868)

- fix garbage comment in http.c (i am very sorry for that)
- add final '.' to the commit message for imap-send.c and to other commit messages
- typofix double ; in http.c
- merge the nice cleanup and code refactoring of Ramsay Jones (Thank you very much !!)
- squash the previous commit 2/4

*Changes from V1

- introduced GIT_TRACE_CURL variable with its documentation
- changed the name of the temporary variable "i" in "w" in the helper routine
- used the c escape sequences instead of the hex equivalent
- dropped the previous GIT_DEBUG_CURL env var
- curl_dump and curl_trace factored out to a shared implementation
in http.c




Elia Pinto (2):
  http.c: implement the GIT_TRACE_CURL environment variable
  imap-send.c: introduce the GIT_TRACE_CURL enviroment variable

 Documentation/git.txt |   8 ++++
 http.c                | 123 +++++++++++++++++++++++++++++++++++++++++++++++++-
 http.h                |   2 +
 imap-send.c           |   1 +
 4 files changed, 132 insertions(+), 2 deletions(-)

-- 
2.8.2.435.g7c6234f.dirty
