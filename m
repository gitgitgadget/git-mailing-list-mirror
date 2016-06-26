Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 43ADF20179
	for <e@80x24.org>; Sun, 26 Jun 2016 19:30:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751427AbcFZT36 (ORCPT <rfc822;e@80x24.org>);
	Sun, 26 Jun 2016 15:29:58 -0400
Received: from sub3.mail.dreamhost.com ([69.163.253.7]:55774 "EHLO
	homiemail-a12.g.dreamhost.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751330AbcFZT35 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 26 Jun 2016 15:29:57 -0400
Received: from homiemail-a12.g.dreamhost.com (localhost [127.0.0.1])
	by homiemail-a12.g.dreamhost.com (Postfix) with ESMTP id B13771030063;
	Sun, 26 Jun 2016 12:29:52 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=novalis.org; h=subject:to
	:references:cc:from:message-id:date:mime-version:in-reply-to
	:content-type:content-transfer-encoding; s=novalis.org; bh=unCDL
	ap0/v4LxwZblNx5JZoR6Io=; b=Mg3cD+pKTERMXQ6oNEkpPIWL50ATSs1fSmP9w
	vDvsMbnsveYYvBdzVWD7qkdmi7CKatnEaJ3XeEScG8l/dLMgSe3Avoyhi6W4eOxh
	AYieo4AdRopkX3LbgLh1I5157SHI6EbuioWWoBvPHntuedLei8zcaqShLpNLGsFn
	ue/rMM=
Received: from [10.0.1.180] (207-38-164-98.c3-0.43d-ubr2.qens-43d.ny.cable.rcn.com [207.38.164.98])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: novalis@novalis.org)
	by homiemail-a12.g.dreamhost.com (Postfix) with ESMTPSA id 6F4351030062;
	Sun, 26 Jun 2016 12:29:52 -0700 (PDT)
Subject: Re: [PATCH v12 04/20] index-helper: new daemon for caching index and
 related stuff
To:	Duy Nguyen <pclouds@gmail.com>
References: <1463694357-6503-1-git-send-email-dturner@twopensource.com>
 <1463694357-6503-5-git-send-email-dturner@twopensource.com>
 <CACsJy8CftPGmrKP8Yeok90T9=whzj69bfE3_X6wHyWOEp6vRzg@mail.gmail.com>
 <576ED9A2.8070202@novalis.org>
 <CACsJy8Dqvv-Ty-wG0qkenyvLNLyqVueJmhjiQXnr0zVUGFvDeA@mail.gmail.com>
Cc:	Git Mailing List <git@vger.kernel.org>
From:	David Turner <novalis@novalis.org>
Message-ID: <57702D2F.9080306@novalis.org>
Date:	Sun, 26 Jun 2016 15:29:51 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.8.0
MIME-Version: 1.0
In-Reply-To: <CACsJy8Dqvv-Ty-wG0qkenyvLNLyqVueJmhjiQXnr0zVUGFvDeA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On 06/26/2016 12:27 AM, Duy Nguyen wrote:
> On Sat, Jun 25, 2016 at 9:21 PM, David Turner <novalis@novalis.org> wrote:
>> On 06/25/2016 10:33 AM, Duy Nguyen wrote:
>>>>
>>>> +               /*
>>>> +                * Our connection to the client is blocking since a
>>>> client
>>>> +                * can always be killed by SIGINT or similar.
>>>> +                */
>>>> +               set_socket_blocking_flag(client_fd, 0);
>>>
>>>
>>> Out of curiosity, do we really need this? I thought default behavior
>>> was always blocking (and checked linux kernel, it seemed to agree with
>>> me). Maybe for extra safety because other OSes may default to
>>> something else?
>>
>>
>> Yes -- see this bug report for details:
>> https://bugs.python.org/issue7995
>>
>
> I think we should refer to this issue in the comment block right
> before set_socket_blocking_flag() call. Imagine a year from now, I may
> read the code, decide this code is useless and try to remove it.

Assuming that we do keep this (see Eric Wong's note), I do not think we 
need a comment.  It is documented in the man page for accept[1], and it 
is the reader's responsibility to understand standard POSIX APIs.



[1] "On Linux, the new socket returned by accept()  does  not  inherit 
file status  flags such as O_NONBLOCK and O_ASYNC from the listening 
socket. This behavior differs from the canonical  BSD  sockets 
implementation."


