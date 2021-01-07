Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FEECC433DB
	for <git@archiver.kernel.org>; Thu,  7 Jan 2021 16:23:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 400F7224D3
	for <git@archiver.kernel.org>; Thu,  7 Jan 2021 16:23:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728532AbhAGQWj (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Jan 2021 11:22:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726427AbhAGQWj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Jan 2021 11:22:39 -0500
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 178B9C0612F4
        for <git@vger.kernel.org>; Thu,  7 Jan 2021 08:21:59 -0800 (PST)
Received: by mail-qt1-x834.google.com with SMTP id 7so4617140qtp.1
        for <git@vger.kernel.org>; Thu, 07 Jan 2021 08:21:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=cNBiw1zgSrg/qV7GNXZEZa15AtD7I1aaUCqae2WJgjE=;
        b=RHxTDYb2kuQo2HGML1pGM7M2q/5CHqD870daRsxxepjrKFaqclRdzAfwSaiix0fQ/x
         L9zGHm7hH7batMElbVAe8fid/HUAi+MqdZ2GOiI9jqFMW4lQOPQAq9IlbSm1v8+ymJx6
         1EPloE5GwAp8/j2Cl9fuXygEMu+IqaLvGnN5v9fCz+WCZFZYCaQIClWN54RpBSn9XvAt
         ZCfNvaJeyPQ7W9fsbsznXyss4DZ+hGkCXVX9j12hXuiEH32qrKbxq+zfxkSeIvltiEgW
         6R8gD6bEPQCO78QLh7EYs9xiupMj2sVbCt6GFl13+f/boQUjHq4myQQ5oKrHkSfuEW40
         vb9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=cNBiw1zgSrg/qV7GNXZEZa15AtD7I1aaUCqae2WJgjE=;
        b=T2JGSOxecKjEl0/L8otRO5wdUihn0ipy7TcWqPdw1oLDsc19Cp2cxdo+aoU4pmtYMM
         23S0sIjakGjhrUdAbXd1tFf74uX7le0cAneVQuBv86AEhPT6RD/myGHjTBhm2bTrPkuN
         qd0I5cRy/CtYESeY2W83V7NEC7LXZ7bsLx23gfzWkdOyMpGMcQawaN3thV7cmpdAo0eD
         l7dslIJPmqEl+fsDJz0UJcUSHO0r85ZFyNnU0Q7NTTMHh+c+e+Nww4o+hU/WJpshBGoC
         yOmkQLrAhoy2Wb/sb2iqUMc7iIF28PDBDMbeIg8xHvYnzbjyLN5/nfew4CdhMC3VMNmF
         XSJw==
X-Gm-Message-State: AOAM533DX+VyaahAqFEVtwe/aa0AUJO3z9366cE90lJ8aQ2k4/FIz80Y
        0QzHz8RUveyYYa1OXcJhU1U=
X-Google-Smtp-Source: ABdhPJwwO6cJrUwv8GgeJsqnH3y51mLdTxVx9RoB9RU39YsadNS3QPLMzOOEg5XMfDixdawSTeLNFA==
X-Received: by 2002:ac8:4801:: with SMTP id g1mr9015922qtq.44.1610036518222;
        Thu, 07 Jan 2021 08:21:58 -0800 (PST)
Received: from [192.168.1.127] ([192.222.216.4])
        by smtp.gmail.com with ESMTPSA id e10sm2856334qtr.92.2021.01.07.08.21.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Jan 2021 08:21:57 -0800 (PST)
Subject: Re: git-bugreport-2021-01-06-1209.txt (git can't deal with special
 characters)
To:     =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Cc:     "Randall S. Becker" <rsbecker@nexbridge.com>,
        'Daniel Troger' <random_n0body@icloud.com>,
        git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
References: <20210106214737.qwlp4jvg3x2voafs@tb-raspi4>
 <A342FAE0-A363-4280-848C-162F38C22C8E@icloud.com>
 <002601d6e480$c193bd00$44bb3700$@nexbridge.com>
 <ffe0a3ae-780d-95ae-524d-7b029eda21ee@gmail.com>
 <20210107154926.6tb7ukgemn7kmpnl@tb-raspi4>
From:   Philippe Blain <levraiphilippeblain@gmail.com>
Message-ID: <613fb31c-c23d-0568-f311-74eb14bba2ca@gmail.com>
Date:   Thu, 7 Jan 2021 11:21:56 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:78.0)
 Gecko/20100101 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210107154926.6tb7ukgemn7kmpnl@tb-raspi4>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Torsten,

