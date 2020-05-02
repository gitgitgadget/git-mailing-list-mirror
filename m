Return-Path: <SRS0=N0vB=6Q=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37CE2C3A5A9
	for <git@archiver.kernel.org>; Sat,  2 May 2020 15:27:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 06FEF216FD
	for <git@archiver.kernel.org>; Sat,  2 May 2020 15:27:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="df8JqNFZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728219AbgEBP1t (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 2 May 2020 11:27:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728072AbgEBP1s (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 2 May 2020 11:27:48 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81B53C061A0C
        for <git@vger.kernel.org>; Sat,  2 May 2020 08:27:48 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id i16so7099864ils.12
        for <git@vger.kernel.org>; Sat, 02 May 2020 08:27:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=yU6Vkn7nxTB5pZdy/NKeMCsjeVhnFUo4+RVbOtph5jg=;
        b=df8JqNFZwghU6EFkeT+g4/DCXhKkdvoRXNB/wCpe0Iyw7RP5uyt7QMQ9sk8wMLHIB+
         /MAHzSVHxYukweNkCrQ7ndXW6UJRXbp17W4mAMXfxPdScp18VEaNRF41Muk+5EfBJ89Y
         0JdeI9ZmCLHWLOq6oLdILyyNGKq21OzXALL8g1DB+IIgXiUX/mf8Ppj9s7c3bnigL+mu
         dfflsko0PC8tKe9GnM3hxXcgv3mfUhRLHGi6uhixMzMA1/31u1c7HbaR9uuwF4AV+MDE
         v3FNaiurptOO6YjJAJNFMo1CdAoofYS6GYcgUsHY9ATqnqbSIbCKdJeBCO4u0tQ47u1p
         cBiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=yU6Vkn7nxTB5pZdy/NKeMCsjeVhnFUo4+RVbOtph5jg=;
        b=haMloWlgiXUPyZEPYF+D/tpWj4o6t3SUplU+WuWR/SRnz7Bv7im5NVOzfzYtTJQc5c
         Lj6Ci4Di+CemfpzuB4tL2FbddnwxY0t8Ds4Gz5MD4KboSQIno7aBQf7FcwvNvxKyX7c4
         gjF/c6ZlKpDd84Zw0Fz5F+QrRzL/0pEPMh+iPVdP5l/qCdjICi+mEby8Q0ITzQZn6sKY
         rhKsP/E5e4HWLY8LZrjW85ma1OAdnLRFCKB5T2YF6Y/O3Txl7GO+NWNH0jtFQN+/2ibV
         EGwBtolEfgdQjzwiR/izmecOp5I3aMkDMlPlBlWdnHbou+NosTA3SjoNgYusvI28/xpX
         aH9Q==
X-Gm-Message-State: AGi0PubQB/Ia/Rz9SvUPgb1/M1H+bQ1B6UhKHv+LHh2IJ+xtnfUQP0PD
        OYnWsJ6FvVpA2jYVMiPXXfY=
X-Google-Smtp-Source: APiQypINHLXJQ0K5sr14uCudw65cg2EwF0IO0xTcPKTbfxYBiYMs70jCywRgdx1PT5w17lpqYH/Lhg==
X-Received: by 2002:a92:c80d:: with SMTP id v13mr8565919iln.285.1588433267688;
        Sat, 02 May 2020 08:27:47 -0700 (PDT)
Received: from ?IPv6:2601:8c0:37f:6012:886f:d51d:fbf5:59b6? ([2601:8c0:37f:6012:886f:d51d:fbf5:59b6])
        by smtp.gmail.com with ESMTPSA id u83sm2529508ili.17.2020.05.02.08.27.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 02 May 2020 08:27:47 -0700 (PDT)
Subject: Re: [PATCH 1/3 v3] Clean up t6016-rev-list-graph-simplify-history
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git-ml <git@vger.kernel.org>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Derrick Stolee <dstolee@microsoft.com>
References: <df0b9e59-e6d7-8839-ca3b-86145dc3bdf3@gmail.com>
 <d3079ba8-33e1-3b68-23d2-ea97b9ca1e97@gmail.com>
 <3a2605b6-c612-f70c-a11e-1e1cc3f59184@gmail.com>
 <xmqq4kszoa2w.fsf@gitster.c.googlers.com>
From:   Antonio Russo <antonio.e.russo@gmail.com>
Message-ID: <01dc74f9-8bc6-cb8d-4eca-6495ffb04826@gmail.com>
Date:   Sat, 2 May 2020 09:27:46 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <xmqq4kszoa2w.fsf@gitster.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 5/1/20 11:10 AM, Junio C Hamano wrote:
> Antonio Russo <antonio.e.russo@gmail.com> writes:
> 
>> +check_graph () {
>> +	cat >expected &&
> 
> Not a new issue, but we may want to fix this to align to majority of
> tests by calling it "expect".
> 
>> +	git rev-list --graph "$@" | sed "$(cat sedscript)" > actual &&
> 
> Style. No SP between > (or < for that matter) and the filename.
> 
> The "sed" utility can be told to read its script from a file with
> its "-f" option.
> 
> Correctness.  Never run "git" command that is the target being
> tested on the left side of a pipe.  It will hide the exit status.

>> -	'
>> +	echo "s/ *$//;" > sedscript &&
>> +	( for tag in $(git tag -l) ; do echo "s/$(git rev-parse --verify $tag)/$tag/;" >> sedscript ; done )
> 
> Avoid unreadable one-liner with needless subshell.
> 
> I suspect that this is a task for-each-ref was designed for,
> something along the lines of...
> 
> 	git for-each-ref --format='s|%(objectname)|%(refname:short)|' \
> 		refs/tags/ >>sedScript
> 

Thanks, I've fixed these.

> 
> Much nicer to see.
> 
> Having said all that, I am not sure if this change of design is
> sound.
> 
> The original approach would have worked even if two or more of these
> tags pointed at the same object.  Your version will pick one of
> them.  If two tags, say A5 and C8, pointed at the same commit, and
> the illustration given to check_graph helper from its standard
> output labeled a commit as C8, wouldn't the actual output converted
> to show A5 with your sedScript approach?
> 
> I think it is salvageable by changing the direction you munge.
> Instead of munging the rev-list output, you can store it as-is in
> "actual", and instead pass the illustration that comes from the
> standard input of the check_graph helper through sed to expand the
> symbolic names to actual object names before comparing. i.e.
> 
> 	check_graph () {
> 		sed -f expand_tag_to_objects.sed >expect &&
> 		git rev-list --graph "$@" >actual &&
> 		test_cmp expect actual
> 	}
> 
> Note that I renamed the overly generic "sedscript" to a name that
> reflects the purpose of the file (and the contents being of a
> certain type is conveyed by .sed suffix, just like you'd use
> suffixes like .c, .txt).  A good discipline to learn, I would say.

I also fixed these.  I originally chose the other direction
(oid->refname) to make the output more human readable.

If you think that's a worthwhile goal, I can figure something out.

That said, the patchset as it stands scratches my immediate need,
and addressing D. Stolee's comments (in particular, making it work
with revs->limited==0) unfortunately has to be a lower priority
for me.

I am not abandoning the patchset, but may be more delayed
responding to review.

Thanks,
Antonio
