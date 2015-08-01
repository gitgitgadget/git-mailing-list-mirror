From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH/RFC 0/2] bisect per-worktree
Date: Sat, 01 Aug 2015 01:55:45 -0400
Organization: Twitter
Message-ID: <1438408545.4735.40.camel@twopensource.com>
References: <1438387012-29229-1-git-send-email-dturner@twopensource.com>
	 <55BC4438.8060709@alum.mit.edu>
	 <CAPc5daVnfit8pkjc2HCSn0erW-q++We8gx8tPsb_ptd5H+CpJg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Git Mailing List <git@vger.kernel.org>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Aug 01 07:56:07 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZLPmA-0001oc-1w
	for gcvg-git-2@plane.gmane.org; Sat, 01 Aug 2015 07:56:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751072AbbHAFzs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Aug 2015 01:55:48 -0400
Received: from mail-qg0-f48.google.com ([209.85.192.48]:35160 "EHLO
	mail-qg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750833AbbHAFzs (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Aug 2015 01:55:48 -0400
Received: by qgii95 with SMTP id i95so59513689qgi.2
        for <git@vger.kernel.org>; Fri, 31 Jul 2015 22:55:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:content-type:mime-version
         :content-transfer-encoding;
        bh=DqyasQEOutzN40F0t/+F5UiV5EaTcNCshlrkMt0TgcY=;
        b=Bae3v4pY7XKIK2jHLNjuk7PvkYgKynt1EM1FaUsuUuh4STILjeLcxuS4023aYIt49M
         H2ldqZ8awk5r+2tVGZWOZ5xVPrzQOO6G7sFdHWl7Aoepp+FFPrcp4z/aWTNo6UWs6W5R
         fSbkM/etGiMQ2OhNwqHIoe1+Y0dj+EPODoJ/ulK2wlUG1lWijtPjvy8u0Kw9ffRTBcxs
         wnuWZaV5Ou1Og6j0Y3C9+qTR58ZG9Bkhl12CSD1+Td8TR3OkvlzsUJdoabxPYKgC25EZ
         X0Aosay/2LITi7MYbohRr5ITBZF3JWrIO2BT3SfcRRJz8YkXdqJdHVXnWJpb2+/6YOTY
         21Yw==
X-Gm-Message-State: ALoCoQk7ctiPNp8U7bqItJuCHCJAQXfwxR4Vjf9CfljMhPRkFmlY/4IxSon6C3ED0KfoWID9DE8Y
X-Received: by 10.140.238.86 with SMTP id j83mr11293986qhc.37.1438408547251;
        Fri, 31 Jul 2015 22:55:47 -0700 (PDT)
Received: from ubuntu (207-38-164-98.c3-0.43d-ubr2.qens-43d.ny.cable.rcn.com. [207.38.164.98])
        by smtp.gmail.com with ESMTPSA id y11sm3403719qky.42.2015.07.31.22.55.46
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 31 Jul 2015 22:55:46 -0700 (PDT)
In-Reply-To: <CAPc5daVnfit8pkjc2HCSn0erW-q++We8gx8tPsb_ptd5H+CpJg@mail.gmail.com>
X-Mailer: Evolution 3.12.11-0ubuntu3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275107>

On Fri, 2015-07-31 at 22:12 -0700, Junio C Hamano wrote:
> On Fri, Jul 31, 2015 at 8:59 PM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
> >
> > It seems to me that adding a new top-level "worktree-refs" directory is
> > pretty traumatic. Lots of people and tools will have made the assumption
> > that all "normal" references live under "refs/".
> > ...
> > It's all a bit frightening, frankly.
> 
> I actually feel the prospect of pluggable ref backend more frightening,
> frankly ;-). These bisect refs are just like FETCH_HEAD and MERGE_HEAD,
> not about the primary purpose of the "repository" to grow the history of refs
> (branches), but about ephemeral pointers into the history used to help keep
> track of what is being done in the worktree upstairs. There is no need for
> these to be visible across worktrees. If we use the real refs that are grobal
> in the repository (as opposed to per-worktree ones), we would hit the backend
> databas with transactions to update these ephemeral things, which somehow
> makes me feel stupid.

Agreed, I think it's a mistake to complicate the global ref namespace
like that.

> I wish we could just make refs/bisect/* (or whatever the current bisect
> code uses) automatically per worktree. I know David dismissed it saying
> that the current code is not set up to allow it easily, but is it
> really a fundamental
> limitation, or is it just a matter of coding a few more dozens of lines?

We still need the packed-refs and is_per_worktree_ref change; we need a
different and more complicated loose-refs loading change, and we need
changes to path.c to treat refs/bisect different from refs/.  Probably a
few dozen lines, yeah.  And it's sort of ugly to make the refs/bisect
special case into a fundamental part of the repository structure.  

I'm worried that we'll discover a need for more of these.  But I can do
the rewrite and see how it looks (probably on Monday).

Do we need to worry about reflogs for these?  If so, a few more lines,
probably.

> If we can keep using the same location under refs/ and transparently make
> them appear per-worktree, "what is the name of the main one?", and "do we
> even need to call the one and the only one 'main'?" will automatically
> disappear.
> Of course, "git bisect" and "gitk --bisect" does not have to change if
> we go that
> route.
> 
> And there will not be any backward compatibility worries. If you are not
> using multiple worktrees, you will see them as refs/bisect/*, just at the
> same location as you are familiar with.

Yes, this is a good point.
