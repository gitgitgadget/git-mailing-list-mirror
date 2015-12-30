From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: Segfault in git reflog
Date: Wed, 30 Dec 2015 17:31:41 +0700
Message-ID: <CACsJy8Db-SjNj_tOgERMuRyydq6XC3Fq4pEKNRr8bqgpaUxKig@mail.gmail.com>
References: <20151230092400.GA9319@spirit>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Dennis Kaarsemaker <dennis@kaarsemaker.net>
X-From: git-owner@vger.kernel.org Wed Dec 30 11:32:18 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aEE3F-0008O1-Nl
	for gcvg-git-2@plane.gmane.org; Wed, 30 Dec 2015 11:32:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754545AbbL3KcO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Dec 2015 05:32:14 -0500
Received: from mail-lf0-f51.google.com ([209.85.215.51]:36187 "EHLO
	mail-lf0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752407AbbL3KcM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Dec 2015 05:32:12 -0500
Received: by mail-lf0-f51.google.com with SMTP id z124so219415029lfa.3
        for <git@vger.kernel.org>; Wed, 30 Dec 2015 02:32:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=Z9URa9t0waFYOOorsXSBlFj7GPOVPQ+axeNNMdo8bBg=;
        b=GO+4Pz9RoBNEynoDMwCKct5xY6Uts3z0VSbe/+ZeneoQ86cPPw6kelWLAXb8vj805b
         Q5/pO1XEAIzOEuw7s7VA/OcYsGA2jm1p9WbCr1/wHzUESBOyT/JTbV0G5/kFv1/t7GlE
         9HaivuZOoxBZOPPG19PLtPg60AC5LC4ORj4Apu9OiLgzHi208GZnuv5tCWnVpjfRv5T8
         IQaeg8LQS9FIbk8w8XolVth/DFqDJ/FYWeY3opRlhuHyxCLENj0WA+csXVFr9kIC6prg
         yoPV0ON16xw+5cslPMUyDom9HU6I+DNEh9gGT+fdhXkoSEoxXGtvxAP6PHLpjmKWljOH
         P7fQ==
X-Received: by 10.25.137.84 with SMTP id l81mr22900192lfd.45.1451471531170;
 Wed, 30 Dec 2015 02:32:11 -0800 (PST)
Received: by 10.112.97.72 with HTTP; Wed, 30 Dec 2015 02:31:41 -0800 (PST)
In-Reply-To: <20151230092400.GA9319@spirit>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283173>

On Wed, Dec 30, 2015 at 4:24 PM, Dennis Kaarsemaker
<dennis@kaarsemaker.net> wrote:
> I've hit a segfault in git reflog with latest git, reproducable in git.git:
>
> spirit:~/code/git (master)$ ./git describe
> v2.7.0-rc3
>
> I've minimized the reflog to:
>
> spirit:~/code/git (master)$ cat .git/logs/HEAD
> 2635c2b8bfc9aec07b7f023d8e3b3d02df715344 54bc41416c5d3ecb978acb0df80d57aa3e54494c Dennis Kaarsemaker <dennis@kaarsemaker.net> 1446765642 +0100
> 74c855f87d25a5b5c12d0485ec77c785a1c734c5 54bc41416c5d3ecb978acb0df80d57aa3e54494c Dennis Kaarsemaker <dennis@kaarsemaker.net> 1446765951 +0100  checkout: moving from 3c3d3f629a6176b401ebec455c5dd59ed1b5f910 to master
>
> ...which I realize looks a bit broken. I think at the time I was playing with
> some patches that also caused segfaults, causing gaps in the reflog.
> Nevertheless, I think segfaulting is bad. All objects in the reflog are
> reachable.
>
> gdb has the following to say:
>
> spirit:~/code/git (master)$ gdb --args ./git --no-pager reflog

If it helps, if add_ref_decoration is not called at all, there's no
segfault. Definitely something with reflog parsing, probably leaving
an uninitialized pointer. But I have not gotten there yet.
-- 
Duy
