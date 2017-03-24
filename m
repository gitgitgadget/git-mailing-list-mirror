Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 31C951FC19
	for <e@80x24.org>; Fri, 24 Mar 2017 23:32:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934264AbdCXXcC (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 Mar 2017 19:32:02 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:33647 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932972AbdCXXcA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Mar 2017 19:32:00 -0400
Received: by mail-pg0-f66.google.com with SMTP id 79so753949pgf.0
        for <git@vger.kernel.org>; Fri, 24 Mar 2017 16:32:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=t7XycStroX/DtRsb09jL5rkbS0hQls6ds8boPuB7hUI=;
        b=Ri5FEFp7OfobEqIusZw7Je3W7cAv1abcVdXj7KWoIBQv7Hn/bcqE40dFFSPp65Q4sa
         //H7bvqAbYa3bkPQG2Zrq4mE436LC8mtPrUXnQhjlRZPBAtNLtXGtSl1MbDF+IhuQEUj
         ne9M3mbjxnJMPgM9stDMr00HbYFB7JdTi4XuKz2Y1B5NIlNhZFSrWeW3qU9i6ELltr2g
         gDGP1ZKwUP3ckPYyObpkKScZYZ4mJCdDVFSI3FUvkusik7rdClwO0KCeePH8EOcCCvf+
         6zPw7MKRrG3F08AcixDf3NZuShXKanjCFj3b0rSHQKSg6E5LZRgIDjxKo+wMGulHH3i8
         j5cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=t7XycStroX/DtRsb09jL5rkbS0hQls6ds8boPuB7hUI=;
        b=ijKF8DwyTzMUSEQjuJgWq6mmyt4w08JMFdJSw3wBpMkOcfEW4XFvMAZMWB2Ie5LOgf
         uuX+FHfWBRyfjneYGHkeWVE42A1i2u1Z065sQ/6CgvLno2INOfF7QgavYn4ee0Pb6I3b
         OMj11H2YS+9ZZb6BB1QDF3KxsGirinHfGZKnyGatlrKlpZEtotACUyrD2jv+nVu9ohVG
         dxwsYXx5ILyCF0vuAc0u180GcMkTPK6W5nPHZYacY7fuUU+YX7kmS/oJcGPC/Urd0zkX
         ZCkshBe7zobr20wuubat/B+ZBgsW8BIC1faMSyF/Qo4R8mVuwdh/5LCWZGZmfEF33L5O
         xR6A==
X-Gm-Message-State: AFeK/H2xTLLuZe96IxIi7ZohM3bKxmCrkKLWFcSwTKfZEq6Pe77VYam4jUVHDR8H4YnrOA==
X-Received: by 10.99.36.194 with SMTP id k185mr11720088pgk.201.1490398319154;
        Fri, 24 Mar 2017 16:31:59 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:1000:5b10:8597:ae41:db75:6a97])
        by smtp.gmail.com with ESMTPSA id k184sm6647282pgc.23.2017.03.24.16.31.58
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 24 Mar 2017 16:31:58 -0700 (PDT)
Date:   Fri, 24 Mar 2017 16:31:56 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     gitster@pobox.com, git@vger.kernel.org
Subject: Re: [PATCH 7/7] submodule.c: correctly handle nested submodules in
 is_submodule_modified
Message-ID: <20170324233156.GL31294@aiede.mtv.corp.google.com>
References: <20170323223338.32274-7-sbeller@google.com>
 <20170324182902.19280-1-sbeller@google.com>
 <20170324182902.19280-8-sbeller@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170324182902.19280-8-sbeller@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller wrote:

