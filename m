From: Pranit Bauva <pranit.bauva@gmail.com>
Subject: Re: [PATCH v3] bisect--helper: convert a function in shell to C
Date: Thu, 24 Mar 2016 00:08:12 +0530
Message-ID: <CAFZEwPMEFJ=hPj_P_=f4KYBtit0cA9kfACToF1QrE6ZCNTU+3w@mail.gmail.com>
References: <010201539d57ae98-ce4860a6-f7b6-4e06-b556-3c1340cd7749-000000@eu-west-1.amazonses.com>
	<01020153a254974b-68f7d16a-66d7-4dc1-805d-2185ff1b3ebf-000000@eu-west-1.amazonses.com>
	<alpine.DEB.2.20.1603231238180.4690@virtualbox>
	<CAFZEwPPDhK1biRLuXtYeBX5fsQGw==fUOLxSOXVaZPghbJQYGg@mail.gmail.com>
	<xmqqtwjxcgbr.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 23 19:38:29 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ainfn-0004lU-4C
	for gcvg-git-2@plane.gmane.org; Wed, 23 Mar 2016 19:38:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756546AbcCWSiO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Mar 2016 14:38:14 -0400
Received: from mail-yw0-f195.google.com ([209.85.161.195]:36084 "EHLO
	mail-yw0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753908AbcCWSiN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Mar 2016 14:38:13 -0400
Received: by mail-yw0-f195.google.com with SMTP id p65so2713455ywb.3
        for <git@vger.kernel.org>; Wed, 23 Mar 2016 11:38:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=JqoX8mfn25w4/N6Xh2k+TcDrPtVMTgocNgozNFKLup4=;
        b=qQ5bihgdQDBMixTt2JqLT5XumWeU+MOJJx/sBjyHIXnkC/az+X7KyNiLhueGwYX7wk
         YYsi/TW/2g43XzWs2zH+5eMh1Ph+kTxoGaMp/N9BZzjIdK78qOVR/VnklC7pXLalhvfY
         qjVn6fHUFYLhkvSB9cYGdvmLLT6iUykkHtrfGet3igxecwxCJo8sPx1SLFF3WFg/FUpl
         B0ahvBqJ67dLrabC0W5IjyLCpAKAcZknmrXaktW+xAWpo4xKm0l+URW4LHvTPu4HjRu2
         EWid+2bfJocCzldn7+WS0hBVj5JmQ6iftgNDgIu54HhGYQq3WHoPTH8Bt76u3a1JwbBG
         dOcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=JqoX8mfn25w4/N6Xh2k+TcDrPtVMTgocNgozNFKLup4=;
        b=muTRZm1QGat6GmYUP9bx8FPC5TaL5LRo/xbQEBUkmvPWPU15yM8EO65i2ySuzSoHxx
         RyYDd9DHdsIJ3VXhzNFS4rlrVUIg6kfB9SPQDcClk1m7Xr66ahvvsXCDN+s3N0m483Ky
         xGy9U5VgE7ns7TWLIv0F2nC27b6FKDCXRtXI2Ucof0xXG2PSOnA5Oluh0hKu6wgtweXS
         XdcND69LHb2dxNezya23eW9nCepT1loemn9xldz5G1+blKh44/WXOpEEdTIlINKSehO6
         wvzexAJRJ2WoKs0m1GRiJb+OoiEgbHqesH2ReJEpoeHkjiCJoUCz+HwnQHHqkBX3aj95
         K2jQ==
X-Gm-Message-State: AD7BkJI0df9s/rlimHrm0uGFRZ6TG0hJidZTUVnE1RvTf1rZNl9/qf2wbF3npGRwBGvbFqw1xDR7EEQlbK8WUw==
X-Received: by 10.37.1.196 with SMTP id 187mr2247283ybb.53.1458758292306; Wed,
 23 Mar 2016 11:38:12 -0700 (PDT)
Received: by 10.13.203.137 with HTTP; Wed, 23 Mar 2016 11:38:12 -0700 (PDT)
In-Reply-To: <xmqqtwjxcgbr.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289674>

On Wed, Mar 23, 2016 at 9:54 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Pranit Bauva <pranit.bauva@gmail.com> writes:
>
>> On Wed, Mar 23, 2016 at 5:27 PM, Johannes Schindelin
>> <Johannes.Schindelin@gmx.de> wrote:
>>> Hi Pranit,
>>>
>>> On Wed, 23 Mar 2016, Pranit Bauva wrote:
>>>
>>>> Convert the code literally without changing its design even though it
>>>> seems that it is obscure as to the use of comparing revision to different
>>>> bisect arguments which seems like a problem in shell because of the way
>>>> function arguments are handled.
>
> Are you talking about the need to do one_of("help", "start", ...)?
>
> I do not see how that is "problem in shell" or "they way function
> arguments are handled".
>
>     git bisect bad
>     git bisect good
>
> are the ways how you mark the current commit as bad or good, and
> recent change that introduced the "term" thingy allows you to
> replace these "bad" and "good" with your own words, but
>
>     git bisect start
>     git bisect help
>
> etc. have their own meaning, so you cannot say "I call bad state
> 'start' and good state 'help'" without confusing yourself.  You'd
> never be able to start or get help if you did so, and that does not
> have anything to do with "shell" or "function argument" which are
> implementation detail.
>
> You cannot fundamentally allow replacing bad/good with these
> blacklisted words unless you are going to adopt different command
> line syntax (e.g. instead of accepting "git bisect $bad" with a word
> chosen by the end user, use "git bisect mark $bad", and $bad can be
> any word including "start", "visualize", etc.).

Seems like I got confused. Thanks for the clarification. :)
