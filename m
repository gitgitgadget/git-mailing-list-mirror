Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B75CEB64DD
	for <git@archiver.kernel.org>; Wed,  9 Aug 2023 13:15:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232734AbjHINPc (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Aug 2023 09:15:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229803AbjHINPb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Aug 2023 09:15:31 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FC1EE5F
        for <git@vger.kernel.org>; Wed,  9 Aug 2023 06:15:30 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-3fe1a17f983so57464985e9.3
        for <git@vger.kernel.org>; Wed, 09 Aug 2023 06:15:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691586928; x=1692191728;
        h=content-transfer-encoding:in-reply-to:from:cc:references:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Q1efreTC8jEWcB1EGgeVfKK2SOxfq3GMzTIirwcQOAk=;
        b=QPuJD+fd7WBL0SMa+aa5yq3XcVpXRJ1101bTYP230KEQkqg2PCfwwFw4BwbJ1DxceB
         WL9IMPuPJPBy0+eSryPhlP1DzhokwY+nqgQ1mi1KLieKgKa/Rz0vJUM/jtjh/Gvbdjev
         EdBwN13WyomciBtwtg8m2YZpx9OPH0oY/mo9Ap1RdJLz8lJVcujH4Z/B1Uc3aSDj/Cnt
         NJjvcskIdkvbbcAt2EwtffRKyCMh4g+Rol1S0k2M6Tnw+sERSgpf8yJSgVtKfb7X1cBS
         vzcGNhLKU060CfZUFh0nErtjqQO8R2usP6p4vManJimTkGd/f4YRUCqWE6U6ue8TyN2Z
         HVLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691586928; x=1692191728;
        h=content-transfer-encoding:in-reply-to:from:cc:references:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q1efreTC8jEWcB1EGgeVfKK2SOxfq3GMzTIirwcQOAk=;
        b=Brv+QAXDDwYI+OIU5KkEDSnC+IxPR0ZkPUYix6koF6KidBEGe3Y2gfxUEjWYIoWxHi
         bICr9qLLB2efCRK2MyGJzFft9p0L7CedU8hx8AlyLd4nU8HIJ3YBEmcRd/SRxZRjWL8x
         ZBbPmlrnFuUtAlHoKg6yh5pb+IAf0Oz1cPzrPWzLtRWjD8H2UmRr5EY0fQ4jBW+AAP5F
         W1Us6SiQM98S9FKTFunP0+uWlsDKcyZ+D9QBtTa6e+F7+zAEmxjlX2dIKLloF3Cuz2Uw
         H26amtwleI4VIQ+fysIQ80UImHDZBwZaMUbL5Ma4Uh46Tbdsim96BNQu+/sv/bhTeTZb
         viEQ==
X-Gm-Message-State: AOJu0Yx1rQJHShhyAUBAemlBCemZI4EIvN4a4kqaojo6uqh5M0YKCbBP
        EJwFu2Ff06RuPs9nTXGXXiE=
X-Google-Smtp-Source: AGHT+IHTl5nwFv6JvbeNldC16i/POIdwJMqMf0QAbVlR2pvfeMm8Sxc38XMofUsrA8v/rHWP+KRnkw==
X-Received: by 2002:a5d:5652:0:b0:313:e456:e64a with SMTP id j18-20020a5d5652000000b00313e456e64amr1745990wrw.21.1691586928522;
        Wed, 09 Aug 2023 06:15:28 -0700 (PDT)
Received: from [192.168.1.101] ([90.242.223.1])
        by smtp.googlemail.com with ESMTPSA id s18-20020adfeb12000000b0031779a6b451sm16763213wrn.83.2023.08.09.06.15.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Aug 2023 06:15:28 -0700 (PDT)
Message-ID: <6e40eb0b-2331-1e39-bee0-c9720c24d1c8@gmail.com>
Date:   Wed, 9 Aug 2023 14:15:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v1 1/1] git stash needing mkdir deletes untracked file
Content-Language: en-US
To:     tboegi@web.de, git@vger.kernel.org, friebetill@gmail.com
References: <5260C6A0-C53C-4F6D-B899-6AD8601F8458@gmail.com>
 <20230808172624.14205-1-tboegi@web.de>
Cc:     Junio C Hamano <gitster@pobox.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <20230808172624.14205-1-tboegi@web.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Torsten

Thanks for working on this. I've cc'd Junio for his unpack_trees() 
knowledge.

