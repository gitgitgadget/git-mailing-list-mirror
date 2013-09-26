From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: Problem switching branches in submodule
Date: Fri, 27 Sep 2013 06:44:59 +0700
Message-ID: <CACsJy8DifMCL4QZV_jxgHaL1MLDi6nrgBTSuBcB69btfOJOWvA@mail.gmail.com>
References: <BLU0-SMTP17403D5452DA1619FEFCCBAB8280@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Manish Gill <mgill25@outlook.com>
X-From: git-owner@vger.kernel.org Fri Sep 27 01:45:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VPLFW-0007EZ-9H
	for gcvg-git-2@plane.gmane.org; Fri, 27 Sep 2013 01:45:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753131Ab3IZXpa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Sep 2013 19:45:30 -0400
Received: from mail-oa0-f43.google.com ([209.85.219.43]:49677 "EHLO
	mail-oa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751264Ab3IZXpa (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Sep 2013 19:45:30 -0400
Received: by mail-oa0-f43.google.com with SMTP id f4so1563795oah.16
        for <git@vger.kernel.org>; Thu, 26 Sep 2013 16:45:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=629ai+RL5Et6SbVhMrcZ/pcAyHQwNN1fUetiE4No6Gw=;
        b=NEtTe1Mwt8QF4GMQJkQ/El5VUvvIiKLr7JbrjoQCl+3a01Fg9KddBEXD4bLJ/bKXj7
         LrVxAHXp/fdR4eLlVp5JNswRu3DSzda/5inVAgjImnbBS7tjm8h4FBQeNmpoAjQOmIZw
         SYRC/tGGDJEd9FdCl1ITkEgzZlndaD7FCrSEbKFkQAH8/e/kfiol5pKqmI7L+ldnhQs9
         vkQXPX3hno5Wg0Yhbi3WxfJQ3amKbN7ZwntV3JgebfZ6RJCNh1hyIE3lUoelmPOMR+ti
         E7NOB05aKpxHjUYypADplvdsOcH8hsQQcKv7/WTwMhic/Bai8TWGByfmKrXCt71ONj4K
         TitQ==
X-Received: by 10.60.58.10 with SMTP id m10mr2956668oeq.61.1380239129484; Thu,
 26 Sep 2013 16:45:29 -0700 (PDT)
Received: by 10.182.49.233 with HTTP; Thu, 26 Sep 2013 16:44:59 -0700 (PDT)
In-Reply-To: <BLU0-SMTP17403D5452DA1619FEFCCBAB8280@phx.gbl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235440>

On Fri, Sep 27, 2013 at 12:20 AM, Manish Gill <mgill25@outlook.com> wrote:
> Hello,
>
> I have a git repository with lots of submodules. In one particular
> submodule, I'm having the following problem:
>
> If I try to switch branches at the top-level of that submodule, I succeed.
>
> But, if I try to switch branches in any subsequen levels, I get the
> following error:
>
>     fatal: internal error: work tree has already been set
>     Current worktree: ../path/Mailman3/rest_project
>     New worktree: ../path/Mailman3/rest_project/website/public_rest
>

Can you apply this patch, rebuild git and retry again? It will create
a coredump at "fatal:...", which might give me a clue what's going
on.. Once you get the coredump, open it with gdb, execute "bt full"
and paste the output here.

diff --git a/usage.c b/usage.c
index ed14645..0403091 100644
--- a/usage.c
+++ b/usage.c
@@ -34,6 +34,7 @@ static NORETURN void usage_builtin(const char *err,
va_list params)
 static NORETURN void die_builtin(const char *err, va_list params)
 {
        vreportf("fatal: ", err, params);
+       *(char*)0 = 1;
        exit(128);
 }

-- 
Duy
