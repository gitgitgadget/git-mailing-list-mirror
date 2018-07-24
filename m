Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 90B591F597
	for <e@80x24.org>; Tue, 24 Jul 2018 17:11:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388486AbeGXSTC (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Jul 2018 14:19:02 -0400
Received: from mail-wr1-f50.google.com ([209.85.221.50]:39825 "EHLO
        mail-wr1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388429AbeGXSTC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Jul 2018 14:19:02 -0400
Received: by mail-wr1-f50.google.com with SMTP id h10-v6so4886347wre.6
        for <git@vger.kernel.org>; Tue, 24 Jul 2018 10:11:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=7301O0vLjDQjw9v5N4tunQXBC7r1QZ2x/7CbZkObpNM=;
        b=RWCHMWG2dz586Jt8zYH5BPN8nzfb1ZlTFunsy/AyFyPueToxm6OT7NUymBLkrA+vSY
         SYaT5Q7/UnWbLkqd0WWweZGJtSW9gzYer5h36UNOiro8gGa1Gr92ZMq2vsP/dW/j5tr5
         VFgm8SmNHy3TF+wiCSLuRJaoI4mtid8lg71O/1iOiRV3VA7em4Z/4Rey1x03mRcWF0Yz
         WEUgZ5VxAnyiT6+iH+TADLgo/ZF3+6C358kFwn2IDtQs/b1cOgbXYmta/BwANdh5aBwn
         DtGXB4cLfPMLuYywVp3il01waPlzzAf6UXJjpko7xCydSbbt6OQ5C67CWGHmoOiHMu4D
         Ji8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=7301O0vLjDQjw9v5N4tunQXBC7r1QZ2x/7CbZkObpNM=;
        b=WU1wbjecOvs0PAOdQkaQb+PcyveVZcv3INGRWRkD7ZaSHoeR1MN9Z2OkBOnH922nQs
         Sn3dlFG8pC/QI0vk4q6+JkymnxzDVhueihUq3lhogVJoTjeluRTkEZKRYbfTeBXU7Sbp
         LnXgyoFAjm+eT8XhQ7H0J/Iz7EUKP6ZM3DKgVA9VZPGCh1MBDxTe1UeAra6WiMP1/VNi
         no47YFsR7XQXb1IPRzLeaIv8ur5m2W5eLw+KE9YHKdqepwYXtblbaHwWrvAJDEfWF9mM
         4jhKYG50QngZNvj9BZCnu3Udo0T59GvSDStdz2cZPzwBC/uo85dXwwYX0JvhKLLbozSe
         hQ2Q==
X-Gm-Message-State: AOUpUlG17Rjq2ErEJUQ92U5PBUaH+VZRfqa2vRuYCytoNjDKlIYyyHQA
        CNeWjEwVRspUnc7JHUR5fxUxYZat
X-Google-Smtp-Source: AAOMgpeNc0Px//ZMxkdjSH/Z+jMRtt8gd0NCYCJtFVCY4OqadDQ7NAQZBYn9k1H7OktyIDt63HWNAA==
X-Received: by 2002:adf:cc0a:: with SMTP id x10-v6mr11556545wrh.242.1532452293748;
        Tue, 24 Jul 2018 10:11:33 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id b10-v6sm10860517wrp.49.2018.07.24.10.11.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 24 Jul 2018 10:11:32 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [RFC PATCH 3/5] pack-objects: add delta-islands support
References: <20180722054836.28935-1-chriscool@tuxfamily.org>
        <20180722054836.28935-4-chriscool@tuxfamily.org>
        <xmqqk1pkzhuo.fsf@gitster-ct.c.googlers.com>
Date:   Tue, 24 Jul 2018 10:11:32 -0700
In-Reply-To: <xmqqk1pkzhuo.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Tue, 24 Jul 2018 10:03:27 -0700")
Message-ID: <xmqqfu08zhh7.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

>> +-------------------------------------------
>> +[pack]
>> +island = refs/virtual/([0-9]+)/heads/
>> +island = refs/virtual/([0-9]+)/tags/
>> +island = refs/virtual/([0-9]+)/(pull)/
>> +-------------------------------------------
>
> It becomes clear only from this example that what the feature calls
> (and documented in patch 2/5) "regexp" is not BRE but ERE.  Update
> 2/5 so that it is clear to readers of "git config --help" who looks
> for "pack.island" in the output.
>
>> +That puts the heads and tags for each fork in their own island (named
>> +"1234" or similar), and the pull refs for each go into their own
>> +"1234-pull".
>
> "by concatenating any capture groups" made me imagine that the last
> one would be "1234pull" without dash.  The actual rule should be
> mentioned in that paragraph (i.e.  "concatenating any capture groups
> from the regex, with a '-' dash in between" or something like that).

Another thing I noticed from 2/5 is that you can have up to 7 such
capture groups.  I do not have any opinion if 7 is too few or too
many, but we would want the number to be documented, and end-user
input diagnosed when it requires more captures than we support (if
we are not already checking, that is).
