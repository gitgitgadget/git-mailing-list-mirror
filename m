From: Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCH v7 0/2] Implement the GIT_TRACE_CURL environment variable
Date: Mon, 23 May 2016 13:44:01 +0000
Message-ID: <20160523134403.43880-1-gitter.spiros@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Elia Pinto <gitter.spiros@gmail.com>
To: git@vger.kernel.org, tboegi@web.de, ramsay@ramsayjones.plus.com,
	gitster@pobox.com, sunshine@sunshineco.com, peff@peff.net
X-From: git-owner@vger.kernel.org Mon May 23 15:44:52 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b4qA7-0004ji-9M
	for gcvg-git-2@plane.gmane.org; Mon, 23 May 2016 15:44:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752867AbcEWNoq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 May 2016 09:44:46 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:33016 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750867AbcEWNop (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 May 2016 09:44:45 -0400
Received: by mail-wm0-f68.google.com with SMTP id 67so15269316wmg.0
        for <git@vger.kernel.org>; Mon, 23 May 2016 06:44:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MRmnwPICj9ZZXj3F5CnFxRYm2pESn2Q5xFBl+zdSK1E=;
        b=UBGzA4ji94JbyE3LkMdQY/28a8wetim2Ji4BImhcdjfqTdjC4lEfuQpvW3hhiO6YEj
         uPgKjapdCsbAmrUzeUs1M+Fk1UkGdIz77crT4kdABPqD49m+DSTMGq+MCDsp4VLCOhtt
         E7dg5M4rPBWN+tJebEetE+kYGZ2GL95gXgSelq4DclZKAAdsUx6jGX0GNWm5NIgaIg7G
         AFQ02W/RATwSnTRdrg5ulaO1pcp5HuSVj18fi2Ez31zsOyLU1/ulH0vzPN4D8rl/OTnU
         wI6RFUNEualTVLazPVvdAfGQuSAbeNO0EKFUAYbaQTAfqErxIFhyQwrJsY6Tvq2+EJ9q
         h/Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MRmnwPICj9ZZXj3F5CnFxRYm2pESn2Q5xFBl+zdSK1E=;
        b=kArqcp081Szlt4NpCkPWLIp6BLlAeoYJI13OFMLVpSgVqNRKkZwP7ty9lKEqahe8kq
         dQgZ1Z69IG4Wm0DKKEIiH3pivSZh/SSdP3NAHOWlf2ypAJPy72vIC33qXcfK/80pUdAI
         8X3JrUwQvHIkyjrVYl1KgWwQsjG7UUaw9xGrB1XhagFJqMcndRXTDccyiSLyo0gPBk2X
         2NEMzwHOyuD7tBgp5r+4qYM310PMIRwUtQ0t6HX3YRt6raOb5aMMEumOwuQOoLfkl7yA
         MZtYQ7eeAHwLIHZdyWSKVF5uJSXjqIUYY+IcqQmKaUj2NJbGn44jOZxFE+Kw0kpiVsSR
         bcGw==
X-Gm-Message-State: ALyK8tK9uZeHYLODu0YdP5A9DPMC2gu2k3deBgvofjKI7+7hQRjcWiX1+JDf4ity0H66uQ==
X-Received: by 10.28.68.68 with SMTP id r65mr10676728wma.11.1464011084018;
        Mon, 23 May 2016 06:44:44 -0700 (PDT)
Received: from ubuntu2pinto.pd5x2phgis1evm2itoce0l41ib.ax.internal.cloudapp.net ([23.101.69.192])
        by smtp.gmail.com with ESMTPSA id t3sm13764131wmf.20.2016.05.23.06.44.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 23 May 2016 06:44:43 -0700 (PDT)
X-Mailer: git-send-email 2.8.3.614.g2da74fb.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295321>

This is the  seventh version but in reality is the complete rewriting of the patches discussed here
(here called V1)

$gmane/290520
$gmane/290521

*Changes from V6
($gmane/295158)
- updated with junio suggestions ($gmane/295207)
  * http.c: add redact_sensitive_header() helper
  * http.c: renamed  header_list and ptr_list to
    headers and header
  * http.c: reduce width in curl_dump_data
  * http.c: curl_dump_data. cut strbuf_addch at a sensible place
  * http.c: drop the nopriv_header variable: add an enum instead


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
 http.c                | 125 +++++++++++++++++++++++++++++++++++++++++++++++++-
 http.h                |   2 +
 imap-send.c           |   1 +
 4 files changed, 134 insertions(+), 2 deletions(-)

-- 
2.8.3.614.g2da74fb.dirty
