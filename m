From: Dennis Kaarsemaker <dennis@kaarsemaker.net>
Subject: Re: how to check for uncommitted/unstaged changes on remote side
 before pushing
Date: Mon, 09 Nov 2015 09:25:00 +0100
Message-ID: <1447057500.5074.8.camel@kaarsemaker.net>
References: <20151108212320.GA18762@torres.zugschlus.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
To: Marc Haber <mh+git@zugschlus.de>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 09 09:25:11 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZvhlG-000263-LO
	for gcvg-git-2@plane.gmane.org; Mon, 09 Nov 2015 09:25:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751835AbbKIIZF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Nov 2015 03:25:05 -0500
Received: from mail-wm0-f44.google.com ([74.125.82.44]:34107 "EHLO
	mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751762AbbKIIZE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Nov 2015 03:25:04 -0500
Received: by wmnn186 with SMTP id n186so92545192wmn.1
        for <git@vger.kernel.org>; Mon, 09 Nov 2015 00:25:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kaarsemaker_net.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:date:in-reply-to:references:content-type
         :mime-version:content-transfer-encoding;
        bh=2TeBetSQeQVminGI4QM3vORrlK79/09whObJPy9Iz2g=;
        b=go/eZO8jqaEemXgXvbzLtzfChpUvOMU0w3E5vpyq2MYbkrveYHPMueghlQCUTVqG0k
         z0vPDUAs1KA/m1FVgi/THlAc6sR1uLmgVJwx6n2kven8dmaUlgaXJLhW7s9DR5xOiEhN
         dNS2uNEDdklmx2PZPg3qjjCt9J9MasiSigWQ7c3u2iJ9uo8BCuE9GPy22/VCIg5tFMj5
         JiQs8+QG1k7U3wX/1QrBi3gkM6R43qacp2g+gDruLFZ/5oxmkY82c2nF1kPTu3hvP8D/
         3L2ofiBJgJcBbwnZi3eoKwTxKVhi9Gc4p+HIJKEjmKUOdyljxNijeTkCIU78lrrnsdGE
         plAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:content-type:mime-version:content-transfer-encoding;
        bh=2TeBetSQeQVminGI4QM3vORrlK79/09whObJPy9Iz2g=;
        b=RQhb4qzX4lT+nayexqc/wHfi6zibQbgLA6p4O+Gn40KfnTtkkR/RaMX+ktOhA/fd+C
         MLkZc+DQj/nr+WsF6sOPPhJq2wg3CGYUvdhUD8NpdKccYkYzQcJTzMIvN76op8LVW+M1
         Y1KKV/y1L8ypyC/7CcJn/p1Mg9n9ETCJV1piX4MvVJfrihiSNIjG1kUQhcbKTQGsXWXi
         0d28ldZgFKqg2OiWydN+SkaNieci+4Zx5i8CVCzjSZrc+CoRfC3xYOtXoNcQMHw//Wy9
         +CKKSq6R0ohymNq8DJ2Q0NYjPl4GTA8Dz2fAhxpFifU7p3cIgk2CmypjRchYm8enwZOD
         F3/A==
X-Gm-Message-State: ALoCoQkis8C1F0zjADnhUQ7K0m79gRRKpJTu5kh0gMhFZtWNfeKJJoOjLd4AnymtJeJg0mMYhDW7
X-Received: by 10.28.130.80 with SMTP id e77mr23997232wmd.33.1447057502756;
        Mon, 09 Nov 2015 00:25:02 -0800 (PST)
Received: from spirit.home.kaarsemaker.net ([145.132.209.114])
        by smtp.gmail.com with ESMTPSA id hk1sm14084766wjb.6.2015.11.09.00.25.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Nov 2015 00:25:01 -0800 (PST)
In-Reply-To: <20151108212320.GA18762@torres.zugschlus.de>
X-Mailer: Evolution 3.16.5-1ubuntu3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281045>

On zo, 2015-11-08 at 22:23 +0100, Marc Haber wrote:
> Hi,
> 
> I am trying to abuse git as a code distribution channel and would
> like
> to be able to trigger redistribution just by git push.

[insert obligatory remark about git not being a deployment tool]

> The idea is to push to a remote to the branch that is currently
> checked out followed by a git reset --hard in the post-receive hook.
> I
> have already figured out that I need to set receive.denyCurrentBranch
> to ignore to be able to push to the currently checked out branch.

You'll need a new enough git, so you can set it to updateInstead (and
maybe use a push-to-checkout hook).

> I am also aware that it is a good idea to git pull before git push
> just in case there were local commits on the remote.

No, hooks should never pull, merge or do anything that could be
interactive.

> git reset --hard will unconditionally throw away local uncommitted
> changes. I would like to detect this situation on the remote and
> abort
> the receive progress. But my pre-receive hook does not work as
> intended. Here is my code:
>
> [snip code]
>
> What is going wrong here?

You mention a post-receive hook first, but have written a pre-receive
hook. Not sure if that's what you intended (or even if that's what's
going wrong).

> If my entire approach is wrong, what is the recommended way to 
> prevent a repository with unstaged or uncommitted changes from being 
> pushed to?

Push-to-checkout is a very simplistic way of deploying and while it
works in simple cases, I'd not recommend it. 

Two safer/saner approaches are:
- Have a separate non-bare repo, and make the post-receive hook in a
  bare repo trigger a fetch+reset in the non-bare one
- Use git archive and symlink trickery for even better deploys

Questions like this come up in #git all the time, so I wrote up a few
more detailed recipes here, including working hooks and config for all
three ways of deploying: 
http://git.seveas.net/simple-deployments-with-git.html

-- 
Dennis Kaarsemaker
www.kaarsemaker.net
