From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 2/2] t1500-rev-parse: rewrite each test to run in
 isolation
Date: Sun, 17 Apr 2016 01:59:55 -0400
Message-ID: <20160417055955.GA13384@flurp.local>
References: <1460823230-45692-1-git-send-email-rappazzo@gmail.com>
 <1460823230-45692-3-git-send-email-rappazzo@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com, pclouds@gmail.com,
	szeder@ira.uka.de, peff@peff.net
To: Michael Rappazzo <rappazzo@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 17 08:00:19 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1arfkm-0003oX-RU
	for gcvg-git-2@plane.gmane.org; Sun, 17 Apr 2016 08:00:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751458AbcDQGAF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Apr 2016 02:00:05 -0400
Received: from mail-ig0-f194.google.com ([209.85.213.194]:32950 "EHLO
	mail-ig0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751218AbcDQGAD (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Apr 2016 02:00:03 -0400
Received: by mail-ig0-f194.google.com with SMTP id g8so7422450igr.0
        for <git@vger.kernel.org>; Sat, 16 Apr 2016 23:00:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=85WSuPj818QdOcwBsTH0it/NtyFvkgcOKS3jP4RNXQM=;
        b=zPgSH/Rb3h4ZhoLYDRLQVhznNxzHwLZfDAGAc214e/9fbyqZaYiEO8LL8vTEYLa0g/
         pX93cyagAAzLkQLl7DG7V1KSsjYO3PRM4bs1DN8lcRlwpkPW8qHDEyAVbbrqnrRovnUJ
         GjbpV1dccG437KeXcE437kB8qkKupY1YkSm07+ExuxjY6z2/90BiZ1W/UGz7LNe8aKFK
         gMk//e3iR+4srdP/udulU4pBqsOWgQJ5nF+CscBIQJiseqeskxcFPXW0jg2Aq6UrTK9k
         Ze2dd6IqpJNeNYyAR4sFDFma82kk/OZE0vNbfX5hwMIbEDLfNxotynGMj6a82Y7lxBMW
         irpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=85WSuPj818QdOcwBsTH0it/NtyFvkgcOKS3jP4RNXQM=;
        b=TBJaHlMKd8uodnBQdfX22S1m/gbVNFEnKOfjmaV76tEuwf4/7BJuL20mgy23alUGeI
         Jxj8jPd7aRfgdgd+JAXgcH/HFIpB9NlHPDLItzFwy/tvQKbHrhbj3yHCPPRgSdHtNpVN
         kjr+bfhkAihQ2npWzc+N2wRhEbQFnl+N8FAbI7F0c/I3FNOJmDRXo0oiZ7Ir97fvZjYG
         5vQYtNi9F3n8GIWShtImywDRSFdHj+6zISZqFt3Wxf8JYfgdkX0Td9IpiBq+ci+4usq2
         lUB01Pyf5RJkIf5Fdawzpn37K7k10pSSgC+2u/juO53Lo+j36yzbzBAmOIoPRzrk+HZG
         Aj/A==
X-Gm-Message-State: AOPr4FVqPY3dZDH0zeTuRmaAHFmg0AhIMMfrbZ/ywJLaGgNpOVy3HDKzXezSFFnsH0AOBQ==
X-Received: by 10.50.93.138 with SMTP id cu10mr12896322igb.96.1460872802175;
        Sat, 16 Apr 2016 23:00:02 -0700 (PDT)
Received: from flurp.local (user-12l3c5v.cable.mindspring.com. [69.81.176.191])
        by smtp.gmail.com with ESMTPSA id q198sm33469516iod.6.2016.04.16.23.00.00
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 16 Apr 2016 23:00:01 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1460823230-45692-3-git-send-email-rappazzo@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291745>

On Sat, Apr 16, 2016 at 12:13:50PM -0400, Michael Rappazzo wrote:
> t1500-rev-parse has many tests which change directories and leak
> environment variables.  This makes it difficult to add new tests without
> minding the environment variables and current directory.
> 
> Each test is now setup, executed, and cleaned up without leaving anything
> behind.  Test comparisons been converted to use test_cmp or test_stdout.

Overall, I'm not enthused about how this patch unrolls the systematic
function-driven approach taken by the original code and turns it into
a series of highly repetitive individual tests. Not only does it make
the patch mind-numbing to review, but it is far too easy for errors
to creep into the conversion which simply wouldn't exist if a
systematic approach was used (whether via function, table, or
for-loops).

The very fact that you missed several test_stdout conversion
opportunities and didn't notice a bit of gunk (an unnecessary
">actual") or several bogus and misspelled "test_config care.bar ="
invocations, makes a good argument that this patch's approach is
undesirable.

The fact that I also missed these problems when reading through the
patch hammers the point home. It wasn't until I started actually
changing the patch in order to present you with a "here's a diff atop
your patch which fixes the issues" as a convenience, that I noticed
the more serious problems.

> Signed-off-by: Michael Rappazzo <rappazzo@gmail.com>
> ---
> diff --git a/t/t1500-rev-parse.sh b/t/t1500-rev-parse.sh
> @@ -3,85 +3,320 @@
> +test_expect_success '.git/objects/: git-dir' '
> +	echo $(pwd)/.git >expect &&
> +	git -C .git/objects rev-parse --git-dir >actual &&
> +	test_cmp expect actual
> +'

You forgot to convert this test_cmp to test_stdout.

> +test_expect_success 'subdirectory: prefix' '
> +	mkdir -p sub/dir &&
> +	test_when_finished "rm -rf sub" &&
> +	test sub/dir/ = "$(git -C sub/dir rev-parse --show-prefix)"
> +'

You forgot to convert this 'test' to test_stdout.

> -git config core.bare true
> -test_rev_parse 'GIT_DIR=../repo.git, core.bare = true' true false false ''
> +test_expect_success 'subdirectory: git-dir' '
> +	mkdir -p sub/dir &&
> +	test_when_finished "rm -rf sub" &&
> +	echo $(pwd)/.git >expect &&

Nit: Here and one other place, you could quote this: "$(pwd)/.git"

> +	git -C sub/dir rev-parse --git-dir >actual &&
> +	test_cmp expect actual
> +'

Ditto: test_cmp => test_stdout

> +test_expect_success 'core.bare = true: is-bare-repository' '
> +	test_config core.bare true &&
> +	test_stdout true git rev-parse --is-bare-repository
> +'

Is there a reason you chose to use test_config rather than the more
concise '-c foo=bar' as suggested by the review[1]?

[1]: http://article.gmane.org/gmane.comp.version-control.git/291368

> +test_expect_success 'core.bare undefined: is-bare-repository' '
> +	test_config core.bare "" &&

Is setting core.bare to "" really the same as undefining it, or is
the effect the same only as an accident of implementation? (Genuine
question; I haven't checked.)

> +	test_stdout false git rev-parse --is-bare-repository
> +'
> +test_expect_success 'GIT_DIR=../.git, core.bare = false: is-bare-repository' '
> +	mkdir work &&
> +	test_when_finished "rm -rf work" &&
> +	test_config -C "$(pwd)"/.git core.bare false &&

Drop the unnecessary "$(pwd)"/ here and elsewhere.

> +	GIT_DIR=../.git test_stdout false git -C work rev-parse --is-bare-repository
> +'
> +
> +test_expect_success 'GIT_DIR=../.git, core.bare = false: prefix' '
> +	mkdir work &&
> +	test_when_finished "rm -rf work" &&
> +	test_config -C "$(pwd)"/.git core.bare false &&
> +	GIT_DIR=../.git test_stdout "" git -C work rev-parse --show-prefix >actual

Drop the unnecessary '>actual' redirection.

> +'
> +
> +test_expect_success 'GIT_DIR=../.git, core.bare undefined: is-bare-repository' '
> +	mkdir work &&
> +	test_when_finished "rm -rf work" &&
> +	test_config -C "$(pwd)"/.git core.bar = &&

What is "core.bar =" (here and elsewhere)?

> +	GIT_DIR=../.git test_stdout false git -C work rev-parse --is-bare-repository
> +'
> +
> +test_expect_success 'GIT_DIR=../repo.git, core.bare = false: is-bare-repository' '
> +	mkdir work &&
> +	test_when_finished "rm -rf work" &&
> +	cp -r .git repo.git &&
> +	test_when_finished "rm -r repo.git" &&

You could coalesce these two test_when_finished invocations:

    test_when_finished "rm -rf work repo.git" &&

Windows folk might appreciate it since process spawning is expensive
and slow there.

> +	test_config -C "$(pwd)"/repo.git core.bare false &&
> +	GIT_DIR=../repo.git test_stdout false git -C work rev-parse --is-bare-repository
> +'

For convenience, here's a diff atop your patch which addresses the
above issues (except the question about core.bare set to "" versus
being undefined). However, as noted above, I think this patch's
approach is going in the wrong direction.

--- 8< ---
diff --git a/t/t1500-rev-parse.sh b/t/t1500-rev-parse.sh
index e2c2a06..beaf6e3 100755
--- a/t/t1500-rev-parse.sh
+++ b/t/t1500-rev-parse.sh
@@ -60,9 +60,7 @@ test_expect_success '.git/objects/: prefix' '
 '
 
 test_expect_success '.git/objects/: git-dir' '
-	echo $(pwd)/.git >expect &&
-	git -C .git/objects rev-parse --git-dir >actual &&
-	test_cmp expect actual
+	test_stdout "$(pwd)/.git" git -C .git/objects rev-parse --git-dir
 '
 
 test_expect_success 'subdirectory: is-bare-repository' '
@@ -86,237 +84,193 @@ test_expect_success 'subdirectory: is-inside-work-tree' '
 test_expect_success 'subdirectory: prefix' '
 	mkdir -p sub/dir &&
 	test_when_finished "rm -rf sub" &&
-	test sub/dir/ = "$(git -C sub/dir rev-parse --show-prefix)"
+	test_stdout sub/dir/ git -C sub/dir rev-parse --show-prefix
 '
 
 test_expect_success 'subdirectory: git-dir' '
 	mkdir -p sub/dir &&
 	test_when_finished "rm -rf sub" &&
-	echo $(pwd)/.git >expect &&
-	git -C sub/dir rev-parse --git-dir >actual &&
-	test_cmp expect actual
+	test_stdout "$(pwd)/.git" git -C sub/dir rev-parse --git-dir
 '
 
 test_expect_success 'core.bare = true: is-bare-repository' '
-	test_config core.bare true &&
-	test_stdout true git rev-parse --is-bare-repository
+	test_stdout true git -c core.bare=true rev-parse --is-bare-repository
 '
 
 test_expect_success 'core.bare = true: is-inside-git-dir' '
-	test_config core.bare true &&
-	test_stdout false git rev-parse --is-inside-git-dir
+	test_stdout false git -c core.bare=true rev-parse --is-inside-git-dir
 '
 
 test_expect_success 'core.bare = true: is-inside-work-tree' '
-	test_config core.bare true &&
-	test_stdout false git rev-parse --is-inside-work-tree
+	test_stdout false git -c core.bare=true rev-parse --is-inside-work-tree
 '
 
 test_expect_success 'core.bare undefined: is-bare-repository' '
-	test_config core.bare "" &&
-	test_stdout false git rev-parse --is-bare-repository
+	test_stdout false git -c core.bare= rev-parse --is-bare-repository
 '
 
 test_expect_success 'core.bare undefined: is-inside-git-dir' '
-	test_config core.bare "" &&
-	test_stdout false git rev-parse --is-inside-git-dir
+	test_stdout false git -c core.bare= rev-parse --is-inside-git-dir
 '
 
 test_expect_success 'core.bare undefined: is-inside-work-tree' '
-	test_config core.bare "" &&
-	test_stdout true git rev-parse --is-inside-work-tree
+	test_stdout true git -c core.bare= rev-parse --is-inside-work-tree
 '
 
 test_expect_success 'GIT_DIR=../.git, core.bare = false: is-bare-repository' '
-	mkdir work &&
 	test_when_finished "rm -rf work" &&
-	test_config -C "$(pwd)"/.git core.bare false &&
-	GIT_DIR=../.git test_stdout false git -C work rev-parse --is-bare-repository
+	mkdir work &&
+	GIT_DIR=../.git test_stdout false git -C work -c core.bare=false rev-parse --is-bare-repository
 '
 
 test_expect_success 'GIT_DIR=../.git, core.bare = false: is-inside-git-dir' '
-	mkdir work &&
 	test_when_finished "rm -rf work" &&
-	test_config -C "$(pwd)"/.git core.bare false &&
-	GIT_DIR=../.git test_stdout false git -C work rev-parse --is-inside-git-dir
+	mkdir work &&
+	GIT_DIR=../.git test_stdout false git -C work -c core.bare=false rev-parse --is-inside-git-dir
 '
 
 test_expect_success 'GIT_DIR=../.git, core.bare = false: is-inside-work-tree' '
-	mkdir work &&
 	test_when_finished "rm -rf work" &&
-	test_config -C "$(pwd)"/.git core.bare false &&
-	GIT_DIR=../.git test_stdout true git -C work rev-parse --is-inside-work-tree
+	mkdir work &&
+	GIT_DIR=../.git test_stdout true git -C work -c core.bare=false rev-parse --is-inside-work-tree
 '
 
 test_expect_success 'GIT_DIR=../.git, core.bare = false: prefix' '
-	mkdir work &&
 	test_when_finished "rm -rf work" &&
-	test_config -C "$(pwd)"/.git core.bare false &&
-	GIT_DIR=../.git test_stdout "" git -C work rev-parse --show-prefix >actual
+	mkdir work &&
+	GIT_DIR=../.git test_stdout "" git -C work -c core.bare=false rev-parse --show-prefix
 '
 
 test_expect_success 'GIT_DIR=../.git, core.bare = true: is-bare-repository' '
-	mkdir work &&
 	test_when_finished "rm -rf work" &&
-	test_config -C "$(pwd)"/.git core.bare true &&
-	GIT_DIR=../.git test_stdout true git -C work rev-parse --is-bare-repository
+	mkdir work &&
+	GIT_DIR=../.git test_stdout true git -C work -c core.bare=true rev-parse --is-bare-repository
 '
 
 test_expect_success 'GIT_DIR=../.git, core.bare = true: is-inside-git-dir' '
-	mkdir work &&
 	test_when_finished "rm -rf work" &&
-	test_config -C "$(pwd)"/.git core.bare true &&
-	GIT_DIR=../.git test_stdout false git -C work rev-parse --is-inside-git-dir
+	mkdir work &&
+	GIT_DIR=../.git test_stdout false git -C work -c core.bare=true rev-parse --is-inside-git-dir
 '
 
 test_expect_success 'GIT_DIR=../.git, core.bare = true: is-inside-work-tree' '
-	mkdir work &&
 	test_when_finished "rm -rf work" &&
-	test_config -C "$(pwd)"/.git core.bare true &&
-	GIT_DIR=../.git test_stdout false git -C work rev-parse --is-inside-work-tree
+	mkdir work &&
+	GIT_DIR=../.git test_stdout false git -C work -c core.bare=true rev-parse --is-inside-work-tree
 '
 
 test_expect_success 'GIT_DIR=../.git, core.bare = true: prefix' '
-	mkdir work &&
 	test_when_finished "rm -rf work" &&
-	test_config -C "$(pwd)"/.git core.bare true &&
-	GIT_DIR=../.git test_stdout "" git -C work rev-parse --show-prefix
+	mkdir work &&
+	GIT_DIR=../.git test_stdout "" git -C work -c core.bare=true rev-parse --show-prefix
 '
 
 test_expect_success 'GIT_DIR=../.git, core.bare undefined: is-bare-repository' '
-	mkdir work &&
 	test_when_finished "rm -rf work" &&
-	test_config -C "$(pwd)"/.git core.bar = &&
-	GIT_DIR=../.git test_stdout false git -C work rev-parse --is-bare-repository
+	mkdir work &&
+	GIT_DIR=../.git test_stdout false git -C work -c core.bare= rev-parse --is-bare-repository
 '
 
 test_expect_success 'GIT_DIR=../.git, core.bare undefined: is-inside-git-dir' '
-	mkdir work &&
 	test_when_finished "rm -rf work" &&
-	test_config -C "$(pwd)"/.git core.bar = &&
-	GIT_DIR=../.git test_stdout false git -C work rev-parse --is-inside-git-dir
+	mkdir work &&
+	GIT_DIR=../.git test_stdout false git -C work -c core.bare= rev-parse --is-inside-git-dir
 '
 
 test_expect_success 'GIT_DIR=../.git, core.bare undefined: is-inside-work-tree' '
-	mkdir work &&
 	test_when_finished "rm -rf work" &&
-	test_config -C "$(pwd)"/.git core.bar = &&
-	GIT_DIR=../.git test_stdout true git -C work rev-parse --is-inside-work-tree
+	mkdir work &&
+	GIT_DIR=../.git test_stdout true git -C work -c core.bare= rev-parse --is-inside-work-tree
 '
 
 test_expect_success 'GIT_DIR=../.git, core.bare undefined: prefix' '
-	mkdir work &&
 	test_when_finished "rm -rf work" &&
-	test_config -C "$(pwd)"/.git core.bar = &&
-	GIT_DIR=../.git test_stdout "" git -C work rev-parse --show-prefix
+	mkdir work &&
+	GIT_DIR=../.git test_stdout "" git -C work -c core.bare= rev-parse --show-prefix
 '
 
 test_expect_success 'GIT_DIR=../repo.git, core.bare = false: is-bare-repository' '
+	test_when_finished "rm -rf work repo.git" &&
 	mkdir work &&
-	test_when_finished "rm -rf work" &&
 	cp -r .git repo.git &&
-	test_when_finished "rm -r repo.git" &&
-	test_config -C "$(pwd)"/repo.git core.bare false &&
-	GIT_DIR=../repo.git test_stdout false git -C work rev-parse --is-bare-repository
+	GIT_DIR=../repo.git test_stdout false git -C work -c core.bare=false rev-parse --is-bare-repository
 '
 
 test_expect_success 'GIT_DIR=../repo.git, core.bare = false: is-inside-git-dir' '
+	test_when_finished "rm -rf work repo.git" &&
 	mkdir work &&
-	test_when_finished "rm -rf work" &&
 	cp -r .git repo.git &&
-	test_when_finished "rm -r repo.git" &&
-	test_config -C "$(pwd)"/repo.git core.bare false &&
-	GIT_DIR=../repo.git test_stdout false git -C work rev-parse --is-inside-git-dir
+	GIT_DIR=../repo.git test_stdout false git -C work -c core.bare=false rev-parse --is-inside-git-dir
 '
 
 test_expect_success 'GIT_DIR=../repo.git, core.bare = false: is-inside-work-tree' '
+	test_when_finished "rm -rf work repo.git" &&
 	mkdir work &&
-	test_when_finished "rm -rf work" &&
 	cp -r .git repo.git &&
-	test_when_finished "rm -r repo.git" &&
-	test_config -C "$(pwd)"/repo.git core.bare false &&
-	GIT_DIR=../repo.git test_stdout true git -C work rev-parse --is-inside-work-tree
+	GIT_DIR=../repo.git test_stdout true git -C work -c core.bare=false rev-parse --is-inside-work-tree
 '
 
 test_expect_success 'GIT_DIR=../repo.git, core.bare = false: prefix' '
+	test_when_finished "rm -rf work repo.git" &&
 	mkdir work &&
-	test_when_finished "rm -rf work" &&
 	cp -r .git repo.git &&
-	test_when_finished "rm -r repo.git" &&
-	test_config -C "$(pwd)"/repo.git core.bare false &&
-	GIT_DIR=../repo.git test_stdout "" git -C work rev-parse --show-prefix
+	GIT_DIR=../repo.git test_stdout "" git -C work -c core.bare=false rev-parse --show-prefix
 '
 
 test_expect_success 'GIT_DIR=../repo.git, core.bare = true: is-bare-repository' '
+	test_when_finished "rm -rf work repo.git" &&
 	mkdir work &&
-	test_when_finished "rm -rf work" &&
 	cp -r .git repo.git &&
-	test_when_finished "rm -r repo.git" &&
-	test_config -C "$(pwd)"/repo.git core.bare true &&
-	GIT_DIR=../repo.git test_stdout true git -C work rev-parse --is-bare-repository
+	GIT_DIR=../repo.git test_stdout true git -C work -c core.bare=true rev-parse --is-bare-repository
 '
 
 test_expect_success 'GIT_DIR=../repo.git, core.bare = true: is-inside-git-dir' '
+	test_when_finished "rm -rf work repo.git" &&
 	mkdir work &&
-	test_when_finished "rm -rf work" &&
 	cp -r .git repo.git &&
-	test_when_finished "rm -r repo.git" &&
-	test_config -C "$(pwd)"/repo.git core.bare true &&
-	GIT_DIR=../repo.git test_stdout false git -C work rev-parse --is-inside-git-dir
+	GIT_DIR=../repo.git test_stdout false git -C work -c core.bare=true rev-parse --is-inside-git-dir
 '
 
 test_expect_success 'GIT_DIR=../repo.git, core.bare = true: is-inside-work-tree' '
+	test_when_finished "rm -rf work repo.git" &&
 	mkdir work &&
-	test_when_finished "rm -rf work" &&
 	cp -r .git repo.git &&
-	test_when_finished "rm -r repo.git" &&
-	test_config -C "$(pwd)"/repo.git core.bare true &&
-	GIT_DIR=../repo.git test_stdout false git -C work rev-parse --is-inside-work-tree
+	GIT_DIR=../repo.git test_stdout false git -C work -c core.bare=true rev-parse --is-inside-work-tree
 '
 
 test_expect_success 'GIT_DIR=../repo.git, core.bare = true: prefix' '
+	test_when_finished "rm -rf work repo.git" &&
 	mkdir work &&
-	test_when_finished "rm -rf work" &&
 	cp -r .git repo.git &&
-	test_when_finished "rm -r repo.git" &&
-	test_config -C "$(pwd)"/repo.git core.bare true &&
-	GIT_DIR=../repo.git test_stdout "" git -C work rev-parse --show-prefix
+	GIT_DIR=../repo.git test_stdout "" git -C work -c core.bare=true rev-parse --show-prefix
 '
 
 test_expect_success 'GIT_DIR=../repo.git, core.bare undefined: is-bare-repository' '
+	test_when_finished "rm -rf work repo.git" &&
 	mkdir work &&
-	test_when_finished "rm -rf work" &&
 	cp -r .git repo.git &&
-	test_when_finished "rm -r repo.git" &&
-	test_config -C "$(pwd)"/repo.git core.bare "" &&
-	GIT_DIR=../repo.git test_stdout false git -C work rev-parse --is-bare-repository
+	GIT_DIR=../repo.git test_stdout false git -C work -c core.bare= rev-parse --is-bare-repository
 '
 
 test_expect_success 'GIT_DIR=../repo.git, core.bare undefined: is-inside-git-dir' '
+	test_when_finished "rm -rf work repo.git" &&
 	mkdir work &&
-	test_when_finished "rm -rf work" &&
 	cp -r .git repo.git &&
-	test_when_finished "rm -r repo.git" &&
-	test_config -C "$(pwd)"/repo.git core.bare "" &&
-	GIT_DIR=../repo.git test_stdout false git -C work rev-parse --is-inside-git-dir
+	GIT_DIR=../repo.git test_stdout false git -C work -c core.bare= rev-parse --is-inside-git-dir
 '
 
 test_expect_success 'GIT_DIR=../repo.git, core.bare undefined: is-inside-work-tree' '
+	test_when_finished "rm -rf work repo.git" &&
 	mkdir work &&
-	test_when_finished "rm -rf work" &&
 	cp -r .git repo.git &&
-	test_when_finished "rm -r repo.git" &&
-	test_config -C "$(pwd)"/repo.git core.bare "" &&
-	GIT_DIR=../repo.git test_stdout true git -C work rev-parse --is-inside-work-tree
+	GIT_DIR=../repo.git test_stdout true git -C work -c core.bare= rev-parse --is-inside-work-tree
 '
 
 test_expect_success 'GIT_DIR=../repo.git, core.bare undefined: prefix' '
+	test_when_finished "rm -rf work repo.git" &&
 	mkdir work &&
-	test_when_finished "rm -rf work" &&
 	cp -r .git repo.git &&
-	test_when_finished "rm -r repo.git" &&
-	test_config -C "$(pwd)"/repo.git core.bare "" &&
-	GIT_DIR=../repo.git test_stdout "" git -C work rev-parse --show-prefix
+	GIT_DIR=../repo.git test_stdout "" git -C work -c core.bare= rev-parse --show-prefix
 '
 
 test_done
-- 
2.8.1.217.gcab2cda
