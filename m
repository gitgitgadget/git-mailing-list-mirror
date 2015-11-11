From: Stefan Beller <sbeller@google.com>
Subject: Re: git clone --recursive should run git submodule update with flag --remote
Date: Wed, 11 Nov 2015 11:48:08 -0800
Message-ID: <CAGZ79kbOyXm11uPCXcDJzKxbQzBx6ZOmq0TS8kc52xy-qV_FiQ@mail.gmail.com>
References: <loom.20151111T133121-436@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Stanislav <s.seletskiy@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 11 20:48:36 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZwbNh-0001aa-6B
	for gcvg-git-2@plane.gmane.org; Wed, 11 Nov 2015 20:48:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752699AbbKKTsa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Nov 2015 14:48:30 -0500
Received: from mail-yk0-f175.google.com ([209.85.160.175]:33552 "EHLO
	mail-yk0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752416AbbKKTsI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Nov 2015 14:48:08 -0500
Received: by ykdv3 with SMTP id v3so67141857ykd.0
        for <git@vger.kernel.org>; Wed, 11 Nov 2015 11:48:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=yE+AJMp1Qo0VrSwyjipW1QTFuWLZ88xBO+WEiGGAyrE=;
        b=TyiM6aeqkdwkj2W65W+c5hm2l5e7vN/x+h0UfOa4z0E5Mm1G6JS5z8e0VltO70f21C
         NF4Fy5edtL+C8XiDHs9W8AAfYjd+vxFLbviImvOrub32Av1hlBLvwPDGbZlgdhXXbY1p
         DAWHwZAl4+5o2uBv9nWChp28a0LkXxcfQeSHS/hn9RVEgPUYTNWk75epnXIfyjT0YpEH
         exeX66qQ8azJrcaHVqsw/71H4z1bnYbw4i9TCk8cw6wY0LCnIUBTZErnk8wrtW/QW+b8
         iZCLmYL3A7q+DDKXvcL/XRfSwELXWlPpPdx9U4iU+CLW/GFb9Vnmg3oWRfUcD2GPDz1Q
         3mQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=yE+AJMp1Qo0VrSwyjipW1QTFuWLZ88xBO+WEiGGAyrE=;
        b=P4v8VB3DGxNVsOvLuhOkaaWHbQZlsuIeTyDgDcYsEmWCN3e73kLzR2MC3r6p4idZP4
         99HN8YVjc10nhUZnh5dG/3RPmWpjeKKXb48TehiInCGOWM9DtK4so8nz0E/VEc1bot3d
         ZiAU4h8IkXjRoXIJrSm/Dktp5LxUO/sZKBWkfQCeKj0V2mlmTEvGWKjnEOCYDxq4+c3g
         qJeVt72ibIRmA24PkNGDi2SOx2o9uZeqLqlReXd/I0tf8IuJtQSJU1QWC2Uxp+/qlw7m
         deIAv4IhFWcHwTqj3G1smtp+iigwyViA+X5iz95AeyfWOPS08K+Pfi7HY0Lex6IJDz28
         awhg==
X-Gm-Message-State: ALoCoQl5tTc1O3+f5DLxlu6faht59ZYlydKL/Om2vnHNYhC2eGZQqayo5uiA4miszPUzGTlgShsY
X-Received: by 10.13.210.4 with SMTP id u4mr11943516ywd.68.1447271288153; Wed,
 11 Nov 2015 11:48:08 -0800 (PST)
Received: by 10.37.196.70 with HTTP; Wed, 11 Nov 2015 11:48:08 -0800 (PST)
In-Reply-To: <loom.20151111T133121-436@post.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281191>

On Wed, Nov 11, 2015 at 4:46 AM, Stanislav <s.seletskiy@gmail.com> wrote:
> Consider two repositories, A and B.
>
> Repo A is embedded into B by using submodule:
>
>   git submodule add -b master <url-to-A> sub-a
>
> So, submodule sub-a is set to track master branch of the repo A.
>
> Running git submodule update --remote inside repo B will automatically
> update and checkout submodule sub-a to the latest master commit (as expected).
>
> However, when using git clone --recursive <url-to-B>, repo B will be cloned
> with submodule A checkouted to the commmit which was recorded on git
> submodule add command, not the master commit.
>
> Expected behaviour is to automatically update checkout commit pointed by
> branch, that was specified by -b flag in the git submodule add invocation.

To achieve what you want to do, you can first clone B and then
do a `git submodule update` using the --remote option yourself.
That is cumbersome however, I agree.

>
> Reason for this behaviour is that line:
>
>   https://github.com/git/git/blob/master/builtin/clone.c#L99
>
> I guess, it should be changed to include --remote flag.

I guess we could tweak the behavior to include the --remote flag
when the branch is recorded in the .gitmodules file.

Just wondering what should happen if there are both a sha1
and a branch recorded?

>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
