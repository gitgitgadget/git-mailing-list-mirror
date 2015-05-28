From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Redirect "git" subcommand to itself?
Date: Wed, 27 May 2015 18:53:26 -0700
Message-ID: <xmqqoal5ii21.fsf@gitster.dls.corp.google.com>
References: <CAGZ79kZHa9wUrRsWfHgGdSdx+cN9VAirAAfu3YLVTuSmggcehg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "git\@vger.kernel.org" <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Thu May 28 03:53:35 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yxn0n-0005KE-SE
	for gcvg-git-2@plane.gmane.org; Thu, 28 May 2015 03:53:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753272AbbE1Bxa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 May 2015 21:53:30 -0400
Received: from mail-ig0-f178.google.com ([209.85.213.178]:36679 "EHLO
	mail-ig0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752995AbbE1Bx3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 May 2015 21:53:29 -0400
Received: by igbpi8 with SMTP id pi8so100317226igb.1
        for <git@vger.kernel.org>; Wed, 27 May 2015 18:53:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=eWfT2hgQjJbNT1DKYhApQEkcNq4eEMMzWDt9bgBNQ8A=;
        b=G8HC5LRHkl9RsYFR2MOBe1VOFQaeX7mwWbH1Z6QHNcgBgF/Nn5uJ5dbZ13DCpyyt6P
         nl9s1YXVSMiwkowtkTCKsH6xisCEn33Nhtb62iMSBLzS9puNa5jETTZQluRASfnVxCB8
         Rx9NH5Vdy+KZvuWhmxUGUtrZyWlgx1HLkLhbPTB7hmZhywbyHQ7ZwA6EEAIbAzGBmhxW
         9fUBMZWCHQFhEtml2dRBnj8wd8gCxcgfcXugWg3QZbjAjynjOUtm75BpC+1Sj8kh6nsx
         QQfR/zaSauBpqv9gxe/dTCa8ZGCZPjkJ1vHZr6PKFzeXSyMDzh4pn3mHc6YxJnQujnQo
         e+Rg==
X-Received: by 10.42.144.131 with SMTP id b3mr6888101icv.35.1432778008389;
        Wed, 27 May 2015 18:53:28 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:91c7:752b:4513:7344])
        by mx.google.com with ESMTPSA id av6sm3163145igc.17.2015.05.27.18.53.27
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 27 May 2015 18:53:27 -0700 (PDT)
In-Reply-To: <CAGZ79kZHa9wUrRsWfHgGdSdx+cN9VAirAAfu3YLVTuSmggcehg@mail.gmail.com>
	(Stefan Beller's message of "Wed, 27 May 2015 17:28:34 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270123>

Stefan Beller <sbeller@google.com> writes:

> so I just run into this problem again (which happens to me maybe twice a week):
> I want to do a git operations, so I type "git " into my shell, and
> then I look around what
> exactly I want to do and usually I find it in the help text of a
> previous command such as
>     You are currently reverting commit 383c14b.
>       (fix conflicts and run "git revert --continue")
>       (use "git revert --abort" to cancel the revert operation)
>
> then I copy the whole operation "git revert --abort" in this case and
> paste it to the shell
> and let go.
> The result looks like
>     $ git git revert --abort
>     git: 'git' is not a git command. See 'git --help'.
>
>     Did you mean this?
>     init
>
> I wonder if we want to make a "git" subcommand, which behaves exactly
> the same as git itself?
> Then "git git git status" would just return the same as "git status".

A few unrelated thoughts.

 * Perhaps we should omit 'git' from these advice-texts?  E.g.

     use "revert --abort" to cancel

   I dunno.

 * While we bend over backwards to a certain degree to be helpful, I
   somehow feel making "git git" a synonym to "git" is going too
   far, akin to asking POSIX maintainers to define "act", "cta",
   "atc", "tca", and "tac" all as synonyms to "cat" because you
   often fat-finger when typing "cat" (yes, "tac" does something
   else that is more useful, I know).

 * You can help yourself with something like this, I suppose:

   [alias]
	git = "!sh -c 'exec git \"$@\"' -"

   but I personally feel that it is too ugly to live as part of our
   official suggestion, so please do not send a patch to add it as
   a built-in alias ;-).
