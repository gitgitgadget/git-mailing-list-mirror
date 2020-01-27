Return-Path: <SRS0=ksp+=3Q=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF275C32771
	for <git@archiver.kernel.org>; Mon, 27 Jan 2020 07:00:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 895CB20842
	for <git@archiver.kernel.org>; Mon, 27 Jan 2020 07:00:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="kr7KVP8u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726380AbgA0HA1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Jan 2020 02:00:27 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:39743 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725763AbgA0HA1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Jan 2020 02:00:27 -0500
Received: by mail-wr1-f67.google.com with SMTP id y11so9717168wrt.6
        for <git@vger.kernel.org>; Sun, 26 Jan 2020 23:00:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Phuzi4J9Fj2eB8pHaKo7Y/OYJ/1KDxDCfUOA0tttakU=;
        b=kr7KVP8uGrM4KYhRMLRT77LLeWXSWPE4amSCVlxJK/RNqWmHrPMB3eaflGI2M3HdEH
         z3QG3iEqcL5/NmzUL8JW6heZQEWn4JvRl7QZgNHvq9n0E+5eN04J8F105zrREL44zWOJ
         9Y0Wq42Amb+TmSjMSkvKgoIyohAeNhcAarpPwJbbsgOkV/hI6Z5Nf9ehsqudPs/JgQ/Q
         WHGe/e4DACRaPUe5nltx1oDA9hQ7dKjztRw0V5zVkbernk4HdOaKSBLQUm+KweeVCUM8
         Bp6G5WILlAZvhUTGEbounRMIXtA0UZz4kWd5LHIibYX6ej58aFeVjgDjSuEGdDf5qGaP
         McbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Phuzi4J9Fj2eB8pHaKo7Y/OYJ/1KDxDCfUOA0tttakU=;
        b=Yy62K2vWlK8VS7ftlIklTH1I3Rr9ihaHw956uX5wQ5w3XJ6yPWMFwvt257JRbjLNz8
         g9ci5tvhgMJQaWdK+OsxEHltioUtNeiGS+ioj7BSx9mzBd434qXDBOWDQP4Ah/AcItRa
         l1/+4+nc268fd+Dsziyp/y9iHPuX3CEBPNWiSd0Ti0WwL8uSMGzLbhYedprih++rSea2
         2mPyyJL0mcLggr4BVUAoZXJx72HgecH1arCCYBhtwwd3sdUfWcSBUVaClE0b7JDo7rwL
         X65ltwHhB2Js+EsKQUyg41AhW1VQ3fWAS6Jb/bBW9SgUuhP4uE/icu6sKLBkjcbG2ERC
         lOwQ==
X-Gm-Message-State: APjAAAU5fy9AluhdT3zOmYRkL1mdLGh98G5t4HM0DyKG308miRpFAhkT
        V/UbFyYGg3ERj3rTIyY=
X-Google-Smtp-Source: APXvYqzozZves+FZQl2dP+lZXRp4OpVtAaRD83qeZnjgORdXzkmidnGL7i2bXe93rYaMH3U2cYI8Nw==
X-Received: by 2002:adf:e591:: with SMTP id l17mr20043634wrm.139.1580108424090;
        Sun, 26 Jan 2020 23:00:24 -0800 (PST)
Received: from ?IPv6:2a02:810a:8c80:d2c:1d4:baf0:179f:5856? ([2a02:810a:8c80:d2c:1d4:baf0:179f:5856])
        by smtp.gmail.com with ESMTPSA id x10sm19090049wrv.60.2020.01.26.23.00.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 26 Jan 2020 23:00:23 -0800 (PST)
Subject: Re: [PATCH] doc: clarify "explicitly given" in push.default
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
References: <ed9a0485-1e6c-79ae-6a59-655105203728@googlemail.com>
 <20200125003836.GA568952@coredump.intra.peff.net>
 <b4c31e50-6da5-7699-1069-d94091f768bd@googlemail.com>
 <20200125200554.GC5519@coredump.intra.peff.net>
