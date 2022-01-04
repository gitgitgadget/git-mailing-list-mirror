Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 715F6C433F5
	for <git@archiver.kernel.org>; Tue,  4 Jan 2022 18:03:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235746AbiADSDL (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Jan 2022 13:03:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233070AbiADSDL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Jan 2022 13:03:11 -0500
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F202C061761
        for <git@vger.kernel.org>; Tue,  4 Jan 2022 10:03:11 -0800 (PST)
Received: by mail-qt1-x82c.google.com with SMTP id j17so34953716qtx.2
        for <git@vger.kernel.org>; Tue, 04 Jan 2022 10:03:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:references:from:cc:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=pHIUoRgkkS5eEE2hAe37o9OIqxK6PiffitNdrr0UUtk=;
        b=PO9c3G2/r1pjZI4Pqe8jM2nEEEKcMaCuOdJ4zB2BoWpGA4bch+MiK+PAo3JI/hYW+s
         pIivsIZfhLXRWwydmEglgZo7CWCMH/Yo0Fa7ExkBJNm1CWJtDyS4naTnW9lQ4uTd8izN
         dh0p/Uo/7l50t4R5QC2Ehkn75F4ae5s99bYlJ1SQgeDLH+iMasIwhEAojM0rYxHYtnuj
         mPfDHdaaG18Xv8pHNWZ6nuaiSB1+fJCZYH3zpveOLc1eXEym/v6aNRYucunFaSr12vt8
         n3C31JQJUTFS9enEI5i7PEHI6XIyavryaXcbVXzTi7nUR1VzZvRxPLQb+LtW2R08BHV1
         07Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:references:from:cc:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=pHIUoRgkkS5eEE2hAe37o9OIqxK6PiffitNdrr0UUtk=;
        b=tIc2axkO/EzFBB3lCbi+ocTiPpwcXybiAEUjD8ehUArPh3i4bk3HY2GDQQPNk70ZqH
         Jx0olIz8zMep0lWAA+WPBTZ92yg4Tq+DNlszfXaQUUyi4si0Rub9AFLHzHuVbxuHAg2l
         aIru/jr2ITeQ3Wqhl8pLht45qzXFfeNQ5A3xHAFzlpN1qZJ9Q/iqex+4yEYRew2le6Ia
         bKLMOqEgBDvybGKKXnrNaNIFPMiiGzbZZjaVd8cJhBk961T9hzKTUEaAOYEJUQ+OHhqd
         qaMHXcIASSCcXz9jXerjs0UsMYw56LrCXyVZ6adfE6mqNF7iuNt/F89Q5HaezrT4IsOc
         e9ww==
X-Gm-Message-State: AOAM530UPqNA2QNF4MtFuz57I1GCx9F0K9AGw3DwzVupIScpgCrDiElf
        eo7BqfZdA0rCfdxqVqmmIOQ=
X-Google-Smtp-Source: ABdhPJxIpK19KmigXV94TsrEL1ABVwuejAifT9b1IVVEu2bDAN08Yjm0fbXW1r4/Swc5gzGL8N5l5g==
X-Received: by 2002:ac8:5841:: with SMTP id h1mr45074553qth.517.1641319390190;
        Tue, 04 Jan 2022 10:03:10 -0800 (PST)
Received: from [192.168.1.127] (173-246-5-136.qc.cable.ebox.net. [173.246.5.136])
        by smtp.gmail.com with ESMTPSA id b9sm33151594qtb.53.2022.01.04.10.03.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Jan 2022 10:03:09 -0800 (PST)
Subject: Re: [BUG] git pull --rebase ignores rebase.autostash config when
 fast-forwarding
To:     Philip Oakley <philipoakley@iee.email>,
        Tilman Vogel <tilman.vogel@web.de>, git@vger.kernel.org
References: <9749fa2c-b08d-c08b-ce43-041d13852d02@web.de>
 <1240d0cd-230d-8a80-2250-37336b834834@iee.email>
From:   Philippe Blain <levraiphilippeblain@gmail.com>
Cc:     Felipe Contreras <felipe.contreras@gmail.com>
Message-ID: <cb8d6e8a-aaca-c2eb-6cc8-5c4ad33adfdb@gmail.com>
Date:   Tue, 4 Jan 2022 13:03:08 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <1240d0cd-230d-8a80-2250-37336b834834@iee.email>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Tilman,

Le 2022-01-04 à 07:59, Philip Oakley a écrit :
> On 03/01/2022 18:08, Tilman Vogel wrote:
>> Hi git-people,
>>
>> I ran into strange behavior when having rebase.autostash enabled and
>> doing a git pull --rebase:
>>
>>> git config rebase.autostash true
>>> git pull --rebase
>> Updating cd9ff8a..f3c9840
>> error: Your local changes to the following files would be overwritten by
>> merge:
>>          content
>> Please commit your changes or stash them before you merge.
>> Aborting
>>
>> Confusingly, this fixes the issue:
>>
>>> git config merge.autostash true
>>> git pull --rebase
>> Updating cd9ff8a..f3c9840
>> Created autostash: c615fda
>> Fast-forward
>>   content | 1 +
>>   1 file changed, 1 insertion(+)
>> Applied autostash.
>>
>> Leaving me wonder why merge config options fix rebase behavior.
>>
>> So, in order to make it easier to check the problem, I added some
>> test-cases to the git test-suite. Please see the attached patch.

Thanks, this really makes it easier to bisect the issue.

>>
>> Or here:
>> https://github.com/tvogel/git/commit/bc941f9357518a34cfa11788dfb8e7fa7f711705
>>
>> I did not try to find the root-cause as I am not experienced with the
>> code-base but if there are questions, let me know.
> 
> Which version are you running?
> 

That's a good info to include indeed. I'm guessing you are using v2.34.1 as that's the version
indicated at the bottom of your attached patch. I can replicate the behaviour on my side on 2.34.1.
I did not bisect manually but I'm pretty sure it's a regression caused by 340062243a (pull: cleanup autostash
check, 2021-06-17) (author CC'ed). I checked that the parent of that commit passes all 4 of your added tests, provided
this is squashed in:

diff --git a/t/t5521-pull-options.sh b/t/t5521-pull-options.sh
index 4046a74cad..5ad19b1028 100755
--- a/t/t5521-pull-options.sh
+++ b/t/t5521-pull-options.sh
@@ -260,7 +260,6 @@ test_expect_success 'git pull --rebase --autostash succeeds on ff' '
  	test_commit -C src --printf "more_content" file "more content\ncontent\n" &&
  	echo "dirty" >>dst/file &&
  	git -C dst pull --rebase --autostash >actual 2>&1 &&
-	grep -q "Fast-forward" actual &&
  	grep -q "Applied autostash." actual
  '
  
@@ -273,7 +272,6 @@ test_expect_success 'git pull --rebase with rebase.autostash succeeds on ff' '
  	echo "dirty" >>dst/file &&
  	test_config -C dst rebase.autostash true &&
  	git -C dst pull --rebase  >actual 2>&1 &&
-	grep -q "Fast-forward" actual &&
  	grep -q "Applied autostash." actual
  '

After that commit, in case of fast-forward, 'git pull --rebase --autostash' delegates the fast-forward
operation to 'git merge' under the hood, which was not the case before. The '--autostash' flag seems
to be forwarded correctly to that 'git merge' invocation, but the config 'rebase.autostash' seems to not
be passed along.

I did not yet look into why in the code itself. That does explain however why 'merge.autostash' makes it
work - the 'git merge' invocation does check its own config, and if merge.autostash is there the autostash
behaviour is activated.

Philippe.


