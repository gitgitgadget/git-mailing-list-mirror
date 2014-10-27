From: David Aguilar <davvid@gmail.com>
Subject: Re: difftool--helper: exit when reading a prompt answer fails
Date: Sun, 26 Oct 2014 18:10:52 -0700
Message-ID: <20141027011051.GA87518@gmail.com>
References: <544CAC30.7000607@kdbg.org>
 <20141027004148.GB81127@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Sitaram Chamarty <sitaramc@gmail.com>
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Mon Oct 27 02:10:47 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XiYpY-0003Pn-8S
	for gcvg-git-2@plane.gmane.org; Mon, 27 Oct 2014 02:10:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751892AbaJ0BKk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Oct 2014 21:10:40 -0400
Received: from mail-pa0-f42.google.com ([209.85.220.42]:45868 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751728AbaJ0BKj (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Oct 2014 21:10:39 -0400
Received: by mail-pa0-f42.google.com with SMTP id bj1so812956pad.1
        for <git@vger.kernel.org>; Sun, 26 Oct 2014 18:10:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=ngJoKwwzZvGdepzCJhyH5H/w6OmKdxlvJu5X65+uB2w=;
        b=X1sb5oDlRdyufmXzZInW8XqL/bffVUnyJtfaCA/ORkvQPYiGnc7Xu4/T2L+vVJZgJn
         4FdPHIw3nzgKmS8saegSxV329EihEW5HVcS+bqYDgAk2bMhzL89R9tN/LKHyivvFmKz1
         NTv6OM6IOls6M0mWIk2y2FJSCnmMq5UIS6EC+WbtXpVK2z3nJQRXrmvTqWSiBMb6ikzs
         oHV+n4xf6/wSeSyvOR0NnALTHfhEadfm/9Z/NxhflIvjO0YWys6cEkRPAPsFD1wagXIS
         XiKHoYibN7HUFMT7DdbYcKckAA3rM4i8viHKVk7MPx9FsOaOSBGdxYta6Gz/Tu/PCNoo
         W3hQ==
X-Received: by 10.68.87.37 with SMTP id u5mr806173pbz.128.1414372239148;
        Sun, 26 Oct 2014 18:10:39 -0700 (PDT)
Received: from gmail.com (208-106-56-2.static.sonic.net. [208.106.56.2])
        by mx.google.com with ESMTPSA id o4sm9305588pdj.2.2014.10.26.18.10.37
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sun, 26 Oct 2014 18:10:38 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20141027004148.GB81127@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Oct 26, 2014 at 05:41:49PM -0700, David Aguilar wrote:
> On Sun, Oct 26, 2014 at 09:09:20AM +0100, Johannes Sixt wrote:
> > An attempt to quit difftool by hitting Ctrl-D (EOF) at its prompt does
> > not quit it, but is treated as if 'yes' was answered to the prompt and
> > all following prompts, which is contrary to the user's intent. Fix the
> > error check.
> > 
> > Signed-off-by: Johannes Sixt <j6t@kdbg.org>
> > ---
> >  Found while reviewing your latest patch.
> 
> 
> Thanks for the careful review.
> I have one small question about the test below.

[snip]

> > diff --git a/t/t7800-difftool.sh b/t/t7800-difftool.sh
> > index dc30a51..9cf5dc9 100755
> > --- a/t/t7800-difftool.sh
> > +++ b/t/t7800-difftool.sh
> > @@ -301,6 +301,14 @@ test_expect_success PERL 'say no to the second file' '
> >  	! grep br2 output
> >  '
> >  
> > +test_expect_success PERL 'ending prompt input with EOF' '
> > +	git difftool -x cat branch </dev/null >output &&
> > +	! grep master output &&
> > +	! grep branch output &&
> > +	! grep m2 output &&
> > +	! grep br2 output
> > +'
> 
> Should we use "test_must_fail grep ..." instead of "! grep ..." here?


Nevermind, this is good as-is.
Using "! grep" is consistent with the rest of the tests in t7800.

What I'll do is add a follow-up patch in my upcoming reroll
that swaps all the "! grep" lines to "test_must_fail grep"
in one step.
-- 
David
