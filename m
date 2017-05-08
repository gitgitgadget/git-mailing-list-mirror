Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5B20220188
	for <e@80x24.org>; Mon,  8 May 2017 02:08:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751293AbdEHCIe (ORCPT <rfc822;e@80x24.org>);
        Sun, 7 May 2017 22:08:34 -0400
Received: from mail-pf0-f171.google.com ([209.85.192.171]:35270 "EHLO
        mail-pf0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750943AbdEHCId (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 7 May 2017 22:08:33 -0400
Received: by mail-pf0-f171.google.com with SMTP id v14so25735780pfd.2
        for <git@vger.kernel.org>; Sun, 07 May 2017 19:08:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=ZUgXEGiEUd4VWrLFOHOMe9UCQ+msE+O8xqxZCnfk/rg=;
        b=lrxKHTrD6Gr2NPh7sK8M+CPPbeuJO6CCuX9EM0LtLX0z8tP9fdmc2zbP+RRk1+yOg/
         /rOLGoH4DAvgxL+n9nJWtQb3jkHoeJLncah0xzqCsU7X1hYCGmbbF7PDAx4GIURkC0NU
         v06DuvzNmkrDOIKDzFbN19chL3kq/8YCgu27qkixnRmWusmfiRa4VLf1KuWDmDnvRdUF
         oVekp2outBJUwgtvTHDI5r7bTxymrMgRMAmuyzJcN4ws4kd8g5HxfRI63HnwKFVe3Jps
         mIpHNP4o5aGmzppHElMRQddxSRI7EmwrETrk90ZejRFXLuEuqKqgK4aWDlAMnVeK4RDT
         zEvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=ZUgXEGiEUd4VWrLFOHOMe9UCQ+msE+O8xqxZCnfk/rg=;
        b=o1hK4Um0ICuYxMpQOeT4ISYK0k+GFC3l7g+SZiyep4v2Q8zFFLWtDPs2J0s6iM5TYD
         Iz63Peas4TxVMs3Lt7LMQr9QnyECFc81d20dAWiiO1GNyaqB6bZbpoO3CbfQn84mfIpj
         /It9DXj06wAt9KpU9pZkyVQNjV34QX0c+7sB2+EkESs868XHQQkz9qcnnYLP7EQAX+ld
         95hjPfEfD7CY2Vh9czi1j18y1U7w+v4md3ve+AixzJP2sZ1EGw3ZtNH1WNsk5vY2bA4d
         LCbc0eySjoM8sj6kxtaBtMgfARzKkT9BLRG9eLnrkA0W62dLMPh3nOCg/yt9lefnGmZf
         Zc1g==
X-Gm-Message-State: AN3rC/5ml6P+IyjWOamoObwCQ7oH+hMMTW6scuGASOw4uZXXRvO5G1sy
        kPuYH/wZfbw2Bg==
X-Received: by 10.99.97.215 with SMTP id v206mr16100142pgb.235.1494209312584;
        Sun, 07 May 2017 19:08:32 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:3011:642f:81a0:efbd])
        by smtp.gmail.com with ESMTPSA id z22sm21382975pfg.117.2017.05.07.19.08.31
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sun, 07 May 2017 19:08:31 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Bryan Turner <bturner@atlassian.com>
Cc:     akos tajti <akos.tajti@gmail.com>, Git Users <git@vger.kernel.org>
Subject: Re: Git smart http: parsing commit messages in git-receive-pack
References: <7DA6022F-02F0-41AC-ABAB-64565E81481F@gmail.com>
        <CAGyf7-EDHPdL_YvNoC9QNy11=YfxSpmZBFZ5UR50ub1o2yqAug@mail.gmail.com>
Date:   Mon, 08 May 2017 11:08:31 +0900
In-Reply-To: <CAGyf7-EDHPdL_YvNoC9QNy11=YfxSpmZBFZ5UR50ub1o2yqAug@mail.gmail.com>
        (Bryan Turner's message of "Sat, 6 May 2017 12:14:44 -0700")
Message-ID: <xmqq4lwwayn4.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Bryan Turner <bturner@atlassian.com> writes:

> That means if you pair a pre-receive hook with Git 2.11 or newer on
> the server, you should be able to achieve what you're looking for.

It probably is worth mentioning that even without the "quarantine"
changes of 2.11, the new objects brought in by a rejected push
cannot be used because they are not reachable from any ref, and will
be discarded as garbage when the next GC run.  So pre-receive should
be sufficient for the purpose of "not accepting" an undesirable
push, with older versions of Git.  You can view the "quarantine"
feature mostly as "quality of implementation" issue.



