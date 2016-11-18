Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 23A361FE4E
	for <e@80x24.org>; Fri, 18 Nov 2016 23:33:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752634AbcKRXdZ (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 Nov 2016 18:33:25 -0500
Received: from mail-qk0-f169.google.com ([209.85.220.169]:33535 "EHLO
        mail-qk0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752480AbcKRXdY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Nov 2016 18:33:24 -0500
Received: by mail-qk0-f169.google.com with SMTP id x190so283664422qkb.0
        for <git@vger.kernel.org>; Fri, 18 Nov 2016 15:33:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=z3BogOvzCABZ0GLF8lvxYYo3bE5x/P+sgYXYr1h4DUA=;
        b=oIqfCWOBVSJefOBop5fhm90PqccHp50nzHV+qfTiC6aRADRFr5dhpOY7aGipNl5t/N
         KSc+NQUHoixFzJeFLbDClsW8vD8WF/1FAd6vnC+ByJBIFI1sjZXybeVSwpxfj6B1Z+cL
         BdJ7qelETii94R3ZA/kzaBy83OnwYVSUBcwvhyYMPvA7yy629ugpDPUwQ5RF7Nj3ND6p
         ZpALmcZDQ40f2UX2R+Mv9effcmBwH8o00MaGELRWDw1C4fTdDkeUGA47XK8zqbldvhQk
         BSGP5k5E3IhB4+oSfyR2oWrDSKdDlp7hz2/3BWy3YX/y5z2jdeT2Y1do6kplKQ9ewhZK
         s4Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=z3BogOvzCABZ0GLF8lvxYYo3bE5x/P+sgYXYr1h4DUA=;
        b=mWd8ijf5oOjI6W0hw9vvZXoGE69vz8o8kjLXoezh6R2ig4mJ/nOUjODOjFKdelWENw
         cXL0lOUndRP3jVv/bYIGhBTP6vdNr/4mIL6V69aQgKakvGaajR/bGasIs2vYxgh7I52o
         vFfZtY2gKsjCnOvOp9kOIkUKni2Ae+Q277v1irhat+uLx9S3XExsUfnnohk4ncTJ23Gf
         2e5P+S6TPcuxDNpVJNNDxnwWW8meDscuEsz09sh8+Yq+FrsqGkywnmGWjl8oMcFqM+zK
         tfiPcLaMAqPYgrrAUwYC2690QiVvvIT4XqnC1muRA/aStVeNGPvSASSvUo9El7ewgmjD
         4OBQ==
X-Gm-Message-State: AKaTC02GHw8r2jNwBa4b6EUaoUucA9T73twCua4zHOoTppjNEPuwS8Dk0Q7M0ZRWO3YTwWAsnYom71/qVZiigcl5
X-Received: by 10.55.186.3 with SMTP id k3mr3122115qkf.47.1479512003236; Fri,
 18 Nov 2016 15:33:23 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.134.65 with HTTP; Fri, 18 Nov 2016 15:33:22 -0800 (PST)
In-Reply-To: <f54d446aa7734cb4aec4b51c7b81a2b6@exmbdft7.ad.twosigma.com>
References: <20161115230651.23953-1-sbeller@google.com> <20161115230651.23953-14-sbeller@google.com>
 <f54d446aa7734cb4aec4b51c7b81a2b6@exmbdft7.ad.twosigma.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Fri, 18 Nov 2016 15:33:22 -0800
Message-ID: <CAGZ79kb-TKgQm1_p3NyJS7mso2FFWMNHa7F8vwzocjSJfyjXJQ@mail.gmail.com>
Subject: Re: [PATCH 13/16] submodule: teach unpack_trees() to update submodules
To:     David Turner <David.Turner@twosigma.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        "bmwill@google.com" <bmwill@google.com>,
        "gitster@pobox.com" <gitster@pobox.com>,
        "jrnieder@gmail.com" <jrnieder@gmail.com>,
        "mogulguy10@gmail.com" <mogulguy10@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 15, 2016 at 4:22 PM, David Turner <David.Turner@twosigma.com> wrote:
>>       msgs[ERROR_NOT_UPTODATE_DIR] =
>>               _("Updating the following directories would lose untracked
>> files in it:\n%s");
>> +     msgs[ERROR_NOT_UPTODATE_SUBMODULE] =
>> +             _("Updating the following submodules would lose modifications
>> in
>> +it:\n%s");
>
> s/it/them/

done, also fixed the existing ERROR_NOT_UPTODATE_DIR.

>> +             if (!S_ISGITLINK(ce->ce_mode)) {
>
> I generally prefer to avoid if (!x) { A } else { B } -- I would rather just see if (x) { B } else { A }.

done.

>> +                             if (submodule_is_interesting(old->name, null_sha1)
>> +                                 && ok_to_remove_submodule(old->name))
>> +                                     return 0;
>> +                     }
>
> Do we need a return 1 in here somewhere?  Because otherwise, we fall through and return 0 later.

Otherwise we would fall through and run

    if (errno == ENOENT)
        return 0;
    return o->gently ? -1 :
        add_rejected_path(o, error_type, ce->name);

which produces different results than 0?
