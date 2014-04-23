From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [RFC/PATCH v2 3/3] Add 'update-branch' hook
Date: Wed, 23 Apr 2014 16:35:54 -0500
Message-ID: <5358323a29162_24448772ec5a@nysa.notmuch>
References: <1398282160-26151-1-git-send-email-felipe.contreras@gmail.com>
 <1398282160-26151-4-git-send-email-felipe.contreras@gmail.com>
 <xmqqsip3yemg.fsf@gitster.dls.corp.google.com>
 <53582bb6ceb64_24448772ecaf@nysa.notmuch>
 <xmqq8uqvyc53.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Ilya Bobyr <ilya.bobyr@gmail.com>
To: Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 23 23:46:34 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wd4zx-0004Dx-P3
	for gcvg-git-2@plane.gmane.org; Wed, 23 Apr 2014 23:46:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751403AbaDWVqZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Apr 2014 17:46:25 -0400
Received: from mail-oa0-f41.google.com ([209.85.219.41]:61066 "EHLO
	mail-oa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750980AbaDWVqU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Apr 2014 17:46:20 -0400
Received: by mail-oa0-f41.google.com with SMTP id j17so1716040oag.14
        for <git@vger.kernel.org>; Wed, 23 Apr 2014 14:46:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=Vbvir4JH8R2SpyWonafVfaXLewubSKXiaDUyPrLTD7Q=;
        b=QgQB6uwRPVuPajbVaE4s4Jv+L6AuZvKF2/54QBneOv6RrZ2ZFWp7ntAoRIoATwHuYG
         t3q+yWkQqOeZhwxdeOjuZAneXc9dXJEmwO555c7rNRfPupLTNXg0tiauD9JvhT1VO8my
         hvOtAHxf59J05b7YSp/vGI9VS8xjCAifiZIE/r/pxu+SI/3rM+eo1zyIIPwFpVpBZEXy
         oaQqve/3AmsJ/EYfto8n5piyg/9hqbw/mdCDZd2cwGPQ0FcsdXjZ0NoqLbBCQgqcki1e
         /2zhEz153vs5mF5UUrK8P0at5gS/waq7HeJ6DuyU41PWXiULdXGMCBJEkGwEZK0i/9FI
         avKQ==
X-Received: by 10.60.34.65 with SMTP id x1mr44157476oei.6.1398289579841;
        Wed, 23 Apr 2014 14:46:19 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id cn1sm8835522oeb.11.2014.04.23.14.46.17
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Apr 2014 14:46:18 -0700 (PDT)
In-Reply-To: <xmqq8uqvyc53.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246905>

Junio C Hamano wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
> 
> > Junio C Hamano wrote:
> >> Felipe Contreras <felipe.contreras@gmail.com> writes:
> >> 
> >> > This hook is invoked before a branch is updated, either when a branch is
> >> > created or updated with 'git branch', or when it's rebased with 'git
> >> > rebase'.  It receives three parameters; the name of the branch, the
> >> > SHA-1 of the latest commit, and the SHA-1 of the first commit of the
> >> > branch.
> >> >
> >> > When a branch is created the first and last commits of the branch are
> >> > the same, however when a branch is rebased they are not. If the SHA-1 of
> >> > the first commit of the branch is not available (e.g. git reset) a null
> >> > SHA-1 (40 zeroes) would be passed.
> >> >
> >> > The hook exit status can be used to deny the branch update.
> >> >
> >> > It can be used to verify the validity of branch names, and also to keep
> >> > track of the origin point of a branch, which is otherwise not possible
> >> > to find out [1].
> >> 
> >> Please call it pre-update-branch at least,
> >
> > I will do so when I see a good argument for it.
> 
> If you choose to ignore "a user cannot tell from the name
> update-branch when it will be called, we cannot introduce
> post-update-branch later without making things more inconsistent if
> we do not name it pre-something" and label them not "a good
> argument", then I do not have anything to say to you.

I did not ignore it, it's an invalid argument, and I explained why.

You are the one making the assumption that there will be a post-udpate-branch
without actually providing any reasoning *why* we would want such a hook.

-- 
Felipe Contreras
