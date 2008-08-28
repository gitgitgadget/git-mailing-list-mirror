From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: ref markers link to named shortlogs
Date: Thu, 28 Aug 2008 08:48:32 +0200
Message-ID: <200808280848.34084.jnareb@gmail.com>
References: <1219341860-4913-1-git-send-email-giuseppe.bilotta@gmail.com> <200808261349.28771.jnareb@gmail.com> <48B602B5.1070304@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>, git@vger.kernel.org,
	Petr Baudis <pasky@ucw.cz>, Junio C Hamano <gitster@pobox.com>
To: Lea Wiemann <lewiemann@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 28 08:49:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYbKF-0004MX-Kf
	for gcvg-git-2@gmane.org; Thu, 28 Aug 2008 08:49:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752415AbYH1Gsm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Aug 2008 02:48:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752248AbYH1Gsm
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Aug 2008 02:48:42 -0400
Received: from ug-out-1314.google.com ([66.249.92.173]:17482 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752064AbYH1Gsl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Aug 2008 02:48:41 -0400
Received: by ug-out-1314.google.com with SMTP id c2so1076926ugf.37
        for <git@vger.kernel.org>; Wed, 27 Aug 2008 23:48:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=y9De+KNTAqXeS9ixFNNhL2t2uHYTS59m5n+8NE3mwEs=;
        b=hE2KOOrftZmrDHsCZtzvm2bFgcaazaCqGGqQQD3USyBhIE6I5DkFPhUJY6gnHrlLct
         JvpaTsnSaDVbgAltdT3SKRoDUcdRi35iDrapoBWgQUJl7YJP4j0PJ6e3MOJpAgWK0dsX
         i5Bj16GSbHWp2kA0z5+rJLbBqWEXYTEkri/Gs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=iEdWudo5NYS8QOvCxE+zI5djMxkhEP96p6XzUzVejLjSw4z2IMuSS01ddrNxNWwS9T
         GVEBJ5DIaaWCHxjCYbASAVrhP3dBP5Cc9C23jA6zeMkGpTzbCSxxgbJvXOwMmHvqFI4+
         s58PLC6H09ixVccRZCIYUR8pSLiHLv4sQAFLA=
Received: by 10.66.245.2 with SMTP id s2mr2914309ugh.80.1219906119421;
        Wed, 27 Aug 2008 23:48:39 -0700 (PDT)
Received: from ?192.168.1.11? ( [83.8.214.109])
        by mx.google.com with ESMTPS id 7sm731569eyb.1.2008.08.27.23.48.37
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 27 Aug 2008 23:48:38 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <48B602B5.1070304@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Lea Wiemann wrote:
> Jakub Narebski wrote:
> >
> > By the way, this is argument *for* selecting action when generating
> > link, if it is possible without incurring unnecessary (if you don't
> > follow the link) performance penalty.
> 
> I agree that it's much cleaner to select the action when generating the
> page, rather than having an 'objectview' action or so.
> 
> Worrying about performance seems like premature optimization though --
> my guesstimate is that the performance penalty for looking up the object
> type is not practically noticeable (read: relevant), and with my patch
> applied (even without caching activated) it should move below the
> measurable range.  So don't complicate the code to gain another 0.01%
> performance. ;-)

First, without your 'git cat-file --batch-check' reuse-connection trick
it wouldn't be _one_ additional fork; it is one fork per ref marker,
which might be quite a lot in tag-heavy, branch-heavy, and using for
example StGIT (with its refs) environment.  Note that not all operating
systems have lightweight fork, and that even with "caching" it is IO hit,
and a bit of CPU hit.

Second, it isn't much more code than git_get_type solution, it is bit
larger change: leave ^{} alone, check if ^{} and strip it, as compared
to git_get_type.

-- 
Jakub Narebski
Poland
