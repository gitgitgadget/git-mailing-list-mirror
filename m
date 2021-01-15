Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 954DAC433E0
	for <git@archiver.kernel.org>; Fri, 15 Jan 2021 06:37:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 555FB23370
	for <git@archiver.kernel.org>; Fri, 15 Jan 2021 06:37:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727381AbhAOGhi (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 Jan 2021 01:37:38 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53944 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726650AbhAOGhi (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Jan 2021 01:37:38 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7B790B2E55;
        Fri, 15 Jan 2021 01:36:51 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=Gy8SqQXlVbMR42pNdaxVbhY6XNw=; b=kg1z+BqZyyfylFVP9L+u
        egr446uSYVrZIF2eE7f5+zOROMc2CfP8wJ9aaNMvmAuCjTRDV68vRJJEDddlalG6
        HVNSjO+yWLEUkp6ROYeCXlrEVww+Y7IWpuecGNQG05qqy40rPiZ1D2gfBHLPvPpf
        2N5zD8vHyafE8dVfTHOcqcc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         q=dns; s=sasl; b=leCmk24piI5EAx+n1sPWvYAk0PJdLCarfFHpHDtMDHb7tf
        qKX22EIyA+YsOyjGYVzCsYrhjPCdNhrqNgItCiNTyFOYaA0HtKJOXp1t98aXUcIL
        jev+CdJOqRbWUJ94C4uM6tBZLhf3M2mTu+cHu9sJpNOrMKwHw8pA35tNhwSpI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7379DB2E54;
        Fri, 15 Jan 2021 01:36:51 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id F3A1FB2E53;
        Fri, 15 Jan 2021 01:36:50 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Emily Shaffer <emilyshaffer@google.com>, git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jan 2021, #02; Fri, 8)
References: <xmqqk0sni68g.fsf@gitster.c.googlers.com>
        <YADOf41CcaRuToD7@google.com>
        <15237c6c-98eb-0d1f-e6d5-2dda91c0ce09@gmail.com>
Date:   Thu, 14 Jan 2021 22:36:50 -0800
Message-ID: <xmqqr1mmu2nx.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0CB919CC-56FC-11EB-94E1-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

> Perhaps it would be better to have a --fixed-value patch on top
> of the merge that combines the two topics?

Thanks.  That is how we usually handle this kind of fallouts from
multiple topics.

In fact, there already are conflicting hunks in t/t7900 when the
topic is merged into the current 'master', and rerere database knows
about them; I'll need to teach "--fixed-value" to these places.

Here is how eventual merge of the topic into 'master' would resolve
conflicts.  The straight merge chain from master..seen would have
such a merge with the resolution shown below, but 'next' already has
a mismerge, so I'll be applying a single-parent commit to fix the
mismerge directly on 'next' (which I'll send in a separate message).

Thanks, all, for all the help.



diff --cc t/t7900-maintenance.sh
index 99bf0c7582,135505f619..0000000000
--- i/t/t7900-maintenance.sh
+++ w/t/t7900-maintenance.sh
@@@ -406,23 -380,11 +419,23 @@@ test_expect_success 'register and unreg
  	test_cmp before actual
  '
  
 +test_expect_success !MINGW 'register and unregister with regex metacharacters' '
 +	META="a+b*c" &&
 +	git init "$META" &&
 +	git -C "$META" maintenance register &&
 +	git config --get-all --show-origin maintenance.repo &&
 +	git config --get-all --global --fixed-value \
 +		maintenance.repo "$(pwd)/$META" &&
 +	git -C "$META" maintenance unregister &&
 +	test_must_fail git config --get-all --global --fixed-value \
 +		maintenance.repo "$(pwd)/$META"
 +'
 +
  test_expect_success 'start from empty cron table' '
- 	GIT_TEST_CRONTAB="test-tool crontab cron.txt" git maintenance start &&
+ 	GIT_TEST_MAINT_SCHEDULER="crontab:test-tool crontab cron.txt" git maintenance start &&
  
  	# start registers the repo
 -	git config --get --global maintenance.repo "$(pwd)" &&
 +	git config --get --global --fixed-value maintenance.repo "$(pwd)" &&
  
  	grep "for-each-repo --config=maintenance.repo maintenance run --schedule=daily" cron.txt &&
  	grep "for-each-repo --config=maintenance.repo maintenance run --schedule=hourly" cron.txt &&
@@@ -430,13 -392,13 +443,13 @@@
  '
  
  test_expect_success 'stop from existing schedule' '
- 	GIT_TEST_CRONTAB="test-tool crontab cron.txt" git maintenance stop &&
+ 	GIT_TEST_MAINT_SCHEDULER="crontab:test-tool crontab cron.txt" git maintenance stop &&
  
  	# stop does not unregister the repo
 -	git config --get --global maintenance.repo "$(pwd)" &&
 +	git config --get --global --fixed-value maintenance.repo "$(pwd)" &&
  
  	# Operation is idempotent
- 	GIT_TEST_CRONTAB="test-tool crontab cron.txt" git maintenance stop &&
+ 	GIT_TEST_MAINT_SCHEDULER="crontab:test-tool crontab cron.txt" git maintenance stop &&
  	test_must_be_empty cron.txt
  '
  
@@@ -446,22 -408,89 +459,105 @@@ test_expect_success 'start preserves ex
  	grep "Important information!" cron.txt
  '
  
 +test_expect_success 'magic markers are correct' '
 +	grep "GIT MAINTENANCE SCHEDULE" cron.txt >actual &&
 +	cat >expect <<-\EOF &&
 +	# BEGIN GIT MAINTENANCE SCHEDULE
 +	# END GIT MAINTENANCE SCHEDULE
 +	EOF
 +	test_cmp actual expect
 +'
 +
 +test_expect_success 'stop preserves surrounding schedule' '
 +	echo "Crucial information!" >>cron.txt &&
- 	GIT_TEST_CRONTAB="test-tool crontab cron.txt" git maintenance stop &&
++	GIT_TEST_MAINT_SCHEDULER="crontab:test-tool crontab cron.txt" git maintenance stop &&
 +	grep "Important information!" cron.txt &&
 +	grep "Crucial information!" cron.txt
 +'
 +
+ test_expect_success 'start and stop macOS maintenance' '
+ 	# ensure $HOME can be compared against hook arguments on all platforms
+ 	pfx=$(cd "$HOME" && pwd) &&
+ 
+ 	write_script print-args <<-\EOF &&
+ 	echo $* | sed "s:gui/[0-9][0-9]*:gui/[UID]:" >>args
+ 	EOF
+ 
+ 	rm -f args &&
+ 	GIT_TEST_MAINT_SCHEDULER=launchctl:./print-args git maintenance start &&
+ 
+ 	# start registers the repo
 -	git config --get --global maintenance.repo "$(pwd)" &&
++	git config --get --global --fixed-value maintenance.repo "$(pwd)" &&
+ 
+ 	ls "$HOME/Library/LaunchAgents" >actual &&
+ 	cat >expect <<-\EOF &&
+ 	org.git-scm.git.daily.plist
+ 	org.git-scm.git.hourly.plist
+ 	org.git-scm.git.weekly.plist
+ 	EOF
+ 	test_cmp expect actual &&
+ 
+ 	rm -f expect &&
+ 	for frequency in hourly daily weekly
+ 	do
+ 		PLIST="$pfx/Library/LaunchAgents/org.git-scm.git.$frequency.plist" &&
+ 		test_xmllint "$PLIST" &&
+ 		grep schedule=$frequency "$PLIST" &&
+ 		echo "bootout gui/[UID] $PLIST" >>expect &&
+ 		echo "bootstrap gui/[UID] $PLIST" >>expect || return 1
+ 	done &&
+ 	test_cmp expect args &&
+ 
+ 	rm -f args &&
+ 	GIT_TEST_MAINT_SCHEDULER=launchctl:./print-args git maintenance stop &&
+ 
+ 	# stop does not unregister the repo
 -	git config --get --global maintenance.repo "$(pwd)" &&
++	git config --get --global --fixed-value maintenance.repo "$(pwd)" &&
+ 
+ 	printf "bootout gui/[UID] $pfx/Library/LaunchAgents/org.git-scm.git.%s.plist\n" \
+ 		hourly daily weekly >expect &&
+ 	test_cmp expect args &&
+ 	ls "$HOME/Library/LaunchAgents" >actual &&
+ 	test_line_count = 0 actual
+ '
+ 
+ test_expect_success 'start and stop Windows maintenance' '
+ 	write_script print-args <<-\EOF &&
+ 	echo $* >>args
+ 	while test $# -gt 0
+ 	do
+ 		case "$1" in
+ 		/xml) shift; xmlfile=$1; break ;;
+ 		*) shift ;;
+ 		esac
+ 	done
+ 	test -z "$xmlfile" || cp "$xmlfile" "$xmlfile.xml"
+ 	EOF
+ 
+ 	rm -f args &&
+ 	GIT_TEST_MAINT_SCHEDULER="schtasks:./print-args" git maintenance start &&
+ 
+ 	# start registers the repo
 -	git config --get --global maintenance.repo "$(pwd)" &&
++	git config --get --global --fixed-value maintenance.repo "$(pwd)" &&
+ 
+ 	for frequency in hourly daily weekly
+ 	do
+ 		grep "/create /tn Git Maintenance ($frequency) /f /xml" args &&
+ 		file=$(ls .git/schedule_${frequency}*.xml) &&
+ 		test_xmllint "$file" || return 1
+ 	done &&
+ 
+ 	rm -f args &&
+ 	GIT_TEST_MAINT_SCHEDULER="schtasks:./print-args" git maintenance stop &&
+ 
+ 	# stop does not unregister the repo
 -	git config --get --global maintenance.repo "$(pwd)" &&
++	git config --get --global --fixed-value maintenance.repo "$(pwd)" &&
+ 
+ 	printf "/delete /tn Git Maintenance (%s) /f\n" \
+ 		hourly daily weekly >expect &&
+ 	test_cmp expect args
+ '
+ 
  test_expect_success 'register preserves existing strategy' '
  	git config maintenance.strategy none &&
  	git maintenance register &&

