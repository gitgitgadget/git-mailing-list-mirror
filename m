Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C30EA1F424
	for <e@80x24.org>; Fri, 27 Apr 2018 02:09:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757128AbeD0CJs (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Apr 2018 22:09:48 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:45968 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754298AbeD0CJr (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Apr 2018 22:09:47 -0400
Received: by mail-wr0-f193.google.com with SMTP id p5-v6so241140wre.12
        for <git@vger.kernel.org>; Thu, 26 Apr 2018 19:09:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=0n8qAagVm6Zn3Tznq62xrj0CBDPcKOG5nEwRPt1wdhY=;
        b=r+0C1nxib0ivMJwy1rnc9BWS6eTEtSQViRgOxFB+t9dbAgKtXaASLqDTHYftzF56x5
         wPPGjdi2m24m6fJK19OGoMgasFJO23Xx90TzaHdGhaJEN5qR8Rm0CaQoMIJA8QCAXJ8W
         +UWeMFnq9SmCLkGk16t73aRBqPB6isBZYujT5btsRDLppNnFsFmHk+Ux/3qIm+J9y3FY
         a7bcKkfwahoytSTH+IUFf/Xsd00uZvkBYlszqugWH2d3H/t5ZCm2A8Xetmrg2La5n7sp
         f4G4Qgf/zezkN8XLrZapl9gr/3n/iwIfa7FY3oYGH4OPdQcQTOzfm+hAypsy+QYfh6U/
         SFvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=0n8qAagVm6Zn3Tznq62xrj0CBDPcKOG5nEwRPt1wdhY=;
        b=WxxL/z0c2WT30cZRhQpfANjIH9Tzz6v+qQ9fsA8y8blDEyvGpALXCwjCXA4AcVOYfA
         WN75FjT1+HTS27fE3VGKG7kuLZptEDWiCAIrXejaNfrMlR6WMm347Y2untg3djWWRNTc
         8kazolZ5f8hmmuqCoyVRToRFJoS02sJSQBYtMQgg38QBiHU90XzOMxW7tPf61kWrGF0h
         z1d5Jpq+vAItHu0GzDP14U3PMWL6/GmsKsLAVsfgLwRaeFpDIWRV7HFSBaZdPU6U/QiT
         oOc8cwubH+3tWSJUw1Nfc3/tlJlYPSSzres+1OpaQha0CmXOz6cefQe8KDH7ScCROT70
         kXEg==
X-Gm-Message-State: ALQs6tCiUoXAyjJKZl2O4nVC+JybHIXZ7DuLLy/6eEKRIT3BLTjv2ebN
        mmwijbgc/YSYSoGqchxWYJo=
X-Google-Smtp-Source: AB8JxZptej3LaeaQRn6YjHgyf5C/zIZ7lwTC13p6eI74q+lQ2zOSQUN/5FNMojLiFAefOlzlWZsS+Q==
X-Received: by 2002:adf:be83:: with SMTP id i3-v6mr251926wrh.166.1524794985604;
        Thu, 26 Apr 2018 19:09:45 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id d9sm30095wmh.38.2018.04.26.19.09.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 26 Apr 2018 19:09:44 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Isabella Stephens <istephens@atlassian.com>
Cc:     sunshine@sunshineco.com, szeder.dev@gmail.com, git@vger.kernel.org,
        peff@peff.net, bturner@atlassian.com, jacob.keller@gmail.com
Subject: Re: [PATCH v4 1/2] blame: prevent error if range ends past end of file
References: <CAPig+cSH-y7ChDE_LW55M_wB=KhD7uJHXX=OvZ=1ri5KfYQ5Sg@mail.gmail.com>
        <20180426074502.78318-1-istephens@atlassian.com>
        <20180426074502.78318-2-istephens@atlassian.com>
        <xmqq7eot1nhl.fsf@gitster-ct.c.googlers.com>
        <25cd86ff-a5c0-a968-62d2-4365e5e17a81@atlassian.com>
Date:   Fri, 27 Apr 2018 11:09:44 +0900
In-Reply-To: <25cd86ff-a5c0-a968-62d2-4365e5e17a81@atlassian.com> (Isabella
        Stephens's message of "Fri, 27 Apr 2018 11:42:45 +1000")
Message-ID: <xmqq36zh1jtj.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Isabella Stephens <istephens@atlassian.com> writes:

> On 27/4/18 10:50 am, Junio C Hamano wrote:
>> istephens@atlassian.com writes:
>> 
>>> diff --git a/line-range.c b/line-range.c
>>> index 323399d16..023aee1f5 100644
>>> --- a/line-range.c
>>> +++ b/line-range.c
>>> @@ -47,7 +47,7 @@ static const char *parse_loc(const char *spec, nth_line_fn_t nth_line,
>>>  			else if (!num)
>>>  				*ret = begin;
>>>  			else
>>> -				*ret = begin + num;
>>> +				*ret = begin + num ? begin + num : -1;
>> 
>> When parsing "-L<something>,-20" to grab some lines before the line
>> specified by <something>, if that something happens to be line #20,
>> this gives -1 to *ret.  If it is line #19, *ret becomes -1, and if
>> it is line #18 or before, *ret becomes -2, -3, ...
>> 
>> Is that what we really want here?  It is disturbing that only line
>> #19 and #20 are treated identically in the above example.  If it
>> were "if going backwards by -num lines from begin goes beyond the
>> beginning of the file, clip it to the first line", I would
>> understand it, but as written, I am not sure what the code is trying
>> to do.
>> 

[administrivia] Do not top-post, but cull the context to leave
enough to remind readers what the discussion was about.

> My intention was to modify existing behaviour as little as possible,
> but I agree clipping to the first line makes a lot more sense. That
> raises the question though, do we clip to 1 and treat -L,-n as a valid
> input, or clip to -1 so that this case be detected?

Maybe I misread the previous discussion and/or your cover letter,
but I have been assuming that you are trying to avoid failing the
command in a useless way (e.g. when the file has only ~800 lines but
the user does not know exactly how many, instead of letting -L1,820 
to fail with "the file only has 815 lines", pretend that the -L1,815
was given) and instead give a reasonable fall-back behaviour.

And to be consistent with that world view, I would have expected
that the meaning of -L<something>,-20 to be updated from "fail if
<something> is before line #20, or show 20 lines leading to
<something>" to "show lines leading to <something>, up to 20 lines
but it is OK if there aren't enough lines in the file to show that
many".

So the answer to the question probably depends on what happens when
"this case is detected" by returning -1 from here.  Do we detect and
fail?  That would defeat the overall theme of these patches.  Do we
detct and warn but continue?  That may be sensible in theory, but in
practice, especially where this "the users may not know how many
lines exactly the blob has, so do not force them to count" matters,
"blame" and "log" would show a lot of output that is sent to the
pager, so the warning message may not be shown in a noticeable way.
Compared to that, "pretend as if the first line was specified and go
on" looks like we have one fewer thing to worry about ;-)


