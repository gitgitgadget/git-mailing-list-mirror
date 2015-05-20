From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 2/4] ref-filter: add ref-filter API
Date: Wed, 20 May 2015 15:07:32 -0400
Message-ID: <CAPig+cTiYk_oGj98QttMMDjyJDFV256yOwu9b8_znOMnaMt7-A@mail.gmail.com>
References: <555C88C2.8060902@gmail.com>
	<1432127904-21070-2-git-send-email-karthik.188@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Matthieu Moy <matthieu.moy@grenoble-inp.fr>,
	Christian Couder <christian.couder@gmail.com>
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 20 21:07:40 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yv9L9-00021w-FN
	for gcvg-git-2@plane.gmane.org; Wed, 20 May 2015 21:07:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753303AbbETTHe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 May 2015 15:07:34 -0400
Received: from mail-ie0-f176.google.com ([209.85.223.176]:34476 "EHLO
	mail-ie0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753216AbbETTHd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 May 2015 15:07:33 -0400
Received: by ieczm2 with SMTP id zm2so46823600iec.1
        for <git@vger.kernel.org>; Wed, 20 May 2015 12:07:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=XYdHltNjuN4ph07pdTRLGGka/vF5TufWB/1tyIjMkwc=;
        b=U54ffnYAmKVBBHwu7TMzcvYTySlvyMj9l3OXwdj4rPQ1FOUBzXdLu3sxKdj74fNvDb
         f9r8/hbwa+NThyA032/jY+VcLiQj9teeGBUyiUHbgGawqogNVExDiBTGCR03Grku+lm0
         YjYWrpIjXdb6lZ2/ecCgqVcc6vVRCyRzl/FPmMQbTMPqeiKrxFB0lD5MQDgs6g/WXJVd
         B1aBmWRvAYMaE8XStdNuAKBlTK0l6kMla9ODL1AR5EFRx+GacK0Ghr4nAUyRaiifiqOs
         XmEgHjWzWiVW4Agfi224TwItPPCQJr0+1sA6bPxhpfV6YdNQgAw3TYmwvithXlsPX57v
         x/5Q==
X-Received: by 10.50.61.200 with SMTP id s8mr30349034igr.7.1432148852559; Wed,
 20 May 2015 12:07:32 -0700 (PDT)
Received: by 10.107.28.132 with HTTP; Wed, 20 May 2015 12:07:32 -0700 (PDT)
In-Reply-To: <1432127904-21070-2-git-send-email-karthik.188@gmail.com>
X-Google-Sender-Auth: tTCLZHyTk9bkFQRWPVb743U_sPM
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269493>

On Wed, May 20, 2015 at 9:18 AM, Karthik Nayak <karthik.188@gmail.com> wrote:
> add a ref-filter API to provide functions to filter refs for listing.
> This will act as a common library for commands like 'tag -l',
> 'branch -l' and 'for-each-ref'. ref-filter will enable each of these
> commands to benefit from the features of the others.
>
> Mentored-by: Christian Couder <christian.couder@gmail.com>
> Mentored-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
> ---
>  Makefile     |  1 +
>  ref-filter.c | 73 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  ref-filter.h | 47 ++++++++++++++++++++++++++++++++++++++
>  3 files changed, 121 insertions(+)
>  create mode 100644 ref-filter.c
>  create mode 100644 ref-filter.h

A shortcoming of this approach is that it's not blame-friendly.
Although those of us following this patch series know that much of the
code in this patch was copied from for-each-ref.c, git-blame will not
recognize this unless invoked in the very expensive "git blame -C -C
-C" fashion (if I understand correctly). The most blame-friendly way
to perform this re-organization is to have the code relocation (line
removals and line additions) occur in one patch.

There are multiple ways you could arrange to do so. One would be to
first have a patch which introduces just a skeleton of the intended
API, with do-nothing function implementations. A subsequent patch
would then relocate the code from for-each-ref.c to ref-filter.c, and
update for-each-ref.c to call into the new (now fleshed-out) API.
