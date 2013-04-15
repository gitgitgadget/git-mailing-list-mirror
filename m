From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 3/3] pull: introduce --[no-]autostash and pull.autostash
Date: Mon, 15 Apr 2013 22:01:53 +0530
Message-ID: <CALkWK0kMRm74SOiZ7Jgm2xqS5UEc5HOXQ6F12QqLnhO=QGktew@mail.gmail.com>
References: <1365887729-9630-1-git-send-email-artagnon@gmail.com>
 <1365887729-9630-4-git-send-email-artagnon@gmail.com> <7v8v4k2vm0.fsf@alter.siamese.dyndns.org>
 <CALkWK0mmrvYSjvUCvvjbnav4JmbkVKho2K6c7QAM2AuqWFkEFw@mail.gmail.com> <7vsj2rzuwl.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 15 18:32:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1URmKi-0004ib-Sq
	for gcvg-git-2@plane.gmane.org; Mon, 15 Apr 2013 18:32:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933036Ab3DOQci (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Apr 2013 12:32:38 -0400
Received: from mail-ia0-f174.google.com ([209.85.210.174]:64529 "EHLO
	mail-ia0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750956Ab3DOQcg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Apr 2013 12:32:36 -0400
Received: by mail-ia0-f174.google.com with SMTP id o25so1677253iad.19
        for <git@vger.kernel.org>; Mon, 15 Apr 2013 09:32:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=KzeGlFXLh8A9d4w/g7uA1CXSw8BsGQp5V5+Dy6cgR/8=;
        b=EYlI6rabm2XR99YKQVe/hTk05drvSmod7GyT0Nu1p0q3PWdDa3XlgC+KjDE3K3KfgP
         SSAwxt47cvKlmetsuv7tsel5w9cJN9plG8MGnjNra8C0fLzbn/LBiIdpZqkUG1h303tO
         ke5wOxgFYO2jJiqGX8LJoLoTzCikg7YeV46pjt2t+n7nGpOZUFB2Ar8J/91S8sUcI2O3
         Nm2bGgZZlddJGjkCV1DTK+cML9IgEv3/ITwUL9Ad0yb7G3JTAPc1POps4tYzCUlCLXu/
         PWbsvG6H3rOOdlpLtxKy+gpQ9YXXZLZ8+SUhl5OR1/SmCgM+aUYcQrr85E/TdzzrAx5V
         P3Lg==
X-Received: by 10.50.119.102 with SMTP id kt6mr5881198igb.12.1366043553990;
 Mon, 15 Apr 2013 09:32:33 -0700 (PDT)
Received: by 10.64.34.80 with HTTP; Mon, 15 Apr 2013 09:31:53 -0700 (PDT)
In-Reply-To: <7vsj2rzuwl.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221248>

Junio C Hamano wrote:
> By tempting the user to use autostash first, you are forcing the
> user to say "reset --hard" (the first one), "ORIG_HEAD" (to start
> from the pre-pull state), "stash pop" (to recover the autostashed
> WIP), to a user who got conflict during "stash pop" after the pull
> integrated the committed work with the remote side.
>
> If the user did this instead:
>
>         ... Let's save my large WIP away in a more permanent place first
>         git checkout -b wip
>         ... perhaps work a bit more ...
>         git commit -a -m wip
>         git checkout -
>         ... and then ...
>         git pull
>
> the user wouldn't have had to do those extra steps.

Hm, yes.  For a pull-merge guy who opts for pull.autostash, the
penalty for forgetting to commit a big WIP in advance is too high.  It
probably makes sense to restrict the autostash feature to kick in only
in the rebase codepath: it might be a good idea to implement
rebase.autostash for reduced case of non-interactive rebases instead.
I'm only slightly iffy about --onto, but it's not a big concern.
