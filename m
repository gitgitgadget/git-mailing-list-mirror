From: Dan Zwell <dzwell@gmail.com>
Subject: [PATCH] Git.pm: Don't return 'undef' in vector context.
Date: Fri, 16 Nov 2007 00:15:47 -0600
Message-ID: <473D3593.9080806@zwell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Nov 16 07:17:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IsuW9-00031t-GQ
	for gcvg-git-2@gmane.org; Fri, 16 Nov 2007 07:17:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751581AbXKPGRM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Nov 2007 01:17:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751432AbXKPGRL
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Nov 2007 01:17:11 -0500
Received: from py-out-1112.google.com ([64.233.166.180]:5423 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751365AbXKPGRJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Nov 2007 01:17:09 -0500
Received: by py-out-1112.google.com with SMTP id u77so4010381pyb
        for <git@vger.kernel.org>; Thu, 15 Nov 2007 22:17:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:user-agent:mime-version:to:subject:content-type:content-transfer-encoding:from;
        bh=qfID8tltHMnAjC+9R5Whsrzz8bOJc3ETYxiNv95JjPs=;
        b=F+JGrj9OALk/9EYasEh+VdibvX/rGfIsDKQmtFNrkq17DdqquNbcBs+K6oV+Zuk4wNt1YpDxCkzuIqGRtrkG7YilQu2mvxolA23h4q9rNynLJYiCMzu0QYZd5phfRGE0NHAkbwpeWV0xa0nJ/vm2khWbX7x+1fsPNA4bQJnN9qc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:user-agent:mime-version:to:subject:content-type:content-transfer-encoding:from;
        b=Th9sQT/l+j1HO4m5LKcBu+tL89TvMJBIsafIg4u6jy/kdByz6XKcou154oCizGbq7W81oe6R+xEvSJb6FsxoEDU5SAhbo4TWvBi10nJ70cgZgfzMVahGQE62dNfhpDV0VRFhHt2B12AWg/+UCwJDKIKo3rlU8UKc4CVi0pOC+hc=
Received: by 10.35.102.1 with SMTP id e1mr1766902pym.1195193828857;
        Thu, 15 Nov 2007 22:17:08 -0800 (PST)
Received: from ?143.44.70.185? ( [143.44.70.185])
        by mx.google.com with ESMTPS id f10sm6194440pyh.2007.11.15.22.17.00
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 15 Nov 2007 22:17:08 -0800 (PST)
User-Agent: Thunderbird 2.0.0.6 (X11/20071031)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65196>

Previously, the Git->repository()->config('non-existent.key')
evaluated to as true in a vector context. Return an empty list
instead.
---
I don't know whether this breaks anything, because I don't use most of 
the git perl scripts. I can't imagine that there is a script that relies 
on the fact that config('non-existent.key') actually returns (''), in an 
array context. Is this a reasonable change?

  perl/Git.pm |    2 +-
  1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/perl/Git.pm b/perl/Git.pm
index e9dc706..ffcc541 100644
--- a/perl/Git.pm
+++ b/perl/Git.pm
@@ -508,7 +508,7 @@ sub config {
  		my $E = shift;
  		if ($E->value() == 1) {
  			# Key not found.
-			return undef;
+			return wantarray ? () : undef;
  		} else {
  			throw $E;
  		}
-- 
1.5.3.5.565.gf0b83-dirty
