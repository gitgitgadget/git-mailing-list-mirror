Return-Path: <SRS0=p0jH=64=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E959C433E1
	for <git@archiver.kernel.org>; Thu, 14 May 2020 09:07:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5681920709
	for <git@archiver.kernel.org>; Thu, 14 May 2020 09:07:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UyugoCLl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726140AbgENJHq (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 May 2020 05:07:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726108AbgENJHo (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 14 May 2020 05:07:44 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 744CEC061A0C
        for <git@vger.kernel.org>; Thu, 14 May 2020 02:07:44 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id u10so934184pls.8
        for <git@vger.kernel.org>; Thu, 14 May 2020 02:07:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=u9mdk7MN8re9MEDGVE6JDFrDSUaBDugDYaKKskYwl9U=;
        b=UyugoCLl5Yl8CM4Tx10vb6I0F4+biMxkXKWoO61BjTicLuFoDI0YbBNAqVQKbGTUCH
         tvgs4lFGMr0Ezzplnxtp29iBf1RAWejHubkxBeGMHnY+DkYWPjIKl+jjWPFQDlMqfH3U
         jTF4lXLDjzC8URrkkyDHAOYF2l1TpJdyuLe3VaRmWpPBpJtLGr7hLfEpWM3zlLaDIQnT
         z4Be8CDzYC3FXA4uK+DHKDYcjaedVN37x4zFJG+nP0l0cbWYjq6QS0UaGCzJrvxtukb4
         CRtUppjvMedrp10FEZxxun3KU9XVfi8VsAxufZGyZ0ARwhQZ0yhyVDobDI6ZcNq+iEnf
         VR/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=u9mdk7MN8re9MEDGVE6JDFrDSUaBDugDYaKKskYwl9U=;
        b=Efl5RoGVcyHhisFtY1AEVIZscIywbPec3RmSPCp6y6cr56/yoTFz63QGQuDS4unJAq
         21vKI+Lwws4wiwCT3O92dOme5SbqQFTLwNIIjy40Iy4ZDCSDJ+TrwKgT/S/Dkr8jZuvr
         WJvQxdKvdj9PD6mXYnUSYBpylONJagLYTAZIYZCiiPxp1CTibDqfDGIkDR9/8VzcGnzj
         SmbKNrRWj0AZdft2lHRU8DxqgBn2bhfpuY5my2+cMh05YRInoW+2luVDQ+dcSd/ooqBH
         IVK1sMdbzsE59nlgHqfHTG/bln1gPcKnrAzo7bqlbe6zOl6Q8ViZiAqCp7C30nQ5SxoC
         6GkQ==
X-Gm-Message-State: AGi0PuYLJgYMBDTRBhQb3bsZJ78CfEq5xEic+pOCWrFy6R7iT7Df17B6
        aKJidFfUI3/5fhUM4QHzFRVRqXld
X-Google-Smtp-Source: APiQypLyPhJNMKHBpiG5FNW5uXrdNzQfpErOjVu19+eoQ/5a3E11y2TUaOtOTLfTqV+R/v7+I0edwA==
X-Received: by 2002:a17:90a:ae0d:: with SMTP id t13mr37301889pjq.1.1589447264015;
        Thu, 14 May 2020 02:07:44 -0700 (PDT)
Received: from [192.168.43.191] ([106.198.5.191])
        by smtp.gmail.com with ESMTPSA id i184sm1721140pgc.36.2020.05.14.02.07.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 May 2020 02:07:43 -0700 (PDT)
Subject: Re: [PATCH 1/2] submodule: port subcommand 'set-branch' from shell to
 C
To:     git@vger.kernel.org
Cc:     Shourya Shukla <shouryashukla.oo@gmail.com>,
        christian.couder@gmail.com, gitster@pobox.com, liu.denton@gmail.com
References: <20200513201737.55778-1-shouryashukla.oo@gmail.com>
From:   Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Message-ID: <4e36c8a0-4f43-79f8-137f-5fd080066af6@gmail.com>
Date:   Thu, 14 May 2020 14:37:37 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200513201737.55778-1-shouryashukla.oo@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

-Cc: chriscool@tuxfamily.org (seems redundant; Also, .mailmap confirms 
that christian.couder@gmail.com is Christian's preference)

On 14-05-2020 01:47, Shourya Shukla wrote:
> 
> The extra '$branch' on line 752 was because of Christian's help after
> reference from TLDP's Parameter Subsitution documentation:
> https://www.tldp.org/LDP/abs/html/parameter-substitution.html
>

For those who lack the context, during the conversion of the script 
Shourya faced an issue where the '--branch' argument did not work as 
expected. He described the issue in a private e-mail where Christian 
pointed out the following (quoting his reply hoping he doesn't mind):

 > On Tue, May 12, 2020 at 5:55 PM Christian Couder
<christian.couder@gmail.com> wrote:
 >>
 >> In your commit (in submodule.sh line 781) there is:
 >>
 >>         `git ${wt_prefix:+-C "$wt_prefix"} ${prefix:+--super-prefix
 >> "$prefix"} submodule--helper set-branch ${GIT_QUIET:+--quiet}
 >> ${branch:+--branch} ${default:+--default} -- "$@"`
 >
 > Actually the issue might come from the above. I think it should use 
${branch:+--branch $branch} instead of ${branch:+--branch}.
 >
 > See: https://www.tldp.org/LDP/abs/html/parameter-substitution.html

That's why Shourya mentions the '$branch' as extra. Of course, that's 
how it is supposed to be in the first place :)

-- 
Sivaraam
