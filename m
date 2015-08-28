From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 7/9] fetch: fetch submodules in parallel
Date: Fri, 28 Aug 2015 11:36:25 -0700
Message-ID: <CAGZ79kbJEK=xD1=j3ZaiyRHUQNS_ryTT2zqatO5u=BVRH7YHJw@mail.gmail.com>
References: <1440724495-708-1-git-send-email-sbeller@google.com>
	<1440724495-708-8-git-send-email-sbeller@google.com>
	<CAGZ79kbTAVDVmw+MrXvky6tJWZcG97tT_KAxV7S-pKCiNqRp3g@mail.gmail.com>
	<20150828170141.GB8165@google.com>
	<xmqqfv332v84.fsf@gitster.mtv.corp.google.com>
	<20150828182008.GC8165@google.com>
	<xmqqpp271d6v.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Jeff King <peff@peff.net>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 28 20:36:32 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZVOVr-0000MG-7G
	for gcvg-git-2@plane.gmane.org; Fri, 28 Aug 2015 20:36:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752639AbbH1Sg1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Aug 2015 14:36:27 -0400
Received: from mail-yk0-f180.google.com ([209.85.160.180]:34358 "EHLO
	mail-yk0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751872AbbH1Sg0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Aug 2015 14:36:26 -0400
Received: by ykba134 with SMTP id a134so11146368ykb.1
        for <git@vger.kernel.org>; Fri, 28 Aug 2015 11:36:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=wSNMtX59iBzsifBzH6nwGsKX0zZtBW9yvncvS8a7NBQ=;
        b=ljOl0Hdy9RUa0v6mFTSd9GKJJpQFYe6s9LWUaEYpD7xTDJ1jLtNH9F6MZdWGeUxhMK
         /Jtjbor96WikGDX+wiM3uGRPOyG54bhJQ//WuV1wEd89IN8mU9Lu8E+1kynho6Jn/R38
         iv+f5RGAZOsxx21gt1KJg7o+T52J831nJZBBiMBXDoB22opg3iLmnjqtLiOJ752MzmPf
         pqBAWNcWQI0cnMKn0SBn/Z/RQmusr1s8pzoz1mAPvRuvd+lwK8VQrARaut24QmAwnWft
         TIW4cVgTot5GKa0R5Dupl0vXDmPNIe8Rl8sZSWUwHPmqu/zBQqWBoj/G9ZmEM764d7o3
         SYtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=wSNMtX59iBzsifBzH6nwGsKX0zZtBW9yvncvS8a7NBQ=;
        b=FLHMMr9VYjURrWeCDfz3BAdlr5L8K93kYE9DRenQzWuHp1k6VaBIQ/P91jaBESmgwH
         IpkNnTAmvTrDLsX9409T9hQn6gME9h8Uy6e8xd9bTc6ParVdHBHhpGUA9v/mihKq8kBn
         IM4BULSxRXorQwpsmd3AKWpuQ38hHj4aQz5dzV9d233y9jR7BT1CnLoufzlqp6g81o1E
         BUOFAd+b8L5HZFNCS2ma1R/nknH0aGUIiolobcRXt79YE++xqgWo+4YgU5C2slzygQDK
         JTufXWGOeSdhYZUinLjLzkzT7tmoXTMbyh8ELMdFNNq4+AUXuLT3vEPaCIXV1dZUC63C
         0ibg==
X-Gm-Message-State: ALoCoQnwvxoNewtAupjPRJd7dsT90JeLlxvgvsp9mxPwnmxVgFZN2ThxAY1tfQFbimj4HdQ90zY8
X-Received: by 10.129.116.138 with SMTP id p132mr10159307ywc.1.1440786985995;
 Fri, 28 Aug 2015 11:36:25 -0700 (PDT)
Received: by 10.37.21.132 with HTTP; Fri, 28 Aug 2015 11:36:25 -0700 (PDT)
In-Reply-To: <xmqqpp271d6v.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276747>

On Fri, Aug 28, 2015 at 11:27 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Jonathan Nieder <jrnieder@gmail.com> writes:
>
>> Junio C Hamano wrote:
>>
>>> My preference is still (1) leave standard error output all connected
>>> to the same fd without multiplexing, and (2) line buffer standard
>>> output so that the output is at least readable as a text, in a
>>> similar way a log of an irc channel where everybody is talking at
>>> the same time.
>>
>> There is something nice about the immediacy of seeing output from all
>> the subprocesses at the same time in that model.
>>
>> But for commands that show progress like "git clone", "git checkout",
>> and "git fetch", it does not work well at all.  They provide output
>> that updates itself by putting a carriage return at the end of each
>> chunk of output, like this:
>>
>>  remote: Finding sources:  11% (18/155)           \r
>>  remote: Finding sources:  12% (19/155)           \r
>>
>> With multiple commands producing such output, they will overwrite each
>> other's lines, producing a mixture that is confusing and unuseful.
>
> That example also illustrates why it is not a useful to buffer all
> of these lines and showing them once.
>
>> Ideally what I as a user want to see is something like what "prove"
>> writes, showing progress on the multiple tasks that are taking place
>> at once:
>>
>>  ===(     103;1  0/?  8/?  3/?  11/?  6/?  16/?  1/?  1/? )==============
>
> Tell me how that "buffer all and show them once" helps us to get
> near that ideal.

It doesn't, but it looks better than the irc like everybody speaks at
the same time
solution IMHO.

At the very the user may not even be interested in the details similar
to what prove
provides. The client can estimate its own total progress by weighting
the progress
from all tasks.

>
>> That would require more sophisticated inter-process communication than
>> seems necessary for the first version of parallel "git submodule
>> update".
>
> Exactly.  Why waste memory to buffer and stall the entire output
> from other processes in the interim solution, then?
>
>
