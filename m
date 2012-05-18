From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] rebase -i: avoid checking out $branch when possible
Date: Fri, 18 May 2012 08:25:45 -0700
Message-ID: <xmqqaa154ikm.fsf@junio.mtv.corp.google.com>
References: <fee3225e29915e1b61e29a5d2fe37db20fa4b596.1334933837.git.trast@student.ethz.ch>
	<xmqqwr5atn89.fsf@junio.mtv.corp.google.com>
	<87lilqjstf.fsf@thomas.inf.ethz.ch>
	<xmqqmx66mamc.fsf@junio.mtv.corp.google.com>
	<CANMpiOQPefL_FNocLJ=pZyAb1hZ7bEvLk6frU3xme6VQrSDD2A@mail.gmail.com>
	<7vwr4de5j8.fsf@alter.siamese.dyndns.org>
	<87obplhp12.fsf@thomas.inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Shezan Baig <shezbaig.wk@gmail.com>,
	Thomas Rast <trast@student.ethz.ch>, <git@vger.kernel.org>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
To: Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Fri May 18 17:25:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SVP3y-0006Dj-Ft
	for gcvg-git-2@plane.gmane.org; Fri, 18 May 2012 17:25:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755140Ab2ERPZt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 May 2012 11:25:49 -0400
Received: from mail-vb0-f74.google.com ([209.85.212.74]:57274 "EHLO
	mail-vb0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753599Ab2ERPZr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 May 2012 11:25:47 -0400
Received: by vbnl22 with SMTP id l22so377057vbn.1
        for <git@vger.kernel.org>; Fri, 18 May 2012 08:25:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type:x-gm-message-state;
        bh=1vmXI7Gv2jr5LNdecgrcty5JyTps8JjMF7L34k7W0qY=;
        b=I158oyEWCGQOGhl3vKN03BkXsPuDHE50vYMxQUof4TjB0LNUq1MG9UwF2I38LgbO8t
         ym7sj7jXc4R5kJFFYsb9UQoFSRiByu1DNFI7wjflfKUIKItPrW6FaobXDXCEqQZgbyUW
         d4wanxXbUXQ398YW1edtaY4JZme82L+H1Lv9sL94HZ4YnvZaMK95MXIr1qLh0khzhPYI
         UOZ0nr2PADuFyOBw3g+/ABL/1DGTPb1XyO42Fe8paTPnz/EFney/5odHkwX5Jdk9/yLG
         YhB+zcITAq8hArT3ZIB21093+zQiQJse6/zldXI2PYHkus5Ec718+qt6QGwtYeYLsvnD
         d2fQ==
Received: by 10.236.190.227 with SMTP id e63mr9985926yhn.3.1337354746227;
        Fri, 18 May 2012 08:25:46 -0700 (PDT)
Received: by 10.236.190.227 with SMTP id e63mr9985909yhn.3.1337354746157;
        Fri, 18 May 2012 08:25:46 -0700 (PDT)
Received: from wpzn3.hot.corp.google.com (216-239-44-65.google.com [216.239.44.65])
        by gmr-mx.google.com with ESMTPS id b8si8129682yhn.6.2012.05.18.08.25.46
        (version=TLSv1/SSLv3 cipher=AES128-SHA);
        Fri, 18 May 2012 08:25:46 -0700 (PDT)
Received: from junio.mtv.corp.google.com (junio.mtv.corp.google.com [172.27.69.24])
	by wpzn3.hot.corp.google.com (Postfix) with ESMTP id 118FB1000AD;
	Fri, 18 May 2012 08:25:46 -0700 (PDT)
Received: by junio.mtv.corp.google.com (Postfix, from userid 110493)
	id A64D4E1772; Fri, 18 May 2012 08:25:45 -0700 (PDT)
In-Reply-To: <87obplhp12.fsf@thomas.inf.ethz.ch> (Thomas Rast's message of
	"Fri, 18 May 2012 10:27:53 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1 (gnu/linux)
X-Gm-Message-State: ALoCoQkiAd6N54+j1Ut1Uqk/9X41Qzo7AuyYrHN2EyG/GrcN5ROc/PE/fYY16PrxcwjY4bSFPwOBa1pkSb/oBnEd3WU8dxLhyxqnepGJeACd0R49EaAAwNODFqY01T0bEwep1/JUW2SadljizZ0Yv8gOq/npIn/7Fg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197957>

Thomas Rast <trast@inf.ethz.ch> writes:

>>  - The user told us not to do the rebase by making insn sheet empty.  In
>>    other words, this is "aborting the entire rebase", so ideally it
>>    should come back to the state before the user ran "git rebase"
>>    command (i.e. where she was before we switched to <branch>).
>> 
>>    I do not think this ideal behaviour is something neither batch or
>>    interactive rebase has traditionally implemented, but I can see how
>>    we can sell this as a bugfix to the end users.
>
> That's a convincing argument, so let's make it so.
>
>>  - It turns out that everything is already contained and there is
>>    nothing to apply, i.e. after this sequence:
>> 
>> 	git checkout branch
>> 	git checkout $onto_or_merge_base_between_base_and_branch
>> 
>>    we find out that "git cherry $onto_or_merge_base branch" is empty.
>
> Is there a command missing here?  This alone does not make them the
> same, perhaps you meant some resetting.

Actually that was phrased rather poorly.  At least "after this sequence"
should have been "during this sequence inside the implementation of
'rebase -i'".  In other words, the scenario is still where the user
typed:

  git rebase [-i] [--onto $onto] $base $branch

which is defined to be equivalent to

  git checkout $branch && git rebase [-i] [--onto $onto] $base

The first half of the equivalent command succeeds.  We are on $branch.
The second half finds there is nothing to be done.

I think the current code (and probably with your patch) does this in
such a case:

has_action "$todo" ||
	die_abort "Nothing to do"

and the die happens on $branch before we detach (iow, between the two
checkouts), and the user should end up on $branch.  Unlike the case
where the user told us to abort the entire rebase, which we agreed that
we should come back to the original branch above, I think in this case
we should not nullify the first "checkout $branch".
