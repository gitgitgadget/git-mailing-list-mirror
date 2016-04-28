From: Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCHv4 0/2] Implement the GIT_TRACE_CURL environment variable
Date: Thu, 28 Apr 2016 11:57:46 +0000
Message-ID: <20160428115748.37177-1-gitter.spiros@gmail.com>
Cc: tboegi@web.de, ramsay@ramsayjones.plus.com, gitster@pobox.com,
	sunshine@sunshineco.com, peff@peff.net,
	Elia Pinto <gitter.spiros@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 28 13:58:17 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1avkaH-000284-1g
	for gcvg-git-2@plane.gmane.org; Thu, 28 Apr 2016 13:58:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752665AbcD1L6E (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Apr 2016 07:58:04 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:36707 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752067AbcD1L6D (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Apr 2016 07:58:03 -0400
Received: by mail-wm0-f68.google.com with SMTP id w143so22659830wmw.3
        for <git@vger.kernel.org>; Thu, 28 Apr 2016 04:58:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=ABnXVjXYoWBHYjFfUK+3KVK5IhDqfnBF76Ny15vxUpQ=;
        b=HohNL6e7aU85sS86Gr22d7hnWlvS3u/aBF3YaZOU+J0+jIT7MG699usPB2CmhuaRAa
         lduaFYRTgFiCuGhR+2xcW/QM/Z+dyxlzkOgGczQCljwNK97ogbRKbFyjtwfJ1Mw+ALgU
         d9ctdxTsQUm+yB3Ijjv0XWTwnIpYo/LLvoI3mXLgefDuSWGeP8AW3evRM1pHRj6WT6Y7
         YIBESb5opjdv9GOZDo5/I+/4iVGifHsAczQB7NICUq+7S3cGbWwXcvXWDCCxnexAEI+W
         le8Ob8+y7iqqLoqqk5nZ2h9bd2Iw4fmmpmNgFOn0OyEQbyyM3F6AgQNUIUGuwMlLcvvb
         Gzmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ABnXVjXYoWBHYjFfUK+3KVK5IhDqfnBF76Ny15vxUpQ=;
        b=PNO5PG/0q1MuCczs4gww7IU6cGnN6/4s0uVazxP8WPEJVTzgLZWZ1U+1qqJvpmYUMO
         T/wYpRXAZRLqUyqhNKtI9PplJgJdp/PrEtrXn1F8+PEhwHLu4XlZ79GD7xZ9uJlB0LDs
         LldRsTRgMilP5L2nxGNePdkQuBUa6xpTYHyn0m9ZNBK17HP5R+UPLV8IpIr7HilGM534
         W96dqpBI518RV1kttbx2jYbfAGV1QaPym5PbmPpLtTbgnXGFr3Ny/ctEikstKpnOv87p
         JC+xUIWnimBf6r2cPal5qKGkAkfvYNODgVB8gh8arH+DI+AxQPyndLZJY4wFFxs6aMrd
         JbWw==
X-Gm-Message-State: AOPr4FV8FcM4X1k02HFUoB2J1gLt+LsChLF6EGxN4ZH5hQ/waNjzeWNvddefC6cKq1qfSQ==
X-Received: by 10.28.20.144 with SMTP id 138mr15893943wmu.103.1461844681423;
        Thu, 28 Apr 2016 04:58:01 -0700 (PDT)
Received: from ubuntu2pinto.pd5x2phgis1evm2itoce0l41ib.ax.internal.cloudapp.net ([23.101.69.192])
        by smtp.gmail.com with ESMTPSA id xt9sm9319278wjb.17.2016.04.28.04.58.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 28 Apr 2016 04:58:00 -0700 (PDT)
X-Mailer: git-send-email 2.8.1.487.gf8c3767.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292867>

This is the fourth version but in reality is the complete rewriting of the patches discussed here
(here called V1)

$gmane/290520
$gmane/290521

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
 http.c                | 109 +++++++++++++++++++++++++++++++++++++++++++++++++-
 http.h                |   4 ++
 imap-send.c           |   6 +++
 4 files changed, 126 insertions(+), 1 deletion(-)

-- 
2.8.1.487.gf8c3767.dirty
