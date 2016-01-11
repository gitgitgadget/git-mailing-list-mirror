From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH v3 0/4] Ensure that we can build without libgen.h
Date: Mon, 11 Jan 2016 19:29:41 +0100 (CET)
Message-ID: <cover.1452536924.git.johannes.schindelin@gmx.de>
References: <cover.1452270051.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: git@vger.kernel.org, Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 11 19:30:05 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aIhE7-0007zF-EE
	for gcvg-git-2@plane.gmane.org; Mon, 11 Jan 2016 19:29:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933247AbcAKS3z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Jan 2016 13:29:55 -0500
Received: from mout.gmx.net ([212.227.17.21]:64457 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933244AbcAKS3y (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jan 2016 13:29:54 -0500
Received: from virtualbox ([37.24.143.74]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0MEKZg-1aPFjr00sa-00FRYj; Mon, 11 Jan 2016 19:29:43
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <cover.1452270051.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:rrqEv/N9Li3I7o7aM/A3HZcn7D9DwFMiTYbYsoxPRRb79tn5D1K
 SGl9p0kx0N25J0ySBi8GRbKhSERC56F+c8XRj2Kn/GatiMAOCzseMfW/bt6DPsUtWZ0kcTw
 klzH/9peTky8dakP6mkjRQ85FIuxtdSCKURokutiVxw9JabHKqKlI9bSNByn2TpgxpUo7VG
 AbDU1PQ0KQ/OmZVBotA9A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:1NvbsaN9Mds=:Tao/HdxhRniZobTSbLG02e
 SugAzWA0Bh3qpZ8gHVcY6TasEhYQhZZjHJ3NEOk7V4bpr8RJkDKUTqBtAljlSsg2yrz94elDi
 yqGJ4HzrxlMQHjL8CYHYxQczEfA+6yL/3E0qqv97Z2fkL/JDUh4+7K7HZDHlQ4rcNCGkHVm6O
 MicbhZfmbtWBYQn31nP5fWPW5ubKxXuISEOe0pv9g1oIllFKD7w4357M5c8c+mXScChyigP7P
 SeItY5IgYcUIbW1LLZ5ix8WdZBhzcMa0wB06Pha9Hq6uWH9nqAu9Ov82ho4GciWNS+nIRMiBN
 enbJ8a8JYTelihAZAJr6CDLZd6nM5Kv1XcxUlz1rNS6hQMgPS7gNbise//F/NAfqIjPNcYIma
 isskqd02LkdRr648FXi4s8Kf03hhUKA+sJPJe9VlnOZExbIzZgIi9KY7+5tqTxCgE5yWoklhX
 Y7L5ORBLPfbwRVuXMfrCa2MdQKL3s6vnUKgGmixG6OQ3xB3wdeXtc5YbSOQmLkXbhlnAJxZVo
 dHBrbzKFKecMq7l18/DBfCt8YY9yMbiaPP9sUY6dWQn/JtnTg2HrEsUJFdqSKbcmuyEsJhlWG
 YdisAHz8It6SDSSkpYa1/cIggt21ZD/mT30xomcGYu9+vfzRcunRhhZ9htoY+ZTOb85EBn98V
 2CF+gQCLLJMzX565Vo2Zpc5A2FjRDRb7mEc9mJSKMmFahMgilxkfV7oaEngawWmh3nxq6pHu7
 /ENrX07S3xhTXlB0pZl9qB9A0CqoyojUKU7A2NljzjQQ99LnnVYLHmnJZ6T7HLDjpwhoQg3B 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283692>

This mini series adds a fall-back for the `dirname()` function that we use
e.g. in git-am. This is necessary because not all platforms have a working
libgen.h.

While at it, we ensure that our basename() drop-in conforms to the POSIX
specifications.

In addition to the interdiff vs v2, the commit message was fixed to
mention basename("") as cornercase (not basename("abc")).


Johannes Schindelin (4):
  Refactor skipping DOS drive prefixes
  compat/basename: make basename() conform to POSIX
  Provide a dirname() function when NO_LIBGEN_H=YesPlease
  t0060: verify that basename() and dirname() work as expected

 compat/basename.c     |  66 ++++++++++++++++++--
 compat/mingw.c        |  14 ++---
 compat/mingw.h        |  10 ++-
 git-compat-util.h     |  10 +++
 path.c                |  14 ++---
 t/t0060-path-utils.sh |   3 +
 test-path-utils.c     | 166 ++++++++++++++++++++++++++++++++++++++++++++++++++
 7 files changed, 259 insertions(+), 24 deletions(-)

Interdiff vs v2:

 diff --git a/test-path-utils.c b/test-path-utils.c
 index 74e74c9..4ab68ac 100644
 --- a/test-path-utils.c
 +++ b/test-path-utils.c
 @@ -40,15 +40,15 @@ static void normalize_argv_string(const char **var, const char *input)
  }
  
  struct test_data {
 -	char *from;  /* input:  transform from this ... */
 -	char *to;    /* output: ... to this.            */
 +	const char *from;  /* input:  transform from this ... */
 +	const char *to;    /* output: ... to this.            */
  };
  
  static int test_function(struct test_data *data, char *(*func)(char *input),
  	const char *funcname)
  {
  	int failed = 0, i;
 -	static char buffer[1024];
 +	char buffer[1024];
  	char *to;
  
  	for (i = 0; data[i].to; i++) {
 @@ -61,10 +61,10 @@ static int test_function(struct test_data *data, char *(*func)(char *input),
  		if (strcmp(to, data[i].to)) {
  			error("FAIL: %s(%s) => '%s' != '%s'\n",
  				funcname, data[i].from, to, data[i].to);
 -			failed++;
 +			failed = 1;
  		}
  	}
 -	return !!failed;
 +	return failed;
  }
  
  static struct test_data basename_data[] = {
 @@ -132,7 +132,6 @@ static struct test_data basename_data[] = {
  
  #endif
  #endif
 -	{ NULL,              "."    },
  	{ NULL,              NULL   }
  };
  
 @@ -197,7 +196,6 @@ static struct test_data dirname_data[] = {
  
  #endif
  #endif
 -	{ NULL,              "."      },
  	{ NULL,              NULL     }
  };
  

-- 
2.6.3.windows.1.300.g1c25e49
