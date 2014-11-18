From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] t960[34]: mark cvsimport tests as requiring perl
Date: Tue, 18 Nov 2014 10:56:22 -0800
Message-ID: <20141118185622.GG6527@google.com>
References: <20141118172231.GA16387@peff.net>
 <20141118172932.GA31672@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Nov 18 19:56:45 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XqnxE-0005Vh-NI
	for gcvg-git-2@plane.gmane.org; Tue, 18 Nov 2014 19:56:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755204AbaKRS4j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Nov 2014 13:56:39 -0500
Received: from mail-ig0-f171.google.com ([209.85.213.171]:57703 "EHLO
	mail-ig0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755253AbaKRS4V (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Nov 2014 13:56:21 -0500
Received: by mail-ig0-f171.google.com with SMTP id uq10so1543735igb.4
        for <git@vger.kernel.org>; Tue, 18 Nov 2014 10:56:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=FfC/4AwimsYkBuBHSe7KCEAJwKv/AD7EnmYJHfdcG/g=;
        b=EWV91xfN9lYm7O55Hu6F/t3NSPmn77EE4Dnztj1fX9lWb/fLUBmFUDv+4nAscQHU73
         56PPoDwm6xgpyEuD9yllcAdMjzMNMhllH4c1owoRS6/iXlGZqNBLHtXXLPf9JMrnP14e
         W4MCXbMb7IpD8l0WOiijbFcjb8tLQSeQvHta3zwJGHyDForyEJa6vNaKvA/xDd6te8Pw
         Vi+zokRqYlrnW5vVqIlxE6HT8wV7VybQO6XgT4Z2FB2fO8mOuBt42iuO2d6X/i0qFoPf
         0L1Nde3pbjOH1mz0I/ozvcNs5MrIMJ/LpWZHYfmw+tZdFjd4ww+4pWvJcshMN2U2emBs
         HH6g==
X-Received: by 10.107.16.130 with SMTP id 2mr4443423ioq.81.1416336980833;
        Tue, 18 Nov 2014 10:56:20 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:1d6d:1067:602d:d9c7])
        by mx.google.com with ESMTPSA id kv4sm8114594igb.13.2014.11.18.10.56.18
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 18 Nov 2014 10:56:19 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20141118172932.GA31672@peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King wrote:

> It would probably make sense to have these scripts just
> skip_all if NO_PERL is set, but I opted to follow the pattern
> set by t9600, etc. If somebody feels like spending time refactoring the
> cvsimport test harness, be my guest.

Wouldn't it be a matter of the following, plus (optionally) dropping
the existing PERL prerequisites on cvs tests?

-- >8 --
Subject: test: cvsimport requires perl

Git-cvsimport is written in perl, which understandably causes the
tests to fail if you build with NO_PERL (which will avoid building
cvsimport at all). The earlier cvsimport tests in t9600-t9602 are all
marked with a PERL prerequisite, but t9603 and 9604 are not.

The one in t9603 was likely not noticed because it is an expected
failure.

The ones in t9604 have been around for a long time, but it is likely
that the combination of NO_PERL and having cvsps installed is rare
enough that nobody noticed.

Reported-by: Jeff King <peff@peff.net>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 t/lib-cvs.sh | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/t/lib-cvs.sh b/t/lib-cvs.sh
index 9b2bcfb..b75df11 100644
--- a/t/lib-cvs.sh
+++ b/t/lib-cvs.sh
@@ -10,6 +10,12 @@ then
 	test_done
 fi
 
+if ! test_have_prereq PERL
+then
+	skip_all='skipping cvsimport tests, perl not available'
+	test_done
+fi
+
 CVS="cvs -f"
 export CVS
 
-- 
2.1.0.rc2.206.gedb03e5
