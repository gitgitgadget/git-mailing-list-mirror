Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A75D320FCF
	for <e@80x24.org>; Wed, 29 Jun 2016 20:44:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751023AbcF2UoO (ORCPT <rfc822;e@80x24.org>);
	Wed, 29 Jun 2016 16:44:14 -0400
Received: from mail-qk0-f173.google.com ([209.85.220.173]:35922 "EHLO
	mail-qk0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750932AbcF2UoO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Jun 2016 16:44:14 -0400
Received: by mail-qk0-f173.google.com with SMTP id j2so55091772qkf.3
        for <git@vger.kernel.org>; Wed, 29 Jun 2016 13:43:41 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=C0M6R+FwjiqSnSuQtay8f9J3FDE20Eqh8j85Bx7LYeU=;
        b=h8LYnubSXwvZn2CdBViIKt8Z8Cpr5jdI3txGXwOh+31Is2S4W3dzZU+28YDKMto+w9
         ++WkGXh61J491O0Y58KpgzfSbsHBdIX8S/c/PKPTKlcjC2DCA2hdhgtAnZO/CeclYWzp
         SBXbNElH1V1kcSHBehtGK4G52JAT593wIK3tnUVqp5EIqz9bryMrNIAiYcbUBgb1ggsl
         KqIeafHE6CvOXdDYjqNMTKZhLm27xtR5Cmk+sEzbQGJ3b6l0LhtpF+BEA3bDbZOC9Dyv
         zQM1aV8UjDCIBSbRmxcUFl86spotjPcAC5C9AZHvEh1RSlzZHuNHrf6Y0sBbqOD9Lumj
         0u9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=C0M6R+FwjiqSnSuQtay8f9J3FDE20Eqh8j85Bx7LYeU=;
        b=jzAoK3EKHOl2UsFsaooktjHP42GlFByA0jYe7SP4KfXLzI3DQR8pGrXCXdEpftNkYP
         3ooVHpnXQ9VZD7VBnUzQad6dNuQr4oFIm+stnHN+oVnqpeBJLhUtW13u6JcCCkTUmXWX
         otEkuFLvXKmyoh/y7cajDJvhUeNeAZD5udGhK/CU3qxFqIijER0JpBRXnFwLSPb58O+5
         lQdvaErNAJI4j22ayN41/YX1pRxk9NsQFrisGq5ZZ7kef2Myb4Z013g0pSO3uk9P2sBt
         V78UpIOH2HSmX5AJWmOjm7FSM25pZEZKhm9SisYizq30YQ7UeiPifVMz/AvxMrw7RKvF
         8+mA==
X-Gm-Message-State: ALyK8tLO9ly2nEtrRME+uqReZTQf2tw/i7DOT1dxDvFIsXmlKhqpm/fJ4ZPuee1h12bjBjdneQuyDSpGAwegow==
X-Received: by 10.37.58.197 with SMTP id h188mr4708185yba.104.1467233020817;
 Wed, 29 Jun 2016 13:43:40 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.13.251.71 with HTTP; Wed, 29 Jun 2016 13:43:21 -0700 (PDT)
In-Reply-To: <CAGZ79kYS=XWBpEBJsj95FV+j+HLxg=5xqwD73618t7ERYrKUfA@mail.gmail.com>
References: <OF95D98CB6.47969C1C-ONC1257FE1.0058D980-C1257FE1.0059986D@dakosy.de>
 <xmqqd1n0552i.fsf@gitster.mtv.corp.google.com> <xmqqtwgb52py.fsf@gitster.mtv.corp.google.com>
 <CAGZ79kYS=XWBpEBJsj95FV+j+HLxg=5xqwD73618t7ERYrKUfA@mail.gmail.com>
From:	Junio C Hamano <gitster@pobox.com>
Date:	Wed, 29 Jun 2016 13:43:21 -0700
X-Google-Sender-Auth: zLGDIm_yrcKg11Cwjog6N6T9Q0Y
Message-ID: <CAPc5daURyXO6-yaOWPhvvdS8Dr5psEEc8MVP4wQJ_AuxyZraRg@mail.gmail.com>
Subject: Re: git pull --rebase should use fast forward merge if possible
To:	Stefan Beller <sbeller@google.com>
Cc:	neuling@dakosy.de, "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Wed, Jun 29, 2016 at 1:40 PM, Stefan Beller <sbeller@google.com> wrote:
>> +               merge_head = lookup_commit_reference(merge_heads.sha1[0]);
>
> The crashes for merge_heads.nr == 0.
> (I did not inspect code further up if this is caught before, I think
> it would trigger if
> you and the remote are on an initial commit with no parents?)

Perhaps you can inspect code before you start typing?

die_no_merge_candidates() would have triggered, I would imagine.

Note that I won't be applying this without test updates and proper log message,
so no need to worry about the style yet ;-)
