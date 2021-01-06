Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9051C433E0
	for <git@archiver.kernel.org>; Wed,  6 Jan 2021 15:59:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 832D523130
	for <git@archiver.kernel.org>; Wed,  6 Jan 2021 15:59:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726396AbhAFP7w (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Jan 2021 10:59:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:57303 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725800AbhAFP7w (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 6 Jan 2021 10:59:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1609948705;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kPgVTlcHNC97WTbhJlTe3n8LiL2Nx10d7aIZ8Tc7Yck=;
        b=EunFwYwn7Rihk6TbmkpOR9OevZQCB7euAS9i1LC+f8h0lF8YjQtKyQmYkcG+BXDOUTzBcz
        1ntPKWP9AhYZ9T7BtG8f7nTvKEVLJ0PeJdXsBPabPXdgYwm5dO7h1CqzAfpZvKTZasd64B
        hzF+9PsHyZZqlWsQ9ZZQrBA73qf0pHI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-272-l5ADVRhuM7eZzQKiqKsGSg-1; Wed, 06 Jan 2021 10:58:20 -0500
X-MC-Unique: l5ADVRhuM7eZzQKiqKsGSg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7584BC740A;
        Wed,  6 Jan 2021 15:58:19 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (ovpn-113-198.ams2.redhat.com [10.36.113.198])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 74BFB10016DB;
        Wed,  6 Jan 2021 15:58:18 +0000 (UTC)
Subject: Re: [RFC PATCH] gitk: Activate --find-copies-harder
To:     Robert Pollak <robert.pollak@posteo.net>,
        Paul Mackerras <paulus@ozlabs.org>
Cc:     git@vger.kernel.org
References: <b12574f0-3ebc-95c0-9def-555150257e46@posteo.net>
From:   Laszlo Ersek <lersek@redhat.com>
Message-ID: <46693c60-98ee-b6c9-df8e-12216622ddf9@redhat.com>
Date:   Wed, 6 Jan 2021 16:58:17 +0100
MIME-Version: 1.0
In-Reply-To: <b12574f0-3ebc-95c0-9def-555150257e46@posteo.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 01/04/21 20:54, Robert Pollak wrote:
> Naively forward the diff arguments to make --find-copies-harder work.
> 
> Signed-off-by: Robert Pollak <robert.pollak@posteo.net>
> ---
> Dear Paul Mackerras,
> 
> This patch is an obviously naive attempt to make gitk observe
> --find-copies-harder. I am a gitk user with many small projects, so I am
> currently using this patch to get better diffs.
> 
> With this, gitk displays the copy in the second commit of my test
> repository [1] as desired:
> 
> similarity index 100%
> copy from a
> copy to b
> 
> 
> I see the following problems with my patch:
> 
> 1) It is totally untested with all the other args that are collected in
> diffargs, like e.g. "-O<orderfile>", since I didn't need them yet.

It would be really great if gitk supported both "-O<orderfile>" and
--find-copies-harder!

I can't offer a review, but I very much support the use case.

Thanks,
Laszlo

> 
> 2) Even if --find-copies-harder is the only diff argument used, there
> might be unintended side effects, since the modified procedure 'diffcmd'
> is called in several places. I did not systematically test all these
> code paths.
> 
> 
> To deal with 1), I could rename the variable 'vdflags' to
> 'vdflags_ignored' and continue using 'vdflags' only for
> --find-copies-harder. Later, other flags could be moved over, after
> their harmlessness has been proven. Would this be good?
> 
> Ad 2), maybe someone with more code knowledge can tell whether this
> a real risk? Also, would it be preferable to add the new flag(s) only to
> the arguments of the diffcmd call in 'getblobdiffs'?
> (as in:
> diff --git a/gitk b/gitk
> index 23d9dd1..da6b372 100755
> --- a/gitk
> +++ b/gitk
> @@ -8017,7 +8017,7 @@ proc initblobdiffvars {} {
>  proc getblobdiffs {ids} {
>      global blobdifffd diffids env
>      global treediffs
> -    global diffcontext
> +    global vdflags diffcontext
>      global ignorespace
>      global worddiff
>      global limitdiffs vfilelimit curview
> @@ -8031,7 +8031,7 @@ proc getblobdiffs {ids} {
>      if {[package vcompare $git_version "1.6.6"] >= 0} {
>          set submodule "--submodule"
>      }
> -    set cmd [diffcmd $ids "-p $textconv $submodule  -C --cc --no-commit-id -U$diffcontext"]
> +    set cmd [diffcmd $ids "$vdflags($curview) -p $textconv $submodule  -C --cc --no-commit-id -U$diffcontext"]
>      if {$ignorespace} {
>          append cmd " -w"
>      }
> )
> For my test case, this also works.
> 
> 
> I'd be happy to prepare an updated patch incorporating your feedback.
> 
> Having this functionality in gitk will hopefully make some people stop
> crafting their git history for copy detection, like described e.g. in
> https://devblogs.microsoft.com/oldnewthing/20190919-00/?p=102904 .
> 
> I am CCing Laszlo Ersek, because he expressed interest in a similar
> topic a year ago:
> 'gitk feature requests: (1) "diff.orderFile" and (2) "--function-context"',
> https://public-inbox.org/git/d972c1f1-c49a-f644-ab1c-6a3e26c43ee3@redhat.com/
> .
> 
> -- Robert
> 
> [1] My minimal test case:
>> git init
>> echo "a file" > a
>> git add a
>> git commit -m "a file"
>> cp a b
>> git add b
>> git commit -m "a copy"
> 
> 
>  gitk | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/gitk b/gitk
> index 23d9dd1..eb6ba9a 100755
> --- a/gitk
> +++ b/gitk
> @@ -7869,7 +7869,7 @@ proc addtocflist {ids} {
>  }
>   proc diffcmd {ids flags} {
> -    global log_showroot nullid nullid2 git_version
> +    global log_showroot nullid nullid2 git_version vdflags curview
>       set i [lsearch -exact $ids $nullid]
>      set j [lsearch -exact $ids $nullid2]
> @@ -7909,7 +7909,7 @@ proc diffcmd {ids flags} {
>          if {$log_showroot} {
>              lappend flags --root
>          }
> -        set cmd [concat | git diff-tree -r $flags $ids]
> +        set cmd [concat | git diff-tree -r $vdflags($curview) $flags $ids]
>      }
>      return $cmd
>  }
> 

