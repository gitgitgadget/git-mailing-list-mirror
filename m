Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 389061FD99
	for <e@80x24.org>; Fri, 26 Aug 2016 19:44:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752619AbcHZTow (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Aug 2016 15:44:52 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59325 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751139AbcHZTov (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Aug 2016 15:44:51 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5B79338AE8;
        Fri, 26 Aug 2016 15:42:31 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=043ioLqVPZmTz9AfTHrP2xA7a6o=; b=TkkVil
        F1cF/CmiFFgRRCNbQUsdCj8fPFJK/8sbxbdwD3qNj0iHDJ8Y/t5RTjOujbuGxzQ2
        stfvPORKrzvtl82OyKRpGRIPTySX4RxE+aPMH5djcCNDxXtYxcgGTealnm9NZ0ad
        6x22y9nlg+bqTLoUqituxUgIa3zWqwwhsPy98=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Z4eSUIwC/+4F93oZxK3MaEq52Nu/bwB7
        VkXm2XenkMQL/KXwsLsuqL8Y16k3IuqfREjo8dr2wl46XSunpEtKYSVUFLPrCQib
        0kQLexrQlSBksonDL1wEquL6Vs/Qy/Y3qAGsw3vSam8d8ATYvmlqqEaE6zJFE0tM
        rVgTAJEpUaU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 524B438AE7;
        Fri, 26 Aug 2016 15:42:31 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id CF86138AE4;
        Fri, 26 Aug 2016 15:42:30 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ralf Thielow <ralf.thielow@gmail.com>
Cc:     git@vger.kernel.org, larsxschneider@gmail.com, me@jnm2.com,
        philipoakley@iee.org, john@keeping.me.uk,
        johannes.schindelin@gmx.de
Subject: Re: [PATCH v2 2/3] help: introduce option --exclude-guides
References: <20160818185719.4909-1-ralf.thielow@gmail.com>
        <20160826175836.14073-1-ralf.thielow@gmail.com>
        <20160826175836.14073-3-ralf.thielow@gmail.com>
        <xmqq8tvjgxiy.fsf@gitster.mtv.corp.google.com>
Date:   Fri, 26 Aug 2016 12:42:28 -0700
In-Reply-To: <xmqq8tvjgxiy.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Fri, 26 Aug 2016 12:06:45 -0700")
Message-ID: <xmqqwpj3fhaz.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3A1FB4A6-6BC5-11E6-9734-F7BB12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Let's hide this option from command help of "git help" itself, drop
> the short-and-sweet "-e", not command-line complete it, and leave it
> not-mentioned here.
> ...
> Unless there is a good reason you MUST do so, avoid quoting the test
> body with double quotes, as it invites mistakes [*1*].
>
> Also, how about using something like:
> ...
> instead?  That way, you can ensure that "git help status" attempts
> to call git-status.html with the expected path, not gitstatus.html
> or status.html, or somesuch, immediately after running "git help
> status" in the next test by inspecting test-browser.log ...

Taking all of these together, I'll queue this as a proposed fix-up
directly on top of yours.

 Documentation/git-help.txt             |  6 +-----
 builtin/help.c                         |  2 +-
 contrib/completion/git-completion.bash |  2 +-
 t/t0012-help.sh                        | 33 ++++++++++++++++++---------------
 4 files changed, 21 insertions(+), 22 deletions(-)

diff --git a/Documentation/git-help.txt b/Documentation/git-help.txt
index eeb1950..40d328a 100644
--- a/Documentation/git-help.txt
+++ b/Documentation/git-help.txt
@@ -8,7 +8,7 @@ git-help - Display help information about Git
 SYNOPSIS
 --------
 [verse]
-'git help' [-a|--all] [-e|--exclude-guides] [-g|--guide]
+'git help' [-a|--all] [-g|--guide]
 	   [-i|--info|-m|--man|-w|--web] [COMMAND|GUIDE]
 
 DESCRIPTION
@@ -43,10 +43,6 @@ OPTIONS
 	Prints all the available commands on the standard output. This
 	option overrides any given command or guide name.
 
--e::
---exclude-guides::
-	Do not show help for guides.
-
 -g::
 --guides::
 	Prints a list of useful guides on the standard output. This
diff --git a/builtin/help.c b/builtin/help.c
index 40901a9..49f7a07 100644
--- a/builtin/help.c
+++ b/builtin/help.c
@@ -40,7 +40,7 @@ static enum help_format help_format = HELP_FORMAT_NONE;
 static int exclude_guides;
 static struct option builtin_help_options[] = {
 	OPT_BOOL('a', "all", &show_all, N_("print all available commands")),
-	OPT_BOOL('e', "exclude-guides", &exclude_guides, N_("exclude guides")),
+	OPT_HIDDEN_BOOL(0, "exclude-guides", &exclude_guides, N_("exclude guides")),
 	OPT_BOOL('g', "guides", &show_guides, N_("print list of useful guides")),
 	OPT_SET_INT('m', "man", &help_format, N_("show man page"), HELP_FORMAT_MAN),
 	OPT_SET_INT('w', "web", &help_format, N_("show manual in web browser"),
diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 63cccb9..bd25b0a 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1340,7 +1340,7 @@ _git_help ()
 {
 	case "$cur" in
 	--*)
-		__gitcomp "--all --exclude-guides --guides --info --man --web"
+		__gitcomp "--all --guides --info --man --web"
 		return
 		;;
 	esac
diff --git a/t/t0012-help.sh b/t/t0012-help.sh
index f91088b..9d99812 100755
--- a/t/t0012-help.sh
+++ b/t/t0012-help.sh
@@ -7,27 +7,30 @@ test_description='help'
 configure_help () {
 	test_config help.format html &&
 	test_config help.htmlpath test://html &&
-	test_config help.browser firefox
+	test_config browser.test.cmd ./test-browser &&
+	test_config help.browser test
 }
 
-test_expect_success "setup" "
-	write_script firefox <<-\EOF
-	exit 0
+test_expect_success "setup" '
+	write_script test-browser <<-\EOF
+	echo "$*" >test-browser.log
 	EOF
-"
+'
 
-test_expect_success "works for commands and guides by default" "
+test_expect_success "works for commands and guides by default" '
 	configure_help &&
 	git help status &&
-	git help revisions
-"
+	echo "test://html/git-status.html" >expect &&
+	test_cmp expect test-browser.log &&
+	git help revisions &&
+	echo "test://html/gitrevisions.html" >expect &&
+	test_cmp expect test-browser.log
+'
 
-test_expect_success "--exclude-guides does not work for guides" "
-	cat <<-EOF >expected &&
-		git: 'revisions' is not a git command. See 'git --help'.
-	EOF
-	test_must_fail git help --exclude-guides revisions 2>actual &&
-	test_i18ncmp expected actual
-"
+test_expect_success "--exclude-guides does not work for guides" '
+	>test-browser.log &&
+	test_must_fail git help --exclude-guides revisions &&
+	test_must_be_empty test-browser.log
+'
 
 test_done
-- 
2.10.0-rc1-260-gbdd1a2a

