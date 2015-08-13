From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH v3 3/4] refs: make refs/worktree/* per-worktree
Date: Thu, 13 Aug 2015 13:41:48 -0400
Organization: Twitter
Message-ID: <1439487708.8855.2.camel@twopensource.com>
References: <1439416645-19173-1-git-send-email-dturner@twopensource.com>
	 <1439416645-19173-3-git-send-email-dturner@twopensource.com>
	 <CAPig+cRM-J-5SHJ9JVsHPR+B2Y05nwFrRQWsd0M56pm9jS-mTQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Git List <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Christian Couder <chriscool@tuxfamily.org>,
	=?UTF-8?Q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc?= Duy 
	<pclouds@gmail.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Thu Aug 13 19:41:57 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZPwVn-0007Zo-OG
	for gcvg-git-2@plane.gmane.org; Thu, 13 Aug 2015 19:41:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753040AbbHMRlv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Aug 2015 13:41:51 -0400
Received: from mail-qg0-f49.google.com ([209.85.192.49]:33561 "EHLO
	mail-qg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751559AbbHMRlu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Aug 2015 13:41:50 -0400
Received: by qged69 with SMTP id d69so35837012qge.0
        for <git@vger.kernel.org>; Thu, 13 Aug 2015 10:41:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:content-type:mime-version
         :content-transfer-encoding;
        bh=FbUn41lV0kwW/ooqO/UbULL+/x1KnEACkuinT3hXpww=;
        b=AQ+Gu2MeXvyPptNRD/ZcLY3wJM7QRjcELOXQ54PuXAiUyrMzaKvzYQlpN/tKrIgS7i
         /e2PAhYoeWeGaunABkZFVN+gixWLQP93g69aMeg4K+gDR2uRq4oCxzNq3WonO3XBbmz5
         WpJGbZa41sh1pKQWaGDw1JLmr2mcX+NN3s0Nntncvyseqrk8bOXJ7mXwEAqQIpiugw0U
         IoIcp9tKOi1db6WjKoP0aIZPkwAeVbpBSsFfHSvaS2Py8zlUy87AodFGs0TOVUkJInD8
         pnR5Oz0uVSGCjoAULbjaXbfZRvZmjjc8dp6hWmfyYwzGL5681dwQ+6bb4wQYoVHgIMWW
         Epdg==
X-Gm-Message-State: ALoCoQlqoJRchOr85Qi8z0G38dlOEwh1VHkxEVlzzrSii7n8Jk13AFfP3YPw2jRXXI0TPTq5wzXF
X-Received: by 10.140.238.195 with SMTP id j186mr18616223qhc.21.1439487710049;
        Thu, 13 Aug 2015 10:41:50 -0700 (PDT)
Received: from ubuntu ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id f194sm1479562qka.49.2015.08.13.10.41.48
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Aug 2015 10:41:49 -0700 (PDT)
In-Reply-To: <CAPig+cRM-J-5SHJ9JVsHPR+B2Y05nwFrRQWsd0M56pm9jS-mTQ@mail.gmail.com>
X-Mailer: Evolution 3.12.11-0ubuntu3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275866>

On Thu, 2015-08-13 at 13:15 -0400, Eric Sunshine wrote:
> On Wed, Aug 12, 2015 at 5:57 PM, David Turner <dturner@twopensource.com> wrote:
> > diff --git a/t/t0060-path-utils.sh b/t/t0060-path-utils.sh
> > index 93605f4..28e6dff 100755
> > --- a/t/t0060-path-utils.sh
> > +++ b/t/t0060-path-utils.sh
> > +test_expect_success 'handle per-worktree refs in refs/worktree' '
> > +       git commit --allow-empty -m "initial commit" &&
> > +       git worktree add -b branch worktree &&
> > +       (
> > +               cd worktree &&
> > +               git commit --allow-empty -m "test commit"  &&
> > +               git for-each-ref | test_must_fail grep refs/worktree &&
> 
> s/test_must_fail/!/
> 
> From t/README:
> 
>    On the other hand, don't use test_must_fail for running regular
>    platform commands; just use '! cmd'.  We are not in the business
>    of verifying that the world given to us sanely works.

When I make that change, my test fails with:

FATAL: Unexpected exit with code 2

Apparently, you can't use ! in pipelines like that.  So that's why I
used test_must_fail.
