Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AAF3A1FF1E
	for <e@80x24.org>; Tue, 31 Jan 2017 00:12:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932103AbdAaAME (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Jan 2017 19:12:04 -0500
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.221]:36198 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753576AbdAaAMC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Jan 2017 19:12:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1485821421;
        l=4850; s=domk; d=benjaminfuchs.de;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:
        Date:From:Cc:References:To:Subject;
        bh=OKFVJgm+LfF37BODqhHvc18CSrKiSJzc9f3oTBR0miY=;
        b=nSH0iY0lNhVfb5q5xonoh3hEegineYHqCKZF7hpWSAOFEZjA63v5HsBzO/scdnQWOL
        Y0PV8Qi8sUJ3Am/AjjyrmkBmax5OS2/V9mf+/498uEXvS1phdeGgeO3R2Y2AcYVtDdM9
        Ik2juE6CnMEXVCRZ98FsS2BzMkCUuQOG2kxGc=
X-RZG-AUTH: :KWEFfEyIefqISxrQo86CUgBQlWGSsNRH+R9E5PK46928JQqK/BdMsTbbwXy65FRWcJCl
X-RZG-CLASS-ID: mo00
Received: from [192.168.140.70] (p5499AE19.dip0.t-ipconnect.de [84.153.174.25])
        by smtp.strato.de (RZmta 39.12 DYNA|AUTH)
        with ESMTPSA id f07c43t0V0AG4aM
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Tue, 31 Jan 2017 01:10:16 +0100 (CET)
Subject: Re: [PATCH 1/4] git-prompt.sh: add submodule indicator
To:     Junio C Hamano <gitster@pobox.com>
References: <1485809065-11978-1-git-send-email-email@benjaminfuchs.de>
 <1485809065-11978-2-git-send-email-email@benjaminfuchs.de>
 <xmqqr33krtww.fsf@gitster.mtv.corp.google.com>
Cc:     git@vger.kernel.org, szeder.dev@gmail.com, sbeller@google.com,
        sandals@crustytoothpaste.net, ville.skytta@iki.fi
From:   Benjamin Fuchs <email@benjaminfuchs.de>
Message-ID: <c872072a-4754-051d-81e7-1e2166560733@benjaminfuchs.de>
Date:   Tue, 31 Jan 2017 01:10:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.5.1
MIME-Version: 1.0
In-Reply-To: <xmqqr33krtww.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,
thanks for your reply. Some of your suggestions are covered by my rework 
in Patch [2/4].
In [2/4] I got rid of the loop by feedback of Gábor.
Sorry if my patch wasn't well formed.

On 31.01.2017 00:48, Junio C Hamano wrote:
> Benjamin Fuchs <email@benjaminfuchs.de> writes:
>
>> I expirienced that working with submodules can be confusing. This indicator
>> will make you notice very easy when you switch into a submodule.
> I am not quite sure what the above wants to say.  If you work on two
> projects, A and B, then having something that quickly reminds you
> which one you are in is beneficial and people often do so by having
> the current directory name in the prompt.
>
> The log message needs to explain why working on a submodule C of a
> project A is any more special, i.e. why are the existing ways the
> users are using to remind them between A and B cannot be used for C.
A submodule can be anywhere in your parent git repository. And while 
walking through the
parent repository it is sometime a good reminder to know when to just 
entered a submodule.
Because now all git command will work on the submodule. I guess this 
indicator is a good way
to show that.
And with patch [2/4] (and fixed it with [3/4]) I also introduced the 
"dirty" indicator for the submodule, which can
show you, that your current checked out state in the submodule is not 
the one committed
to the parent.

>
>> diff --git a/contrib/completion/git-prompt.sh b/contrib/completion/git-prompt.sh
>> index 97eacd7..4c82e7f 100644
>> --- a/contrib/completion/git-prompt.sh
>> +++ b/contrib/completion/git-prompt.sh
>> @@ -93,6 +93,10 @@
>>   # directory is set up to be ignored by git, then set
>>   # GIT_PS1_HIDE_IF_PWD_IGNORED to a nonempty value. Override this on the
>>   # repository level by setting bash.hideIfPwdIgnored to "false".
>> +#
>> +# If you would like __git_ps1 to indicate that you are in a submodule,
>> +# set GIT_PS1_SHOWSUBMODULE. In this case a "sub:" will be added before
>> +# the branch name.
>>   
>>   # check whether printf supports -v
>>   __git_printf_supports_v=
>> @@ -284,6 +288,32 @@ __git_eread ()
>>   	test -r "$f" && read "$@" <"$f"
>>   }
>>   
>> +# __git_is_submodule
>> +# Based on:
>> +# http://stackoverflow.com/questions/7359204/git-command-line-know-if-in-submodule
>> +__git_is_submodule ()
> It seems like this function is checking if you are "IN" submodule,
> not "IS" submodule.  A misnamed function?
Reworked in Patch [2/4]
>> +{
>> +	local git_dir parent_git module_name path
>> +	# Find the root of this git repo, then check if its parent dir is also a repo
>> +	git_dir="$(git rev-parse --show-toplevel)"
>> +	module_name="$(basename "$git_dir")"
> This does not give "module_name" in the sense the word is used in
> the submodule subsystem.  If this variable is useful, call that
> with "path" in its name (I do not think it alone is useful at all).
Reworked in Patch [2/4]
>
>> +	parent_git="$(cd "$git_dir/.." && git rev-parse --show-toplevel 2> /dev/null)"
>> +	if [[ -n $parent_git ]]; then
>> +		# List all the submodule paths for the parent repo
>> +		while read path
>> +		do
>> +			if [[ "$path" != "$module_name" ]]; then continue; fi
>> +			if [[ -d "$git_dir/../$path" ]];    then return 0; fi
>> +		done < <(cd $parent_git && git submodule --quiet foreach 'echo $path' 2> /dev/null)
> Instead of doing this "loop over submodules and just get true or
> false", it may make a lot more sense to find the module name and
> report that.  That would allow you to have the actual submodule
> name, not a generic "sub:" which does not help the users to tell
> which one of 47 submodules they have in their top-level project
> they are currently in.
>
> If your projects are layed out like so
>
> 	/home/bf/projects/A/
> 	/home/bf/projects/A/lib/B/ -- submodule
> 	/home/bf/projects/A/Doc/ -- another submodule
> 	/home/bf/projects/A/Doc/technical -- a subdirectory of Doc submodule
>
> and you are in /home/bf/projects/A/Doc/technical/ subdirectory, your
> $git_dir variable (which is grossly misnamed, too; call it "top"
> perhaps?) would be "/home/bf/projects/A/Doc" and then your
> $parent_git variable (again, that is misnamed; call it
> "parent_top"?) would be "/home/bf/projects/A".  The submodule path
> to the submodule you are currently in is "Doc" (you learn it as the
> difference between these two).
>
> You can ask the top-level project the name of the submodule that is
> currently at "Doc" with "submodule--helper name".  Unless the project
> has moved it since it first added the submodule, the module name may
> also be "Doc", but if it were moved, it may be different.
>
> And that "module name" is a more useful thing than a hardcoded
> string "sub:" to use in the prompt, I would think.
Reworked in Patch [2/4].

