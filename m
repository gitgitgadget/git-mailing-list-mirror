Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2388BC433FE
	for <git@archiver.kernel.org>; Wed, 26 Oct 2022 21:23:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233356AbiJZVXW (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Oct 2022 17:23:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233282AbiJZVXV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Oct 2022 17:23:21 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 476091290B9
        for <git@vger.kernel.org>; Wed, 26 Oct 2022 14:23:20 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id a5so11725788qkl.6
        for <git@vger.kernel.org>; Wed, 26 Oct 2022 14:23:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q49HR09PevPgestYOpoBlLpmgNZ83wvCLoW4V4RLBAA=;
        b=ClkM60WPbulzdN6ATKrYRdYRRWBx6EBfjBS7NuTadpEz24SPAkOxvlOWuKK6pYxFpb
         qRSR7X4IgQhMOrA23psLsTBJi4KBF/6Y8mMNZuBdUEef86wEr4sudUies3J40qjONbyV
         VA9FLk95UbCkDm7dicAygQ2lYnBKPPt1LMyP5HBFjOPH5Q/r9b7Pglw2KsMjLn4/I8f1
         DW71ZKHYuK6VlA0gYET55ZAOgLJja7qTPljqBqBZzFg5teMA2QIXAsRLOKjk48C7LmiB
         jA3t7VoyAJ9WHnoQLGAg/GvdVfec42UjWM2+moZGIH+4vzsuqmmm12aQz5k7lAvpcDZ3
         +yEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q49HR09PevPgestYOpoBlLpmgNZ83wvCLoW4V4RLBAA=;
        b=lTgji+A5vjUR9qg2EnqyzDZYC52Hrq5yorPPWjD74k5cQ3lrEwgsBOhbHwDc8alR3T
         uF5geYFcVVxUH38qp9c8hMh4TFkQAJFwoC/UORx6TV5ug2ZMWNyK6oOkRYVRPfLwH1Z5
         CMAQ+RhBnensDJER+Pa5+9/WK4PH4u5ZsS/rPyl1vYgwYJUfHsmfR7dA5VEWiOe/LkZ9
         nQatIDNYzTvkK6ft96sclWuKhRlnTvs1MTr41RCD+MLDx+Fm0oQZCzMH1+QiAMTHItIu
         5zZS7RqK7EoqQ+pU+xbHXHdVZnLAvR7bSkmj0euWqIQD2V6UJukPworp1nVZaHDIPFYR
         2PNA==
X-Gm-Message-State: ACrzQf1ITufYVdX+BDpEx2MS5MsVwvPR44wK3EaW7dsnaTNsJM0RBS5G
        J4fj++sicRydj3TmXjzWL1ZPoDDP8WXtvg==
X-Google-Smtp-Source: AMsMyM65v2z3oKPojCoNYMVmShA67fIiL4Ol/jxvSVesAHW4ltieaJekHYTnS6XJdbRnTHAnIQJQZA==
X-Received: by 2002:a37:e118:0:b0:6ec:565e:f2d8 with SMTP id c24-20020a37e118000000b006ec565ef2d8mr32494066qkm.719.1666819399370;
        Wed, 26 Oct 2022 14:23:19 -0700 (PDT)
Received: from [192.168.1.127] (173-246-5-136.qc.cable.ebox.net. [173.246.5.136])
        by smtp.gmail.com with ESMTPSA id u6-20020a37ab06000000b006eed094dcdasm4484252qke.70.2022.10.26.14.23.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Oct 2022 14:23:18 -0700 (PDT)
Subject: Re: [PATCH 3/9] subtree: add 'die_incompatible_opt' function to
 reduce duplication
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Philippe Blain via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Luke Shumaker <lukeshu@datawire.io>,
        Thomas Koutcher <thomas.koutcher@online.fr>,
        James Limbouris <james@digitalmatter.com>
References: <pull.1390.git.1666365219.gitgitgadget@gmail.com>
 <c890f55f59994231be6114f76f020510eb824453.1666365220.git.gitgitgadget@gmail.com>
 <221021.86v8oddtuj.gmgdl@evledraar.gmail.com>
From:   Philippe Blain <levraiphilippeblain@gmail.com>
Message-ID: <949edc06-8252-6995-addf-cfba398f73dd@gmail.com>
Date:   Wed, 26 Oct 2022 17:23:17 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <221021.86v8oddtuj.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Ævar,

Le 2022-10-21 à 12:22, Ævar Arnfjörð Bjarmason a écrit :
> 
> On Fri, Oct 21 2022, Philippe Blain via GitGitGadget wrote:
> 
>> From: Philippe Blain <levraiphilippeblain@gmail.com>
>>
>> 9a3e3ca2ba (subtree: be stricter about validating flags, 2021-04-27)
>> added validation code to check that options given to 'git subtree <cmd>'
>> made sense with the command being used.
>>
>> Refactor these checks by adding a 'die_incompatible_opt' function to
>> reduce code duplication.
> 
> This looks good, but...
> 
>> Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
>> ---
>>  contrib/subtree/git-subtree.sh | 32 ++++++++++++++++++++------------
>>  1 file changed, 20 insertions(+), 12 deletions(-)
>>
>> diff --git a/contrib/subtree/git-subtree.sh b/contrib/subtree/git-subtree.sh
>> index 49ef493ef92..f5eab198c80 100755
>> --- a/contrib/subtree/git-subtree.sh
>> +++ b/contrib/subtree/git-subtree.sh
>> @@ -102,6 +102,14 @@ assert () {
>>  	fi
>>  }
>>  
>> +# Usage: die_incompatible_opt OPTION COMMAND
>> +die_incompatible_opt () {
>> +	assert test "$#" = 2
>> +	opt="$1"
>> +	arg_command="$2"
>> +	die "The '$opt' flag does not make sense with 'git subtree $arg_command'."
>> +}
>> +
>>  main () {
>>  	if test $# -eq 0
>>  	then
>> @@ -176,16 +184,16 @@ main () {
>>  			arg_debug=1
>>  			;;
>>  		--annotate)
>> -			test -n "$allow_split" || die "The '$opt' flag does not make sense with 'git subtree $arg_command'."
>> +			test -n "$allow_split" || die_incompatible_opt "$opt" "$arg_command"
>>  			arg_split_annotate="$1"
>>  			shift
>>  			;;
> 
> Since this is all in this form I wonder why not (maybe adding some "local" and/or "&&" too while at it):
> 
> 	die_if_other_opt {
> 		assert test "$#" = 3
> 		other="$1"
>                 shift
>                 if test -z "$other"
> 		then
> 			return
> 		fi
> 		[...the rest of your version]
> 	}
> 
> Then:
> 
>>  		--no-annotate)
>> -			test -n "$allow_split" || die "The '$opt' flag does not make sense with 'git subtree $arg_command'."
>> +			test -n "$allow_split" || die_incompatible_opt "$opt" "$arg_command"
> 
> Instead of this:
> 
> 	die_if_other_opt "$allow_split" "$opt" "$arg_command"
> 
> Or actually just:
> 
> 	die_if_other_opt "$allow_split"
> 
> Maybe you disagree, but since the function will see the variables & this
> is purely a helper for this getopts parse loop I think it's fine just to
> assume we can read "$opt" and "$arg_command" there..., so, urm, maybe just:
> 
> 	test -n "$allow_split" || die_incompatible_opt
> 
> ? :) Anyway, an easy bike shed, you should go for whatever variant you
> prefer :) Thanks for indulging me.
> 

Thanks for your suggestion, but I think I'll stick to what I have for now :)

Philippe.
