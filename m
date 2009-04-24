From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH 0/3] http-push: fix fetching
Date: Sat, 25 Apr 2009 00:35:16 +0800
Message-ID: <49F1EA44.6010209@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 24 18:41:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LxOPQ-0007gN-2o
	for gcvg-git-2@gmane.org; Fri, 24 Apr 2009 18:37:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754323AbZDXQgT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Apr 2009 12:36:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752373AbZDXQgS
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Apr 2009 12:36:18 -0400
Received: from rv-out-0506.google.com ([209.85.198.226]:59162 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751105AbZDXQgR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Apr 2009 12:36:17 -0400
Received: by rv-out-0506.google.com with SMTP id f9so1071259rvb.1
        for <git@vger.kernel.org>; Fri, 24 Apr 2009 09:36:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:subject:content-type
         :content-transfer-encoding;
        bh=00w5DhuBjlscUNxHTr7y1jyznUZNsFYywfb9kPMET/c=;
        b=q/IPcYxxIv6ckbRTrWKX7/v+KCtQJD5+xctWFBef4h2i16pWhcDkCkYOSFZJkNmb3T
         OyAdo5q5fVq2Lk1U9wOr7JsJWPbUhE2vFEeHLlCpdau64PxczaXOcr9dEYoiVjWUvBVA
         gHqcuHH0UvAfdw3c8c5YD9Ttzt7xbkseHE1c0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:subject
         :content-type:content-transfer-encoding;
        b=Rw3PYKjj9zUS5cdjh5JThtdVYOTbPP50X01WOt6gfDglFxtvt5CcBO7Ry6+89xlLgU
         3AgW38ITRZPo8tXG+ipegEYC7hZX+wNKsuRfjUKgr6D8/Bg7dC4CMZdmIKf7WWAh1CTb
         F65tges7cF57uQUwCCyXdrdkNbm9h4DzIV/2U=
Received: by 10.114.176.7 with SMTP id y7mr1442923wae.194.1240590977317;
        Fri, 24 Apr 2009 09:36:17 -0700 (PDT)
Received: from ?116.87.149.49? (cm49.zeta149.maxonline.com.sg [116.87.149.49])
        by mx.google.com with ESMTPS id v32sm1962177wah.24.2009.04.24.09.36.15
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 24 Apr 2009 09:36:16 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.21 (Windows/20090302)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117466>

http-push.c contains a lot of fetching code, but it's not known if it
really works, given that most people fetch first before pushing (after
all, the git manual recommends this).

The first two patches add tests[1] that demonstrate that http-push.c
fails to fetch from the remote repo, and remedy this by ensuring fetch
requests are sent out. Along the way, code that sends out requests on
the requests queue is refactored (run_request_queue()), and a mechanism
against accidental pushing to the remote side is introduced.

Footnotes:
[1] the tests coerce http-push into fetching objects from the repo by
    removing local objects before executing http-push, and represent
    just one possible workflow that lead to fetching in http-push.

Tay Ray Chuan (3):
  t5540-http-push: test fetching of loose objects
  t5540-http-push: test fetching of packed objects
  http-push: send out fetch requests on queue

 http-push.c          |   37 ++++++++++++++++++++++++++-----------
 t/t5540-http-push.sh |   36 ++++++++++++++++++++++++++++++++++++
 2 files changed, 62 insertions(+), 11 deletions(-)


-- 
Cheers,
Ray Chuan
