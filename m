From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] notes: Allow treeish expressions as notes ref
Date: Mon, 13 Jul 2015 14:19:41 -0700
Message-ID: <xmqqegkbzrf6.fsf@gitster.dls.corp.google.com>
References: <CALKQrgdGJy6vtBRL413bbSHSi+=KTh4Q98hpbgg29j4J191=bA@mail.gmail.com>
	<1436517551-12172-1-git-send-email-mh@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Johan Herland <johan@herland.net>
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Mon Jul 13 23:19:48 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZEl8d-00048M-Qg
	for gcvg-git-2@plane.gmane.org; Mon, 13 Jul 2015 23:19:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751882AbbGMVTo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Jul 2015 17:19:44 -0400
Received: from mail-ie0-f176.google.com ([209.85.223.176]:33864 "EHLO
	mail-ie0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751769AbbGMVTn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Jul 2015 17:19:43 -0400
Received: by iebmu5 with SMTP id mu5so243438216ieb.1
        for <git@vger.kernel.org>; Mon, 13 Jul 2015 14:19:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=V6ZyBT2sznT2IXoI6B9EwzZZiOAKmK0Hv48sXf9s+o8=;
        b=QVpXGuRNampsgbsppdvfPIoFEFQR78D58vs7WMGkFCZPb6ABXddIjL1HNzkV1G5oKd
         SK6Kgich81oku5pCL1oQoYKUJ9cOa/mgaS9DE1q9fDt0edmLzyqcR2hWm99gSbcrsPVr
         IvYMH4zNYfCpCuzoa6WFELeK6n6/ld1/VZnlFKOHFJARGOvTP5mQw8CJtcLGnVfABr7f
         wEynBaC9C/7O4VY4MDrlg2jUP7CZLj6aStfDzIoqbjU9CHxe7CvO21afD0MArf4/MDtQ
         r8IgU55A5gjNHT2vsCYZEGQ8FvHMrhDr4EBqoB5SkOZlher5vUIZzDd26GCSZoznmJzg
         GdHQ==
X-Received: by 10.107.28.202 with SMTP id c193mr12726757ioc.90.1436822382875;
        Mon, 13 Jul 2015 14:19:42 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:4d10:ec6a:e89:91cb])
        by smtp.gmail.com with ESMTPSA id lr1sm6475276igb.10.2015.07.13.14.19.42
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 13 Jul 2015 14:19:42 -0700 (PDT)
In-Reply-To: <1436517551-12172-1-git-send-email-mh@glandium.org> (Mike
	Hommey's message of "Fri, 10 Jul 2015 17:39:11 +0900")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273929>

Mike Hommey <mh@glandium.org> writes:

> init_notes() is the main point of entry to the notes API. It is an arbitrary
> restriction that all it allows as input is a strict ref name, when callers
> may want to give an arbitrary treeish.
>
> However, some operations that require updating the notes tree require a
> strict ref name, because they wouldn't be able to update e.g. foo@{1}.
>
> So we allow treeish expressions to be used in the case the notes tree is
> going to be used without write "permissions", and to distinguish whether
> the notes tree is intended to be used for reads only, or will be updated,
> a flag is added.
>
> This has the side effect of enabling the use of treeish as notes refs in
> commands allowing them, e.g. git log --notes=foo@{1}.
>
> Signed-off-by: Mike Hommey <mh@glandium.org>
> ---
>  builtin/notes.c  | 29 ++++++++++++++++-------------
>  notes-cache.c    | 11 ++++++-----
>  notes-utils.c    |  6 +++---
>  notes.c          | 11 +++++++----
>  notes.h          | 10 +++++++++-
>  t/t3301-notes.sh | 10 ++++++++++
>  6 files changed, 51 insertions(+), 26 deletions(-)

At least Documentation/pretty-options.txt needs to be updated, as it
explicitly requests you to feed a ref, but you'd want to tell the
users that you loosened it.  I suspect Documentation/git-notes.txt
may also need adjustment as that involves writing side, but I didn't
look very carefully.

Thanks.
