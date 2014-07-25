From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Amending merge commits?
Date: Fri, 25 Jul 2014 15:19:11 -0700
Message-ID: <20140725221911.GL12427@google.com>
References: <22F01493C523F940B4B5E53BB6D0F5352275F207@G5W2738.americas.hpqcorp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: "Besen, David" <david.besen@hp.com>
X-From: git-owner@vger.kernel.org Sat Jul 26 00:19:19 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XAnpf-0005yt-08
	for gcvg-git-2@plane.gmane.org; Sat, 26 Jul 2014 00:19:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760693AbaGYWTP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jul 2014 18:19:15 -0400
Received: from mail-pd0-f176.google.com ([209.85.192.176]:51981 "EHLO
	mail-pd0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752059AbaGYWTO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jul 2014 18:19:14 -0400
Received: by mail-pd0-f176.google.com with SMTP id y10so6325051pdj.7
        for <git@vger.kernel.org>; Fri, 25 Jul 2014 15:19:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=BdNcOkeoKo3w97ND/jB2e33Iuxy9RKXTtCuFuDwO4nE=;
        b=hV4ZI0iocinWZP15b6dgaxgBMYPva3rB82is2wfRGsq3X9Hg3bhS/pMPuJB/WqTijw
         ABvw3mDr+XkJccHa4NgjACFb/dOMGPEk46V6VIbMbWJeZpFYbZibxSbIzoxiPmMCO0Ak
         9WJgeGhSuIy+ROavE23oPyBK8X7pGjgOpLrv88u7aC7OtVtP12M4xIhnJV2rTv8qAx7i
         RFr0L4KklWSbaJqcHT9c7+8+Ty9z4e0seH1jqUQ+/1Zn+JNIAfzMHkdZlCZH2V7OIRR2
         wnW+4uUdklHLvJnX8vymSaMd2WC4Dub8+0XuOfbh6M8GcCU3WAYVIIAitMsqELDZSrgX
         wdyw==
X-Received: by 10.66.236.6 with SMTP id uq6mr21758294pac.24.1406326754215;
        Fri, 25 Jul 2014 15:19:14 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:11c3:a287:a529:3c10])
        by mx.google.com with ESMTPSA id gd2sm9885940pbb.95.2014.07.25.15.19.13
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 25 Jul 2014 15:19:13 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <22F01493C523F940B4B5E53BB6D0F5352275F207@G5W2738.americas.hpqcorp.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254271>

Besen, David wrote:

> I think one of my coworkers has stumbled on a git bug -- if you
> amend a merge commit, and then pull, your amends are lost.

This is how pull --rebase works.  It turns your single-parent commits
into a sequence of patches on top of upstream and completely ignores
your merge commits.

There is a --rebase=preserve option that makes a halfhearted attempt
to preserve your merges --- perhaps that would help?  The
git-rebase(1) documentation has more details.

In an ideal world, I think pull --rebase would do the following:

 1. Do the same thing it does today
 2. Behind the scenes, *also* try a 'pull --merge' but don't save
    the result.
 3. Compare the results.  If they differ, show a diff and explain
    to the user what happened.

I may be the only one that wants that, though.

Hope that helps,
Jonathan
