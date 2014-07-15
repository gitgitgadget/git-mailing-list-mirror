From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v20 43/48] refs.c: move the check for valid refname to
 lock_ref_sha1_basic
Date: Tue, 15 Jul 2014 11:04:24 -0700
Message-ID: <20140715180424.GJ12427@google.com>
References: <1403275409-28173-1-git-send-email-sahlberg@google.com>
 <1403275409-28173-44-git-send-email-sahlberg@google.com>
 <53BC07FC.8080601@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ronnie Sahlberg <sahlberg@google.com>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Tue Jul 15 20:04:34 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X775c-0003Vh-F6
	for gcvg-git-2@plane.gmane.org; Tue, 15 Jul 2014 20:04:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756899AbaGOSE2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jul 2014 14:04:28 -0400
Received: from mail-pa0-f43.google.com ([209.85.220.43]:52201 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754456AbaGOSE1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jul 2014 14:04:27 -0400
Received: by mail-pa0-f43.google.com with SMTP id lf10so7333943pab.16
        for <git@vger.kernel.org>; Tue, 15 Jul 2014 11:04:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=FGZsZanoW/MhZZmNiSbGL0kOaHxOFpE0FhP38UdcXBk=;
        b=uqnvYGbONH6UuxhNY9azYviAnMj3Z+99eRp/bMqMYBcy0dYVC9iK4YCrULfaWJz2sc
         e4czAgryiTgATRNCita8IITuqYiMV5VTEdl48APF+RzdkNfN53qdUyrpLNqjrK7JP0BU
         KbtN97b5FysB/xWQbAi+BBxPRmEzNvHaZ6qYWRh+klw7VSCnFH8YG3EcV9AEjV3/UAKX
         sNQl2luxjcn3TefDEyQHuS9hHs09HPYSQ68/jVjQlkGZKH9sV9vZHJ+HA+oZV9VAK9Wn
         sA7Hqs0J7hDZylNWxpfQuil7Mle2FLEnhK4KpgErBFwQ9YeuVtwGHLxJ0ZPLziHWqQi4
         1dlw==
X-Received: by 10.66.158.36 with SMTP id wr4mr24449051pab.34.1405447467395;
        Tue, 15 Jul 2014 11:04:27 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:888a:1e2f:d307:1d55])
        by mx.google.com with ESMTPSA id og2sm19474225pdb.42.2014.07.15.11.04.26
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 15 Jul 2014 11:04:26 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <53BC07FC.8080601@alum.mit.edu>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253576>

Michael Haggerty wrote:

> So...I like the idea of enforcing refname checks at the lowest level
> possible, but I think that the change you propose is too abrupt.  I
> think it needs either more careful analysis showing that it won't hurt
> anybody, or some kind of tooling or non-strict mode that people can use
> to fix their repositories.

The recovery code has been broken for a while, so I don't see harm
in this change.

How to take care of the recovery use case is another question.  FWIW I
also would prefer if "git update-ref -d" or "git branch -D" could be
used to delete corrupt refs instead of having to use fsck (since a
fsck run can take a while), but that's a question for a later series.

In an ideal world, the low-level functions would allow *reading* and
*deleting* poorly named refs (even without any special flag) but not
creating them.  Is that doable?  The main complication I can see is
iteration: would iteration skip poorly named refs and warn, or would
something more complicated be needed?

Thanks,
Jonathan
