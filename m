From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH v2 0/8] Fix atomicity and avoid fd exhaustion in ref transactions
Date: Tue, 12 May 2015 15:26:50 +0200
Message-ID: <CAP8UFD2QcbTPmhpjbgE1g6PD5J1xWBv8bpDggH0+niXO-w3UwA@mail.gmail.com>
References: <1431225937-10456-1-git-send-email-mhagger@alum.mit.edu>
	<xmqqr3qng2h4.fsf@gitster.dls.corp.google.com>
	<555051C9.7040204@alum.mit.edu>
	<CAGZ79kbkfp-nZUqK3nO7hmdL4C+RaTREBTHbkjUtVxFgOeozOQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	Eric Sunshine <sunshine@sunshineco.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Tue May 12 15:27:01 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YsAD4-0005xz-Rl
	for gcvg-git-2@plane.gmane.org; Tue, 12 May 2015 15:26:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933199AbbELN0y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 May 2015 09:26:54 -0400
Received: from mail-wi0-f172.google.com ([209.85.212.172]:35245 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932892AbbELN0w (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 May 2015 09:26:52 -0400
Received: by widdi4 with SMTP id di4so153638817wid.0
        for <git@vger.kernel.org>; Tue, 12 May 2015 06:26:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=h6vDJp4k2a475LKNwHnsGwuxvSc+IM98FPFSA0zgk24=;
        b=Eufk+b1ZEbNnEwUgUE4e/fUYrBDEguDIVsMjSGMDpnQArTgVe6cFjXhoijgAuw0p7S
         xtX/aUnr6V4IikN2uMdEdRVY4FjIeFb0A2WAUfxueY6M0yyT7qqAS0gskLhez4sQ1K3n
         HQI7Cd2JWhTy6ip1obKduWkuSC952kTFYqapajSKHrIOAPPklLMEeQxwFswL3AQxWmsG
         q2PThtYNz5/P/y4iIV/YYxtl0R9/hpYw2KGPxRoVIGC5B4yvw0nKWrkuZ10QnYsQL3l/
         Eawobg+d50W9tTY8zK5Ee/MUNG14VOttrb0MlVyeJirn+ffDT9tVvoBcIm75Euhtcrk1
         ZjyQ==
X-Received: by 10.180.88.99 with SMTP id bf3mr29942393wib.75.1431437210925;
 Tue, 12 May 2015 06:26:50 -0700 (PDT)
Received: by 10.194.40.8 with HTTP; Tue, 12 May 2015 06:26:50 -0700 (PDT)
In-Reply-To: <CAGZ79kbkfp-nZUqK3nO7hmdL4C+RaTREBTHbkjUtVxFgOeozOQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268853>

On Mon, May 11, 2015 at 7:10 PM, Stefan Beller <sbeller@google.com> wrote:
> On Sun, May 10, 2015 at 11:52 PM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
>> This is exactly the kind of case that "rebase with history" [1] was
>> meant to address. But given that our tooling doesn't support such
>> complicated histories very well, your plan sounds reasonable.
>
> As a side note to your blog post unrelated to the current series:
>
> I think the new proposed history for "rebase-by-merging-a-patch-at-a-time" also
> improves bisectability because you have less long running side branches
> (as compared to both in traditional rebase and traditional merge), but a finer
> meshed DAG where it is easier to split the commit range into half its size.
> When going back one step in history you have more merge nodes where
> bisect can decide how many commits to chop off of the new range.

Yeah, this was discussed at the Git Merge 2013 in Berlin, where
Michael gave two presentations (one on the developer day and one on
the user day) about git-imerge. We also discussed the idea of using a
replace ref to be able to switch between different "views" of the
merge, for example one view where you see only one commit for the
whole merge/rebase with history, and one view where you see all the
micro merge commits.

Best,
Christian.
