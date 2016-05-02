From: Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCHv5 0/2] Implement the GIT_TRACE_CURL environment variable
Date: Mon,  2 May 2016 14:28:11 +0000
Message-ID: <20160502142813.50868-1-gitter.spiros@gmail.com>
Cc: tboegi@web.de, ramsay@ramsayjones.plus.com, gitster@pobox.com,
	sunshine@sunshineco.com, peff@peff.net,
	Elia Pinto <gitter.spiros@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 02 16:28:29 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1axEpo-0001VT-Hy
	for gcvg-git-2@plane.gmane.org; Mon, 02 May 2016 16:28:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753101AbcEBO2U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 May 2016 10:28:20 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:34817 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750836AbcEBO2S (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 May 2016 10:28:18 -0400
Received: by mail-wm0-f68.google.com with SMTP id e201so17301901wme.2
        for <git@vger.kernel.org>; Mon, 02 May 2016 07:28:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=xWKudZgpz4pLRvhdVMDIc7qx1eEPyOSOX5VG5FclTGk=;
        b=YCe9/9awUwjSlH/nzE++JiYHbPApWN4qGX2as8rINMWxwJg677XvwPJ1wFI1FcX1NP
         BgNydKaXpsSLsNZHGPDVz42Yk/lz/YWGMWFnTQjaI+pomxawCbCESaTLVLpl7MbQRjtc
         WfTvpSDbAmfAH5rpkiQ/HSeKxdzEPaH492T5QT21cD3np4eNDUvM/JKLJDquc2ClYkIw
         gN1TR1fcjiwFK9moB6HQR2W2Lro5pK9uFk3bVWbAOr7L6OUzUGGEIjpEdKej4ndILHER
         bveX/EFwl6jogiL8qM4hKV6XirqYsz+0qS+HHF4qkytlrX5szj6my20s04B7HSiO/TI6
         oAcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=xWKudZgpz4pLRvhdVMDIc7qx1eEPyOSOX5VG5FclTGk=;
        b=UrBNej5Y/vFEMmnj1Ywp7YNsQrEPvDDFv3WH4DHa8gxYbrjFyeISIxSFHBGCC8aiyx
         nksq4NfkGwwsyCd53XniMIdNzOysidTk7EVsrHhW/315QyLRN4nmAFZFhTldYmd+SgwM
         x3k71UsiEtvWgRNDaQTHiK9fb8yra17DxTLh2Oq5P8/w6AQQS7UG7hXeerOxgaz71THR
         GN8AK0Kd7ZJ6z0ZmYIkVo58uunTdi46gcmdLmXlP+xwiVw1xuOi9fEv0wWy6P6yj1orn
         koVNCYLtBC2G5pueOtu2wjlZicW80CNO2VJn6feGrj+CiZbf/SvtcJoXLGEz/Vz2jlfj
         1MYw==
X-Gm-Message-State: AOPr4FVkMTBnhVNPXfNs2bO8pJSAJ8oVySbinPMAgWyzZWMMs4LveY38wZXNb85D67Y4AQ==
X-Received: by 10.194.20.162 with SMTP id o2mr2039718wje.78.1462199297098;
        Mon, 02 May 2016 07:28:17 -0700 (PDT)
Received: from ubuntu2pinto.pd5x2phgis1evm2itoce0l41ib.ax.internal.cloudapp.net ([23.101.69.192])
        by smtp.gmail.com with ESMTPSA id a200sm19197814wme.8.2016.05.02.07.28.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 02 May 2016 07:28:16 -0700 (PDT)
X-Mailer: git-send-email 2.8.2.435.ga07a3e0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293236>

This is the fifth version but in reality is the complete rewriting of the patches discussed here
(here called V1)

$gmane/290520
$gmane/290521

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
 http.c                | 115 +++++++++++++++++++++++++++++++++++++++++++++++++-
 http.h                |   4 ++
 imap-send.c           |   1 +
 4 files changed, 126 insertions(+), 2 deletions(-)

-- 
2.8.2.435.ga07a3e0
