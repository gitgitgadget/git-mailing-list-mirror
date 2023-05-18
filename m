Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE4CEC7EE25
	for <git@archiver.kernel.org>; Thu, 18 May 2023 15:57:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231459AbjERP5D (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 May 2023 11:57:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230476AbjERP5B (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 May 2023 11:57:01 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E646BE7
        for <git@vger.kernel.org>; Thu, 18 May 2023 08:56:59 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-64d247a023aso454144b3a.2
        for <git@vger.kernel.org>; Thu, 18 May 2023 08:56:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684425419; x=1687017419;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RyyAUb3/Jz1V+haqTEIlqt/ugbGZ6LWIHPtcr6n0mYo=;
        b=eHoskIil3iYZZDhsG1G3gvX2iLGGt/V2L60QjITh6lNKrlHZooSu230TEubSz0QrrG
         tEoodLzPmylkfSSP8qu9szoXQ5bXayJYNEa+oiAvxkogTMcy8F4hmzIxOZRZKqeVIYkz
         ssTliXRdqVbXv6j5jVobcxjYq69vaKEykTQcvszQ9evzBHQ+wFCk6CUivyz56IgWbqUQ
         DsoYEr6ZSHLtldjPlyF2gI1td48iiS9u1MtMcTfOk+1c/bB2mzScaY2wqrL7TwNVuqp8
         p6k1kOyITymaO3LEk8HA1HzYpvT3sLZONorHReQki6czSGYWCPEQ27ijubwJEP6GII7y
         nVbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684425419; x=1687017419;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=RyyAUb3/Jz1V+haqTEIlqt/ugbGZ6LWIHPtcr6n0mYo=;
        b=J/g+KxYoTgHXTkDJ4hHyYIR+Nu9BrPXZXsRNINdJkbkyyDC3xic57Uuo4iixhlC9/S
         KPrmhiBvDl7MfrCMW/aS9xrDUlHsyl3/fqnb1iS8JEahbVRPcz5eJS4UZ1BhLzWBkPUG
         0Opxg4/KP3V9RhAdWlHKarqvdU+9LxSqZbvKqrj5J09Xn0RprklFG5Q/MCxBFM8UEqwd
         aAIToiySLRRRnxXp8tv4sQfuInYsoR1VqUaoyzcO/3aKU3jczPVESorfSbaA0TagNYFd
         1tH38gAgp+XuhLTPynisaduFbGMd2eoTd+3xh/fO+71ci/nmhKEWc0Zy0S5u+WvjEAT1
         V/Sg==
X-Gm-Message-State: AC+VfDyXfZv3iQ8zonamnLNYl7YUQ6tGN83P1P199aHzTzl7H/TxkhqD
        5hiMWgVEdeWHCjiUETkSZqI=
X-Google-Smtp-Source: ACHHUZ4x5YPY6PIKN3z3UuGzJaCZpXdkkK0bRXdZwT+v699PfOKt6mVr3OOlmLqFB+3Pw6RXfecQFg==
X-Received: by 2002:a17:903:230f:b0:1ac:a61c:7a12 with SMTP id d15-20020a170903230f00b001aca61c7a12mr3462282plh.57.1684425416563;
        Thu, 18 May 2023 08:56:56 -0700 (PDT)
Received: from localhost (187.137.203.35.bc.googleusercontent.com. [35.203.137.187])
        by smtp.gmail.com with ESMTPSA id 4-20020a170902c24400b001a64011899asm1639085plg.25.2023.05.18.08.56.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 May 2023 08:56:56 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Christian Hesse <list@eworm.de>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        Christian Hesse <mail@eworm.de>
Subject: Re: [PATCH 1/1] imap-send: include strbuf.h
References: <20230517070632.71884-1-list@eworm.de>
        <xmqqwn17q7ou.fsf@gitster.g> <ZGT6fEZFumAsZnxu@nand.local>
        <xmqqilcrq6a9.fsf@gitster.g> <20230517221237.590fb984@leda.eworm.net>
        <20230517221850.1117204b@leda.eworm.net>
Date:   Thu, 18 May 2023 08:56:55 -0700
In-Reply-To: <20230517221850.1117204b@leda.eworm.net> (Christian Hesse's
        message of "Wed, 17 May 2023 22:18:50 +0200")
Message-ID: <xmqqbkihvdiw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Hesse <list@eworm.de> writes:

> Christian Hesse <list@eworm.de> on Wed, 2023/05/17 22:12:
>> > OK, so the fix seems to make sense, but the justification for the
>> > change needs to be rewritten, I think.
>> > 
>> >     We make liberal use of the strbuf API functions and types, but
>> >     the inclusion of <strbuf.h> comes indirectly by including
>> >     <http.h>, which does not happen if you build with NO_CURL.
>> > 
>> > or something like that?  
>> 
>> Fine with me!
>> Do you want me to re-send the patch or do you modify this on the fly?
>
> Found it in next branch already. Thanks a lot!

We made moderate amount of these kind of header shuffling this
cycle, and it is inevitable to encounter a gotcha like this when
building with anything less than the most common configurations.

Thanks for reporting and fixing; very much appreciated.

