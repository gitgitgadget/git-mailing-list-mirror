From: Stefan Karpinski <stefan.karpinski@gmail.com>
Subject: Re: [RFC] post-commit hook to "fix" patches
Date: Wed, 11 Feb 2009 01:56:23 -0800
Message-ID: <d4bc1a2a0902110156nff21282q5fe0a6b7b656a0e6@mail.gmail.com>
References: <d4bc1a2a0902110148u4e13d77cs3dde64d27003e58c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Alex Riesen <raa.lkml@gmail.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Jonathan del Strother <maillist@steelskies.com>,
	A Large Angry SCM <gitzilla@gmail.com>,
	Marc Weber <marco-oweber@gmx.de>
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Feb 11 10:57:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LXBqq-0004Be-Ds
	for gcvg-git-2@gmane.org; Wed, 11 Feb 2009 10:57:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754332AbZBKJ40 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Feb 2009 04:56:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752645AbZBKJ4Z
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Feb 2009 04:56:25 -0500
Received: from wa-out-1112.google.com ([209.85.146.182]:28547 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752546AbZBKJ4Y (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Feb 2009 04:56:24 -0500
Received: by wa-out-1112.google.com with SMTP id v33so62169wah.21
        for <git@vger.kernel.org>; Wed, 11 Feb 2009 01:56:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=RC5/kRoU1OwfyHZq8lOLJEhUfV2x/a6nz17FvffcbwE=;
        b=hp30pqXgwgIhB76huLbD4Nq8mJw7n4vYLdtXUI7CyJfx4hFGkIIxQgpHpZr8qFn4rA
         65XTE1jRk0p8iaIie/XGeLim6q5LpFnRl/hPmBH62eC5rz4kHZJVgcaxMRAR2BpmAuE9
         Y8t1qGOf85uMXB/JdcOAMCIDy6KDW7xsRy/NM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=Q4++DxsIb1+2GvY8lS2A0nkGy8DkWAD5Z1Sy/dqwUN5QbvPr0ibKYK86RlB4FgZYyU
         rvY7RsM4M+715yvPtMkQ/vBB423KyL/iKrRUFf6L9jLDUIwQmdpmbj+sTq+M1/Hidckm
         B8AJQXQ8VKenW2JJgDB1M7c5rMPbvaixBUQWg=
Received: by 10.114.157.1 with SMTP id f1mr5458702wae.43.1234346183395; Wed, 
	11 Feb 2009 01:56:23 -0800 (PST)
In-Reply-To: <d4bc1a2a0902110148u4e13d77cs3dde64d27003e58c@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109395>

I'm CC'ing a couple people who replied to the thread I referenced
earlier, in case they're interested and would otherwise miss this
message.

Especially Marc Weber, who expressed interest in having a good
solution to this problem. Does this address what you wanted? I like it
because it allows you to transparently and automatically enforce style
policy and:

  - it doesn't require modifying git,
  - it's efficient (no overhead except on commit),
  - it doesn't pretend to be a clean/smudge filter (as people pointed
out this isn't reversible),
  - it's portable: everything's written in sh and perl.
