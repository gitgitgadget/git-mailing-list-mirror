Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6C14920365
	for <e@80x24.org>; Thu, 13 Jul 2017 20:54:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753033AbdGMUyG (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Jul 2017 16:54:06 -0400
Received: from mail-pg0-f45.google.com ([74.125.83.45]:33812 "EHLO
        mail-pg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752847AbdGMUyF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Jul 2017 16:54:05 -0400
Received: by mail-pg0-f45.google.com with SMTP id t186so35255945pgb.1
        for <git@vger.kernel.org>; Thu, 13 Jul 2017 13:54:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=4PF+ucgDqpstzvC4rs6DWgG3FXwSudqHfeuELNbf98g=;
        b=GvzNiDc+J8y2mAJNEK/9yw1KFcUrdlPDwnGme6/7waGPqbUPB867JUrVKf8LtSiDAu
         QrLWkxFoGLzEDbkBs3DY46D1tdx6o3xjZuUT5gH/17HkNTbsiQtFHS1n/Oz20nYHzsT8
         9RI5U+6pnagTBr2xPdLyj7biiQbyryyGmkRfeJdOK1MU1xjJTpGoVnvRE0Axbb/3GAxb
         7KLNMCKshJPjjnxxr1maIovnNl77WPeGRwKbc4NY4CyrLk1bbwcUBFX3PXCV+UmA+hgW
         5qGb5xHAblG1gaeQbONVsFUZdCA917Fjia+Q6NC6FuAL10CvKPlagEalXGtVvn7cTUEh
         BWrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=4PF+ucgDqpstzvC4rs6DWgG3FXwSudqHfeuELNbf98g=;
        b=Y6fVkXKGVYI494NNLzYonViTJ1w2ojEQy9E7eji8CzWy8RN1ExfaPeHYE581CVUm+5
         wUJu3YKy2ViQYLNLQrp79JZ1PhG/0mGni+zSVnTBd9zYc24HwibjehFBLf4r/TEPCTVt
         dlX03mmkP1chwOyS2FvSVg5VFzyq6yckxmcPktuEMruOXIV5Nb+skPmG1tr48Qx56uFd
         M1rbwjrhr5sFlxcGX/f6/KJ97q543JtFuymEr77A9zbCKutPn3QlUx9uQCOU32hvvvnJ
         Nb6QWxVlMhAoAmwUgcdLn1AzMvaZURQljdMxLVBz1WjsRrDq90Kz/pwkgEGltEytR0q2
         UIXg==
X-Gm-Message-State: AIVw110CUp8bwyFXsHdDzFiG6R7jTG74/6+M6RhSShMxw/dh5nmvNh0P
        kFTv4ty9inmg9lwxffsrrhvktykpTrjF
X-Received: by 10.84.232.74 with SMTP id f10mr12028765pln.154.1499979244980;
 Thu, 13 Jul 2017 13:54:04 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.167.81 with HTTP; Thu, 13 Jul 2017 13:54:04 -0700 (PDT)
In-Reply-To: <20170713204854.GA158114@aiede.mtv.corp.google.com>
References: <20170712234504.15811-1-sbeller@google.com> <20170713000117.GJ93855@aiede.mtv.corp.google.com>
 <xmqq60exyx5k.fsf@gitster.mtv.corp.google.com> <CAGZ79kaHX-YCMv01T-QE=mYeymjTnwrpg9-bsOrCjg3NWEunDA@mail.gmail.com>
 <xmqqa848xjxr.fsf@gitster.mtv.corp.google.com> <CAGZ79kYtRbHvfC6d=+eEXCceJam4wwo9XqvY752c_pg6kq90DA@mail.gmail.com>
 <20170713204854.GA158114@aiede.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 13 Jul 2017 13:54:04 -0700
Message-ID: <CAGZ79kZouNBxOKr7X8j6wqebp3Wh3cDqhYR-t_PxaF7AwQ0Wzg@mail.gmail.com>
Subject: Re: [PATCH] submodule: use cheaper check for submodule pushes
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jul 13, 2017 at 1:48 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> Hi,
>
> Stefan Beller wrote:
>
>> Yes we are safe, because the function itself only spawns a child process
>> (not using any of the objects).
>>
>> It's only caller push_unpushed_submodules also doesn't rely on objects
>> loaded after calling push_submodule.
>>
>> The caller of push_unpushed_submodules (transport.c, transport_push)
>> also doesn't need submodule objects loaded.
>
> Thanks for looking into it.  This is what the commit message should
> say to help reviewers or people trying to understand it later.  The
> footnotes don't help and are distracting, except that it makes sense
> to point out the original GSoC patch to say the alternate submodule
> odb wasn't needed even then.
>
> E.g.:
>
>  Subject: push: do not add submodule odb as an alternate when recursing on demand
>
>  "git push --recurse-submodules=on-demand" adds each submodule as an
>  alternate with add_submodule_odb before checking whether the
>  submodule has anything to push and pushing it if so.
>
>  However, it never accesses any objects from the submodule.  In the
>  parent process it uses the submodule's ref database to see if there
>  is anything to push.  The actual push (which does rely on objects)
>  occurs in a child process.
>
>  The same was try when this call was originally added in
>  v1.7.11-rc0~111^2 (push: teach --recurse-submodules the on-demand
>  option, 2012-03-29).  Most likely it was added by analogy with
>  fetch --recurse-submodules=on-demand, which did use the submodule's
>  object database.
>
>  Use is_submodule_populated_gently instead, which is simpler and
>  cheaper.

Thanks for giving a good example of commit message that I could use
in a reroll.


> With such a commit message change, this seems like a reasonable change
> in principle (though I haven't looked carefully to verify it).
>
> My one doubt is the is_submodule_populated_gently.  Why are we using
> that instead of simpler is_submodule_populated?  The names and API
> comments don't explain.

One could posit this is laziness of thinking.
See 15cdc64776 (make is_submodule_populated gently, 2017-03-14),
and discover there is no non-gentle version of is_submodule_populated.
And for each new use, it may be cheaper to just use the gentle version
instead of adding a non-gentle version.

Thanks,
Stefan
