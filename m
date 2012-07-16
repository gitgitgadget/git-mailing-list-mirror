From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] Fix overwritten remote ref on with fast-import.
Date: Sun, 15 Jul 2012 19:30:25 -0500
Message-ID: <20120716003024.GA4246@burratino>
References: <1342013933-14381-1-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1342362383-31167-1-git-send-email-florian.achleitner.2.6.31@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, David Michael Barr <davidbarr@google.com>,
	Jeff King <peff@peff.net>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 16 02:30:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SqZD0-0005ia-PI
	for gcvg-git-2@plane.gmane.org; Mon, 16 Jul 2012 02:30:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751523Ab2GPAah (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Jul 2012 20:30:37 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:38197 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751085Ab2GPAag (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Jul 2012 20:30:36 -0400
Received: by obbuo13 with SMTP id uo13so8661032obb.19
        for <git@vger.kernel.org>; Sun, 15 Jul 2012 17:30:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=PB/tj5c+RIeDCaJ0StDDjmigX8T7xXwcZoaQGGTlnvs=;
        b=wr8eIt40fWxPEbp9IrWdjDsOJCCeE1ttXUj0fffQTQtCjuwx2UsFoHkOuv9rowRCzj
         gx5li/Huj9t/aSZ8gfs/41YV10eSkEbCUqA9Kve26QLA6p8j5QYI6PCsz+i297GpObd7
         FnPZ56mEQ8QWKkWqlg6bJpUeqThnxvExeqsKygPWJZGewH/5JM6BfnXvS61O3gXjxO3X
         O3ggUkWasOUaSa7fmOADxsFkj3DomyKM6nCB6v7Qaxk4Rk7A8iKAqFmnv23w1ey1oMCC
         nmnbGKsayKWt1IJgNknnczFZ3d13fxryC4aKrwoZpPHxpSLVnyaKkhxxcFtxbN7kEO7k
         K/yQ==
Received: by 10.50.242.101 with SMTP id wp5mr4022352igc.12.1342398635507;
        Sun, 15 Jul 2012 17:30:35 -0700 (PDT)
Received: from burratino (cl-1372.chi-02.us.sixxs.net. [2001:4978:f:55b::2])
        by mx.google.com with ESMTPS id z3sm7469660igc.7.2012.07.15.17.30.33
        (version=SSLv3 cipher=OTHER);
        Sun, 15 Jul 2012 17:30:34 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1342362383-31167-1-git-send-email-florian.achleitner.2.6.31@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201491>

Hi Florian,

Florian Achleitner wrote:

> After importing new commits on top of refs/remotes/* the
> ref was overwritten with the local refs/heads/master, because the name
> of the remote reference to fetch, i.e. refs/heads/master, was used to
> retrieve old_sha1 for it's local counterpart. Therefore, old_sha1 pointed
> to the local head which was not contained in the remote branch and couldn't
> be updated (printing a warning ..).

I assume you are talking about the status quo here.  It's easy to
forget that others have not already applied your patch, but using the
present tense would make reading easier.  Think of the patch
description as a special kind of bug report.

Unfortunately, as a bug report, the above is lacking some detail.  Do
I understand correctly that some remote helper is failing when git
invokes its 'import' command?  What are the symptoms?  If it prints a
warning, what is the exact warning?

Does that remote helper advertise the 'refspec' capability?  If so,
what refspec does it use?  If not, why not?

It might seem silly to ask for these things when you're providing a
fix along with the report!  However, if someone else runs into the
same symptoms, they need to be able to find your patch quickly; if
your patch has a bad side-effect then we need to know why not to
revert it; and if someone new starts working on the same area of code,
they need to know what bugs to avoid reintroducing.

Curious,
Jonathan
