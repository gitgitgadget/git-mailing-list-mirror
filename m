From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v4 19/32] commit_lock_file(): rollback lock file on
 failure to rename
Date: Wed, 10 Sep 2014 19:55:07 +0700
Message-ID: <CACsJy8AOvyt3FxcnZKa+x77WJ90Zn7DhiBUpbQ8DhU-D3SLfyA@mail.gmail.com>
References: <1409989846-22401-1-git-send-email-mhagger@alum.mit.edu>
 <1409989846-22401-20-git-send-email-mhagger@alum.mit.edu> <20140910075519.GA16413@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j6t@kdbg.org>,
	=?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Sep 10 14:55:58 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XRhR1-0003of-09
	for gcvg-git-2@plane.gmane.org; Wed, 10 Sep 2014 14:55:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751013AbaIJMzj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Sep 2014 08:55:39 -0400
Received: from mail-ig0-f172.google.com ([209.85.213.172]:41070 "EHLO
	mail-ig0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750770AbaIJMzi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Sep 2014 08:55:38 -0400
Received: by mail-ig0-f172.google.com with SMTP id h15so6405499igd.5
        for <git@vger.kernel.org>; Wed, 10 Sep 2014 05:55:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=gpyeGYpBUaLMi293d7OHb5VfawZH0ZZotqSft3OGEZg=;
        b=jtXFcx47Ny2VK3Ozro8G3/p+kpOxU4xS/v2teH5Ju2hmspbxjc+Gm0ERDdLBpO55Et
         fqE/zv7Zdj6mFYg/Qd7ItmHazqrKOlZ6dO1KAbZkYvC8INXJBWA+DGiLWw3O8KSlIbnB
         u6wrooEY9gTv2NhRPMiAo4EK8LGmoE1WCy4bv+WNoR1iBJWZjBUgBWiXpdHkMJ4n7fPK
         oeMrKQcx3XTtHhsrY7gP8szDB9MmHuXVOnc60TPv047R2hG0YgMlr/heyTMzCaXSovGZ
         dv1YlZKMPBvYr8C2J6/0Bsf/2k9WqjCG0cSEcC87vO6J2KC/yPRO2F925L3cr8aCSZB1
         8Akg==
X-Received: by 10.42.136.129 with SMTP id u1mr17310176ict.65.1410353738052;
 Wed, 10 Sep 2014 05:55:38 -0700 (PDT)
Received: by 10.107.131.150 with HTTP; Wed, 10 Sep 2014 05:55:07 -0700 (PDT)
In-Reply-To: <20140910075519.GA16413@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256736>

On Wed, Sep 10, 2014 at 2:55 PM, Jeff King <peff@peff.net> wrote:
> BTW, while grepping for commit_lock_file calls, I notice we often commit
> the shallow file without checking the return code. I'm not sure what we
> should do in each case, but I imagine that calling die() is probably
> better than continuing as if it succeeded. +cc Duy

Noted. To be fixed soon. It looks like we could make gcc warn about
ignoring return code like this with
__attribute__((warn_unused_result)) (but I haven't tested). If it does
help catch mishandling in future commit_lock_file calls and does not
upset other compilers, we may want to add it to commit_lock_file.
-- 
Duy
