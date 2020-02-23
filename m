Return-Path: <SRS0=MMY4=4L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11724C35671
	for <git@archiver.kernel.org>; Sun, 23 Feb 2020 05:06:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB63B208C3
	for <git@archiver.kernel.org>; Sun, 23 Feb 2020 05:06:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=usp-br.20150623.gappssmtp.com header.i=@usp-br.20150623.gappssmtp.com header.b="BSiCedf+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726024AbgBWFGI (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 23 Feb 2020 00:06:08 -0500
Received: from mail-qv1-f66.google.com ([209.85.219.66]:39625 "EHLO
        mail-qv1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725978AbgBWFGI (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 23 Feb 2020 00:06:08 -0500
Received: by mail-qv1-f66.google.com with SMTP id y8so2818168qvk.6
        for <git@vger.kernel.org>; Sat, 22 Feb 2020 21:06:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EuwfTtuHl2vYZbo9qs0UOt9oaQPtzm1vg9vARKVCM3M=;
        b=BSiCedf+Pi4w9y530T9jh5PBk2G/5rE+VvYJ+DW0P7eqPcDHu9yy0dY4e4iPEZwKoc
         HMV9ugISYcCaYZ4muc7SnVLAjoP+PKdvoFKhP4LXsa8k4x4Sc1smr/dh1JxXGw73Tk35
         pXadQWLWvHUp4Kfopg9XzyDhz2fSPECGvwl4dX8EHu4/dWpMGc22g4WaLkdAFPhcEFHt
         +55UvhsWYYT0eYXsYfrWiLvK++hPoj5e47NubKxrOXc5Ovu+I9IhTcGAZoiiMsFVn//H
         QMyysOo5aTUdXa4Xr8tGNNTc5mxO05pJfXm+AZy8VceFaHGyvpkpiSyj+kjwfs6qM8JV
         KqAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EuwfTtuHl2vYZbo9qs0UOt9oaQPtzm1vg9vARKVCM3M=;
        b=eWnxL1B2Io3LEwmbMF1fkTlVYp178DAMsYG4Dp5/YsS6MtZk2cCJE0bpQNLBIq+r4q
         QrQy4YDDPzQYPv0xbyiqTKE0QnPCV4jfwxrv/vdYWQ62QNMnkP9owJ2YJgf8l9MnEApu
         p7PVY9xos2feSocuTk8le/IlSdSrsaj01Y4+8iEAvokOEgTx/lcujyokDaZG3FjalUAU
         JcQxbs+BRdVyiBC5trg96Lp0iw8yFKtgpeS2FOMWFyR7kACh6bb9TR81QNSUj2skQNJa
         e//Vja5ikv52NM+1qkPuAqq5YQPONio7ME5aLvuY6chQJ131KNBEANjdHUV3OYzm2eK0
         /NCQ==
X-Gm-Message-State: APjAAAWUJbrhuWQVUyfh8GuUbJFGaq1ccYzzuxC0DRt4qdjiNucsFG5F
        s9HyUna+BYk3XKoK9WSdpPxcMeqx3J4=
X-Google-Smtp-Source: APXvYqzlc8cJfkcnmuf8/83kYGNYaePDkWmO9X2p5aLWvZZWm952lm4r3rvNa8O7gvQNlx3EbLMpUw==
X-Received: by 2002:a0c:ab13:: with SMTP id h19mr37510256qvb.243.1582434365097;
        Sat, 22 Feb 2020 21:06:05 -0800 (PST)
Received: from mango.spo.virtua.com.br ([2804:14c:81:942d::1])
        by smtp.gmail.com with ESMTPSA id k50sm4114662qtc.90.2020.02.22.21.06.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Feb 2020 21:06:04 -0800 (PST)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     kolyshkin@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, matheus.bernardino@usp.br,
        szeder.dev@gmail.com
Subject: Re: [PATCH v2] completion: add diff --color-moved[-ws]
Date:   Sun, 23 Feb 2020 02:05:57 -0300
Message-Id: <20200223050557.6380-1-matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200221201545.1244861-1-kolyshkin@gmail.com>
References: <20200221201545.1244861-1-kolyshkin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi, Kir

On Fri, Feb 21, 2020 at 5:15 PM Kir Kolyshkin <kolyshkin@gmail.com> wrote:
>
> These options are available since git v2.15, but somehow
> eluded from the completion script.
>
> Note that while --color-moved-ws= accepts comma-separated
> list of values, there is no (easy?) way to make it work
> with completion (see e.g. [1]).

This puzzled me for some time, but I think I finally got a way to make the
comma-separated completion work. Bellow is the code that does the trick,
together with some tests for the new __gitcomp_cvs function. The diff is on top
of your patch, so you can incorporate it for a v3. Alternatively, if you want
to send these changes as a preparatory patch in a two-patches series, you have
my Signed-off-by :)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 348f0c0c57..e12f90b1cb 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -476,6 +476,41 @@ __gitcomp_file ()
 	true
 }
 