> When a nested submodule has untracked files, it would be reported as
> "modified submodule" in the superproject, because submodules are not
> parsed correctly in is_submodule_modified as they are bucketed into
> the modified pile as "they are not an untracked file".
> 
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>  submodule.c                 | 16 ++++++++++++++--
>  t/t3600-rm.sh               |  2 +-
>  t/t7506-status-submodule.sh |  2 +-
>  3 files changed, 16 insertions(+), 4 deletions(-)
> 
> diff --git a/submodule.c b/submodule.c
> index 467f1de763..ec7e9b1b06 100644
> --- a/submodule.c
> +++ b/submodule.c
> @@ -1078,8 +1078,20 @@ unsigned is_submodule_modified(const char *path, int ignore_untracked)
>  		/* regular untracked files */
>  		if (buf.buf[0] == '?')
>  			dirty_submodule |= DIRTY_SUBMODULE_UNTRACKED;
> -		else
> -			dirty_submodule |= DIRTY_SUBMODULE_MODIFIED;
> +
> +		/* regular unmerged and renamed files */
> +		if (buf.buf[0] == 'u' ||
> +		    buf.buf[0] == '1' ||
> +		    buf.buf[0] == '2') {
> +			if (buf.buf[5] == 'S') {

Can this overflow the buffer?  Submodule state is supposed to be 4
characters, so could do

			/*
			 * T XY SSSS:
			 * T = line type, XY = status, SSSS = submodule state
			 */
			if (buf.len < 1 + 1 + 2 + 1 + 4)
				die("BUG: invalid status --porcelain=2 line %s",
				    buf.buf);

			if (buf.buf[5] == 'S' && buf.buf[8] == 'U')
				/* untracked file */
				dirty_submodule |= DIRTY_SUBMODULE_UNTRACKED;

			if (memcmp(buf.buf + 5, "S..U", 4))
				/* other change */
				dirty_submodule |= DIRTY_SUBMODULE_MODIFIED;
		}

> +				/* nested submodule handling */
> +				if (buf.buf[6] == 'C' || buf.buf[7] == 'M')
> +					dirty_submodule |= DIRTY_SUBMODULE_MODIFIED;
> +				if (buf.buf[8] == 'U')
> +					dirty_submodule |= DIRTY_SUBMODULE_UNTRACKED;
> +			} else
> +				dirty_submodule |= DIRTY_SUBMODULE_MODIFIED;
> +		}

I get lost in these cases. What does it mean if we see S..., for
example?

As an example, if I am understanding correctly, before this patch, if
I have a submodule-in-submodule:

	$ find . -name .git
	.git
	sub/.git
	sub/subsub/.git

and I put a stray file in the sub-sub module:

	$ echo stray-file >sub/subsub/x.o

then status --porcelain=2 tells me that sub is modified:

	$ git status --porcelain=2
	1 .M S.M. [...] sub

What should it say after the patch?  Is the XY field ".." or ".M"?

Some tests covering these cases with --porcelain=2 and a brief mention
in documentation may help.

Thanks,
Jonathan

diff --git i/submodule.c w/submodule.c
index ec7e9b1b06..aec1b2cdca 100644
--- i/submodule.c
+++ w/submodule.c
@@ -1083,13 +1083,18 @@ unsigned is_submodule_modified(const char *path, int ignore_untracked)
 		if (buf.buf[0] == 'u' ||
 		    buf.buf[0] == '1' ||
 		    buf.buf[0] == '2') {
-			if (buf.buf[5] == 'S') {
-				/* nested submodule handling */
-				if (buf.buf[6] == 'C' || buf.buf[7] == 'M')
-					dirty_submodule |= DIRTY_SUBMODULE_MODIFIED;
-				if (buf.buf[8] == 'U')
-					dirty_submodule |= DIRTY_SUBMODULE_UNTRACKED;
-			} else
+			/*
+			 * T XY SSSS:
+			 * T = line type, XY = status, SSSS = submodule state
+			 */
+			if (buf.len < 1 + 1 + 2 + 1 + 4)
+				die("BUG: invalid status --porcelain=2 line %s",
+				    buf.buf);
+			if (buf.buf[5] == 'S' && buf.buf[8] == 'U')
+				/* untracked file */
+				dirty_submodule |= DIRTY_SUBMODULE_UNTRACKED;
+			if (memcmp(buf.buf + 5, "S..U", 4))
+				/* other change */
 				dirty_submodule |= DIRTY_SUBMODULE_MODIFIED;
 		}
 
