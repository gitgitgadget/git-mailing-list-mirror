Return-Path: <SRS0=JG/V=3O=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D2C6C35241
	for <git@archiver.kernel.org>; Sat, 25 Jan 2020 07:29:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AB8320716
	for <git@archiver.kernel.org>; Sat, 25 Jan 2020 07:29:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="qbjAnT+K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727046AbgAYH3v (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 25 Jan 2020 02:29:51 -0500
Received: from mail-wr1-f47.google.com ([209.85.221.47]:37539 "EHLO
        mail-wr1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726303AbgAYH3v (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 Jan 2020 02:29:51 -0500
Received: by mail-wr1-f47.google.com with SMTP id w15so4793625wru.4
        for <git@vger.kernel.org>; Fri, 24 Jan 2020 23:29:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=jhLD+lHkHYdoKiA5eO6JvvwgW55cRCtGut6DoMB8mXs=;
        b=qbjAnT+KbP2dVEYyzv0Zuv5PCvHuaOdJLCBXqrB27IaSZjLVW4M4SnFq5zoLeTEWnT
         LvUFniO4Qca8KrYZ6Aq6rI56mdnccnvSxdANNqw5MjkvrnQA7nvyLjJsDtE/89s2ZXsq
         saHT+7NHao2qKlzTplA0EcSbjpm8a2vrOf9jFArhVM7gg6zdef+SBfNUZg8Sn0OFw01t
         cJqEvSQX+2ucmPzKCLm6q5+svTUeuUkKfWhF3M0NV6y1YdCJMXfwqcPCWZqwcMl4KKeV
         dEEnnDW55FSuk/MF3QIG4MnY6MenVbbzE14R4FOCLspr+lPii57TLoykshATluaOuORQ
         SAHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jhLD+lHkHYdoKiA5eO6JvvwgW55cRCtGut6DoMB8mXs=;
        b=e5fZtRUdehWqLNDgZISZh18osvHoVg2+rcGtndTTOcrJbsSaH8LWTTtvcKUw90DGOY
         OArLjNqeCLJuTvlmkxypJkTtFvfxYqY707iOwEuK/3RygKrNb0rESsH7NNiI8tqK5oOv
         VkOMklf9hMERHAeAhgEeSD1SghYZM3mZjoDvO1hICEeIXUEESngyQAHCUoSMp+kVVD3n
         xbodYlsHU18oFrzb+0JwPhZ/wYdiP5bPk/kyjvSt3R0ddmx+errTPXRAwL140CP7CvsJ
         /DEzn2T02D+vENuQR3h1egsJTELperqphcnLTTN/X9ZcrTCNlA0v2pUQ8qXOpRLkNqQZ
         aWQA==
X-Gm-Message-State: APjAAAWrahahDEOywZxzaVWQ/jZORpLt5QDizdDldKgsLTIrdrLQ8oGt
        d8D2vWftKRKllkVmX0A=
X-Google-Smtp-Source: APXvYqwBcea9UFYFdEFsYmyCY2HZP7/C/AxkOFMHsz9rhVdcxOADcLP7yp+ryLTBWpbHfmQbvMUXsw==
X-Received: by 2002:adf:9144:: with SMTP id j62mr9038889wrj.168.1579937388770;
        Fri, 24 Jan 2020 23:29:48 -0800 (PST)
Received: from ?IPv6:2a02:810a:8c80:d2c:1d4:baf0:179f:5856? ([2a02:810a:8c80:d2c:1d4:baf0:179f:5856])
        by smtp.gmail.com with ESMTPSA id s19sm9519316wmj.33.2020.01.24.23.29.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 Jan 2020 23:29:48 -0800 (PST)
Subject: Re: [PATCH v4 4/7] remote rename/remove: handle
 branch.<name>.pushRemote config values
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
References: <cover.1579857394.git.bert.wesarg@googlemail.com>
 <9c2110eda64ab7bf0cb780dafe1f13b28fee5ca0.1579857394.git.bert.wesarg@googlemail.com>
 <nycvar.QRO.7.76.6.2001250142560.46@tvgsbejvaqbjf.bet>
From:   Bert Wesarg <bert.wesarg@googlemail.com>
Message-ID: <055e52dd-9349-697c-277f-abc9ac8ae85e@googlemail.com>
Date:   Sat, 25 Jan 2020 08:29:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <nycvar.QRO.7.76.6.2001250142560.46@tvgsbejvaqbjf.bet>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dear Dscho,

On 25.01.20 01:46, Johannes Schindelin wrote:
> Hi Bert,
> 
> On Fri, 24 Jan 2020, Bert Wesarg wrote:
> 
>> When renaming or removing a remote with
>>
>>      git remote rename X Y
>>      git remote remove X
>>
>> Git already renames/removes any config values from
>>
>>      branch.<name>.remote = X
>>
>> to
>>
>>      branch.<name>.remote = Y
>>
>> As branch.<name>.pushRemote also names a remote, it now also renames
>> or removes these config values from
>>
>>      branch.<name>.pushRemote = X
>>
>> to
>>
>>      branch.<name>.pushRemote = Y
>>
>> Signed-off-by: Bert Wesarg <bert.wesarg@googlemail.com>
>>
>> ---
> 
> This commit seems to cause a failure in t5505:
> https://dev.azure.com/gitgitgadget/git/_build/results?buildId=27833&view=ms.vss-test-web.build-test-results-tab
> 
> Here is the excerpt of the log:
> 
> -- snip --
> [...]
> expecting success of 5505.15 'show':
> 	(
> 		cd test &&
> 		git config --add remote.origin.fetch refs/heads/master:refs/heads/upstream &&
> 		git fetch &&
> 		git checkout -b ahead origin/master &&
> 		echo 1 >>file &&
> 		test_tick &&
> 		git commit -m update file &&
> 		git checkout master &&
> 		git branch --track octopus origin/master &&
> 		git branch --track rebase origin/master &&
> 		git branch -d -r origin/master &&
> 		git config --add remote.two.url ../two &&
> 		git config --add remote.two.pushurl ../three &&
> 		git config branch.rebase.rebase true &&
> 		git config branch.octopus.merge "topic-a topic-b topic-c" &&
> 		(
> 			cd ../one &&
> 			echo 1 >file &&
> 			test_tick &&
> 			git commit -m update file
> 		) &&
> 		git config --add remote.origin.push : &&
> 		git config --add remote.origin.push refs/heads/master:refs/heads/upstream &&
> 		git config --add remote.origin.push +refs/tags/lastbackup &&
> 		git config --add remote.two.push +refs/heads/ahead:refs/heads/master &&
> 		git config --add remote.two.push refs/heads/master:refs/heads/another &&
> 		git remote show origin two >output &&
> 		git branch -d rebase octopus &&
> 		test_i18ncmp expect output
> 	)
> 
> + cd test
> + git config --add remote.origin.fetch refs/heads/master:refs/heads/upstream
> + git fetch
>  From /home/virtualbox/git/t/trash directory.t5505-remote/one
>   * [new branch]      master     -> upstream
> + git checkout -b ahead origin/master
> Switched to a new branch 'ahead'
> Branch 'ahead' set up to track remote branch 'master' from 'origin'.
> + echo 1
> + test_tick
> + test -z
> + test_tick=1112911993
> + GIT_COMMITTER_DATE=1112911993 -0700
> + GIT_AUTHOR_DATE=1112911993 -0700
> + export GIT_COMMITTER_DATE GIT_AUTHOR_DATE
> + git commit -m update file
> [ahead 847549e] update
>   Author: A U Thor <author@example.com>
>   1 file changed, 1 insertion(+)
> + git checkout master
> Switched to branch 'master'
> Your branch is up to date with 'origin/master'.
> + git branch --track octopus origin/master
> Branch 'octopus' set up to track remote branch 'master' from 'origin'.
> + git branch --track rebase origin/master
> Branch 'rebase' set up to track remote branch 'master' from 'origin'.
> + git branch -d -r origin/master
> Deleted remote-tracking branch origin/master (was 9d34b14).
> + git config --add remote.two.url ../two
> + git config --add remote.two.pushurl ../three
> + git config branch.rebase.rebase true
> + git config branch.octopus.merge topic-a topic-b topic-c
> + cd ../one
> + echo 1
> + test_tick
> + test -z set
> + test_tick=1112912053
> + GIT_COMMITTER_DATE=1112912053 -0700
> + GIT_AUTHOR_DATE=1112912053 -0700
> + export GIT_COMMITTER_DATE GIT_AUTHOR_DATE
> + git commit -m update file
> [master 6329a3c] update
>   Author: A U Thor <author@example.com>
>   1 file changed, 1 insertion(+)
> + git config --add remote.origin.push :
> + git config --add remote.origin.push refs/heads/master:refs/heads/upstream
> + git config --add remote.origin.push +refs/tags/lastbackup
> + git config --add remote.two.push +refs/heads/ahead:refs/heads/master
> + git config --add remote.two.push refs/heads/master:refs/heads/another
> + git remote show origin two
> error: src refspec refs/tags/lastbackup does not match any
> + git branch -d rebase octopus
> Deleted branch rebase (was 9d34b14).
> Deleted branch octopus (was 9d34b14).
> + test_i18ncmp expect output
> + test_have_prereq C_LOCALE_OUTPUT
> + save_IFS=
> 
> + IFS=,
> + set -- C_LOCALE_OUTPUT
> + IFS=
> 
> + total_prereq=0
> + ok_prereq=0
> + missing_prereq=
> + negative_prereq=
> + total_prereq=1
> + satisfied_this_prereq=t
> + ok_prereq=1
> + test 1 = 1
> + test_cmp expect output
> + diff -u expect output
> --- expect	2020-01-25 00:44:41.496720000 +0000
> +++ output	2020-01-25 00:44:43.513861900 +0000
> @@ -5,13 +5,6 @@
>     Remote branches:
>       master new (next fetch will store in remotes/origin)
>       side   tracked
> -  Local branches configured for 'git pull':
> -    ahead    merges with remote master
> -    master   merges with remote master
> -    octopus  merges with remote topic-a
> -                and with remote topic-b
> -                and with remote topic-c
> -    rebase  rebases onto remote master
>     Local refs configured for 'git push':
>       master pushes to master   (local out of date)
>       master pushes to upstream (create)
> error: last command exited with $?=1
> not ok 15 - show
> #
> #		(
> #			cd test &&
> #			git config --add remote.origin.fetch refs/heads/master:refs/heads/upstream &&
> #			git fetch &&
> #			git checkout -b ahead origin/master &&
> #			echo 1 >>file &&
> #			test_tick &&
> #			git commit -m update file &&
> #			git checkout master &&
> #			git branch --track octopus origin/master &&
> #			git branch --track rebase origin/master &&
> #			git branch -d -r origin/master &&
> #			git config --add remote.two.url ../two &&
> #			git config --add remote.two.pushurl ../three &&
> #			git config branch.rebase.rebase true &&
> #			git config branch.octopus.merge "topic-a topic-b topic-c" &&
> #			(
> #				cd ../one &&
> #				echo 1 >file &&
> #				test_tick &&
> #				git commit -m update file
> #			) &&
> #			git config --add remote.origin.push : &&
> #			git config --add remote.origin.push refs/heads/master:refs/heads/upstream &&
> #			git config --add remote.origin.push +refs/tags/lastbackup &&
> #			git config --add remote.two.push +refs/heads/ahead:refs/heads/master &&
> #			git config --add remote.two.push refs/heads/master:refs/heads/another &&
> #			git remote show origin two >output &&
> #			git branch -d rebase octopus &&
> #			test_i18ncmp expect output
> #		)
> #
> -- snap --
> 
> Could you have a look to see whether the code or the test need to be
> adjusted?

please ensure that you have v4 of this patch. What you see was a bug in v3.

Thanks.

Bert

> 
> Thanks,
> Dscho
> 
