Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2CAAF2022A
	for <e@80x24.org>; Wed, 26 Oct 2016 23:23:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S941800AbcJZXXr (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Oct 2016 19:23:47 -0400
Received: from mail-qk0-f169.google.com ([209.85.220.169]:36024 "EHLO
        mail-qk0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935954AbcJZXXq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Oct 2016 19:23:46 -0400
Received: by mail-qk0-f169.google.com with SMTP id o68so23623240qkf.3
        for <git@vger.kernel.org>; Wed, 26 Oct 2016 16:23:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=sy/PWjtWeIlv7UxVAUvl3Koj+k6VjsVcjft0cfHKsCo=;
        b=S64PuMgBLUISbLD0PJ6qQ1O6LIHlt7VZEdQ4QH/l3IQA1Ya9t2M0K4nW/dZvKRCfXc
         YPEAeW5QFPeHIM2bhQd+/Ul/4a4Dzb5W0AUgTpwyXSX2plQF9Dl3VWGE/ID5X8jZ6dFf
         7k6sdEjvc2ZoSwtOhJNT2dkvY62QFBGxKp28eOPN1J6TtX/1l06roDNEarGa3lzmJGIF
         4en1y9UeVRJ6amBFeCyH5Q2W6gP7aoflLF0vUul77XIkaKd1Iba2cXzOgdvTVYTnRkfa
         z+FvCdnWgbCA/N/fnBeyQhokonGjcQYTbiM2oR6qrT6RUoOBBY3o63sLVILTKljBlGpB
         2J3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=sy/PWjtWeIlv7UxVAUvl3Koj+k6VjsVcjft0cfHKsCo=;
        b=U5cl0vEZdYmKEP7DhiKMh5BOmKdKqW1lDZQ7Y80HSBe6i34kT2eFalTFGcZXTgFtZ+
         Gai5vCBuJGyzXxrgnj7aO+OCfi+CoBQdvaYG8KzAh7LUOijbujXJjTyWgn5OwU55qdej
         JQSQZmiih+H4F5wD8fbs18PcAonrlq0nbWbW20dBW3Ty6MIl1ClQakSO7vQTOmrQAJSh
         zSVQ3Ti2dsbm7H8aXEKmjbHBrWP0weEKSVr894GTU1UB/KCtFYbSv1JIAHfZ9PeE0OLi
         hAy8jNHT37k2QgEZosvbi2hV8tQ40jjtc4KZ4lJIw+nO6h12TB//IvQfgaipckz16QFR
         plfQ==
X-Gm-Message-State: ABUngvdZqFtkN3uZSOVuFERdAgcQ2aXKX81OSJyjfWmV8DdtHPIzYEumk2uWGKiTYrn3L4yrqR2RrTxr1+3sd7+q
X-Received: by 10.55.184.2 with SMTP id i2mr4277339qkf.47.1477524224948; Wed,
 26 Oct 2016 16:23:44 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.135.40 with HTTP; Wed, 26 Oct 2016 16:23:44 -0700 (PDT)
In-Reply-To: <1477523244.2764.114.camel@mattmccutchen.net>
References: <1477523244.2764.114.camel@mattmccutchen.net>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 26 Oct 2016 16:23:44 -0700
Message-ID: <CAGZ79kaw0s_PC2AstRVwFT8N1CJVC_7yQfC19zPzRjAqkSpMDg@mail.gmail.com>
Subject: Re: "git subtree --squash" interacts poorly with revert, merge, and rebase
To:     Matt McCutchen <matt@mattmccutchen.net>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 26, 2016 at 4:07 PM, Matt McCutchen <matt@mattmccutchen.net> wrote:
> I'm the lead developer of a research software application (https://bitb
> ucket.org/objsheets/objsheets) that uses modified versions of two
> third-party libraries, which we need to version and distribute along
> with our application.  For better or for worse, we haven't made it a
> priority to upstream our changes, so for now we just want to optimize
> for ease of (1) making and reviewing changes and (2) upgrading to newer
> upstream versions.
>
> We've been using git submodules, but that's a pain for several reasons:
> - We have to run "git submodule update" manually.

That is true for now. :( But there are plans to revive a patch series
to include updating the submodule into git-checkout.

https://github.com/stefanbeller/git/commits/submodule-co

> - We have to make separate commits and manage corresponding topic
> branches for the superproject and subprojects.

Well yeah, that is how submodule work on a conceptual level.
While having multiple commits may seem like overhead, note
the subtle difference for these commits. One if deep down in the
stack patching one of the submodules, the other is a high level
commit advancing the submodule pointer.

Note that the target audience of these two commit messages
might be vastly different, hence can be worded differently.
(The submodule describing how you fixed e.g. a memleak or race condition
and the superproject describes on why you needed to include that submodule,
e.g. because you switched your toplevel application to use threads.)

> - A diff of the superproject doesn't include the content of
> subprojects.

A recent patch series by Jacob Keller (jk/diff-submodule-diff-inline)
taught git diff to show the diff in the submodule as well, see
commits that are merged in 305d7f133956a5f43c94d938beabbfbb0ac1753c
or:
https://kernel.googlesource.com/pub/scm/git/git/+/fd47ae6a5b9cc0cfc56c1f7c43db612d26ca4b75%5E%21/#F1

Although this is just Git, you probably also have a code review system that
would need that change as well. Also it is not part of any release yet, but
soon will be.

Is there anything else besides these 3 points that encourages you to
switch away from submodules?

Thanks,
Stefan
