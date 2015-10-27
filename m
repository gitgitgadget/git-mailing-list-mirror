From: David Turner <dturner@twopensource.com>
Subject: Re: Watchman/inotify support and other ways to speed up git status
Date: Tue, 27 Oct 2015 19:54:49 -0400
Organization: Twitter
Message-ID: <1445990089.8302.27.camel@twopensource.com>
References: <CAP8UFD3Cd9SOh6EYwcx9hTVv7P24M5bEJRCYCT5Qgj=qPRJ8hw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	=?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 28 00:54:59 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZrE4v-0008BQ-Jz
	for gcvg-git-2@plane.gmane.org; Wed, 28 Oct 2015 00:54:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753617AbbJ0Xyx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Oct 2015 19:54:53 -0400
Received: from mail-qg0-f50.google.com ([209.85.192.50]:34237 "EHLO
	mail-qg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751824AbbJ0Xyw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Oct 2015 19:54:52 -0400
Received: by qgem9 with SMTP id m9so159294365qge.1
        for <git@vger.kernel.org>; Tue, 27 Oct 2015 16:54:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource_com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :organization:content-type:mime-version:content-transfer-encoding;
        bh=pW1SmdA5I+4r25XsIfiIXDxKNf//pPwbKABvI80tRRU=;
        b=pApK33THiXHbnoPS7FvVRLHsRVpkVzHNNHfFLyo4qrYsMSGNoBNp+M57HZ0nqHiL04
         go2/CYlg9CNpWAtPGBg3FfVDIHemE1nqsmjh55nV+7Fuw/N9nn1L0PH94Cap3cTCxKgy
         Rt4AMuPj6gkoMRiGc2BHvf4toXSxi92l6Ko5DqNTX0TdUscGqzVQLTgeP9Rq0NP3u4W4
         yNrwX/wgSWdGF/Y88apB/m18hKGapaTNa20nTOA5QCAuHg0oLbvqlw0dLT6cyDOYAI00
         4zYq/8fCzWLn+SV4m7vg7NbzOxiUOXi87+X+R1+VaRxLr0iyhq6jlbMcqvjNUTqHZzzg
         5pnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:content-type:mime-version
         :content-transfer-encoding;
        bh=pW1SmdA5I+4r25XsIfiIXDxKNf//pPwbKABvI80tRRU=;
        b=EWM/8pBI2DxJmtMDUycUnQwmKLMbU3fTst1BbRO5yqccN1Hp2MCQa33S0a9XhFrcgt
         lkfk987iJO5elaIf+ZcLw0HUrKE4kzp/rkVMn/+EL9SSvY+cii/vO7uJ921OJEqU9dj+
         4PenelnXIbo7fU2Zej0Cado2X7839BlU+6khIf+X64Ee2PrMBZ38fyMKmlu4xJfGoNy1
         mPZiJp7UBkS47rnjpGvOPcTlULUiDoKVw1+BkiVVBX8PfBGHeGu3X9RgOqYFRlR2nuaL
         U94FgDR0wJ8iTdxKPPL+/t7obSL2r3is6FcVqNtgqUhbIgmT5b92y/EBPgPGhxsZ2dnm
         7M2w==
X-Gm-Message-State: ALoCoQmP7Z7IJEn43bCnXKcWej3Tk7eNK7jCpxqJ57olHpTBCBdZIbJ1dJGTnGeh72LBr7iUQ9jJ
X-Received: by 10.140.23.47 with SMTP id 44mr43933727qgo.42.1445990092006;
        Tue, 27 Oct 2015 16:54:52 -0700 (PDT)
Received: from ubuntu ([8.25.196.25])
        by smtp.gmail.com with ESMTPSA id j94sm16105124qge.27.2015.10.27.16.54.50
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Oct 2015 16:54:50 -0700 (PDT)
In-Reply-To: <CAP8UFD3Cd9SOh6EYwcx9hTVv7P24M5bEJRCYCT5Qgj=qPRJ8hw@mail.gmail.com>
X-Mailer: Evolution 3.12.11-0ubuntu3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280320>


On Thu, 2015-10-22 at 07:59 +0200, Christian Couder wrote:
> Hi everyone,
> 
> I am starting to investigate ways to speed up git status and other git
> commands for Booking.com (thanks to AEvar) and I'd be happy to discuss
> the current status or be pointed to relevant documentation or mailing
> list threads.
> 
> From the threads below ([0], [1], [2], [3], [4], [5], [6], [7], [8]) I
> understand that the status is roughly the following:
> 
> - instead of working on inotify support it's better to work on using a
> cross platform tool like Watchman
> 
> - instead of working on Watchman support it is better to work first on
> caching information in the index
> 
> - git update-index --untracked-cache has been developed by Duy and
> others and merged to master in May 2015 to cache untracked status in
> the index; it is still considered experimental
> 
> - git index-helper has been worked on by Duy but its status is not
> clear (at least to me)
> 
> Is that correct?
> What are the possible/planned next steps in this area? improving

We're using Watchman at Twitter.  A week or two ago posted a dump of our
code to github, but I would advise waiting a day or two to use it, as
I'm about to pull a large number of bugfixes into it (I'll update this
thread and provide a link once I do so).  

It's good, but it's not great.  One major problem is a bug on OS X[1]
that causes missed updates.  Another is that wide changes end up being
quite inefficient when querying watchman.  This means that we do some
hackery to manually update the fs_cache during various large git
operations.

I agree that in general it would be better to store or all some of this
information in the index, and the untracked-cache is a good step on
that. But with it enabled and watchman disabled, there still appears to
be 1 lstat per file (plus one stat per dir).  The stats per-directory
alone are a large issue for Twitter because we have a relatively deep
and bushy directory structure (an average dir has about 3 or 4 entries
in it).  As a result, git status with watchman is almost twice as fast
as with the untracked cache (on my particular machine).


[1] https://github.com/facebook/watchman/issues/172
