From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH v6 6/7] git-reflog: add create and exists functions
Date: Wed, 08 Jul 2015 16:12:23 -0400
Organization: Twitter
Message-ID: <1436386343.4542.14.camel@twopensource.com>
References: <1435609076-8592-1-git-send-email-dturner@twopensource.com>
	 <1435609076-8592-7-git-send-email-dturner@twopensource.com>
	 <559AB200.5020108@alum.mit.edu> <1436316577.5521.25.camel@twopensource.com>
	 <559D22A1.9030100@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Wed Jul 08 22:12:34 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZCvho-0003nx-EL
	for gcvg-git-2@plane.gmane.org; Wed, 08 Jul 2015 22:12:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758236AbbGHUM1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jul 2015 16:12:27 -0400
Received: from mail-qk0-f175.google.com ([209.85.220.175]:34879 "EHLO
	mail-qk0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755439AbbGHUM0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jul 2015 16:12:26 -0400
Received: by qkbp125 with SMTP id p125so171600902qkb.2
        for <git@vger.kernel.org>; Wed, 08 Jul 2015 13:12:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:content-type:mime-version
         :content-transfer-encoding;
        bh=2VHZTpNILiExy+KirRphIHqzhaGyVrYcyzjvGUaEEPc=;
        b=VaGbY8GTC+mI/XU9iNQBI3H9XKp7L3oU6yXBl9070su6PdcdtJGOYuN19l3vcip+C8
         K0dZ+pxsjhKfQCrN8fpX3bsUARPJvz63e4tM7668Muf1HJBsXUq0PHgi6wx3O+efde2u
         dljPGbqzRHCJ/R1rpI50bXNlXd1impRIjeifI8CFxUK9YzleSdQYBITwv9n+XLCUKAc0
         v4dZu7xQ+fp1TJbeJCLC7Gv5am1oW5NbvFxaDeikWh3T0S5OCLAtOsM3qLlo5+UR1AoJ
         RGQlTCnDtFkimby5fr/cysihz+PFJJg6/M0i5t247dBE9JNr95kKKhVEWUZX7nBQncgU
         zxWA==
X-Gm-Message-State: ALoCoQmkeS0By4zIkZV/xli8MT6yhTbmIpWVvuuFnwdOjC2QdWLTLE9/gyqVb3AkKG02ld7pSzDS
X-Received: by 10.55.20.24 with SMTP id e24mr9371023qkh.35.1436386345989;
        Wed, 08 Jul 2015 13:12:25 -0700 (PDT)
Received: from ubuntu ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id p52sm2115816qge.25.2015.07.08.13.12.24
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Jul 2015 13:12:24 -0700 (PDT)
In-Reply-To: <559D22A1.9030100@alum.mit.edu>
X-Mailer: Evolution 3.12.11-0ubuntu3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273705>

On Wed, 2015-07-08 at 15:16 +0200, Michael Haggerty wrote:
> On 07/08/2015 02:49 AM, David Turner wrote:
> > On Mon, 2015-07-06 at 18:51 +0200, Michael Haggerty wrote:
> >> [...]
> >> So all in all, I think it is unwise to allow a reflog to be created
> >> without its corresponding reference.
> >>
> >> This, in turn, suggests one or both of the following alternatives:
> >>
> >> 1. Allow "git reflog create", but only for references that already exist.
> > 
> > This turns out not to work for git stash, which wants to create a reflog
> > for stash creation.
> > 
> >> 2. If we want to allow a reflog to be created at the same time as the
> >> corresponding reference, the reference-creation commands ("git branch",
> >> "git tag", "git update-ref", and maybe some others) probably need a new
> >> option like "--create-reflog" (and, for symmetry, probably
> >> "--no-create-reflog").
> > 
> > git branch should already autocreate reflogs, since the refs it creates
> > are under refs/heads.
> 
> `git branch` only autocreates reflogs if core.logAllRefUpdates is on.
> That setting happens to be on by default in a non-bare repository but
> the user might turn it off. And it is off by default in a bare repository.

Oh, right.  Well, we can always add that later, if anyone needs it.

> In my opinion it would be nice for the user to be able to ask for a
> reflog to be created for a branch regardless of how
> core.logAllRefUpdates is set. Though I'm not saying that you have to be
> the one to implement that functionality :-)
> 
> >> At the API level, it might make sense for the ref-transaction functions
> >> to get a new "REF_FORCE_CREATE_REFLOG" flag or something.
> > 
> > Junio was opposed to the converse flag, so I'm going to just add
> > manually add code to create reflogs.
> 
> Unfortunately I wasn't keeping up with earlier versions of this patch
> series and now I can't find the email from Junio that you are referring
> to. If the earlier flag had the opposite ("converse"?) sense, like
> REF_INHIBIT_CREATE_REFLOG, then I agree that it wouldn't be an improvement.
> 
> But I think this functionality *has to* be implemented within ref
> transactions for references that are just being created, because
> 
> 1. The reflog must *not* be created if the reference creation fails for
> some reason. For example, the reflog shouldn't be created if the
> reference name has a D/F conflict with an existing one in the "refs/foo"
> vs. "refs/foo/bar" sense. (This conflict might not be obvious when
> creating the reflog file because the other reference might not have its
> reflog turned on.) There are other reasons that a reference creation
> might fail, and code outside of the refs API can't be expected to know
> all possibilities.
> 
> 2. On the other hand, the reflog for a newly-created reference *should*
> reflect the creation of the reference. So it would be awkward to require
> the calling code to create the reference and *then* turn on the reflog.

Yep, makes sense.

> For references that already exist, I see no problem with a command that
> turns on the reflog without adding any entries to it. Though if you
> implement this, it would be prudent to check that existing
> reflog-handling code doesn't fail when confronted with an empty file; I
> think empty reflog files are rare now and might not be well-tested.

I think empty reflog files are fine; I recall a few tests creating them
(and git stash did so as well).

But I also don't need that command (I think), so I won't implement it
right now.
