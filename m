From: Martin Erik Werner <martinerikwerner@gmail.com>
Subject: [PATCH v2 0/3] Add bash.showUntrackedFiles config option
Date: Wed, 13 Feb 2013 11:58:58 +0100
Message-ID: <1360753138.25490.10.camel@mas>
References: <1360699936-28688-1-git-send-email-martinerikwerner@gmail.com>
	 <1360699936-28688-3-git-send-email-martinerikwerner@gmail.com>
	 <7vr4kldv2x.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, trsten@science-computing.de
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 13 11:59:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U5a3l-0003cd-KC
	for gcvg-git-2@plane.gmane.org; Wed, 13 Feb 2013 11:59:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933655Ab3BMK7G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Feb 2013 05:59:06 -0500
Received: from mail-la0-f43.google.com ([209.85.215.43]:55462 "EHLO
	mail-la0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932451Ab3BMK7E (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Feb 2013 05:59:04 -0500
Received: by mail-la0-f43.google.com with SMTP id ek20so1032237lab.30
        for <git@vger.kernel.org>; Wed, 13 Feb 2013 02:59:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:message-id:subject:from:to:cc:date:in-reply-to
         :references:content-type:x-mailer:mime-version
         :content-transfer-encoding;
        bh=DfT1JzmE0lZQY2YV3y00MRiIZkXt0hhvF0tcbRAeDt8=;
        b=lmZmv3aQMxsIcqjq70nz5JpQa1B++ugLt38Qt35izH5D3fJ/b8fUjGuT61K4pn0PeO
         dapWgWut1wby4+C/rfTE8YQlg4p9mLv7Oh9HAyOohe/gt33lGBB0mwtjH0fkS1RLWYca
         yEPFkvpM071K6t/Ov1AzO9eQ9STHtWn5r2lBuxpMU+M5DqyfQFvnRM57euFwVAqmL/xp
         ISHZlXo6iWIsx3UPnV4ddjUDQjneGMlM9W8T7iFcoADCJkrACVtXeTLLDqSGksTn5szc
         yBmXhcTnY3QOTqiofEDpGFT05Q4gJmXqaBeNlBJMmqxxI7Mw+shkFdPkjYorzzkRBnC3
         JeVQ==
X-Received: by 10.152.123.194 with SMTP id mc2mr19792673lab.7.1360753141997;
        Wed, 13 Feb 2013 02:59:01 -0800 (PST)
Received: from [192.168.1.2] (nl107-187-0.student.uu.se. [130.243.187.0])
        by mx.google.com with ESMTPS id pk1sm25506324lab.0.2013.02.13.02.58.59
        (version=SSLv3 cipher=RC4-SHA bits=128/128);
        Wed, 13 Feb 2013 02:59:00 -0800 (PST)
In-Reply-To: <7vr4kldv2x.fsf@alter.siamese.dyndns.org>
X-Mailer: Evolution 3.6.1-1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216245>

On Tue, 2013-02-12 at 14:29 -0800, Junio C Hamano wrote:
> Martin Erik Werner <martinerikwerner@gmail.com> writes:
> 
> > Add a test case for the bash.showUntrackedFiles config option, which
> > checks that the config option can disable the global effect of the
> > GIT_PS1_SHOWUNTRACKEDFILES environmant variable.
> >
> > Signed-off-by: Martin Erik Werner <martinerikwerner@gmail.com>
> > ---
> >  t/t9903-bash-prompt.sh |   11 +++++++++++
> >  1 file changed, 11 insertions(+)
> >
> > diff --git a/t/t9903-bash-prompt.sh b/t/t9903-bash-prompt.sh
> > index f17c1f8..c9417b9 100755
> > --- a/t/t9903-bash-prompt.sh
> > +++ b/t/t9903-bash-prompt.sh
> > @@ -447,6 +447,17 @@ test_expect_success 'prompt - untracked files status indicator - not shown insid
> >  	test_cmp expected "$actual"
> >  '
> >  
> > +test_expect_success 'prompt - untracked files status indicator - disabled by config' '
> > +	printf " (master)" > expected &&
> > +	echo "untracked" > file_untracked &&
> > +	test_config bash.showUntrackedFiles false &&
> > +	(
> > +		GIT_PS1_SHOWUNTRACKEDFILES=y &&
> > +		__git_ps1 > "$actual"
> > +	) &&
> > +	test_cmp expected "$actual"
> > +'
> 
> All six combinations need checking:
> 
>  * not having the configuration at all and not having the shell
>    variable should not show the untracked indicator (already tested).
> 
>  * not having the configuration at all and having the shell variable
>    should show the untracked indicator (already tested).
> 
>  * setting configuration to true without having the shell variable
>    should not show the untracked indicator.
> 
>  * setting configuration to true and having the shell variable
>    should show the unttracked indicator.
> 
>  * setting configuration to false and having the shell variable
>    should not show the untracked indicator (the above test checks
>    this).
> 
>  * setting configuration to false without having the shell variable
>    should not show the untracked indicator.
> 
> to prevent others from breaking the code you wrote for [PATCH 1/2],
> so you need three more tests, I guess?

Ah, yes, I was mimicing what the test did for bash.showDirtyState, I've
now added the three extra tests for bash.showUntrackedFiles, which
should cover all of the above cases, hopefully?

I've also added in the three extra tests for bash.showDirtyState,
equivalently. These only cover the case of dirty files and not
combinations with content in index, which I felt was a bit overkill, is
that reasonable?

Thanks for the review :)

-- 
Martin Erik Werner <martinerikwerner@gmail.com>