+# The following function is based on
+# https://unix.stackexchange.com/a/176442 (under CC BY-SA 4.0) written
+# by diffycat (https://unix.stackexchange.com/users/17452/diffycat)
+#
+# Call __gitcomp for options that accept a comma separated list of values, i.e.
+# something like '--option=val1,val2'. The caller must have already checked
+# that `$cur == --option=*`. __gitcomp_csv requires two arguments:
+# 1: The option in the format of '--option='
+# 2: The list of possible values for the said option, separated by spaces. Note
+#    that the values cannot contain commas or spaces.
+__gitcomp_csv ()
+{
+	local cur_values="${cur##$1}" available_values
+
+	# Filter out already used values from completion reply
+	for value in $2
+	do
+		if ! [[ ",$cur_values," =~ ",$value," ]]
+		then
+			available_values="$available_values $value"
+		fi
+	done
+
+	local prefix pattern
+	if [[ "$cur_values" == *,* ]]
+	then
+		prefix="${cur_values%,*},"
+		pattern="${cur_values##*,}"
+	else
+		pattern="$cur_values"
+	fi
+
+	__gitcomp "$available_values" "$prefix" "$pattern"
+}
+
 # Execute 'git ls-files', unless the --committable option is specified, in
 # which case it runs 'git diff-index' to find out the files that can be
 # committed.  It return paths relative to the directory specified in the first
@@ -1532,7 +1567,7 @@ _git_diff ()
 		return
 		;;
 	--color-moved-ws=*)
-		__gitcomp "$__git_color_moved_ws_opts" "" "${cur##--color-moved-ws=}"
+		__gitcomp_csv "--color-moved-ws=" "$__git_color_moved_ws_opts"
 		return
 		;;
 	--*)
diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index 5505e5aa24..75b6afe2b7 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -122,6 +122,21 @@ test_gitcomp_nl ()
 	test_cmp expected out
 }
 
+# Test __gitcomp_csv
+# Arguments are:
+# 1: current word (cur)
+# -: the rest are passed to __gitcomp_csv
+test_gitcomp_csv ()
+{
+	local -a COMPREPLY &&
+	sed -e 's/Z$//' >expected &&
+	local cur="$1" &&
+	shift &&
+	__gitcomp_csv "$@" &&
+	print_comp &&
+	test_cmp expected out
+}
+
 invalid_variable_name='${foo.bar}'
 
 actual="$TRASH_DIRECTORY/actual"
@@ -580,6 +595,21 @@ test_expect_success '__gitcomp_nl - doesnt fail because of invalid variable name
 	__gitcomp_nl "$invalid_variable_name"
 '
 
+test_expect_success '__gitcomp_csv - display all values' '
+	test_gitcomp_csv "--opt=" "--opt=" "val1 val2 val3" <<-\EOF
+	val1 Z
+	val2 Z
+	val3 Z
+	EOF
+'
+
+test_expect_success '__gitcomp_csv - do not display values in $cur' '
+	test_gitcomp_csv "--opt=val1," "--opt=" "val1 val2 val3" <<-\EOF
+	val1,val2 Z
+	val1,val3 Z
+	EOF
+'
+
 test_expect_success '__git_remotes - list remotes from $GIT_DIR/remotes and from config file' '
 	cat >expect <<-EOF &&
 	remote_from_file_1

--->8---

> [v2: added missing ignore-space-change]

Change logs are quite useful for reviewers, so thanks for adding one :) However,
they don't really need to be part of the commit message. So the common place to
write them is between the '---' line and the diff stats. Everything you write
in this section will be available for reviewers but discarded when the patch is
applied.

> Acked-by: Matheus Tavares Bernardino <matheus.bernardino@usp.br>

If you are going to send a v3, please, also use
"Matheus Tavares <matheus.bernardino@usp.br>" instead (that's just how I
normally sign).