From:   Bert Wesarg <bert.wesarg@googlemail.com>
Message-ID: <d8007df9-002b-6db1-4769-d6bf8c338cdf@googlemail.com>
Date:   Mon, 27 Jan 2020 08:00:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200125200554.GC5519@coredump.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 25.01.20 21:05, Jeff King wrote:
> On Sat, Jan 25, 2020 at 08:38:04AM +0100, Bert Wesarg wrote:
> 
>> thanks for this pointer. My initial pointer was the help for push.default:
>>
>>   From git-config(1):
>>
>>         push.default
>>             Defines the action git push should take if no refspec is explicitly
>>             given. Different values are well-suited for specific workflows; for
>>
>> Thus I expected, that this takes effect, when just calling 'git push'.
> 
> Yeah, I agree "explicitly given" is vague there. Perhaps the patch below
> is worth doing?
> 
>> What I actually want to achieve, is to track a remote branch with a
>> different name locally, but 'git push' should nevertheless push to
>> tracked remote branch.
>>
>> In my example above, befor adding the 'push.origin.push' refspec, rename the branch:
>>
>>      $ git branch -m local
>>      $ git push --dry-run
>>        To ../bare.git
>>         * [new branch]      local -> local
>>
>> Is it possible that this pushes to the tracked branch automatically,
>> and because I have multiple such branches, without the use of a push
>> refspec.
> 
> I think if push.default is set to "upstream" then it would do what you
> want as long as you set the upstream of "local" (e.g., by doing "git
> branch --set-upstream-to=origin/master local).

Thanks. This pushes only the current branch and honors the 'rename'.

> 
> There's another way of doing this, which is when you have a "triangular"
> flow: you might pull changes from origin/master into your local branch
> X, but then push them elsewhere. Usually this would be pushing to a
> branch named X on a different remote than origin (e.g., your public fork
> of upstream on a server). And for that you can set branch.X.pushRemote.
> 
> There's no corresponding triangular config branch.X.pushBranch to push
> to a different name than "X" on the remote. And while I do think it
> would be rare to want it, I could imagine a case (you have a triangular
> flow where everybody shares a central repo, but you want to push to some
> local namespace within it; usually people do that now by just making the
> namespace part of their local branch names, too).
> 
> Anyway, here's the documentation patch.
> 
> -- >8 --
> Subject: [PATCH] doc: clarify "explicitly given" in push.default
> 
> The documentation for push.default mentions that it is used if no
> refspec is "explicitly given". Let's clarify that giving a refspec on
> the command-line _or_ in the config will override it.
> 
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>   Documentation/config/push.txt | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/config/push.txt b/Documentation/config/push.txt
> index 0a0e000569..554ab44b4c 100644
> --- a/Documentation/config/push.txt
> +++ b/Documentation/config/push.txt
> @@ -1,6 +1,7 @@
>   push.default::
>   	Defines the action `git push` should take if no refspec is
> -	explicitly given.  Different values are well-suited for
> +	explicitly given (either on the command-line or via a
> +	`remote.*.push` config option). Different values are well-suited for
>   	specific workflows; for instance, in a purely central workflow
>   	`upstream` is probably what you want.  Possible values are:
> 

I would rather talk about 'implicitly given', if it is via a `remote.*.push` config option:

  	Defines the action `git push` should take if no refspec is
-	explicitly given.  Different values are well-suited for
-	specific workflows; for instance, in a purely central workflow
-	(i.e. the fetch source is equal to the push destination),
-	`upstream` is probably what you want.  Possible values are:
+	neither explicitly (on the command-line) nor implicitly (via a
+	`remote.*.push` config option) given. Different values are
+	well-suited for specific workflows; for instance, in a purely
+	central workflow (i.e. the fetch source is equal to the push
+	destination), `upstream` is probably what you want.  Possible
+	values are:


Bert
