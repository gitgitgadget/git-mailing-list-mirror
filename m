Return-Path: <SRS0=hWrV=5D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB5CEC10DCE
	for <git@archiver.kernel.org>; Wed, 18 Mar 2020 13:56:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C53420774
	for <git@archiver.kernel.org>; Wed, 18 Mar 2020 13:56:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="txBEdQLq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726954AbgCRN4C (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Mar 2020 09:56:02 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:43690 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726851AbgCRN4B (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Mar 2020 09:56:01 -0400
Received: by mail-lj1-f194.google.com with SMTP id r7so27143351ljp.10
        for <git@vger.kernel.org>; Wed, 18 Mar 2020 06:55:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=//jhJuMDEMRCZfbSVZPs/fndvkzVxMPFosU2ml90ETE=;
        b=txBEdQLqH+r2f4Sc6aBF0yd0OhLXG8CnAnJ3foUqg+LaSOaPO8yAZVyzSqPylNcCm0
         gmyEg29aZe59GKSuDT0TTBhjkTygkgJ8BSkuG067k1PPiJyKwlQDC4sKdNzfrcsEAEWB
         J1m5sJ+1Hots0xdYA0CuIoOrJ6YiKGmTf1sCKmMA/AllfvBxUffx0elzNysZFc0EP8so
         23MYiQoh6QgbTXx16D49KsahYLsHSKmwyX9sh7VN/R/9xHGMRulbp+YbHmq270c5MIhe
         kdGoKcgM2t1HwRS800eYU0sAb83/3qbHce1vUevUoX8XEA3yoGMqXuDegXwMWPij9Ahu
         Fa1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-transfer-encoding;
        bh=//jhJuMDEMRCZfbSVZPs/fndvkzVxMPFosU2ml90ETE=;
        b=NRbrzLgyNL0AjsHHZC+4GoAeVGpx0kNSmAC9BcpshDytu0SWQOPtZU+oS/qjyNPQ7a
         7enUlqEaX9wnio3MvgaLwR+OAy0F/fC0BCLL8UbL+N9vD2vYKz9I+Sc4nwDHhtm+8zq3
         IdQcabvUXqgpl50ncHq1sgsAkDSTbGotrfULPz/kHEESS3dUTUe1lPLuAjv6kP8I7ZYJ
         RebZ56JBkrm84j8xb6xyKUscIn5ZiQTkHkQsJibaUOcf8K7/TMl+D5goqfA/AjC/1SmR
         PoXDhC8HpUa5fEpqzCfjM2HSpC47RcPUgDWssPCT06dAHOgzxUlH4uvu1btYN7kqQWRl
         QQoA==
X-Gm-Message-State: ANhLgQ15m2/ARzovtS/Q0slpatrVji2V8T+/nxBYT6xI0rQzdO6ftNj4
        eqzUCE8wp+Foi+FlXIrSwuk=
X-Google-Smtp-Source: ADFU+vuw0lAUCVWkyUIDr6ROGPGZ3Hlr6HymrJ4/t9XRPBeKfCJ5KfnVzYFG5NdlCDB6wOgZmFV1qA==
X-Received: by 2002:a2e:9b59:: with SMTP id o25mr2644756ljj.111.1584539758830;
        Wed, 18 Mar 2020 06:55:58 -0700 (PDT)
Received: from Laptop-Acer-Aspire-F15 (host-89-229-7-83.dynamic.mm.pl. [89.229.7.83])
        by smtp.gmail.com with ESMTPSA id s9sm1643485ljm.104.2020.03.18.06.55.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 18 Mar 2020 06:55:57 -0700 (PDT)
From:   Jakub Narebski <jnareb@gmail.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     Derrick Stolee <stolee@gmail.com>, git <git@vger.kernel.org>,
        Heba Waly <heba.waly@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Abhishek Kumar <abhishekkumar8222@gmail.com>
Subject: Re: [RFC] Possible idea for GSoC 2020
References: <86mu8o8dsf.fsf@gmail.com>
        <7d6a84c7-6b16-c2a9-11a1-3397422064d1@gmail.com>
        <86d09b7jx6.fsf@gmail.com>
        <CAP8UFD3BeS8bj8OGKJmVyKeDTCvqhCpBxLhTwuQ3zffejQkj7g@mail.gmail.com>
        <867dzj6p4y.fsf@gmail.com>
        <CAP8UFD1ihR1PtM2y24HTKa2woGXMVFq9MoVSj1cHVZCNWSH7EA@mail.gmail.com>
