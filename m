Return-Path: <SRS0=lBg5=3Z=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BE95C35247
	for <git@archiver.kernel.org>; Wed,  5 Feb 2020 19:56:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B86E2072B
	for <git@archiver.kernel.org>; Wed,  5 Feb 2020 19:56:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ty4hb0BE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727361AbgBET4Z (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Feb 2020 14:56:25 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:44621 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727079AbgBET4Z (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Feb 2020 14:56:25 -0500
Received: by mail-qk1-f193.google.com with SMTP id v195so3111403qkb.11
        for <git@vger.kernel.org>; Wed, 05 Feb 2020 11:56:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=OovOT6+FPF/74QjZRspDYfR6GO5fOoF25oifsAF+/8U=;
        b=ty4hb0BESLYaYRWptXsAnGd7354j2j4yD9SqKi8GTRYl0TondLoCzdHPJzwGGP5Lz3
         L3ViQ2iAiXe1SzO6IUsFf55hHv2MI+IdttCQGXtoJqiHQWaD/dGlf1GVzWmpvMbOX/6k
         4TTt+woI8yD/7agvzDBrMwdnkZLzRJw1VEVwLduXHYHfnV1JdKOiAQysi8TX6xXT4lRn
         4xyU06ssf1Qg27skJL+QMGOlCem1tJhuP4Hkg8WqD/ztt0HRRH8VaSqV7prY6lTo5GaD
         Md//0I8Zv2bAp0Uw2H60bGn1UfPeKdQLOfERmQ6izeIz9vJ1ZwS8+/UfC1dBWa+luT5f
         ipiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=OovOT6+FPF/74QjZRspDYfR6GO5fOoF25oifsAF+/8U=;
        b=Hms+xaL523Ws2keNlhIjQ08pmp77elL8dYAch3DtIWK0xxZZW9dm/SnkDMRapVRQIY
         Le3a1QcbGMlTTI5f5hTKg6OB8fhRoom8ZmdfRkKoSGyRyrB+EoJB3aLXg/y+HfH5lLZn
         lRikX/sbc2RV2eQEkz4zbZOk47V+G6nVmmXF4knRU+7rLdPnqY8B8Yc4FsQPEkQ8yW5b
         et/QqZByJVhGcMKueTlUm5UzuqYS5giu0wvcyWHV5tanvsd6mxFt2/UFtLBuQbDiZ0Ss
         b3eCmsYJ72E0RbUy+FDzI9y3ngA+ZkmEXhDIgD/t+lsT48xSm7boHWrYl4j7EEux2//a
         RPfw==
X-Gm-Message-State: APjAAAUavchVsv1f9qK94hCpC2ODom9xroMp5O1fN1jy3tEcCC8tq4v2
        eG7jUA58FavEa+BhEbw6HDrwZv8EWj4=
X-Google-Smtp-Source: APXvYqzwxkXcyn39ARyY10n/Pdy0zp2Xn1OPZrLuD+DpMZkOa7NeMzUjSXQZv1dLQ15Zh/gvJUsF8w==
X-Received: by 2002:a37:9e09:: with SMTP id h9mr34375476qke.289.1580932581072;
        Wed, 05 Feb 2020 11:56:21 -0800 (PST)
Received: from [10.10.31.126] ([24.229.121.34])
        by smtp.gmail.com with ESMTPSA id t15sm329600qkg.49.2020.02.05.11.56.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Feb 2020 11:56:20 -0800 (PST)
Subject: Re: [PATCH v2 2/4] git-p4: create new method gitRunHook
To:     Junio C Hamano <gitster@pobox.com>,
        Ben Keene via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org
References: <pull.698.git.git.1579555036314.gitgitgadget@gmail.com>
 <pull.698.v2.git.git.1580507895.gitgitgadget@gmail.com>
 <f1f9fdc542353196612f8dd6b996d4fbd1f76c73.1580507895.git.gitgitgadget@gmail.com>
 <xmqqr1za6q83.fsf@gitster-ct.c.googlers.com>
From:   Ben Keene <seraphire@gmail.com>
Message-ID: <ac44531e-b02d-5a98-3e25-a305b1250cf6@gmail.com>
Date:   Wed, 5 Feb 2020 14:56:19 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <xmqqr1za6q83.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On 2/4/2020 3:40 PM, Junio C Hamano wrote:
> "Ben Keene via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
>> diff --git a/git-p4.py b/git-p4.py
>> index 7d8a5ee788..4e481b3b55 100755
>> --- a/git-p4.py
>> +++ b/git-p4.py
>> @@ -4125,6 +4125,35 @@ def printUsage(commands):
>>       "unshelve" : P4Unshelve,
>>   }
>>   
>> +def gitRunHook(cmd, param=[]):
>> +    """Execute a hook if the hook exists."""
>> +    if verbose:
>> +        sys.stderr.write("Looking for hook: %s\n" % cmd)
>> +        sys.stderr.flush()
>> +
>> +    hooks_path = gitConfig("core.hooksPath")
>> +    if len(hooks_path) <= 0:
>> +        hooks_path = os.path.join(os.environ.get("GIT_DIR", ".git"), "hooks")
> This assumes that the process when his function is called (by the
> way, even though the title of the patch uses the word "method", this
> is not a method but a function, no?), it is always at the top level
> of the working tree.  Is that a good assumption?  I don't know the
> code well, so "yes it is good because a very early thing we do is to
> go up to the top" is a good answer.
I'm not sure what you mean by top level of the tree unless you mean
that it is not part of a class, but a "Free standing" function? And
yes, it returns a value so it should be called a function. I'll
correct that.  I chose to not put the function within a class so
that if other hooks should be added, it would not require a refactoring
of the code to use the function in other classes.
>> +    hook_file = os.path.join(hooks_path, cmd)
>> +    if isinstance(param,basestring):
>> +        param=[param]
>> +
>> +    if platform.system() == 'Windows':
>> +        exepath = os.environ.get("EXEPATH")
>> +        if exepath is None:
>> +            exepath = ""
>> +        shexe = os.path.join(exepath, "bin", "sh.exe")
>> +        if os.path.isfile(shexe) \
>> +            and os.path.isfile(hook_file) \
>> +            and os.access(hook_file, os.X_OK) \
>> +            and subprocess.call([shexe, hook_file] + param) != 0:
>> +            return False
>> +
>> +    else:
>> +        if os.path.isfile(hook_file) and os.access(hook_file, os.X_OK) and subprocess.call([hook_file] + param) != 0:
>> +            return False
> Doesn't this mean that on Windows, a hook MUST be written as a shell
> script, but on other platforms, a hook can be any executable?
Good point.
>
> I am not sure if it is necessary to penalize Windows users this way.
> How do other parts of the system run hooks on Windows?  E.g. can
> "pre-commit" hook be an executable Python script on Windows?

Unfortunately, the original code for running the p4-pre-submit hook
was under-developed and there was no way to run other executable
files in the context of a hook. Nothing ran for me, which is what
prompted this change.  But to your point, the restrictions are
unnecessary. I googled around a little and found these two SO articles:

https://stackoverflow.com/questions/18277429/executing-git-hooks-on-windows

https://stackoverflow.com/questions/22074247/git-hook-under-windows

But I haven't found information on how Git for Windows handles
hooks directly.

>
> Even if it is needed to have different implementations (and possibly
> reduced capabilities) for "we found this file is a hook, now run it
> with these parameters" on different platform, the above looks a bit
> inverted.  If the code in this function were
>
>      if os.path.isfile(hook_file) and
>         os.access(hook_file, os.X_OK) and
>         run_hook_command(hook_file, param) != 0:
> 	return False
>      else:
> 	return True
>
> and a thin helper function whose only task is "now run it with these
> parameters" is separately written, e.g.
>
>      def run_hook_command(hook_file, params):
> 	if Windows:
> 		... do things in Windows specific way ...
> 	else:
> 		return subprocess.call([hook_file] + param)
>
> That would have been 100% better, as it would have made it clear
> that logically gitRunHook() does exactly the same thing on all
> platforms (i.e. find where the hook is, normalize param, check if
> the hook file is actually enabled, and finally execute the hook with
> the param), while the details of how the "execute" part (and only
> that part) works may be different.
I'm committing a new version of this change that will define 
run_hook_command.
>> +    return True
>>   
>>   def main():
>>       if len(sys.argv[1:]) == 0:
