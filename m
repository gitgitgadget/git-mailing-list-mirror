From: Shawn Pearce <spearce@spearce.org>
Subject: Re: Commit cache to speed up rev-list and merge
Date: Sun, 30 Sep 2012 19:27:56 -0700
Message-ID: <CAJo=hJsGptu8c04XQh0xLmMhz+mxYKAOQfhbjaNK887dY-jAMA@mail.gmail.com>
References: <CAJo=hJtoqYEL5YiKawCt_SsSUqfCeYEQzY8Ntyb91cNfNS1w_Q@mail.gmail.com>
 <CACsJy8APNsDrTH+hUxgcB=MY0eECCGktm6P1feEEpz2427OQqg@mail.gmail.com>
 <CAJo=hJtweVTOUT84U1=ONnjQXz5Rt_sDYD2BjUP9tOQ4HDj6Kg@mail.gmail.com> <CACsJy8BY2DFhgqdwQdm58+rCuwDj8-7xtqUV9S5cbErU36+zPQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git <git@vger.kernel.org>, Colby Ranger <cranger@google.com>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 01 04:28:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TIVkA-0006Hz-Ty
	for gcvg-git-2@plane.gmane.org; Mon, 01 Oct 2012 04:28:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751906Ab2JAC2R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Sep 2012 22:28:17 -0400
Received: from mail-qc0-f174.google.com ([209.85.216.174]:37384 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751709Ab2JAC2R (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Sep 2012 22:28:17 -0400
Received: by qchd3 with SMTP id d3so3319069qch.19
        for <git@vger.kernel.org>; Sun, 30 Sep 2012 19:28:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spearce.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=Ci6qvc7jncHflJYUFUzFB/hargrXaFIPZC9ortqC1IQ=;
        b=PZ6YUy8O2TY4H3mMR9oAwJuIhi75sDabqH84/bXeURc8AsXPn3++PBJPTKH81jEaKg
         PIBYAO57IWLLROKnRMg6JfrSGyMmKorLfbf6LctzhiDSVb1Znn3wRE1OhXIpNi2ux0Ex
         GWNswfF4m/vxC0IfQzyfgG6pxSzkN5O6wPQEc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:x-gm-message-state;
        bh=Ci6qvc7jncHflJYUFUzFB/hargrXaFIPZC9ortqC1IQ=;
        b=V027Pw/b5iJhXCz7QwkA95B0BJz5djXh8GGhL7q4nOcFemshhNVyYm595cXRrlOrVq
         nUDAioEY9Bo7ynmDpz7Q2AXQTNZg6eyNVVNduyVFDsCku+mkzioam4sBELd4qoGGLX2z
         toWjXDcY7TKFQZQKZg2myoa3Jxo0C8GOjk8fZU5fve7V9yFm8qToQO49NfynXVy5zC0N
         UUoQRi1F+gmEZtuGUCaA1OVcmtpU/IKQhYv1U/Yz2yvqQxHaCVF5i+KTRGao00R+f+x1
         fF3k8oCHxeQUKcvesHFJtokjY2/ExIxzqiRowKDVXe2SnpMveUIhopiiljAQT2pbyUEC
         O9XQ==
Received: by 10.229.135.143 with SMTP id n15mr9330619qct.77.1349058496164;
 Sun, 30 Sep 2012 19:28:16 -0700 (PDT)
Received: by 10.49.35.75 with HTTP; Sun, 30 Sep 2012 19:27:56 -0700 (PDT)
In-Reply-To: <CACsJy8BY2DFhgqdwQdm58+rCuwDj8-7xtqUV9S5cbErU36+zPQ@mail.gmail.com>
X-Gm-Message-State: ALoCoQnBoE/PcZ4DyBtg72JDxKsfqP3tRLvpZLuaWFkN7SHraGYVdcCrNcLQeJDXe0Yy8/sOm8M7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206708>

On Sun, Sep 30, 2012 at 7:05 PM, Nguyen Thai Ngoc Duy <pclouds@gmail.com> wrote:
> On Mon, Oct 1, 2012 at 8:49 AM, Shawn Pearce <spearce@spearce.org> wrote:
>> On Thu, Sep 27, 2012 at 7:14 PM, Nguyen Thai Ngoc Duy <pclouds@gmail.com> wrote:
>>> On Thu, Sep 27, 2012 at 10:51 PM, Shawn Pearce <spearce@spearce.org> wrote:
>>>> In Linus' Linux kernel tree there are currently about 323,178 commits.
>>>> If we store just the pre-parsed commit time as an int32 field this is
>>>> an additional 1.2 MiB of data in the pack-*.idx file, assuming we can
>>>> use additional data like pack offset position to correlate commit to
>>>> the parsed int. If we stored parent pointers in a similar way you
>>>> probably need at least 3.6 MiB of additional disk space on the index.
>>>> For example, use 12 bytes for each commit to store enough of the
>>>> parsed commit time to sort commits, and up to 2 parent pointers per
>>>> commit.... with a reserved magic value for octopus merges to mean the
>>>> commit itself has to be parsed to get the graph structure correct.
>>>
>>> This is much better than my naive approach (storing sha-1 and
>>> timestamps). We could use less space by storing parent pointer of
>>> non-merge commits only. Merge commits linux-2.6 is 6% the number of
>>> commits. git.git has higher percentage, 21%. I bet many projects do
>>> not merge as much and the number of merge commits is less than 5%.
>>
>> Some projects merge quite often. Android's frameworks/base repository
>> has a very large number of merges. Out of 79905 commits reachable from
>> the master branch, 65.3% are merges. So actually there are more merge
>> commits in the Android history than there are code commits. A cache of
>> only non-merges may be worthless on such a history.
>
> The good thing about these cache is it's configurable. Merge-preferred
> projects can choose to cache the first two parents. Non-merge projects
> can choose to cache just the first parent. We don't need a fixed
> format for both.

Git has enough magic switches. It doesn't need yet another magic
switch that one group of users needs to set, and another can safely
ignore because their project's usage just happens to align with Linus
Torvald's current world view.
