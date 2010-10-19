From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [RFC/PATCH 0/4] reset: be more flexible about <rev>
Date: Tue, 19 Oct 2010 17:10:05 -0500
Message-ID: <20101019221005.GC32029@burratino>
References: <8835ADF9-45E5-4A26-9F7F-A72ECC065BB2@gmail.com>
 <AANLkTimkovH9OysLSxA+=di89Xi+dTCYL5hRPmNaADDH@mail.gmail.com>
 <20101019175103.GA28847@kytes>
 <20101019182845.GE25139@burratino>
 <7vhbgiyoo9.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Thore Husfeldt <thore.husfeldt@gmail.com>, git@vger.kernel.org,
	Scott Chacon <schacon@gmail.com>,
	Thomas Rast <trast@student.ethz.ch>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 20 00:13:55 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P8KRO-0006yl-Lq
	for gcvg-git-2@lo.gmane.org; Wed, 20 Oct 2010 00:13:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754600Ab0JSWNq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Oct 2010 18:13:46 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:59158 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753993Ab0JSWNq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Oct 2010 18:13:46 -0400
Received: by iwn7 with SMTP id 7so1390297iwn.19
        for <git@vger.kernel.org>; Tue, 19 Oct 2010 15:13:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=1/XwbsxUaadjyaO+wgwyxNhHJ9MJ2Qccv1kfR6K4UsQ=;
        b=nzLAAbXPEo1KEPPPOPRsUswgm51q+cc5AewAzRz7DyOpEnMN306ta0Xe6KGi18RAzn
         wyRFeubMmLYJ1/FMU4VQHTBJYFmQLKkpLam+Zz6YdvaSSUiV48M4f5zkzKTsAQ7CHbod
         AO5kgUtJmFc3Jhg1pDGml/ANp9m5V+iKMntOI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=sMucBaaFSCluRtpv1PkQcjOPDkY0OpvTD7dd4EgmRCJgaNJcNkqZkNeblGMUz2/Zji
         wmYiBGjOhNpYQeCYTaiI8DLOIMQc3giTvhhNH/JKuj6fLQn/3wIsfPiEwnW+lGydxlqS
         U3t1JlTN7jOcYTvx0NEyjM1zXsoszXSiMeQKg=
Received: by 10.231.32.73 with SMTP id b9mr5449930ibd.133.1287526425553;
        Tue, 19 Oct 2010 15:13:45 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.ameritech.net [68.255.106.176])
        by mx.google.com with ESMTPS id m10sm5277736vcf.45.2010.10.19.15.13.43
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 19 Oct 2010 15:13:44 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7vhbgiyoo9.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159370>

Junio C Hamano wrote:

> It is probably Ok to limit the scope of this change to the case without
> any explicit rev, e.g. "git reset -- frotz.c", but at that point I somehow
> don't think it will reduce confusion but rather will make things worse.

I wouldn't be surprised to find people using

	git reset HEAD <paths>

just because '--' did not come to mind quickly enough.  For example, I
have a faint memory of doing that myself a couple of years ago.  Why
should Git mind?

Patch 1 below teaches reset -p to accept an arbitrary tree for <rev>.
Unfortunately add--interactive notices but does not error out when
<rev> is a blob; that should be fixed in the add--interactive script
by checking the exit status of commands it runs, I think (help from
those more comfortable in perl would be appreciated).

Patch 2 removes the arbitrary restriction in "git reset <rev>
<path>" that <rev> be a commit.  It also paves the way for writing
patch 3 more clearly.

Patch 3 is the "probably Ok" change you mentioned above.  It allows
use of "git reset" to un-add a file from an unborn branch.

Patch 4 is like patch 3, but for "git reset HEAD".

Help on finishing up patch 1 (or comments to the effect that it is
pointless) would be welcome.

Jonathan Nieder (4):
  reset -p: accept "git reset -p <tree>"
  reset: accept "git reset <tree> <path>"
  reset: accept "git reset -- <path>" from unborn branch
  reset: accept "git reset HEAD <path>" from unborn branch

 builtin/reset.c         |   27 ++++++++++++++++-------
 t/t7102-reset.sh        |   31 +++++++++++++++++++++++++++
 t/t7105-reset-patch.sh  |   12 ++++++++++
 t/t7106-reset-unborn.sh |   53 +++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 115 insertions(+), 8 deletions(-)
 create mode 100755 t/t7106-reset-unborn.sh

-- 
1.7.2.3