Le 2021-01-07 à 10:49, Torsten Bögershausen a écrit :
> On Thu, Jan 07, 2021 at 09:34:35AM -0500, Philippe Blain wrote:
>> Hi everyone,
>>
>> Le 2021-01-06 à 18:07, Randall S. Becker a écrit :
>>> On January 6, 2021 5:22 PM, Daniel Troger wrote:
>>>> Hi, maybe this helps you reproduce. I think I should have committed before
>>>> doing the second changes but I still got the error message and the two
>>>> names for one folder:
>>>>
>>>> me@iMac:/tmp$ mkdir git_bug
>>>> me@iMac:/tmp$ cd git_bug
>>>> me@iMac:/tmp/git_bug$ git init
>>>> hint: Using 'master' as the name for the initial branch. This default branch
>>>> name
>>>> hint: is subject to change. To configure the initial branch name to use in all
>>>> hint: of your new repositories, which will suppress this warning, call:
>>>> hint:
>>>> hint: 	git config --global init.defaultBranch <name>
>>>> hint:
>>>> hint: Names commonly chosen instead of 'master' are 'main', 'trunk' and
>>>> hint: 'development'. The just-created branch can be renamed via this
>>>> command:
>>>> hint:
>>>> hint: 	git branch -m <name>
>>>> Initialized empty Git repository in /private/tmp/git_bug/.git/
>>>> me@iMac:/tmp/git_bug$ ls -la total 8
>>>> drwxr-xr-x   4 daniel  wheel   128 Jan  6 23:13 .
>>>> drwxrwxrwt  27 root    wheel   864 Jan  6 23:13 ..
>>>> drwxr-xr-x   9 daniel  wheel   288 Jan  6 23:12 .git
>>>> -rw-r--r--@  1 daniel  staff  1283 Jan  6 23:13 paulbrunngård-springyard.zip
>>>> me@iMac:/tmp/git_bug$ unzip paulbrunngård-springyard.zip
>>>> Archive:  paulbrunngård-springyard.zip
>>>>      creating: paulbrunnga??rd-springyard/
>>>>     inflating: paulbrunnga??rd-springyard/.DS_Store
>>>>      creating: __MACOSX/
>>>>      creating: __MACOSX/paulbrunnga??rd-springyard/
>>>>     inflating: __MACOSX/paulbrunnga??rd-springyard/._.DS_Store
>>>>    extracting: paulbrunnga??rd-springyard/empty me@iMac:/tmp/git_bug$ rm
>>>> -rf __MACOSX/ *.zip me@iMac:/tmp/git_bug$ ls -la total 0
>>>> drwxr-xr-x   4 daniel  wheel  128 Jan  6 23:15 .
>>>> drwxrwxrwt  27 root    wheel  864 Jan  6 23:13 ..
>>>> drwxr-xr-x   9 daniel  wheel  288 Jan  6 23:15 .git
>>>> drwxr-xr-x@  4 daniel  wheel  128 Jan  6 12:20 paulbrunngård-springyard
>>>> me@iMac:/tmp/git_bug$ cd paulbrunngård-springyard/
>>>> me@iMac:/tmp/git_bug/paulbrunngård-springyard$ nano empty
>>>> me@iMac:/tmp/git_bug/paulbrunngård-springyard$ cat empty Initial
>>>> content me@iMac:/tmp/git_bug/paulbrunngård-springyard$ git add empty
>>>> me@iMac:/tmp/git_bug/paulbrunngård-springyard$ nano empty
>>>> me@iMac:/tmp/git_bug/paulbrunngård-springyard$ cat empty Initial
>>>> content
>>>>
>>>>
>>>> Line I want to keep
>>>>
>>>> Line I want gone
>>>> me@iMac:/tmp/git_bug/paulbrunngård-springyard$ git restore -p .
>>>> BUG: pathspec.c:495: error initializing pathspec_item Cannot close git diff-
>>>> index --cached --numstat --summary
>>>> 4b825dc642cb6eb9a060e54bf8d69288fbee4904 --
>>>> :(,prefix:27)paulbrunngård-springyard/ () at
>>>> /usr/local/Cellar/git/2.30.0/libexec/git-core/git-add--interactive line 183.
>>>> me@iMac:/tmp/git_bug/paulbrunngård-springyard$ cd ..
>>>> me@iMac:/tmp/git_bug$ git status
>>>> On branch master
>>>>
>>>> No commits yet
>>>>
>>>> Changes to be committed:
>>>>     (use "git rm --cached <file>..." to unstage)
>>>> 	new file:   "paulbrunnga\314\212rd-springyard/empty"
>>>>
>>>> Changes not staged for commit:
>>>>     (use "git add <file>..." to update what will be committed)
>>>>     (use "git restore <file>..." to discard changes in working directory)
>>>> 	modified:   "paulbrunnga\314\212rd-springyard/empty"
>>>>
>>>> Untracked files:
>>>>     (use "git add <file>..." to include in what will be committed)
>>>> 	.DS_Store
>>>> 	"paulbrunng\303\245rd-springyard/"
>>>>
>>>> me@iMac:/tmp/git_bug$
>>>
>>> Is it possible that the å character is coming from a UTF-16 encoding and is not representable in UTF-8? I'm wondering whether the name has a double-byte representation where one of the bytes is null, resulting in a truncated file name coming from readdir(). The file name would not be representable on some platforms that do not support UTF-16 path names.
>>
>> I don't think that's the case (the angstrom is present in UTF-8 [1]).
>> I think it's another UTF-8 precomposed/decomposed bug. As far as I
>> was able to test it happens as soon as you have a precomposed character
>> in the folder name. I observed the same behaviour with a folder named
>> "folderü", for example. I also tried 'git -c add.interactive.usebuiltin restore -p .'
>> to see if the new experimental builtin§ add-interactive has the same problem,
>> and it does (though the error is less verbose).
>>
>> Anyway as you show with 'git status', it's not just 'git add -p' that is
>> faulty, it's deeper than that, I would say.
>>
>> Cheers,
>>
>> Philippe.
>>
>> [1] https://en.wikipedia.org/wiki/%C3%85#On_computers
> 
> Folks, I can not reproduce anything here.
> - The zip file mentioned earlier does not include a decomposed "å"
>    Neither when running unzip under Linux nor under Mac
> - Trying to write a test script does not show anything special
> 
> My attempt looks like this:

