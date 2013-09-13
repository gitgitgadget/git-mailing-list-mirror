From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: Converting repo from HG, `git filter-branch --prune-empty --
 --all` is extremely slow and errors out.
Date: Thu, 12 Sep 2013 19:47:49 -0500
Message-ID: <CAMP44s1cmcfSuB-TnFL+-57i5W=EA8v322rVDoUELCPF948jPw@mail.gmail.com>
References: <D4C9DBA5F955904683C89B4A96DA7759EA78D60FDF@synapsemail>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: John Gietzen <jgietzen@woot.com>
X-From: git-owner@vger.kernel.org Fri Sep 13 02:48:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VKHYB-0000pR-Q7
	for gcvg-git-2@plane.gmane.org; Fri, 13 Sep 2013 02:47:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755469Ab3IMArv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Sep 2013 20:47:51 -0400
Received: from mail-lb0-f174.google.com ([209.85.217.174]:38917 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755232Ab3IMArv convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 12 Sep 2013 20:47:51 -0400
Received: by mail-lb0-f174.google.com with SMTP id w6so1517086lbh.5
        for <git@vger.kernel.org>; Thu, 12 Sep 2013 17:47:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=gwuBW6yDtXJkV8SGuF3CA3BCeAtDwWgGs9CSqCDy644=;
        b=VhtRdNf2VezJ87vdaB045YEJ1jBV462PQRwxbrS/I4k6vV5u9wRYnxG2ZADQQQFCid
         kZcHmUQzUZq8sR6Jqpvj0n/ab6TGSEwQ+TsHgEOW/tMXYt7TtmxHtCbc/QLBKlbi2323
         2bR+zr8aWnQUTJ2Jm20syEA2QivI2Fe3MO1S5TvlGDbpOezNyw/Vna9AzqsxdXzpWAHj
         QEq/D5yRQlsTAQTPocI3ob/rqg8rJ/DIMaeTPCGkXt81SOxxJhU4Z7kxwgWO7UDmj4h5
         IlzDyV0Q2x2ucXEBID9HdBGOuVqgXYU+yerhY5BMuNCbRMUoaj2we+NZpwSgYzoNnIS3
         hPjg==
X-Received: by 10.152.45.106 with SMTP id l10mr8614484lam.12.1379033269662;
 Thu, 12 Sep 2013 17:47:49 -0700 (PDT)
Received: by 10.114.91.169 with HTTP; Thu, 12 Sep 2013 17:47:49 -0700 (PDT)
In-Reply-To: <D4C9DBA5F955904683C89B4A96DA7759EA78D60FDF@synapsemail>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234715>

On Thu, Sep 12, 2013 at 5:01 PM, John Gietzen <jgietzen@woot.com> wrote:
> Background:
> Windows, git version 1.8.3.msysgit.0
> bare repo, 54k commits after migration from HG
> git filter-branch --prune-empty -- --all
>
> I'm trying to clean up our repository after migrating it from HG.  I'm running the filter-branch command listed above in an effort to clean up all of garbage commits that HG required ("closing branch" commits and their ilk).
>
> From my past experience, "git filter-branch" is extremely quick when using simple filters, like env-filter, since it doesn't have to touch the working dir.  However, in our case each revision is taking 1-3 seconds; our entire repo will take 30 hours to clean up at this rate.  Normally, this wouldn't be a problem, except that we are getting "sh.exe couldn't start" errors after anywhere between the 5000th and 6000th rewritten commit.  Filter-branch doesn't have support for picking up where it left off, so we are entirely unable to clean up our repo.

Indeed, I remember writing my own simplified version of 'git
filter-branch' that was much faster. If I recall correctly, the trick
was avoiding 'git write-tree' which can be done if you are not using
any tree filter, but 'git filter-branch' is not that smart.

If all you want to do is prune empty commits, it should be easy to
write a script that simply does 'git commit-tree'. I might decide to
do that based on my script if I have time today.

-- 
Felipe Contreras
