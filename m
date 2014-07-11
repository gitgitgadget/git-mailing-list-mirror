From: Karsten Blees <karsten.blees@gmail.com>
Subject: [PATCH v8 00/17] add performance tracing facility
Date: Sat, 12 Jul 2014 01:56:53 +0200
Message-ID: <53C079C5.8090503@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
To: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
	msysGit <msysgit@googlegroups.com>
X-From: git-owner@vger.kernel.org Sat Jul 12 01:56:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X5kgR-00064a-Ht
	for gcvg-git-2@plane.gmane.org; Sat, 12 Jul 2014 01:56:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754696AbaGKX4w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jul 2014 19:56:52 -0400
Received: from mail-we0-f175.google.com ([74.125.82.175]:36035 "EHLO
	mail-we0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751498AbaGKX4v (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jul 2014 19:56:51 -0400
Received: by mail-we0-f175.google.com with SMTP id k48so1793914wev.34
        for <git@vger.kernel.org>; Fri, 11 Jul 2014 16:56:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:subject
         :content-type:content-transfer-encoding;
        bh=gbl4aJNaDPZYygB2C3Z4TeauGkrmN5g15dv00dHMmLA=;
        b=IBL7Ma9hwKdC2u1vQxPB/0st5Heezlcq+9Z8y00zdO9XDFyARV5Nz6N9ha/sCw9zhk
         69Z3OVNFlhrPPWL+rlpGZf3eUl8gjuuTGjEtWfVlcBrudP3EIhdBKIX0ORBbvo6UBnB6
         fJMwzMUQnmwmEnJDocn5LreLbZPnctr6hBulxq0kbQw2qPXTuKv7FY7yUs/aJxW3wzGT
         yRACWxe3OQ3cJKMZlIv5+lC5zkhKz2ommLWGgJQ5mRO4FqKzjyg1yTUEduzLMs7czoSZ
         MaRSw9Il2ER87fKMaGXEYfL4RrEUc3ePSDvRJWeqTBB5v74WSMT3QxLQJ14dNmf5dPjm
         6lTA==
X-Received: by 10.194.60.35 with SMTP id e3mr2981543wjr.12.1405123009920;
        Fri, 11 Jul 2014 16:56:49 -0700 (PDT)
Received: from [10.1.116.52] (ns.dcon.de. [77.244.111.149])
        by mx.google.com with ESMTPSA id gc5sm315330wic.6.2014.07.11.16.56.48
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 11 Jul 2014 16:56:49 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253355>

Changes since v7:
[04]: Fixed -Wextra compiler warnings, thanks to Ramsay Jones.
[11]: Added #ifndef TRACE_CONTEXT, explained why __FILE__ ":"
      __FUNCTION__ doesn't work.
[17]: New Documentation/technical/api-trace.txt


Karsten Blees (17):
  trace: move trace declarations from cache.h to new trace.h
  trace: consistently name the format parameter
  trace: remove redundant printf format attribute
  trace: improve trace performance
  Documentation/git.txt: improve documentation of 'GIT_TRACE*' variables
  sha1_file: change GIT_TRACE_PACK_ACCESS logging to use trace API
  trace: add infrastructure to augment trace output with additional info
  trace: disable additional trace output for unit tests
  trace: add current timestamp to all trace output
  trace: move code around, in preparation to file:line output
  trace: add 'file:line' to all trace output
  trace: add high resolution timer function to debug performance issues
  trace: add trace_performance facility to debug performance issues
  git: add performance tracing for git's main() function to debug
    scripts
  wt-status: simplify performance measurement by using getnanotime()
  progress: simplify performance measurement by using getnanotime()
  api-trace.txt: add trace API documentation

 Documentation/git.txt                 |  59 ++++--
 Documentation/technical/api-trace.txt |  97 +++++++++
 Makefile                              |   7 +
 builtin/receive-pack.c                |   2 +-
 cache.h                               |  13 +-
 commit.h                              |   1 +
 config.mak.uname                      |   1 +
 git-compat-util.h                     |   4 +
 git.c                                 |   2 +
 pkt-line.c                            |   8 +-
 progress.c                            |  71 +++----
 sha1_file.c                           |  30 +--
 shallow.c                             |  10 +-
 t/test-lib.sh                         |   4 +
 trace.c                               | 369 ++++++++++++++++++++++++++++------
 trace.h                               | 113 +++++++++++
 wt-status.c                           |  14 +-
 17 files changed, 629 insertions(+), 176 deletions(-)
 create mode 100644 Documentation/technical/api-trace.txt
 create mode 100644 trace.h

-- 
2.0.0.406.g2e9ef9b
