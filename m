From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: Re: Allow git alias to override existing Git commands
Date: Wed, 11 Nov 2015 10:18:58 +0530
Message-ID: <5642C8BA.8030003@gmail.com>
References: <56421BD9.5060501@game-point.net>
 <CAGZ79kZxQWVMe3N1ti8npyp9_4DUPAVy9Uk5a75Jwh3Eud2eZQ@mail.gmail.com>
 <56424DDE.2030808@game-point.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Jeremy Morton <admin@game-point.net>,
	Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Wed Nov 11 05:49:20 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZwNLM-00038i-2W
	for gcvg-git-2@plane.gmane.org; Wed, 11 Nov 2015 05:49:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752150AbbKKEtH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Nov 2015 23:49:07 -0500
Received: from mail-pa0-f47.google.com ([209.85.220.47]:34506 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751820AbbKKEtG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Nov 2015 23:49:06 -0500
Received: by padhx2 with SMTP id hx2so19745821pad.1
        for <git@vger.kernel.org>; Tue, 10 Nov 2015 20:49:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-type:content-transfer-encoding;
        bh=DrVp8QQVl65zaKQ+blFZk4f/Sk63ksP4xHKtI7v7KSA=;
        b=ZyZiNOKvm3x6saGFbjbpFBX9ZO/j8wKeopoRMKNUkiubHvSOoTP5wIDGfscCyMPhdd
         sGlrI0qVTFDnSRuxlld6xgIgpxTESCmaxPlsngHtgVK4MuInY6Q13E7zJe4abQqpoGym
         RRYLvc8PO+RWVwN/Pf8+kIrUDoFyGZyIsBmEKk5GtlB9ZzQXi0GrVYg//KwPTMLetBVd
         Pasma7zE8PTgijTy0IjH2RYbytyRDCUZ+LBog7lhLDLlALAVyN0oWJCekUwK5wUYB8qB
         mLdOjrG0FlgEqOljjnr5Uv4VvqiQCfq3tsXErlbQ9X7kEo3wByI57UCTFvy8cHc/Zv65
         9kVg==
X-Received: by 10.68.173.5 with SMTP id bg5mr11471132pbc.104.1447217345040;
        Tue, 10 Nov 2015 20:49:05 -0800 (PST)
Received: from sita-lt.atc.tcs.com ([117.195.175.90])
        by smtp.googlemail.com with ESMTPSA id so4sm7097899pbc.72.2015.11.10.20.49.01
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Nov 2015 20:49:03 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:38.0) Gecko/20100101
 Thunderbird/38.3.0
In-Reply-To: <56424DDE.2030808@game-point.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281150>

On 11/11/15 01:34, Jeremy Morton wrote:
> On 10/11/2015 18:12, Stefan Beller wrote:
>> On Tue, Nov 10, 2015 at 8:31 AM, Jeremy Morton<admin@game-point.net>  wrote:
>>> It's recently come to my attention that the "git alias" config functionality
>>> ignores all aliases that would override existing Git commands.  This seems
>>> like a bad idea to me.
>>
>> This ensures that the plumbing commands always work as expected.
>> As scripts *should* only use plumbing commands, the scripts should
>> work with high probability despite all the crazy user configuration/aliases.
>>
> 
> I just disagree with this.  If a user chooses to override their Git
> commands, it's their problem.  Why should Git care about this?  It
> should provide the user with the option to do this, and if the user
> ruins scripts because of their aliases, it is not Git's problem.  What
> you are doing is taking away power from users to use git aliases to
> their full potential.

A lot of things in Unix do follow that "give you rope to hang yourself"
philosophy.  I used to (and to *some* extent still do) think like that,
but some years of supporting normal users trying to do stuff has taught
me it's not always that simple.

I can easily see someone blogging some cool way to do something, and a
less savvy user uses that in his gitconfig, and gets burned later
(possibly much later, enough that he does not easily make the
connection!)

So for the record, I am definitely against this kind of change.

But if I were in your place, and really *needed* this, here's what I
would do:

    #!/bin/bash

    # this file is named 'git' and placed in a directory that is earlier in $PATH
    # than the real 'git' binary (typically $HOME/bin).  This allows you to
    # override git sub-commands by adding stuff like this to your ~/.gitconfig
    # (notice the "o-" prefix):
    #
    #   [alias]
    #       o-clone = clone --recursive

    GIT=/bin/git    # the real 'git' binary

    cmd="$1"
    shift

    if $GIT config --get alias.o-$cmd >/dev/null
    then
        $GIT o-$cmd "$@"
    else
        $GIT $cmd "$@"
    fi
