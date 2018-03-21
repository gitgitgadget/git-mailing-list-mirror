Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C11691F404
	for <e@80x24.org>; Wed, 21 Mar 2018 20:00:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753125AbeCUUAy (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Mar 2018 16:00:54 -0400
Received: from mail-wm0-f48.google.com ([74.125.82.48]:36998 "EHLO
        mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752954AbeCUUAy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Mar 2018 16:00:54 -0400
Received: by mail-wm0-f48.google.com with SMTP id 139so12116629wmn.2
        for <git@vger.kernel.org>; Wed, 21 Mar 2018 13:00:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=fsOa+OmsBy8BXl67//yTKCxZsxEeEtxpyOh47oPP2e8=;
        b=LnrQFkngz+Zw2EzEW2WJxvSEJbjc9y6SBHXvZ62isYLWT59OeQjiCoISV/eGNAzNAM
         8X1m84qwTqihZ52+0dPdLIj/dtJMII/nzjAjDSPk1K+4UnAM470IpaQl6kmr1n2jre5i
         PRe3UIzZfcQjQQ7DkzaLBJjo3aDE5ApFarxW7kMXF5/f1o2RHFCxtGcyohJ95FZQCgzT
         aXF8roipX2PeFmg7FeUmqKnseeiAckyUWf9K4TVklW/EwVfhiOyA+YK6MDNiEzEUBjdb
         jd+Bd/23fhGWLenhmsmJjJyY8tINny9hnIXKBGH97TKo8W8dkqS274hAq4vWbTBvtJ+9
         Sagw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=fsOa+OmsBy8BXl67//yTKCxZsxEeEtxpyOh47oPP2e8=;
        b=p71b2LNdgPS7vl+8ONvbnW7V36XQVR5at6GLoPQBrdEMQAQxnB4f007XcQeZtdk7uh
         Myh4oE42VEgLvrzPIekBczL+Pq9H9cT0qE3in0wNFhHlgFlB/Z9YCrZHShqTwEfpgHs0
         MdA3iW+naYzCtyhX0qK8lEM9mzg/WJ8g1AHrKibuFn5HUM/btF3y8l3jsLLBgjUteklf
         bFK4BOuDdDfZF989FPLE/LBfWrzUsqDZNurRluQBlyXK1OPPvfkIpMmTlnBX189JySLy
         s5X9F9igEm3CIAU+7q6zqD2GDMufav77Gy30gt/tT9hpRE9/qZ0rBhphivlz33vgzSqn
         g6kA==
X-Gm-Message-State: AElRT7EYfyyD/fkI4344ZJBnZEqVpFY2a1MmQiWBpmIYVZpMYh6AQr+H
        3IjHDtk80TZltt0i9ashiSU=
X-Google-Smtp-Source: AG47ELsX9NA/4wFRHbgAkXCs9Als7raYBPOIUaEK6aF7Uzn0cUN++yPdesLZU4wLv0E4FhS8ekSXFg==
X-Received: by 10.28.192.8 with SMTP id q8mr1726004wmf.103.1521662452527;
        Wed, 21 Mar 2018 13:00:52 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id n62sm4511214wmf.13.2018.03.21.13.00.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 21 Mar 2018 13:00:51 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Yuki Kokubun <orga.chem.job@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] filter-branch: consider refs can refer to an object other than commit or tag
References: <xmqqwoy5pcno.fsf@gitster-ct.c.googlers.com>
        <20180321103504.9483-1-orga.chem.job@gmail.com>
        <1521646299-16193-1-git-send-email-orga.chem.job@gmail.com>
        <5ab2b606.86f5620a.c0c10.41b3@mx.google.com>
Date:   Wed, 21 Mar 2018 13:00:51 -0700
In-Reply-To: <5ab2b606.86f5620a.c0c10.41b3@mx.google.com> (Yuki Kokubun's
        message of "Wed, 21 Mar 2018 20:00:00 +0000")
Message-ID: <xmqqpo3xnqq4.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Yuki Kokubun <orga.chem.job@gmail.com> writes:

>> Yuki Kokubun <orga.chem.job@gmail.com> writes:
>> 
>> > "git filter-branch -- --all" can be confused when refs that refer to objects
>> > other than commits or tags exists.
>> > Because "git rev-parse --all" that is internally used can return refs that
>> > refer to an object other than commit or tag. But it is not considered in the
>> > phase of updating refs.
>> 
>> Could you describe what the consequence of that is?  We have a ref
>> that points directly at a blob object, or a ref that points at a tag
>> object that points at a blob object.  The current code leaves both of
>> these refs in "$tempdir/heads".  Then...?
>
> Sorry, this is my wrong.
> I wrongly thought only refs/replace can point at a blob or tree object.

No need to be sorry.  You still need to describe what (bad things)
happen if we do not filter out refs that do not point at committish
in the proposed log message.  

IOW, can you elaborate and clarify your "can be confused" at the
beginning?
