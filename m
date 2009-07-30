From: Troy Telford <ttelford.groups@gmail.com>
Subject: Re: git-fast-import question
Date: Wed, 29 Jul 2009 18:00:02 -0600
Message-ID: <1e30a6d10907291700u55eef62cy22c87815602616ee@mail.gmail.com>
References: <1e30a6d10907291536y3ec68caq8788aef2b7c34a6f@mail.gmail.com>
	 <20090729224855.GD1033@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Jul 30 02:00:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MWJ4A-00005g-FQ
	for gcvg-git-2@gmane.org; Thu, 30 Jul 2009 02:00:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755240AbZG3AAE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Jul 2009 20:00:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755233AbZG3AAE
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Jul 2009 20:00:04 -0400
Received: from qw-out-2122.google.com ([74.125.92.25]:14258 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755210AbZG3AAC (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Jul 2009 20:00:02 -0400
Received: by qw-out-2122.google.com with SMTP id 8so638293qwh.37
        for <git@vger.kernel.org>; Wed, 29 Jul 2009 17:00:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=JqM7uPJCH8qtRxOfxlVD+NiSE9r8qu4ZbtV33p7WMpo=;
        b=LgtpVWjJXPi0AKdf++QF5ht2lb6w9gqBoIpFbNBfV5fLasJt5qMmqdeK6tnNkR7PJg
         Qq+m4ctGQkl7dfElQxctOsAYj+0raE9M9A4f00VN8RVP1y/ZY3sIVcvR+YkGuHjSYIux
         yisFnrFPO3wlgII+fzMUBMkVkROCx9+Sba1tY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=ly4YmDycovvHbsVQyOdHANtgsK9EuHptWZ3oFi4Jn9YuL/OqUH76sqmxMDw5H5AFii
         KHYMRmUXhFPiFCo7LxgXBKdON5Cm3QOSaKNp8Np6sdxszIv9DMpXzT7upwQzkq5gyvf8
         lOpGguEl4gIveOe7xfqPIyxPBkgUyBBCRwPXQ=
Received: by 10.229.89.146 with SMTP id e18mr95499qcm.23.1248912002886; Wed, 
	29 Jul 2009 17:00:02 -0700 (PDT)
In-Reply-To: <20090729224855.GD1033@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124413>

> My initial guess is, you don't have what
> you think you have.

Thanks for the tip - you're right in that I don't have what I think I have.

Namely, there are entire sections of the dump file that aren't getting
imported.  fast-import isn't complaining about it either.

commit refs/heads/foo
<various metadata>
M 100644 :mark path/to/some/file

Isn't getting imported (to any branch, let alone refs/heads/foo)

So when the later commit wants to rename the file, it can't be found.

Digging a bit deeper, I found a few cases where I'd have something
along the lines of:

commit refs/heads/foo
mark :1
<etc, etc.>

commit refs/heads/foo
mark :2
from :1
<etc, etc>

ie. two sequential commits, to the same branch.  The first commit is
being imported; the second commit isn't being imported.  Many
subsequent commits are similarly cast aside - then for no reason I can
tell, commits start getting imported again.  I'd expect fast-import to
complain, but that doesn't seem to be happening.
