From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Bug in git-stash(.sh) ?
Date: Fri, 27 Apr 2012 16:02:09 -0700
Message-ID: <xmqqvckk93ta.fsf@junio.mtv.corp.google.com>
References: <20379.9312.943088.350379@winooski.ccs.neu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Eli Barzilay <public-eli-oSK4jVRJLyZg9hUCZPvPmw@plane.gmane.org>
X-From: git-owner@vger.kernel.org Sat Apr 28 01:02:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SNuB8-0001w0-7p
	for gcvg-git-2@plane.gmane.org; Sat, 28 Apr 2012 01:02:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756780Ab2D0XCN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Apr 2012 19:02:13 -0400
Received: from mail-ey0-f202.google.com ([209.85.215.202]:64871 "EHLO
	mail-ey0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756523Ab2D0XCL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Apr 2012 19:02:11 -0400
Received: by eaaq10 with SMTP id q10so60395eaa.1
        for <git@vger.kernel.org>; Fri, 27 Apr 2012 16:02:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type:x-gm-message-state;
        bh=P3f9Lfk/VttTUXOmL8NmPgkQklP5+wkjFKBR9B2PEFg=;
        b=k633xUEx5T6FeFhfehCRF8rTVa3y2M5cDlVUT6yn1sA+hDH7ls3caY9dIiAeMm/NGL
         8XnXhOIU8BCG2jGBI+axCBGcvkUavoCybVEnxBnigwYSgSL3NfBoowZBrBK6ZlunOigv
         kMNYuUICvq/yyU3t+2VW3caF6Jcst+b7125hJ+CdtUNHBDCHp4y04dBuSCe+rPrkz0+w
         hiW+Ksy6Tt+NCyOdpJnWtm9cFid968PiLdt6YP0xl5fqVHyCEiTyb/NXc6r2SQtuDFjm
         /02XnJzA1ZR6eVIu+opntrwCkgNV504NAseQdGvGo9ECzTVb8mLzKxRdvRW6NBBpEad2
         /yDw==
Received: by 10.14.101.16 with SMTP id a16mr3435689eeg.0.1335567730628;
        Fri, 27 Apr 2012 16:02:10 -0700 (PDT)
Received: by 10.14.101.16 with SMTP id a16mr3435678eeg.0.1335567730519;
        Fri, 27 Apr 2012 16:02:10 -0700 (PDT)
Received: from hpza10.eem.corp.google.com ([74.125.121.33])
        by gmr-mx.google.com with ESMTPS id y52si7623328eef.2.2012.04.27.16.02.10
        (version=TLSv1/SSLv3 cipher=AES128-SHA);
        Fri, 27 Apr 2012 16:02:10 -0700 (PDT)
Received: from junio.mtv.corp.google.com (junio.mtv.corp.google.com [172.27.69.24])
	by hpza10.eem.corp.google.com (Postfix) with ESMTP id 53C4520004E;
	Fri, 27 Apr 2012 16:02:10 -0700 (PDT)
Received: by junio.mtv.corp.google.com (Postfix, from userid 110493)
	id A6EBFE125C; Fri, 27 Apr 2012 16:02:09 -0700 (PDT)
In-Reply-To: <20379.9312.943088.350379@winooski.ccs.neu.edu> (Eli Barzilay's
	message of "Fri, 27 Apr 2012 18:57:36 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1 (gnu/linux)
X-Gm-Message-State: ALoCoQm6zqGYvGKS08MnwYDKq4/9cTo3a98daR+5+A+FsoOP4XzWG/C5cpEUT8MDCNbLCoh4NjBhNniHOZsxV1zWOqVk4K+23MeQplOY9gN5KQSyLAIsxXAE6tuwKciMxzU4j9CITgLqtXEddq8vKAmE3I1sC0h+zD49h7OSq5hWDTDaGAsHiA8=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196489>

Eli Barzilay <eli-oSK4jVRJLyZg9hUCZPvPmw@public.gmane.org> writes:

> For a while now I had a problem when I try to do stash operations via
> magit -- for example, it shows this in the process buffer:
>
>   $ git --no-pager stash apply stash@{2012-04-27 08:53:30 -0400}
>   Too many revisions specified: stash@{2012-04-27 08:53:30 -0400}

Not surprised; as far as I understand, ever since the original design,
the stash entries are meant to be _counted_, i.e. stash@{0}, stash@{1},
stash@{2}, ... and never timed.

I do not mind a fix, but I would prefer a solution that does *not*
involve $IFS hack that would not work with a string with LF in it.
