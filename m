From: Luke Diamand <luke@diamand.org>
Subject: Re: git-p4 out of memory for very large repository
Date: Mon, 02 Sep 2013 20:42:36 +0100
Message-ID: <5224EA2C.7090001@diamand.org>
References: <20130823011245.GA7693@jerec> <52170C6A.4080708@diamand.org> <20130823114856.GA8182@jerec> <20130825155001.GA875@padd.com> <20130826134756.GA1335@jerec> <20130828154135.GA16921@jerec> <20130829224609.GB25879@padd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Corey Thompson <cmtptr@gmail.com>, git@vger.kernel.org
To: Pete Wyckoff <pw@padd.com>
X-From: git-owner@vger.kernel.org Mon Sep 02 21:42:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VGa1M-0002Ev-8W
	for gcvg-git-2@plane.gmane.org; Mon, 02 Sep 2013 21:42:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758923Ab3IBTmk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Sep 2013 15:42:40 -0400
Received: from mail-wg0-f53.google.com ([74.125.82.53]:46587 "EHLO
	mail-wg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757074Ab3IBTmj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Sep 2013 15:42:39 -0400
Received: by mail-wg0-f53.google.com with SMTP id n12so4028822wgh.20
        for <git@vger.kernel.org>; Mon, 02 Sep 2013 12:42:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=oTcUqTZgnC538w1ush6y4An0VfUtIJ3Szfj30jxabKo=;
        b=QyGHhPoOrw9OonmmDg90cbbv+Q5DGxAiDgKfVhKB0cUS32+ftp+MgyDk1o4bvYBe77
         xhoXaSbldoVttVCLBiCz2S+M9O0RU43EOYQcYk1fqM9GNeTlM7e3eAiVL4RAT7n8oew8
         0AC9/a0SvX9P3uNXldvbDjYZFrT4w7rIPnBEw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=oTcUqTZgnC538w1ush6y4An0VfUtIJ3Szfj30jxabKo=;
        b=e48fH22fSGyANN32IxfXByV3z21pN02RU9R8aCtBTZetbUbIKriU8Gzqz8SF6X0BEY
         TDgNMSc/ohWycEKSetc1vmMxk7hytAhC6q1clvKmh5NgpPYr+Ia+jpcPL8cRNPjMzf5M
         65YmCuI+BPz9nNK0EURz3WzMV8y5NtEMxaZ+7ViY5+kUOHhllk31Yc3NI3UdjFI99s4Z
         joReXsQGZ3rbNfCR/6Jfqh9q5lBdCQeVGReCd2Diq2U16WmwDD6lr9GGlg/z4jXEhK9H
         o3MM+UrOUxlWG/6bhClnkjacqG9Ua2QpivEbyb0tCagjSyj67+KGxW6DTvB7GTpeIqOd
         VjgA==
X-Gm-Message-State: ALoCoQkdoHCeqw62kvmOQwzOwK/XGwdb+icJldbVAyaL7M1KtUsWFa8kqTAG7PiL678mXKwaJl3y
X-Received: by 10.180.37.199 with SMTP id a7mr15020019wik.43.1378150958125;
        Mon, 02 Sep 2013 12:42:38 -0700 (PDT)
Received: from [86.14.230.179] (cpc14-cmbg17-2-0-cust690.5-4.cable.virginmedia.com. [86.14.230.179])
        by mx.google.com with ESMTPSA id u8sm20643836wiz.2.1969.12.31.16.00.00
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 02 Sep 2013 12:42:37 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:10.0.12) Gecko/20130116 Icedove/10.0.12
In-Reply-To: <20130829224609.GB25879@padd.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233655>

I guess you could try changing the OOM score for git-fast-import.

change /proc/<pid>/oomadj.

I think a value of -31 would make it very unlikely to be killed.

On 29/08/13 23:46, Pete Wyckoff wrote:
> cmtptr@gmail.com wrote on Wed, 28 Aug 2013 11:41 -0400:
>> On Mon, Aug 26, 2013 at 09:47:56AM -0400, Corey Thompson wrote:
>>> You are correct that git-fast-import is killed by the OOM killer, but I
>>> was unclear about which process was malloc()ing so much memory that the
>>> OOM killer got invoked (as other completely unrelated processes usually
>>> also get killed when this happens).
>>>
>>> Unless there's one gigantic file in one change that gets removed by
>>> another change, I don't think that's the problem; as I mentioned in
>>> another email, the machine has 32GB physical memory and the largest
>>> single file in the current head is only 118MB.  Even if there is a very
>>> large transient file somewhere in the history, I seriously doubt it's
>>> tens of gigabytes in size.
>>>
>>> I have tried watching it with top before, but it takes several hours
>>> before it dies.  I haven't been able to see any explosion of memory
>>> usage, even within the final hour, but I've never caught it just before
>>> it dies, either.  I suspect that whatever the issue is here, it happens
>>> very quickly.
>>>
>>> If I'm unable to get through this today using the incremental p4 sync
>>> method you described, I'll try running a full-blown clone overnight with
>>> top in batch mode writing to a log file to see whether it catches
>>> anything.
>>>
>>> Thanks again,
>>> Corey
>>
>> Unforunately I have not made much progress.  The incremental sync method
>> fails with the output pasted below.  The change I specified is only one
>> change number above where that repo was cloned...
>
> I usually just do "git p4 sync @505859".  The error message below
> crops up when things get confused.  Usually after a previous
> error.  I tend to destroy the repo and try again.  Sorry I don't
> can't explain better what's happening here.  It's not a memory
> issue; it reports only 24 MB used.
>
>> So I tried a 'git p4 rebase' overnight with top running, and as I feared
>> I did not see anything out of the ordinary.  git, git-fast-import, and
>> git-p4 all hovered under 1.5% MEM the entire time, right up until
>> death.  The last entry in my log shows git-fast-import at 0.8%, with git
>> and git-p4 at 0.0% and 0.1%, respectively.  I could try again with a
>> more granular period, but I feel like this method is ultimately a goose
>> chase.
>
> Bizarre.  There is no good explanation why memory usage would go
> up to 32 GB (?) within one top interval (3 sec ?).  My theory
> about one gigantic object is debunked:  you have only the 118 MB
> one.  Perhaps there's some container or process memory limit, as
> Luke guessed, but it's not obvious here.
>
> The other big hammer is "strace".  If you're still interested in
> playing with this, you could do:
>
>      strace -vf -tt -s 200 -o /tmp/strace.out git p4 clone ....
>
> and hours later, see if something suggests itself toward the
> end of that output file.
>
> 		-- Pete
