From: "Nigel Magnay" <nigel.magnay@gmail.com>
Subject: git submodules and commit
Date: Wed, 16 Jul 2008 11:32:48 +0100
Message-ID: <320075ff0807160332k5e49c256tb4191de628ecf41c@mail.gmail.com>
References: <320075ff0807160331j30e8f832m4de3e3bbe9c26801@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jul 16 12:33:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJ4KW-0008M3-8X
	for gcvg-git-2@gmane.org; Wed, 16 Jul 2008 12:33:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756677AbYGPKcx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jul 2008 06:32:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756676AbYGPKcx
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Jul 2008 06:32:53 -0400
Received: from yw-out-2324.google.com ([74.125.46.29]:5183 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756672AbYGPKcu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jul 2008 06:32:50 -0400
Received: by yw-out-2324.google.com with SMTP id 9so2710113ywe.1
        for <git@vger.kernel.org>; Wed, 16 Jul 2008 03:32:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=+Xv5mOCu9w9WL46P9frrRQVbUtMCEyxHLEIrozjW7LQ=;
        b=SjEIjhKw+jn07avFEhd+ssx/T7qRSBFFxzyZUJTPJ+FSbDCPDGj27zEHSIXS+oDIx2
         NU+uFLz3GNB2zw7p1E3GjH7CExwCAMg5x2uGHnImAWO7Jpy0p1TMo5IYGfs6YkdLb+wx
         Ha/cVBClidWBKPD70orJ39kuO6D/dF8NHcU5I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=wyy8NCsIuhYlvQBIx9qBEuscx2KKBpivwmQNI8vdR2c4IxjKo5TUnUXRoYWcnYCDIP
         iO6qWLW5+Z4FZ3wlRkuqn/x0TAgI+AEAsQnnG76WIJFUNN1vrkSo1J1RJqL3B2/PYf+F
         X0xCe7HnSDBEqqfDvXNQSU9/EonWWMozTnDYY=
Received: by 10.103.49.7 with SMTP id b7mr735693muk.104.1216204368363;
        Wed, 16 Jul 2008 03:32:48 -0700 (PDT)
Received: by 10.103.246.15 with HTTP; Wed, 16 Jul 2008 03:32:48 -0700 (PDT)
In-Reply-To: <320075ff0807160331j30e8f832m4de3e3bbe9c26801@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88658>

I wonder if this is a fairly common pattern. We tend to have modules
as git repositories, and projects that tie together those git
repositories as submodules. In general, > 90% of the work is done in
one module, and the following stanza gets used a lot:

cd /proj/modA
git commit -s -m "Some change"
git push

cd ..
git add modA
git commit -s -m "Some change (modA)"
git push

But since this is much more cumbersome than (say) "svn ci", what often
happens is developers just commit into modA, then carry on. Or for
people just learning git, they somtimes screw up, and push the parent
proj but not the child modA

This is a shame, as it means any external people pulling updates
directly from proj will not get this change (e.g. CI tools
speculatively compiling against every developer tree).

For me, in some really high proportion of cases, I think I want 'git
commit' to mean 'commit to any child repositories, any sibling
repositories, and any parent repositories (updating the submodule sha1
as appropriate). In other words, 'pretend like the whole thing is one
big repo'.

I guess it probably gets sticky when there are merge conflicts. Is
anyone working on this kind of thing; I might be able to give some
time to help work on it?
