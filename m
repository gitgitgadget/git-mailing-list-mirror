Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 778F5C433F5
	for <git@archiver.kernel.org>; Wed,  5 Oct 2022 19:39:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230204AbiJETjy (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Oct 2022 15:39:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230359AbiJETjr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Oct 2022 15:39:47 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F01AB7F2
        for <git@vger.kernel.org>; Wed,  5 Oct 2022 12:39:46 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id i6so16745895pfb.2
        for <git@vger.kernel.org>; Wed, 05 Oct 2022 12:39:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=No18RgNp6av7FsmgNL2KKZ5cdlltSWr0t2kwWdQ7mIA=;
        b=Cpv8cPMQl1Ngrj+CoqOpbBwljf3LuiNUIo3375ABJk0OkWUnPfOA74+Av73y0rdrYc
         8K3w9FheMZPT78ZXxFtPqcovJzwBYpN/yyjoY0agkSFyfZks8bluR+MQK51cT8k4HCVk
         FiKl3keA21UFm29hILDbrayvwpRlGApNynWHAijFqG1QoAuiYYi2N5S96JpoVPh7y7c/
         RhT0zu9thWmRkgtoZ610Xlnya0KiI7EbvAlrXUl56Xgdn3AVQZjJIOO6sKKLdWRp0TaL
         3HiwRhsbAJxc3WtAZcWeI9nKKs+ARqCjl3AZdi8UyogYPMDiBB8IxBBC/F4XZ8f4sYUj
         WEiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=No18RgNp6av7FsmgNL2KKZ5cdlltSWr0t2kwWdQ7mIA=;
        b=nq2+6cMM+mLBcrKwhtuIVVQIvitWGtFoajRCpOKmgPEKSvrW7Fj9o+t3Aa3CZyrWk9
         v944aEOSSblAU+GIJtawOtbHPozDXrgiFBob1rATlEreiIleEAIIjRy81vCOkjYJ/kpE
         RsXBniJzn1bgvS3NRf8qT+Tir0i3O3pOST3ldQWFpj/XoLEGvnKbPIpaYRS0t8tSXRWU
         PbtPFyji5rqNFHqjb+jMmxDi6h4yNq/iOurb5cNlXAJFph4ZC2or+NE7+hkn0VEE6I85
         Mw10D7BVY076Ab3FYAFY/VuY0B36UlHCRrq23TNGomrtol5PYoADGbQmv4VZJrGcMl2e
         0qmQ==
X-Gm-Message-State: ACrzQf27pMT4CmZ92X28nZCMATXqEG8rl3NPunAenVtkco837HS/xSJz
        bsaBsv4zgxIUadCBPmQUbc4=
X-Google-Smtp-Source: AMsMyM6jOrxXOJrIphq/pJ/ZcgXnkS5S97NTKXMZ8WEmYBJI/eo8/L1LoLXtPXTK3c2j/BUjIFcvWQ==
X-Received: by 2002:a05:6a00:328b:b0:53e:816a:ee5a with SMTP id ck11-20020a056a00328b00b0053e816aee5amr1232900pfb.71.1664998785489;
        Wed, 05 Oct 2022 12:39:45 -0700 (PDT)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id q6-20020aa79606000000b0055fb19e27a8sm8881123pfg.121.2022.10.05.12.39.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Oct 2022 12:39:44 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Chris Torek <chris.torek@gmail.com>
Cc:     Sean Allred <allred.sean@gmail.com>, git <git@vger.kernel.org>
Subject: Re: Using git-update-index to add existing tree objects at other paths
References: <87o7ur1wi9.fsf@gmail.com>
        <CAPx1GvfsRipG0qgDmMMoU+WCWCEyr4ayJteYWAy+EoJOoaNQXg@mail.gmail.com>
Date:   Wed, 05 Oct 2022 12:39:44 -0700
In-Reply-To: <CAPx1GvfsRipG0qgDmMMoU+WCWCEyr4ayJteYWAy+EoJOoaNQXg@mail.gmail.com>
        (Chris Torek's message of "Tue, 4 Oct 2022 08:10:25 -0700")
Message-ID: <xmqq8rluoy9r.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Chris Torek <chris.torek@gmail.com> writes:

> On Tue, Oct 4, 2022 at 7:43 AM Sean Allred <allred.sean@gmail.com> wrote:
>> ... but the following does not work:
>>
>>     $ cat | git update-index --index-info
>>     040000 tree TREEID1 PATH1
>
> The index is not designed to hold tree objects (at least not at this level),
> and update-index should be fed only the full path names of files, symbolic
> links (mode 120000), or gitlinks (mode 160000).

Correct.

With the ongoing "sparse-index" work, it may not be an entirely
unreasonable idea to extend the "update-index" command to allow
it adding a tree entry there (after removing the entries that are
for anything that fall inside that directory), but we are not there
yet, in the sense that we haven't even discussed if doing it at this
level is a reasonable thing to do.
