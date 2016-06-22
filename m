Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9BFBA1FE4E
	for <e@80x24.org>; Wed, 22 Jun 2016 09:41:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751735AbcFVJlG (ORCPT <rfc822;e@80x24.org>);
	Wed, 22 Jun 2016 05:41:06 -0400
Received: from mout.gmx.net ([212.227.15.19]:60068 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751926AbcFVJlD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Jun 2016 05:41:03 -0400
Received: from virtualbox ([37.24.143.194]) by mail.gmx.com (mrgmx002) with
 ESMTPSA (Nemesis) id 0MEWPx-1b9KtR09Cj-00Fnvs; Wed, 22 Jun 2016 11:34:20
 +0200
Date:	Wed, 22 Jun 2016 11:34:19 +0200 (CEST)
From:	Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	git@vger.kernel.org
cc:	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 0/2] Make find_commit_subject() consistent with
 --format=%s
In-Reply-To: <901b24554eb4d0381d74ceb31f7bd08709d5eb25.1466512959.git.johannes.schindelin@gmx.de>
Message-ID: <cover.1466587806.git.johannes.schindelin@gmx.de>
References: <901b24554eb4d0381d74ceb31f7bd08709d5eb25.1466512959.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:8VxWTfUEYLM1VeSp/YVEdVDxlmMvzvGiOGPRBD9YWUVeP7E95Wh
 skAYBbWkM/KhYMGxm8Mu+NJIkODssaHyIGgfdCVKeLObeKlziomSie7e7vHkMvKFjIccZvg
 yTf3b6tBNuxq0Dy28lYZpwXCV546K3Li8ZEBD+Yl9Yg/RQWB6xeoCjsRO5iiFrgMf/4lZr5
 IjiNftTv/nhqzJrBOcXQg==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:eNl2JSDF1lE=:KkeWCsn8a0pADKX+Wz3fJC
 FknVSh7RVDJ3gCQ+bnAjfaYBZOFZGQJRZm1SpDr+vcM4l0tBs9ylGboV8FkxaTr2E+S0ig/6g
 OcrPYQgsi9PLXLTxUVgnOycI9kTJLJLbx3mHUBUQ3mYc+6ag4ZwCUDGaAgQ6TLNle4LMqtuYw
 Eo5qaGhK/igCN+4o9TtIbnK8BspG5X8LR3ykaOWpmFpRss53ZHrBx0jk/wvMfSrn+16FQkKBD
 RP9eC/HQcQWaoWSeFkmBvUH3pICANoBJB23dg2K/U0AMiMOVG20QqfYPcr9ygu/VaBy6LqzwE
 1+9XIGYn0CNSdMVEjvU3O/V7/YKvk1hXROQNlG0DoQevov3gYrJB8C8vP8ogst28GAH5pkZSR
 4fZiIUdtCgzv286X84WTuEwJbE0rviQbyxDAtEs/jhWi+cSaS4rWupcCaucatb4snL+FUNWj/
 DJQh8uK+xBVd/EsRK3nwygFs03LKlmG1eSrZs1Yp/y/Wid12LZpojvqG2H/qSD2rwThCfnxSF
 c8u6drZcRQ0yYu+bzW2EpYuGToTRGD0Z9bnhe1rhfOrPWbcdcmO01j5aoEHcL4GJt9OFhScw7
 F6W0r/Nd4mmJZqeJVg5qCKSeR30Wth366WLbHgOUT31Hz9CDwlsiLAbxpSb7QW8jGFw+XSSyL
 ImovZSnLWa8E6B8HpJiTeccVxmOM7yehr9rP/9705W5U21Eyu6JrRLtpOKyqJekijCob/9+7H
 FXcecu4fVpq4rMVjl+Y8JBH53MSXJ+ekuIvLyb2FVs6Kd9WVK8yoeomwGa9ytIMTh2FFlX2dw
 mOqbBJ1
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

In an intermediate iteration of my rebase--helper patches, I
accidentally generated commits with more than one empty line
between the header and the commit message. When using
find_commit_subject() to show the oneline, it turned up empty, even
if the output of `git show --format=%s` looked fine.

Turned out that the pretty-printing machinery helpfully skipped any
blank lines before the commit message.

In the first iteration of this patch, I failed to notice that
the skip_empty_lines() function used by the pretty printing (which is
declared static, and therefore I originally did not use it in order to
keep the patch as minimal as possible) skips also blank lines.

To make things truly consistent, I now just make the skip_empty_lines()
function public, and then use it.


Johannes Schindelin (2):
  Make the skip_empty_lines() function public
  Make find_commit_subject() more robust

 commit.c                 |  2 +-
 commit.h                 |  1 +
 pretty.c                 |  2 +-
 t/t8008-blame-formats.sh | 17 +++++++++++++++++
 4 files changed, 20 insertions(+), 2 deletions(-)

Published-As: https://github.com/dscho/git/releases/tag/leading-empty-lines-v3
Interdiff vs v2:

 diff --git a/commit.c b/commit.c
 index 7b00989..0bf868f 100644
 --- a/commit.c
 +++ b/commit.c
 @@ -414,9 +414,7 @@ int find_commit_subject(const char *commit_buffer, const char **subject)
  	while (*p && (*p != '\n' || p[1] != '\n'))
  		p++;
  	if (*p) {
 -		p += 2;
 -		while (*p == '\n')
 -			p++;
 +		p = skip_empty_lines(p + 2);
  		for (eol = p; *eol && *eol != '\n'; eol++)
  			; /* do nothing */
  	} else
 diff --git a/commit.h b/commit.h
 index b06db4d..fbdd18d 100644
 --- a/commit.h
 +++ b/commit.h
 @@ -177,6 +177,7 @@ extern const char *format_subject(struct strbuf *sb, const char *msg,
  				  const char *line_separator);
  extern void userformat_find_requirements(const char *fmt, struct userformat_want *w);
  extern int commit_format_is_empty(enum cmit_fmt);
 +extern const char *skip_empty_lines(const char *msg);
  extern void format_commit_message(const struct commit *commit,
  				  const char *format, struct strbuf *sb,
  				  const struct pretty_print_context *context);
 diff --git a/pretty.c b/pretty.c
 index c3ec430..1b807b4 100644
 --- a/pretty.c
 +++ b/pretty.c
 @@ -516,7 +516,7 @@ static int is_empty_line(const char *line, int *len_p)
  	return !len;
  }
  
 -static const char *skip_empty_lines(const char *msg)
 +const char *skip_empty_lines(const char *msg)
  {
  	for (;;) {
  		int linelen = get_one_line(msg);
 diff --git a/t/t8008-blame-formats.sh b/t/t8008-blame-formats.sh
 index 03bd313..b98f9a4 100755
 --- a/t/t8008-blame-formats.sh
 +++ b/t/t8008-blame-formats.sh
 @@ -94,7 +94,7 @@ test_expect_success '--porcelain detects first non-empty line as subject' '
  		echo "This is it" >single-file &&
  		git add single-file &&
  		tree=$(git write-tree) &&
 -		commit=$(printf "%s\n%s\n%s\n\n\noneline\n\nbody\n" \
 +		commit=$(printf "%s\n%s\n%s\n\n\n  \noneline\n\nbody\n" \
  			"tree $tree" \
  			"author A <a@b.c> 123456789 +0000" \
  			"committer C <c@d.e> 123456789 +0000" |

-- 
2.9.0.118.g0e1a633

base-commit: ab7797dbe95fff38d9265869ea367020046db118
