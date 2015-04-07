From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 4/5] t4202-log: add tests for --merges=
Date: Tue, 7 Apr 2015 03:32:57 -0400
Message-ID: <20150407073257.GA45051@flurp.local>
References: <266077>
 <1428110521-31028-1-git-send-email-koosha@posteo.de>
 <1428110521-31028-4-git-send-email-koosha@posteo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Koosha Khajehmoogahi <koosha@posteo.de>
X-From: git-owner@vger.kernel.org Tue Apr 07 09:33:30 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YfO0n-0001cQ-AP
	for gcvg-git-2@plane.gmane.org; Tue, 07 Apr 2015 09:33:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753177AbbDGHdK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Apr 2015 03:33:10 -0400
Received: from mail-ig0-f170.google.com ([209.85.213.170]:36963 "EHLO
	mail-ig0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753169AbbDGHdH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Apr 2015 03:33:07 -0400
Received: by igblo3 with SMTP id lo3so4742525igb.0
        for <git@vger.kernel.org>; Tue, 07 Apr 2015 00:33:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=LDiSFGW2mhGcJV4jlOsmAcKXtkkK1NTTevxObERggTI=;
        b=tikeAvEMlU4vCN/uuZ6158WiJCyinVhCcZdF3NpCr84LyRf6AAShC0jdr//48Mu25b
         WfDgk6K5SDbQmPeGelrlnjkfdT+PJQW9C8aoNg4ArKRIbe7vY+lDEBZ2BLvwle5dv8Ut
         0eaVlS/gKfDJHATi+UWAAWTDERFc6D/4JRf8vrJisxRNXZQVYKtlVh2r+ZqGUREfxUXE
         okpG3H2jgg8HCbHngqoZwiSY4V6BKC6Dp6FXhvzZfr0XwQriQbX8XFPOrFDikrlG6q6W
         WKsazHsAFnxOawMPjZgfy0HyePTWnbegGhw7F5VrLxnD2x3kPzxpS/jTBtUHN7Hbny2f
         e9Iw==
X-Received: by 10.42.84.14 with SMTP id j14mr24842455icl.66.1428391986491;
        Tue, 07 Apr 2015 00:33:06 -0700 (PDT)
Received: from flurp.local (user-12l3cpl.cable.mindspring.com. [69.81.179.53])
        by mx.google.com with ESMTPSA id w3sm4512755igz.1.2015.04.07.00.33.04
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 07 Apr 2015 00:33:05 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1428110521-31028-4-git-send-email-koosha@posteo.de>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266902>

On Sat, Apr 04, 2015 at 03:22:00AM +0200, Koosha Khajehmoogahi wrote:
> Helped-by: Eric Sunshine <sunshine@sunshineco.com>
> Signed-off-by: Koosha Khajehmoogahi <koosha@posteo.de>
> ---
> diff --git a/t/t4202-log.sh b/t/t4202-log.sh
> index 1b2e981..ceaaf4e 100755
> --- a/t/t4202-log.sh
> +++ b/t/t4202-log.sh
> @@ -270,6 +270,90 @@ cat > expect <<\EOF
>  * initial
>  EOF
>  
> +test_expect_success 'setup --merges=' '
> +	git log --min-parents=2 --pretty=tformat:%s >expect_only &&
> +	git log --max-parents=1 --pretty=tformat:%s >expect_hide &&
> +	git log --min-parents=-1 --pretty=tformat:%s >expect_show
> +'
> +
> +test_expect_success 'log with config log.merges=show' '
> +	test_config log.merges show &&
> +	git log --pretty=tformat:%s >actual &&
> +	test_cmp expect_show actual
> +'
> +
[...much repetitious code omitted...]
> +test_expect_success 'log with config log.merges=show with git log --no-merges' '
> +	test_config log.merges show &&
> +	git log --no-merges --pretty=tformat:%s >actual &&
> +	test_cmp expect_hide actual
> +'
> +
[...much repetitious code omitted...]
> +test_log_merges() {
> +	test_config log.merges $2 &&
> +	git log --merges=$1 --pretty=tformat:%s >actual &&
> +	test_cmp $3 actual
> +}
> +
> +test_expect_success 'log --merges=show with config log.merges=hide' '
> +	test_log_merges show hide expect_show
> +'
[...much repetitious code omitted...]

In my previous review[1], I mentioned that the significant repetition
in the implementation of the new tests increased potential for errors
when composing them, and made it more difficult to review. To resolve
the issue, I suggested factoring out the repeated code into a helper
function, and gave an idea of its interface and how it could be
applied to eliminate all the repetition.

In this version of the patch, you've made some progress at
eliminating repetition, but much still remains. I had hoped to see
much more aggressive repetition elimination, collapsing the code to
the bare minimum while still testing all combinations of states.
Here's what I had in mind:

---- 8< ----
diff --git a/t/t4202-log.sh b/t/t4202-log.sh
index 1b2e981..be6d34c 100755
--- a/t/t4202-log.sh
+++ b/t/t4202-log.sh
@@ -270,6 +270,35 @@ cat > expect <<\EOF
 * initial
 EOF
 
+test_expect_success 'setup merges' '
+	git log --min-parents=2 --pretty=tformat:%s >expect_only &&
+	git log --max-parents=1 --pretty=tformat:%s >expect_hide &&
+	git log --min-parents=-1 --pretty=tformat:%s >expect_show
+'
+
+test_log_merges() {
+	expect=expect_$1
+	config=${2:+-c log.merges=$2}
+	option=${3:+--merges=$3}
+	option=${4:-$option}
+	test_expect_success "merges${config:+ $config}${option:+ $option}" "
+		git $config log $option --pretty=tformat:%s >actual &&
+		test_cmp $expect actual
+	"
+}
+
+states="show only hide"
+for c in '' $states
+do
+	for o in '' $states
+	do
+		test_log_merges ${o:-${c:-show}} "$c" "$o"
+	done
+done
+
+test_log_merges hide show '' --no-merges
+test_log_merges only hide '' '--merges --max-parents=2'
+
 test_expect_success 'log --graph with merge' '
 	git log --graph --date-order --pretty=tformat:%s |
 		sed "s/ *\$//" >actual &&
---- 8< ----

The output of the above test code looks like this:

---- 8< ----
ok 29 - setup merges
ok 30 - merges
ok 31 - merges --merges=show
ok 32 - merges --merges=only
ok 33 - merges --merges=hide
ok 34 - merges -c log.merges=show
ok 35 - merges -c log.merges=show --merges=show
ok 36 - merges -c log.merges=show --merges=only
ok 37 - merges -c log.merges=show --merges=hide
ok 38 - merges -c log.merges=only
ok 39 - merges -c log.merges=only --merges=show
ok 40 - merges -c log.merges=only --merges=only
ok 41 - merges -c log.merges=only --merges=hide
ok 42 - merges -c log.merges=hide
ok 43 - merges -c log.merges=hide --merges=show
ok 44 - merges -c log.merges=hide --merges=only
ok 45 - merges -c log.merges=hide --merges=hide
ok 46 - merges -c log.merges=show --no-merges
ok 47 - merges -c log.merges=hide --merges --max-parents=2
---- 8< ----

Hmm, it seems that I've rewritten pretty much the entire patch, so
perhaps the From: header ought to mention my name instead. Oops.

[1]: http://git.661346.n2.nabble.com/PATCH-1-5-Add-a-new-option-merges-to-revision-c-td7627662.html#a7627683
