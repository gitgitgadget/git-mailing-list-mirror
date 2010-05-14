From: Bo Yang <struggleyb.nku@gmail.com>
Subject: Re: Git log follow question
Date: Fri, 14 May 2010 12:16:13 +0800
Message-ID: <AANLkTilFn8qugzcGgr-Ooe5PZsSxmJOiubbG7sAwW1Ft@mail.gmail.com>
References: <006d01caf300$703e96a0$50bbc3e0$@burgmann.anu.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Albert Krawczyk <albert@burgmann.anu.edu.au>
X-From: git-owner@vger.kernel.org Fri May 14 06:16:22 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OCmJx-0003Kw-Uy
	for gcvg-git-2@lo.gmane.org; Fri, 14 May 2010 06:16:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751454Ab0ENEQQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 May 2010 00:16:16 -0400
Received: from mail-qy0-f171.google.com ([209.85.221.171]:42056 "EHLO
	mail-qy0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751048Ab0ENEQP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 May 2010 00:16:15 -0400
Received: by qyk1 with SMTP id 1so2725501qyk.5
        for <git@vger.kernel.org>; Thu, 13 May 2010 21:16:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=sImTSi9CjtK8C+XyE0Br7lm0W07g047n0iWLAG+6if8=;
        b=mAkSP0hZXNOiu1EssWnVZWWvcQpfw1MiNp1/hvrqPFbruuoYygHRbrcfDNOsteVu4o
         wP6pXzYif1a5JBo0VmeJX1ciCvQqHrXMa1L7QBTHXfFh5sP4atQKJvDINGQy980rNjfJ
         5dJxN9lyoNMzA75qv1/VUeiovAiVSCgqvTQT4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=utdDbb198qYb3Rk7zP8X0xO/qdgEcLoLjXZxMqBXLK4N5ZRaWcDthsLce+9pKkVICG
         u3t2QZKPRz8SyFY4Iedu3wsAtFroVvZg5HFPk81FHA3VSkFwO4n0fGpm8lZEKAR2yOWJ
         UWH9C8CcwH4Boe8ia+AgAg28LPB0IR18MVLl4=
Received: by 10.224.99.210 with SMTP id v18mr264196qan.87.1273810573451; Thu, 
	13 May 2010 21:16:13 -0700 (PDT)
Received: by 10.229.97.80 with HTTP; Thu, 13 May 2010 21:16:13 -0700 (PDT)
In-Reply-To: <006d01caf300$703e96a0$50bbc3e0$@burgmann.anu.edu.au>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147043>

Hi Albert,
On Fri, May 14, 2010 at 8:57 AM, Albert Krawczyk
<albert@burgmann.anu.edu.au> wrote:
> As you can see git log --parents and git log --follow --parents produce very
> different results, and as far as I can tell they should produce identical
> outputs.
>
> Could somebody tell me if I'm doing something wrong with the syntax? Or have
> I stumbled onto a quirk I fail to understand?

The problem you encountered is something about parent rewriting.
That's when git do a revision walk it will *modify* the actual parents
of a commit according on the command line options.
When you invoke, git log --parents , the parents rewriting mechanism
is on. Take you have five commits:
commit1 <- commit2 <- commit3 <- 4 <- 5
And only commit 5 and commit 2 change the file alloc.c. When you run
'git log --parents alloc.c', the actual parent of commit 5 will be
modified to commit2. When you run git without --parents, commit 5's
parent will still be commit 4.
And when '--follow' is given, parent rewriting mechanism will be shut
down, so you get two different output.

For another words, I don't understand why we shut down the parent
rewriting when '--follow' given. This make users confusing and also
make --graph inpossible to work with '--follow'...

Regards!
Bo
-- 
My blog: http://blog.morebits.org