With a few modifications, you should see things start to get strange:

> cat test.sh
> #!/bin/sh
> DIR=git-test-restore-p
> GIT=/usr/local/bin/git
> 
> Adiarnfc=$(printf '\303\204')
> Adiarnfd=$(printf 'A\314\210')
> DIRNAME=xx${Adiarnfd}yy
> FILENAME=$DIRNAME/file

change to:
FILENAME=file

> 
> rm -rf $DIR &&
>      mkdir $DIR &&
>      cd $DIR &&
>      $GIT init &&
>      mkdir $DIRNAME &&

add:
cd $DIRNAME &&

>      echo "Initial" >$FILENAME &&

add:
$GIT status &&

>      $GIT add $FILENAME &&

add:
$GIT status &&

>      echo  >>$FILENAME &&
>      echo  >>$FILENAME &&
>      echo "One more line"  >>$FILENAME &&
>      echo  >>$FILENAME &&
>      echo  >>$FILENAME &&
>      echo "Last line"  >$FILENAME &&

add:
$GIT status &&

>      $GIT restore -p . &&
>      $GIT restore -p . &&
>      echo git=$GIT &&
>      $GIT --version &&
>      echo "OK"
> 
> ==================================
> It points out Git from brew, I think.

I don't think it's a packaging bug;
I tried with /usr/bin/git on macOS 10.11 (git version 2.10.1 (Apple Git-78))
and I also get a (different) error but the command does not fail
(I needed to change restore to reset):

$ ./test.sh
Initialized empty Git repository in /private/var/folders/lr/r6n2057j0dzd4gdb614fp0740000gp/T/repro/git-test-restore-p/.git/
Assertion failed: (item->nowildcard_len <= item->len && item->prefix <= item->len), function prefix_pathspec, file pathspec.c, line 317.
No changes.
Assertion failed: (item->nowildcard_len <= item->len && item->prefix <= item->len), function prefix_pathspec, file pathspec.c, line 317.
No changes.
git=/usr/bin/git
git version 2.10.1 (Apple Git-78)
OK

