From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] branch: fix usage string for specific git-branch options
Date: Fri, 17 Jul 2015 12:16:19 -0700
Message-ID: <xmqqsi8m1toc.fsf@gitster.dls.corp.google.com>
References: <1437157020-16672-1-git-send-email-ralf.thielow@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Ralf Thielow <ralf.thielow@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 17 21:16:27 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZGB7S-00036z-7O
	for gcvg-git-2@plane.gmane.org; Fri, 17 Jul 2015 21:16:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752200AbbGQTQW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Jul 2015 15:16:22 -0400
Received: from mail-pd0-f182.google.com ([209.85.192.182]:33877 "EHLO
	mail-pd0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751670AbbGQTQV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Jul 2015 15:16:21 -0400
Received: by pdbbh15 with SMTP id bh15so20580588pdb.1
        for <git@vger.kernel.org>; Fri, 17 Jul 2015 12:16:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=1POgp6TahxlKmZ076JDWA8Bp0k6zev59emtI05DNGvs=;
        b=Wjj+ic+iVMTmGerGY+uFfFS7ZhPeI6sT/b/0DY6Abtzd5hWlik09ZZeytXgKDch0ZI
         HRlfdp4yvP4PbThrdu68XeCvWNnh2X0SHyWHFCy5uotsBrog4yIYGB3GYn0FTvpv6dNy
         Do35yMMEfgtZBf8FcSacD3UPF5B8uZZA0nasAs4MwmvbVCknljaMKZgNijwMosgaN/tw
         xoUNvNTBcN2PsWB0Fx9aHWH3cF3Cf6B3fmRJMBdnqFUB98WFH4MXQVCUZell9/I3us4s
         wTJFpLB+G8xs1AzgHkXWHQ0EkxDtQHDjJG8VJknyONag72N3CaI1iEo8ULcCHmENmpvf
         LFQg==
X-Received: by 10.67.29.175 with SMTP id jx15mr32113656pad.99.1437160580960;
        Fri, 17 Jul 2015 12:16:20 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:902a:e9ec:1aae:aea2])
        by smtp.gmail.com with ESMTPSA id cf7sm12099503pac.41.2015.07.17.12.16.19
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 17 Jul 2015 12:16:20 -0700 (PDT)
In-Reply-To: <1437157020-16672-1-git-send-email-ralf.thielow@gmail.com> (Ralf
	Thielow's message of "Fri, 17 Jul 2015 20:17:00 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274096>

Ralf Thielow <ralf.thielow@gmail.com> writes:

> The usage string of git-branch shows generic options and specific
> options. However, the specific options are called "actions".
> Call them both options.

I think this is a valid problem to address, but I do not know if the
proposed solution is the right one.

Originally, the word "action" there really meant to mean "action".
"git branch" can "list" existing ones, "create" new ones, "delete"
existing ones, "edit" upstream info or description for, etc.  These
are distinct actions.

For a single "action", there are various ways to perform it.
Different ways to affect "list", for example, are like "choosing
which ones are listed", "deciding if the output is colored", etc..
The "options" section was meant to cover these modifiers.

I think the real issues may be coming from one or both of the two:

 (1) some are grossly miscategorized.  "--all" is not an action.  It
     just affects how "listing" works.  "--no-merged" and "--merged"
     are the same way and should sit next to "--contains".

     "--set-upstream" and "--unset-upstream" on the other hand are
     not modifiers for some other actions, but are their own actions.

 (2) "Generic options" would need to show things like "-v/-q/-f"
     that would want to consistently apply to any action that you
     might want to invoke.  Because not all modifiers apply to all
     actions, there is no good place to put things like "-t" (that
     has no meaning when you are invoking "delete" action) that are
     specific to only a subset of available actions, i.e. "Not
     generic" ones.

So the real way forward would be probably to do three things.

 * Keep the same two categorization as we have, i.e. "generic
   options" and "specific actions";

 * Move the miscategorized non-actions to "generic options" section;

 * Move action-specific modifiers out of "generic options" and
   clearly state what action they work with to modify the behaviour
   of the action.