Date:   Wed, 18 Mar 2020 14:55:54 +0100
In-Reply-To: <CAP8UFD1ihR1PtM2y24HTKa2woGXMVFq9MoVSj1cHVZCNWSH7EA@mail.gmail.com>
        (Christian Couder's message of "Tue, 17 Mar 2020 18:04:23 +0100")
Message-ID: <86mu8d6a39.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (windows-nt)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Couder <christian.couder@gmail.com> writes:
> On Tue, Mar 17, 2020 at 3:18 PM Jakub Narebski <jnareb@gmail.com> wrote:
>> Christian Couder <christian.couder@gmail.com> writes:
>>> On Tue, Mar 17, 2020 at 4:13 AM Jakub Narebski <jnareb@gmail.com> wrote:
[...]
>>>> As I wrote below, such positive-cut filter would be directly helpful in
>>>> performing the following commands:
>>>>
>>>>  - `git merge-base --is-ancestor`
>>>>  - `git branch --contains`
>>>>  - `git tag --contains`
>>>>  - `git branch --merged`
>>>>  - `git tag --merged`
>>>>
>>>> It would be also useful for tag autofollow in git-fetch; is is N-to-M
>>>> equivalent to 1-to-N / N-to-1 `--contains` queries.
>>>>
>>>> I am quite sure that positive-cut filter would make `--ancestry-path`
>>>> walk faster.
>>>>
>>>> I think, but I am not sure, that positive-cut filter can make parts of
>>>> topological sort and merge base algorithms at least a tiny bit faster.
>>>
>>> Is there an easy way to check that it would provide significant
>>> performance improvements at least in some cases? Can we ask the
>>> student to do that at the beginning of the GSoC?
>>
>> The "Reachability labels for version control graphs.ipynb" Jupyter
>> Notebook on Google Colaboratory was created to answer this question
>> (originally for the FELINE reachability index).  Among others it can
>> min-post interval labels and topological levels (generation numbers),
>> use them for reachability queries, and load Linux kernel
>> commit-graph. The exploration didn't get finished, but it would be not
>> that difficult, I think, to at least find the amount of false negatives
>> for min-post interval labeling for git.git or Linux kernel repo.
>>
>>   https://colab.research.google.com/drive/1V-U7_slu5Z3s5iEEMFKhLXtaxSu5x=
yzg
>>
>> As Jupyter Notebook, it is run in the web browser.  It can either use
>> local runtime, or run on Google Cloud runtime.  On the other hand it
>> requires at least some knowledge of Python...
>
> Ok, if that's a possible approach to the project, then please add it
> to the description.

Added as a new paragraph in the 'interval labels' subtask description
https://github.com/git/git.github.io/commit/ac526b18b97e53a431767ce147f27ea=
f6af0aa76

[...]
>>>>> My recommendation is that a GSoC student update the
>>>>> generation number to "v2" based on the definition you made in [1].
>>>>> That proposal is also more likely to be effective in Git because
>>>>> it makes use of extra heuristic information (commit date) to
>>>>> assist the types of algorithms we care about.
>>>>>
>>>>> In that case, the "difficult" part is moving the "generation"
>>>>> member of struct commit into a slab before making it a 64-bit
>>>>> value. (This is likely necessary for your plan, anyway.) Updating
>>>>> the generation number to v2 is relatively straight-forward after
>>>>> that, as someone can follow all places that reference or compute
>>>>> generation numbers and apply a diff
>>>>
>>>> Good idea!  Though I am not sure if it is not too late to add it to the
>>>> https://git.github.io/SoC-2020-Ideas/ as the self imposed deadline of
>>>> March 16 (where students can start submitting proposals to GSoC) has
>>>> just passed.  Christian, what do you think?
>>>
>>> Would that be a different project idea or part of your "Graph labeling
>>> for speeding up git commands" project idea?
>>>
>>> I am very reluctant to add new project ideas at that time. I don't
>>> think student will have time to properly research it and get it
>>> reviewed.
[...]

>> So perhaps we should expand "Commit graph labeling for speeding up git
>> commands" idea, splitting it into two possible ways of working in this
>> project: the more technical 'Generation number v2', and 'Interval labels
>> for commit graph' which is more of research project?
>
> Ok for that.
>
>>  Which should be
>> put first, then?
>
> Which ever you prefer. If you say that any part could be done
> separately, that doesn't matter much.

I have added 'Generation number v2' as one of alternative ways of
working on the more generic "Commit graph labeling for speeding up git
commands" idea -- as first task, because it fit better the narrative:
https://github.com/git/git.github.io/commit/a6d59820709417081c334a512034298=
7ff046f1a

Could you (or Stolee) check current proposal, so that it can be merged
in?  Thanks in advance.

  https://github.com/git/git.github.io/blob/soc-2020-idea-jnareb/SoC-2020-I=
deas.md

Best,
--=20
Jakub Nar=C4=99bski