On 08/08/2023 18:26, tboegi@web.de wrote:
> From: Torsten Bögershausen <tboegi@web.de>
> 
> The following sequence leads to loss of work:
>   git init
>   mkdir README
>   touch README/README
>   git add .
>   git commit -m "Init project"
>   echo "Test" > README/README
>   mv README/README README2
>   rmdir README
>   mv README2 README
>   git stash
>   git stash pop
> 
> The problem is, that `git stash` needs to create the directory README/
> and to be able to do this, the file README needs to be removed.
> And this is, where the work was lost.
> There are different possibilities preventing this loss of work:
> a)
>    `git stash` does refuse the removel of the untracked file,
>     when a directory with the same name needs to be created
>    There is a small problem here:
>    In the ideal world, the stash would do nothing at all,
>    and not do anything but complain.
>    The current code makes this hard to achieve
>    An other solution could be to do as much stash work as possible,
>    but stop when the file/directory conflict is detected.
>    This would create some inconsistent state.
> 
> b) Create the directory as needed, but rename the file before doing that.
>    This would let the `git stash` proceed as usual and create a "new" file,
>    which may be surprising for some worlflows.
> 
> This change goes for b), as it seems the most intuitive solution for
> Git users.
> 
> Introdue a new function rename_to_untracked_or_warn() and use it
> in create_directories() in entry.c

Although this change is framed in terms of changes to "git stash push" I 
think the underlying issue and this patch actually affects all users of 
unpack_trees(). For example if "README" is untracked then

	git checkout <rev> README

will currently fail if <rev>:README is a blob but will succeed and 
remove the untracked file if <rev>:README is a tree.

I'm far from an expert in this area but I think we might want to 
understand why unpack_trees() sets state->force when it calls 
checkout_entry() before making any changes.

Best Wishes

Phillip

> Reported-by: Till Friebe <friebetill@gmail.com>
> Signed-off-by: Torsten Bögershausen <tboegi@web.de>
> ---
>   entry.c          | 25 ++++++++++++++++++++++++-
>   t/t3903-stash.sh | 23 +++++++++++++++++++++++
>   2 files changed, 47 insertions(+), 1 deletion(-)
> 
> diff --git a/entry.c b/entry.c
> index 43767f9043..76d8a0762d 100644
> --- a/entry.c
> +++ b/entry.c
> @@ -15,6 +15,28 @@
>   #include "entry.h"
>   #include "parallel-checkout.h"
> 
> +static int rename_to_untracked_or_warn(const char *file)
> +{
> +	const size_t file_name_len = strlen(file);
> +	const static char *dot_untracked = ".untracked";
> +	const size_t dot_un_len = strlen(dot_untracked);
> +	struct strbuf sb;
> +	int ret;
> +
> +	strbuf_init(&sb, file_name_len + dot_un_len);
> +	strbuf_add(&sb, file, file_name_len);
> +	strbuf_add(&sb, dot_untracked, dot_un_len);
> +	ret = rename(file, sb.buf);
> +
> +	if (ret) {
> +		int saved_errno = errno;
> +		warning_errno(_("unable rename '%s' into '%s'"), file, sb.buf);
> +		errno = saved_errno;
> +	}
> +	strbuf_release(&sb);
> +	return ret;
> +}
> +
>   static void create_directories(const char *path, int path_len,
>   			       const struct checkout *state)
>   {
> @@ -48,7 +70,8 @@ static void create_directories(const char *path, int path_len,
>   		 */
>   		if (mkdir(buf, 0777)) {
>   			if (errno == EEXIST && state->force &&
> -			    !unlink_or_warn(buf) && !mkdir(buf, 0777))
> +			    !rename_to_untracked_or_warn(buf) &&
> +			    !mkdir(buf, 0777))
>   				continue;
>   			die_errno("cannot create directory at '%s'", buf);
>   		}
> diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
> index 0b3dfeaea2..1a210f8a5a 100755
> --- a/t/t3903-stash.sh
> +++ b/t/t3903-stash.sh
> @@ -1512,4 +1512,27 @@ test_expect_success 'restore untracked files even when we hit conflicts' '
>   	)
>   '
> 
> +test_expect_success 'stash mkdir README needed - README.untracked created' '
> +	git init mkdir_needed_file_untracked &&
> +	(
> +		cd mkdir_needed_file_untracked &&
> +		mkdir README &&
> +		touch README/README &&
> +		git add . &&
> +		git commit -m "Add README/README" &&
> +		echo Version2 > README/README &&
> +		mv README/README README2 &&
> +		rmdir README &&
> +		mv README2 README &&
> +		git stash &&
> +		test_path_is_file README.untracked &&
> +		echo Version2 >expect &&
> +		test_cmp expect README.untracked &&
> +		rm expect &&
> +		git stash pop &&
> +		test_path_is_file README.untracked &&
> +		echo Version2 >expect &&
> +		test_cmp expect README.untracked
> +	)
> +'
>   test_done
> --
> 2.41.0.394.ge43f4fd0bd
> 

