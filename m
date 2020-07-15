Return-Path: <SRS0=3l3d=A2=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 195A1C433E0
	for <git@archiver.kernel.org>; Wed, 15 Jul 2020 18:00:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E072F20656
	for <git@archiver.kernel.org>; Wed, 15 Jul 2020 18:00:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GdieSQ3r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726479AbgGOSAr (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Jul 2020 14:00:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725861AbgGOSAr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Jul 2020 14:00:47 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 416D1C061755
        for <git@vger.kernel.org>; Wed, 15 Jul 2020 11:00:47 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id r22so2641685qke.13
        for <git@vger.kernel.org>; Wed, 15 Jul 2020 11:00:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=kcmKQ+WzL6bRIVtz+9XATINAchygZ/rbfX4gGM+kGa4=;
        b=GdieSQ3rBla6rcUpUbKzgk3P5GzP15MREDe5b9k/edDzPNyE7iiw49E4IRez9fG+Dk
         sq3NSDbXU6h84KBiMuYV9yM0cYou4M4H8wGft2bR0vgQoMefSftVho9RV9eWTqC/k43f
         L3dzqWGH5C9O+ESMuKQm9qgqhJKyunAkqngi1/2kueFQbXmhLSRMRkkRXP580UoClFKG
         XcuETEpDeqnF5NjL7g+evktgJrSrk9yTL6xBYaooSBoz2U/HONiUmhcszureFP2Ms7oB
         QE8Z3YqKQGar1xojgV611KhIwDIrrEqdDwePbSLbrsqwFDICE/xsKCnM9Gpfd+LRP42D
         pNSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kcmKQ+WzL6bRIVtz+9XATINAchygZ/rbfX4gGM+kGa4=;
        b=ab+ImSI4gogo24iGI0nHh4WCN7SR/iwwHP8Q8cQlpklyTBQ3eUe2eyitbpemEiK1qN
         f9VZT5MiNyG9fn2SQbqRqIVFP8h5I4unp0bv5bUPnqtouhrKtncONccoxOZb/4T+51bI
         Hnv5WWDhAvUf06d1S9paoJjdpZCge8jqf28E3jFbphpaRd270OXuuhuOfX8oe34LS3n+
         xUtpWkJ2rZtJqgXWTb3KnCtqfbCU2jpifXWI2cPwZ3TqNurjJyeT1Og5iQLuSSInXX5V
         Ij8ArieI0z3v1orzAUccjRIcBnzVK5FQDtHumgdfHSgyeBj8vI13RfydpzuPjrArV9j3
         cZTw==
X-Gm-Message-State: AOAM5330gwfCDReisrunMBFlha9L5HynDAdAjt5s6UWkyOmqA/6cISds
        6/DJENPTH9GrJFq8aCQwuPhZKwgFNAY=
X-Google-Smtp-Source: ABdhPJyQy75ufPtedGwc7BIhC78HoKiseBidrbCC04mgWLWpWEjNI1h0JhyYmvv1LbNX3xZiI0jJ1g==
X-Received: by 2002:a37:9a96:: with SMTP id c144mr249033qke.207.1594836044414;
        Wed, 15 Jul 2020 11:00:44 -0700 (PDT)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id g22sm3062555qkm.97.2020.07.15.11.00.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Jul 2020 11:00:43 -0700 (PDT)
Subject: Re: [PATCH] setup: warn about un-enabled extensions
To:     Junio C Hamano <gitster@pobox.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
References: <pull.675.git.1594677321039.gitgitgadget@gmail.com>
 <0bede821-139a-d805-934a-142004abaa4c@gmail.com>
 <nycvar.QRO.7.76.6.2007141420300.52@tvgsbejvaqbjf.bet>
 <xmqqzh82ktgm.fsf@gitster.c.googlers.com>
 <xmqqpn8wkben.fsf@gitster.c.googlers.com>
 <xmqqlfjkk8zv.fsf@gitster.c.googlers.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <31f52913-8745-18b4-63fc-37d2a9aea8d0@gmail.com>
Date:   Wed, 15 Jul 2020 14:00:42 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.0
MIME-Version: 1.0
In-Reply-To: <xmqqlfjkk8zv.fsf@gitster.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 7/15/2020 1:01 PM, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
>> The current one on the table is NOT
>> <20200714040616.GA2208896@google.com> but the two patches
>>
>> <1b26d9710a7ffaca0bad1f4e1c1729f501ed1559.1594690017.git.gitgitgadget@gmail.com>
>> <e11e973c6fff6a523da090f7294234902e65a9d0.1594690017.git.gitgitgadget@gmail.com>
>>
>> For example it special cases only the worktreeconfig and nothing
>> else, even though I suspect that other configuration variables were
>> also honored by mistake.

Sorry for the delay. I had your previous diff applied and was
playing around with the two "known breakages".

The diff below _does_ fail on t0410-partial-clone.sh, but it's
because you do change the behavior. Here is my diff hunk for that
test:

diff --git a/t/t0410-partial-clone.sh b/t/t0410-partial-clone.sh
index 463dc3a8be..fc8da56528 100755
--- a/t/t0410-partial-clone.sh
+++ b/t/t0410-partial-clone.sh
@@ -42,7 +42,7 @@ test_expect_success 'convert shallow clone to partial clone' '
        test_cmp_config -C client 1 core.repositoryformatversion
 '
 
-test_expect_success 'convert shallow clone to partial clone must fail with any extension' '
+test_expect_success 'convert shallow clone to partial clone succeeds with grandfathered extension' '
        rm -fr server client &&
        test_create_repo server &&
        test_commit -C server my_commit 1 &&
@@ -50,7 +50,20 @@ test_expect_success 'convert shallow clone to partial clone must fail with any e
        git clone --depth=1 "file://$(pwd)/server" client &&
        test_cmp_config -C client 0 core.repositoryformatversion &&
        git -C client config extensions.partialclone origin &&
-       test_must_fail git -C client fetch --unshallow --filter="blob:none"
+       git -C client fetch --unshallow --filter="blob:none"
+'
+
+test_expect_success 'convert shallow clone to partial clone must fail with unknown extension' '
+       rm -fr server client &&
+       test_create_repo server &&
+       test_commit -C server my_commit 1 &&
+       test_commit -C server my_commit2 1 &&
+       git clone --depth=1 "file://$(pwd)/server" client &&
+       test_cmp_config -C client 0 core.repositoryformatversion &&
+       git -C client config extensions.unknownExtension true &&
+       git -C client config extensions.partialclone origin &&
+       test_must_fail git -C client fetch --unshallow --filter="blob:none" 2>err &&
+       test_i18ngrep "unable to upgrade repository format from 0 to 1" err
 '
 
 test_expect_success 'missing reflog object, but promised by a commit, passes fsck' '


> The attached may be a less ambitious and less risky update for the
> upcoming release.  It is to be applied on top of the two-patch
> series from Derrick, and just marks the other "known and honored
> back then by mistake" extensions as OK to be there for upgrading.
> 
> Thoughts?  If people are happy with that, then we could apply and
> cut an -rc1 with it.  Or if we are OK with the "just special case
> worktreeconfig; other extensions may have the same issue but we
> haven't heard actual complaints so we will leave them untouched",
> then -rc1 can be done with just those two patches.

The "special case wortreeConfig" of my submission was maybe based
on an incorrect assumption that this is the only place where Git
itself set an extension.* config without _also_ updating the
core.repositoryFormatVersion config.

The error I made in my v1 is to warn on ALL extensions, not just
the ones that Git knows about. This new approach is a good middle
ground between my v1 and v2.

Of course, the _other_ option is to revert xl/upgrade-repo-format
from v2.28.0 and take our time resolving this issue during the
2.29 cycle. I'm not sure how disruptive that action would be.

> Now I do need to shift my attention to other topics in flight.

I appreciate you spending so much time on this! It's a tough
time to be noticing such a complicated situation that is not
easily testable from a single Git version, but across versions.

> 
>  setup.c | 27 ++++++++++++++++-----------
>  1 file changed, 16 insertions(+), 11 deletions(-)
> 
> diff --git a/setup.c b/setup.c
> index 65270440a9..a072c76d05 100644
> --- a/setup.c
> +++ b/setup.c
> @@ -456,27 +456,32 @@ static int check_repo_format(const char *var, const char *value, void *vdata)
>  		data->version = git_config_int(var, value);
>  	else if (skip_prefix(var, "extensions.", &ext)) {
>  		/*
> -		 * record any known extensions here; otherwise,
> -		 * we fall through to recording it as unknown, and
> -		 * check_repository_format will complain
> +		 * Grandfather extensions that were known in 2.27 and
> +		 * were honored by mistake even in v0 repositories; it
> +		 * shoudn't be an error to upgrade v0 to v1 with them
> +		 * in the repository, as they couldn't have been used
> +		 * for incompatible purposes by the end user.
>  		 */
> -		int is_unallowed_extension = 1;
> +		int unallowed_in_v0 = 1;
>  
> -		if (!strcmp(ext, "noop"))
> -			;
> -		else if (!strcmp(ext, "preciousobjects"))
> +		if (!strcmp(ext, "noop")) {
> +			unallowed_in_v0 = 0;
> +		} else if (!strcmp(ext, "preciousobjects")) {
>  			data->precious_objects = git_config_bool(var, value);
> -		else if (!strcmp(ext, "partialclone")) {
> +			unallowed_in_v0 = 0;
> +		} else if (!strcmp(ext, "partialclone")) {
>  			if (!value)
>  				return config_error_nonbool(var);
>  			data->partial_clone = xstrdup(value);
> +			unallowed_in_v0 = 0;
>  		} else if (!strcmp(ext, "worktreeconfig")) {
>  			data->worktree_config = git_config_bool(var, value);
> -			is_unallowed_extension = 0;

Your previous diff had this comment, which I thought to be
helpful: 

+		/*
+		 * Extensions are added by more "} else if (...) {"
+		 * lines here, but do NOT mark them as allowed in v0
+		 * by copy-pasting without thinking.
+		 */

> -		} else
> +			unallowed_in_v0 = 0;
> +		} else {
>  			string_list_append(&data->unknown_extensions, ext);
> +		}
>  
> -		data->has_unallowed_extensions |= is_unallowed_extension;
> +		data->has_unallowed_extensions |= unallowed_in_v0;
>  	}
>  
>  	return read_worktree_config(var, value, vdata);

Thanks,
-Stolee


