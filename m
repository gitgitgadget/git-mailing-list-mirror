From: Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH 1/2] notes: don't expand qualified refs in expand_notes_ref
Date: Wed, 16 Sep 2015 16:00:39 -0700
Message-ID: <CA+P7+xp1aSWJJ5VpAOa6Pje9Qp2sWTjj742xfh5nVJDcD9vCFA@mail.gmail.com>
References: <1442441194-5506-1-git-send-email-jacob.e.keller@intel.com>
 <1442441194-5506-2-git-send-email-jacob.e.keller@intel.com> <xmqqzj0mkn7r.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jacob Keller <jacob.e.keller@intel.com>,
	Git List <git@vger.kernel.org>, Mike Hommey <mh@glandium.org>,
	Johan Herland <johan@herland.net>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 17 01:01:05 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZcLhI-0006ks-Tz
	for gcvg-git-2@plane.gmane.org; Thu, 17 Sep 2015 01:01:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752885AbbIPXBA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Sep 2015 19:01:00 -0400
Received: from mail-io0-f182.google.com ([209.85.223.182]:32922 "EHLO
	mail-io0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752826AbbIPXA7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Sep 2015 19:00:59 -0400
Received: by iofh134 with SMTP id h134so4029402iof.0
        for <git@vger.kernel.org>; Wed, 16 Sep 2015 16:00:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=FFBrqn4ABuMI5Ll64ELNGJl3rk7zAODJdnIKpdZi5mk=;
        b=a/ehkNKcu1D3sIbPgS+j4nfm+Y2YAM+P1bnJNI/obP0LgPiZEbTb/S40kapD8beizZ
         hJLadAP46RNvsu46q1eYrpIpOWjvfcVamq9CtBoZOKHSy/uSpeeKxCInnejSRvWMZRCF
         pnpOCKcPNQy1tJ7EVGUjv2FpSFPQXAABKPR83irfcc19+trxlziKNLNXjnmhiiHZuLds
         sRZj+0S9DXqaD4JgfI3dcJrgHKAKJeBS8bIBt7iSJcCrJBrDZ8SwdW5OOiz4ZUTSnJIR
         z31V+vrmmBXau9JfLsX3EAn5yHxBlC9mvgfmG3/ko7mKxeWDfmKXzrwuI27Ds8jQDLXS
         +KEw==
X-Received: by 10.107.166.201 with SMTP id p192mr1157799ioe.0.1442444458788;
 Wed, 16 Sep 2015 16:00:58 -0700 (PDT)
Received: by 10.107.132.155 with HTTP; Wed, 16 Sep 2015 16:00:39 -0700 (PDT)
In-Reply-To: <xmqqzj0mkn7r.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278086>

On Wed, Sep 16, 2015 at 3:34 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Jacob Keller <jacob.e.keller@intel.com> writes:
>
>> From: Jacob Keller <jacob.keller@gmail.com>
>>
>> The documentation for --refs says that it will treat unqualified refs as
>> under refs/notes. Current behavior is to prefix refs/notes to all
>> strings that do not start with refs/notes or notes/, resulting in
>> performing actions on refs such as "refs/notes/refs/foo/bar" instead of
>> attempting to perform actions on "refs/foo/bar".
>
> That actually sounds like a sensible thing to do, if you replace
> 'foo' with 'heads', for example, i.e. refs/notes/refs/heads/bar is a
> notes about commits reachable from the branch whose name is 'bar'.
>
> So given "refs/heads/bar", which is unqualified in the context of
> talking about references that hold notes trees, the current
> behaviour to turn it into "refs/notes/refs/heads/bar" is very
> sensible, I would think.
>

The end goal is to allow refs inside "refs/remote-notes/".. it seems
really weird that other fully qualified refs don't get "expanded" in
the same way as notes, and documentation does not make it explicit
that this is how it would work. I think that users who actually want
this behavior are already free to say "refs/notes/refs/heads/bar"...
that wouldn't change..

How would you propose allowing merging from "refs/remote-notes/<remote>/bar"?

We could easily just hard-code acceptance of refs/remote-notes/ as
well as refs/notes... But that felt weird to me...

But honestly I don't really care how it is done as long as we can "git
notes show", "git notes list" on refs/remote-notes/<origin>/commits
(or similar, remote-notes may not be the actual location if someone
came up with a better name?)

How would you propose we allow that?

If we keep the current behavior of "expand_notes_ref" then we
absolutely can't because use of "--ref" will auto expand
"refs/remote-notes/<origin>/commits" into
"refs/notes/refs/remote-notes/<origin>/commits" which wouldn't work...

Regards,
Jake
