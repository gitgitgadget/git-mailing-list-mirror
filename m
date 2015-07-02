From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [RFC/PATCH] worktree: replace "checkout --to" with "worktree new"
Date: Thu, 2 Jul 2015 08:07:08 +0700
Message-ID: <CACsJy8BdvLiM8Ki=N1k-fBrqqoEONhjwcN6jzGUk=3NPRRujQw@mail.gmail.com>
References: <1435640202-95945-1-git-send-email-sunshine@sunshineco.com>
 <xmqqr3orakex.fsf@gitster.dls.corp.google.com> <CAPig+cRLpJK-C7MApH1vigZS=gmHNeo6RL3S2wXv4B-TFfnq4g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Thu Jul 02 03:07:44 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZASye-0003Mr-0P
	for gcvg-git-2@plane.gmane.org; Thu, 02 Jul 2015 03:07:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753020AbbGBBHk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Jul 2015 21:07:40 -0400
Received: from mail-ie0-f182.google.com ([209.85.223.182]:36687 "EHLO
	mail-ie0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752416AbbGBBHi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Jul 2015 21:07:38 -0400
Received: by iecvh10 with SMTP id vh10so46601065iec.3
        for <git@vger.kernel.org>; Wed, 01 Jul 2015 18:07:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=WQo8CloSBLssekvxHVnDMBzRwKS8MaRUsJ6WCX1YOdM=;
        b=IWFMqfHcd88U0Umy87/p1v3U6m0tpyBtE82NPWL0ikXAymw7/Pz4/ApR+fq0OA+9yT
         YH5pHNJJpqtJhF+ctcU7fXBw7JUpzIFRRHnYdhesIvlBtYP3lb7xx4gRhoF03ikdXuMO
         GIC6KbmqQ8pOImV4t2l9RA2kqLge6N13EdDziup8pQdJJH15/nkKT2ZR4CLtTux6L799
         W+CMCUr6HxxJdtErlCWb47vOjRZMgFfHeuCPvuWQGYX1tcFfkEkpLQax0m0ADPqNu7rp
         LhqsvH3OO3T2BI6XeXhUb//DlhS3YCaAuLCIJxEvYBJBlGHaCPuTTvh9c+T1dwqlIuWD
         2Sow==
X-Received: by 10.42.93.17 with SMTP id v17mr8365244icm.42.1435799257884; Wed,
 01 Jul 2015 18:07:37 -0700 (PDT)
Received: by 10.107.16.15 with HTTP; Wed, 1 Jul 2015 18:07:08 -0700 (PDT)
In-Reply-To: <CAPig+cRLpJK-C7MApH1vigZS=gmHNeo6RL3S2wXv4B-TFfnq4g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273209>

On Thu, Jul 2, 2015 at 12:13 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
>>    I noticed GIT_CHECKOUT_NEW_WORKTREE environment variabl that does
>>    not seem to be documented.  Is this something we still need?
>>    The log message of 529fef20 (checkout: support checking out into
>>    a new working directory, 2014-11-30) does not tell us much.
>
> Yes, it's still used for the same purpose as before the conversion: as
> a private signal to the sub git-checkout invocation that it's
> operating on a new worktree. When defined, it sets the
> 'new_worktree_mode' flag in checkout.c, and there are still a few bits
> of code which apparently need to know about it. It would be nice to
> eliminate this special knowledge from checkout.c, however, I'm not yet
> familiar enough with the checkout code to determine if doing so is
> viable.

I think it can go away. When "--to" is used, I have to re-execute "git
checkout" command again after creating the new worktree. I could
process the command line arguments from the first execution, delete
"--to", then use the remaining options to run checkout the second
time. But I chose to pass the entire command line to the second
execution. The env is used to let the second run know it should ignore
"--to" (or we get infinite recursion). With "git worktree add" this
recursion disappears and this env var has no reason to exist.
-- 
Duy
