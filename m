From: Paul Tan <pyokagan@gmail.com>
Subject: Re: [PATCH v3 4/9] t5520: test for failure if index has unresolved entries
Date: Fri, 15 May 2015 16:25:02 +0800
Message-ID: <CACRoPnR_tKfSPpRDnQ6_z+XECe7phaN1zRWDZxoaRAz6egGcNw@mail.gmail.com>
References: <1431508136-15313-1-git-send-email-pyokagan@gmail.com>
	<1431508136-15313-5-git-send-email-pyokagan@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Stefan Beller <sbeller@google.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Paul Tan <pyokagan@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri May 15 10:25:28 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YtAvv-0007Nh-Iu
	for gcvg-git-2@plane.gmane.org; Fri, 15 May 2015 10:25:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934569AbbEOIZH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 May 2015 04:25:07 -0400
Received: from mail-la0-f49.google.com ([209.85.215.49]:36829 "EHLO
	mail-la0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934315AbbEOIZE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 May 2015 04:25:04 -0400
Received: by lagv1 with SMTP id v1so108223758lag.3
        for <git@vger.kernel.org>; Fri, 15 May 2015 01:25:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=YZPS6SBUiQusLYvQn7xZm105o4URte1noPq4MeTyFFY=;
        b=BL8CGP0h96Uq2f0zq8UXgO1wEnEPvSMNG4E+Hhxii09zT28/7ansd1Ntak5iWehI6T
         xv7pQ1vWH9jxTiyuEXAU/ZFMX2I5zNBisVlIRAnRCXJ/EXXN7P+v7Z91Wx7wXcRaQYx/
         ibILmzyzyrpZBiYwKrxCn0HakXEPlmIJVO7Ddsg+7Yy97OIGwPKukPKDv5rtOzAxNVH+
         XqNjBvjTVCIqsWX7JZSPVLXOJgU0Ur6a/ypOgdvSpKsqQiPlRaAwTJJbMq0O6hqtl8Kl
         3obTHTSQGxQ6khF/CsxUhiGyTX4ibDALsYGt4d2unMwWJhEpkl5Wgi4fIn7VZMOvha5r
         8v0w==
X-Received: by 10.152.2.38 with SMTP id 6mr6410377lar.80.1431678302422; Fri,
 15 May 2015 01:25:02 -0700 (PDT)
Received: by 10.112.74.133 with HTTP; Fri, 15 May 2015 01:25:02 -0700 (PDT)
In-Reply-To: <1431508136-15313-5-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269132>

On Wed, May 13, 2015 at 5:08 PM, Paul Tan <pyokagan@gmail.com> wrote:
> +test_expect_success 'fail if the index has unresolved entries' '
> +       git checkout -b third second^ &&
> +       test_when_finished "git checkout -f copy && git branch -D third" &&
> +       verbose test "$(cat file)" = file &&
> +       echo modified2 >file &&
> +       git commit -a -m modified2 &&
> +       verbose test -z "$(git ls-files -u)" &&
> +       test_must_fail git pull . second &&
> +       verbose test -n "$(git ls-files -u)" &&
> +       cp file expected &&
> +       test_must_fail git pull . second 2>err &&
> +       test_i18ngrep "you have unmerged files" err &&

Hmm, it appears that this is too loose, as git-merge will throw "merge
is not possible because you have unmerged files".

So it looks like we will have to go back to the stricter "Pull is not
possible because you have unmerged files".

> +       test_cmp expected file &&
> +       git add file &&
> +       verbose test -z "$(git ls-files -u)" &&
> +       test_must_fail git pull . second 2>err &&
> +       test_i18ngrep "have not concluded your merge" err &&
> +       test_cmp expected file
> +'
> +
>  test_expect_success '--rebase' '
>         git branch to-rebase &&
>         echo modified again > file &&
> --
> 2.1.4
>
