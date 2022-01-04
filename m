Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A15C1C433EF
	for <git@archiver.kernel.org>; Tue,  4 Jan 2022 18:30:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236301AbiADSaa (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Jan 2022 13:30:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236320AbiADS3a (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Jan 2022 13:29:30 -0500
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFBCEC061761
        for <git@vger.kernel.org>; Tue,  4 Jan 2022 10:29:30 -0800 (PST)
Received: by mail-qt1-x831.google.com with SMTP id a1so34955872qtx.11
        for <git@vger.kernel.org>; Tue, 04 Jan 2022 10:29:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=vM5RW54zOfVS5/jN09TTqMeCOANpQ/g3ddPL/FHLAYA=;
        b=VM8OY2rxmmkfVm6yAAoLLFl9sxd0keejukc0YU1ovNjZXz5VpCl1001hBWUe1jtnBB
         UGGCSbnO0GPRNY8cwXgt9nDBgnhYf0yamVyIzTb5aic1R73mXCdkK9Kd7kJWEjBBnnM4
         dSo/yWNwXwEBSnyWR4tUF5vMznbzUexIWnl5iFScl3fjQfLuVuAWRyyauSHAWNrZA25/
         w2Q3xyOCdvY4VdSrr++yCh6Np4OISxu6/AaXGa97NsCO4YZwRorogXeombJullfpLyOj
         AdRERlu2iN/JSogaZSM4i/M5pDlUGyKpRc9PhrcydxpbXlr0U53IZSdJu0uHEmAqg/vA
         nOBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vM5RW54zOfVS5/jN09TTqMeCOANpQ/g3ddPL/FHLAYA=;
        b=Qtk8ygKuMuvct5rnaH3mCIDU04X+uuCPcCEYM5Y2MIMs40oxaEnNdtGTxuRD/Ghl5i
         PZT6FKq6+5atDfTX6yQLrmYa2HXdxyQv/sRknGyOVMwrxef1esByszv+y0kPDqzf8aSM
         brQNoCKbnDlZZPGYBSfZ7w5FWtkOEgBQN8ArfD62p1zv4WBLuI1lNeiLvKOHF52KRQEQ
         48wGkpw1NmGyjomh40bjiiYXrNoP3tG8yUZAiayS7uM29GifpZpq6xNIiKQh1rN9N3eo
         MbTHc1zAcHyK6lmz1mbqMkhaxp8bcBloLxT++IuumedY4qU4eGTbU6ttd0qHWyNu6Tgs
         MO1Q==
X-Gm-Message-State: AOAM533DzsK3Bwl2nToz9ezXvl75L7X8ZAEr5+Eu7lFTmgSnTl8hmGtQ
        1EJNhwkWYDJlsvaYDdK9ZEn3KZ6Rq30=
X-Google-Smtp-Source: ABdhPJxXtIbThfewDAupmFFA4yiUmgS3POckFy3IIXjsRmbwwC/KOTcd0Y3uHs2QQSrtzi6wuyT4vw==
X-Received: by 2002:ac8:58cc:: with SMTP id u12mr45994028qta.385.1641320969822;
        Tue, 04 Jan 2022 10:29:29 -0800 (PST)
Received: from [192.168.1.127] (173-246-5-136.qc.cable.ebox.net. [173.246.5.136])
        by smtp.gmail.com with ESMTPSA id d15sm33696156qtd.70.2022.01.04.10.29.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Jan 2022 10:29:29 -0800 (PST)
Subject: Re: [BUG] git pull --rebase ignores rebase.autostash config when
 fast-forwarding
From:   Philippe Blain <levraiphilippeblain@gmail.com>
To:     Philip Oakley <philipoakley@iee.email>,
        Tilman Vogel <tilman.vogel@web.de>, git@vger.kernel.org
Cc:     Felipe Contreras <felipe.contreras@gmail.com>
References: <9749fa2c-b08d-c08b-ce43-041d13852d02@web.de>
 <1240d0cd-230d-8a80-2250-37336b834834@iee.email>
 <cb8d6e8a-aaca-c2eb-6cc8-5c4ad33adfdb@gmail.com>
Message-ID: <507d156f-9135-229e-423d-a8ab68bfa9b7@gmail.com>
Date:   Tue, 4 Jan 2022 13:29:27 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <cb8d6e8a-aaca-c2eb-6cc8-5c4ad33adfdb@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi again,

Le 2022-01-04 à 13:03, Philippe Blain a écrit :
> Hi Tilman,
> 
> Le 2022-01-04 à 07:59, Philip Oakley a écrit :
>> On 03/01/2022 18:08, Tilman Vogel wrote:
>>> Hi git-people,
>>>
>>> I ran into strange behavior when having rebase.autostash enabled and
>>> doing a git pull --rebase:
>>>
>>>> git config rebase.autostash true
>>>> git pull --rebase
>>> Updating cd9ff8a..f3c9840
>>> error: Your local changes to the following files would be overwritten by
>>> merge:
>>>          content
>>> Please commit your changes or stash them before you merge.
>>> Aborting
>>>
>>> Confusingly, this fixes the issue:
>>>
>>>> git config merge.autostash true
>>>> git pull --rebase
>>> Updating cd9ff8a..f3c9840
>>> Created autostash: c615fda
>>> Fast-forward
>>>   content | 1 +
>>>   1 file changed, 1 insertion(+)
>>> Applied autostash.
>>>
>>> Leaving me wonder why merge config options fix rebase behavior.
>>>
>>> So, in order to make it easier to check the problem, I added some
>>> test-cases to the git test-suite. Please see the attached patch.
> 
> Thanks, this really makes it easier to bisect the issue.
> 
>>>
>>> Or here:
>>> https://github.com/tvogel/git/commit/bc941f9357518a34cfa11788dfb8e7fa7f711705
>>>
>>> I did not try to find the root-cause as I am not experienced with the
>>> code-base but if there are questions, let me know.
>>
>> Which version are you running?
>>
> 
> That's a good info to include indeed. I'm guessing you are using v2.34.1 as that's the version
> indicated at the bottom of your attached patch. I can replicate the behaviour on my side on 2.34.1.
> I did not bisect manually but I'm pretty sure it's a regression caused by 340062243a (pull: cleanup autostash
> check, 2021-06-17) (author CC'ed). I checked that the parent of that commit passes all 4 of your added tests, provided
> this is squashed in:
> 
> diff --git a/t/t5521-pull-options.sh b/t/t5521-pull-options.sh
> index 4046a74cad..5ad19b1028 100755
> --- a/t/t5521-pull-options.sh
> +++ b/t/t5521-pull-options.sh
> @@ -260,7 +260,6 @@ test_expect_success 'git pull --rebase --autostash succeeds on ff' '
>       test_commit -C src --printf "more_content" file "more content\ncontent\n" &&
>       echo "dirty" >>dst/file &&
>       git -C dst pull --rebase --autostash >actual 2>&1 &&
> -    grep -q "Fast-forward" actual &&
>       grep -q "Applied autostash." actual
>   '
> 
> @@ -273,7 +272,6 @@ test_expect_success 'git pull --rebase with rebase.autostash succeeds on ff' '
>       echo "dirty" >>dst/file &&
>       test_config -C dst rebase.autostash true &&
>       git -C dst pull --rebase  >actual 2>&1 &&
> -    grep -q "Fast-forward" actual &&
>       grep -q "Applied autostash." actual
>   '
> 
> After that commit, in case of fast-forward, 'git pull --rebase --autostash' delegates the fast-forward
> operation to 'git merge' under the hood, which was not the case before. The '--autostash' flag seems
> to be forwarded correctly to that 'git merge' invocation, but the config 'rebase.autostash' seems to not
> be passed along.
> 
> I did not yet look into why in the code itself

After looking at it a bit, this seems to fix the bug:

diff --git a/builtin/pull.c b/builtin/pull.c
index 1cfaf9f343..0b206bf1d5 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -87,6 +87,7 @@ static char *opt_verify_signatures;
  static char *opt_verify;
  static int opt_autostash = -1;
  static int config_autostash;
+static int autostash = -1;
  static int check_trust_level = 1;
  static struct strvec opt_strategies = STRVEC_INIT;
  static struct strvec opt_strategy_opts = STRVEC_INIT;
@@ -687,9 +688,9 @@ static int run_merge(void)
  	strvec_pushv(&args, opt_strategy_opts.v);
  	if (opt_gpg_sign)
  		strvec_push(&args, opt_gpg_sign);
-	if (opt_autostash == 0)
+	if (autostash == 0)
  		strvec_push(&args, "--no-autostash");
-	else if (opt_autostash == 1)
+	else if (autostash == 1)
  		strvec_push(&args, "--autostash");
  	if (opt_allow_unrelated_histories > 0)
  		strvec_push(&args, "--allow-unrelated-histories");
@@ -1036,7 +1037,7 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
  		oidclr(&orig_head);
  
  	if (opt_rebase) {
-		int autostash = config_autostash;
+		autostash = config_autostash;
  		if (opt_autostash != -1)
  			autostash = opt_autostash;


If nobody beats me to it (if that's the case, be my guest !), I'll try to submit a proper patch later
today or this week.

In case anybody needs it:

Signed-off by: Philippe Blain <levraiphilippeblain@gmail.com>


Cheers,

Philippe.
  

