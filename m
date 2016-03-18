From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 3/2] dir.c: fix dir re-inclusion rules with "NODIR" and "MUSTBEDIR"
Date: Fri, 18 Mar 2016 12:40:09 +0700
Message-ID: <CACsJy8A2FKn-8nWtK4QPMHDCDYvTZBrQs1RVMApnuejXQis19g@mail.gmail.com>
References: <1458218744-15810-2-git-send-email-pclouds@gmail.com>
 <1458219254-16343-1-git-send-email-pclouds@gmail.com> <xmqqfuvoy89q.fsf@gitster.mtv.corp.google.com>
 <56EB8961.70302@fb.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	Mateusz Jakub Kwapich <mitrandir@fb.com>
To: Durham Goode <durham@fb.com>
X-From: git-owner@vger.kernel.org Fri Mar 18 06:41:10 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1agn9p-0007wr-4n
	for gcvg-git-2@plane.gmane.org; Fri, 18 Mar 2016 06:41:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753367AbcCRFlF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Mar 2016 01:41:05 -0400
Received: from mail-lf0-f48.google.com ([209.85.215.48]:36074 "EHLO
	mail-lf0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753305AbcCRFkl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Mar 2016 01:40:41 -0400
Received: by mail-lf0-f48.google.com with SMTP id d82so11180803lfe.3
        for <git@vger.kernel.org>; Thu, 17 Mar 2016 22:40:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=RCQ2PUsn8ONy9YMShZlBrzWJ7KYoB6+x+GoX7MSr5Zg=;
        b=WjzStrLoBhWP4VY+Cg+LLJPS6sdmOLI2iNSYByOnN35kjvDqWG9GCUhmO5zOR8TX6p
         nBSJ4vggRSB04lh3W9EGhRGacvQROTvnSd7f7GaAP8xXAA92lYlG7uUPBLXxAQ34sFhe
         dOydX9QGhMt5NOgQAO9rTQie8s6ByfQwMkvUQHkx06OKijgwkK4HS5fSgrZlohdeVVvT
         EDQmdoQHSNrgvsQipATNbLbXSUzA9YfI1ogog7AndYhvadsIo1AOgkMbfyuO5RacdasF
         Vw537dW1/O1/WKtI9Sc2d1ASUnmRTMpP/Q/KTBtKAR26sl06MWBdEpFXIzCdNn3lSVlx
         eWaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=RCQ2PUsn8ONy9YMShZlBrzWJ7KYoB6+x+GoX7MSr5Zg=;
        b=dEdE/rJ/jzXhXPAy/n/a4bfTQw/Zzo7jmr405O59fAreLL6xZYhkMhOximatb5tK6l
         FMzVPgwSXFAGPHmTPv6O7Lr3YBbsfTIQejqrRutLHzcO92ipPZwZ/g+5ICb6psjpGCps
         /n0UWfBlGGqx+xITyWzFjhNZJyvehLk73BWYjt5DRkrNsuVo9AHJhRzRx5aXwn9FbLGI
         oiF17Hfc0QVIijjkUHPrZ9oF75jBwx8AwfeeArTLLXVJCEoEg501CXZKvzxHqN5RKXi2
         IvwGHazeOQypfp2d2Z18z8HjacGCp6x/fuBXrdoafCfSaLjx632rZuGpcri2nL/xb835
         Qlqg==
X-Gm-Message-State: AD7BkJJjMt3z0TuCN+5mV2Tov+xybhp+tf1oOAecO0OsU1W2mOI4bnpwpnb0D4cFS27KftKqjUtGUPDX9GFnWw==
X-Received: by 10.25.147.202 with SMTP id v193mr5114434lfd.162.1458279639296;
 Thu, 17 Mar 2016 22:40:39 -0700 (PDT)
Received: by 10.112.167.10 with HTTP; Thu, 17 Mar 2016 22:40:09 -0700 (PDT)
In-Reply-To: <56EB8961.70302@fb.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289194>

On Fri, Mar 18, 2016 at 11:51 AM, Durham Goode <durham@fb.com> wrote:
> On 3/17/16 4:49 PM, Junio C Hamano wrote:
>>
>> Thanks for these 5 patches, two of which need to be discarded ;-).
>> I think you can pick either one of 1/2, pick the one that says
>> "non-NULL" (as opposed to "something") in the log message for 2/2.
>>
>> Durham, does it fix your issues if you apply the 1/2 and 2/2 (but
>> not 3/2) on top of 2.8-rc?
>>
>> Duy, how comfortable are you with the idea of including this two in
>> 2.8 final?  We have long passed the final -rc, and while it is
>> probably OK to prolong the cycle and do another -rc, we cannot keep
>> going like "oops, there is another thing discovered by somebod new"
>> forever.
>>
>> Thanks.
>
> Patches 1+2 fix the repro steps in the report, yes.  But I've found another
> case that produces different results in 2.8 than in 2.7:
>
> Given a repo with files:
>
> dir1/dir2/show/file
> dir1/dir2/hide/file
>
> and a sparse-checkout of
>
> /*
> /dir1/dir2/show
> !/dir1/dir2/

I would say this is "undefined behavior" patterns. The intention of
"!" pattern is to revert a subset of a matched pattern, e.g.
!/dir1/dir2/show/something. Combining lines 2 and 3 together,
"!dir1/dir2/" is not only supposed to revert dir1/dir2/show entirely,
but extend the reversion outside of it. At least to me that's not
intended.

Skipping that tricky pair, the pairs "/*" and "!/dir1/dir2/" means
"exclude everything except dir1/dir2" (in .gitignore sense) or
"include everything except dir1/dir2" in sparse checkout sense. Which
results in empty worktree. 1+2 trips when the trailing slash in the
last rule exists and includes both files in show/hide. Patch 3/2 fixes
the tripping and exclude both. If the last rule is "!/dir1/dir2" then
1+2 results in empty worktree as well.

If I swap the last two rules, then it behaves the way we expect,
dir1/dir2/show stays, dir1/dir2/hide is gone (again, the trailing "/"
in !dir1/dir2/ requires patch 3/2).

v2.7.3 differs in the way "!" is handled. It does extend reversion
outside dir1/dir2/show, back to dir1/dir2. While 2.8+1+2 recognizes
and follows the "/*" and "!dir1/dir2/" pair.

The way I interpreted the rules above, though, may be because I'm just
trying to defend the current code. Junio, your call on whether to
revert this whole patch series.

> the working copy still contains dir1/dir2/hide/file when run from 2.8.0-rc2.
> In git 2.6 and 2.7.3 it does not show up (which is the expected behavior,
> from what I understand of the docs).  Repro script is below.  Notice, the
> 'dir2/' part of the paths is important.  If I drop that directory, the issue
> doesn't repro.
-- 
Duy
