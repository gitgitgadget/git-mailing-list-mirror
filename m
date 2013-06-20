From: Dennis Kaarsemaker <dennis@kaarsemaker.net>
Subject: Re: [PATCH] remote: make prune work for mixed mirror/non-mirror
 repos
Date: Fri, 21 Jun 2013 01:29:48 +0200
Message-ID: <1371770988.17896.58.camel@localhost>
References: <1371763424.17896.32.camel@localhost>
	 <1371766304-4601-1-git-send-email-dennis@kaarsemaker.net>
	 <7vppvgpfib.fsf@alter.siamese.dyndns.org>
	 <20130620230843.GA5780@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jun 21 01:29:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UpoId-0005xp-Jl
	for gcvg-git-2@plane.gmane.org; Fri, 21 Jun 2013 01:29:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422657Ab3FTX3v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Jun 2013 19:29:51 -0400
Received: from mail-we0-f176.google.com ([74.125.82.176]:50567 "EHLO
	mail-we0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161046Ab3FTX3v (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Jun 2013 19:29:51 -0400
Received: by mail-we0-f176.google.com with SMTP id t56so5868022wes.21
        for <git@vger.kernel.org>; Thu, 20 Jun 2013 16:29:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :content-type:x-mailer:mime-version:content-transfer-encoding
         :x-gm-message-state;
        bh=gzbpUdG40PhnoN7PsWH8L9iV5AYm577T/wZKoanjExk=;
        b=G3GpYLdj/8pSm9t1csYk5skWTFslTg9ItQkeMZ6tq+Qcxsv4cJyxQ47jU5nmh+ySZu
         jF2yKk39f9anzzUXzBD8fz4CJsrA1wXxQDti1pA4w0lYMqYH9R+YTGFJTy/wMXCu3umO
         Kvx13Lbp24wbZ83yF5M3bidrRYhQ8i7U7bbXt3cOCT8mZHMcXnHcRPicR0q+san6AtRM
         8vD3MGfcIzApsLpBsmTg8irXQKu6doek6vJdxHm6Q5DWYJ5NTNoJpPnoQq+UvpYDgxj+
         JIOnIRBIP1eFFUgPpDV+mZxhv5Tf6rGFT3OYl38tI6F7n5FqSDw1+XFu1ggJC6oAh6zr
         5dLg==
X-Received: by 10.180.39.236 with SMTP id s12mr1079415wik.14.1371770989850;
        Thu, 20 Jun 2013 16:29:49 -0700 (PDT)
Received: from [10.42.1.4] (82-168-11-8.ip.telfort.nl. [82.168.11.8])
        by mx.google.com with ESMTPSA id nj19sm3728349wic.1.2013.06.20.16.29.48
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 20 Jun 2013 16:29:49 -0700 (PDT)
In-Reply-To: <20130620230843.GA5780@sigill.intra.peff.net>
X-Mailer: Evolution 3.6.2-0ubuntu0.1 
X-Gm-Message-State: ALoCoQnuqiyOEGvYk+KHRMGbbDEuSxL74NoNN49QIeFpAgF3wXeHZk3clpDgqNhXA20/QEpGWf2m
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228558>

On do, 2013-06-20 at 19:08 -0400, Jeff King wrote:

> I wonder why Dennis wants to "refs/*:refs/*" in the first place. It
> is not usually a useful thing to have in a non-bare repository,
> because fetches will overwrite local work on branches. If he just
> wanted the automatic "git push --mirror" setting, that does not depend
> on the fetch refspec.

I'm not doing that in non-bare repositories, neither do I use it for
pushing. It's for a continuous integration system, which never has any
locally created branches or commits, but does integrate things from
different remotes in some cases. The example with git.git is used
roughly as follows:

* git fetch all remotes (for most projects that will be 1 remote)
* rebuild reflogs from github events (or fetch via http/ssh)
* per push to next, check out to a separate $GIT_WORK_TREE and run make 
  test
* for the last push, also build and publish daily tarball+deb+rpm

Then, for further testing of local requirements:

* cherry-pick your jk/blame_tree branch
* test, build and install package

Given that this system works with clones of what should be considered
canonical copies of repositories, those remotes shouldn't have any
remotes defined themselves, so at least being able to configure prune to
ignore refs/remotes/* and refs/tags/* would help me a lot.

-- 
Dennis Kaarsemaker
www.kaarsemaker.net
