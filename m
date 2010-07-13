From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: Massive repository corruptions
Date: Mon, 12 Jul 2010 23:23:58 -0400
Message-ID: <AANLkTilXQ3VgPjihf0pjt4QPN-nCjwAWyHwoosLMeRpH@mail.gmail.com>
References: <20100713015600.GA29392@nibiru.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: weigelt@metux.de
X-From: git-owner@vger.kernel.org Tue Jul 13 05:24:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OYW6i-0002Fc-PG
	for gcvg-git-2@lo.gmane.org; Tue, 13 Jul 2010 05:24:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751597Ab0GMDYT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Jul 2010 23:24:19 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:44549 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751303Ab0GMDYT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Jul 2010 23:24:19 -0400
Received: by gxk23 with SMTP id 23so2956568gxk.19
        for <git@vger.kernel.org>; Mon, 12 Jul 2010 20:24:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type;
        bh=oohvtWBDpJCHYExQ3uIUIS53eUE7OHPhK/swLBVmMNE=;
        b=c0c15qtVH38AWuMHjBGgaTQXGKboNJdbogTuARqV04wvFS5R7n9edwl6gMVVuHQoCi
         euepKqk3yEf+6mAX6qS6nqlu5JJ2eNKt6Tj1sf+Df+ngUy3EZ57WXeQT8sZLi8ZjTtZm
         miZkWgaxCLNx3MVE6X3+vSh1jjTfEaNp/oFpU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=BPJfzPitijX9GNUAxEqOBi+Hme47y1ODI2oRDqAo/jKdLZi1rihMQ1XSKRkXsvqWKn
         vytkbkn7nX+rVGmxRe6mJTXftyU2jj94mZrXOi5vmrqgr+3/5LFR+REQKgWsL2sR+r7d
         0INMJ3+QGQK3UEv4MUYZvd0g695Ov9jRVW/8g=
Received: by 10.151.116.2 with SMTP id t2mr5939876ybm.336.1278991458365; Mon, 
	12 Jul 2010 20:24:18 -0700 (PDT)
Received: by 10.151.85.19 with HTTP; Mon, 12 Jul 2010 20:23:58 -0700 (PDT)
In-Reply-To: <20100713015600.GA29392@nibiru.local>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150870>

On Mon, Jul 12, 2010 at 9:56 PM, Enrico Weigelt <weigelt@metux.de> wrote:
> I've just reorganized several repositories (eg. splitted off a large
> repo into several small ones), and then I had massive corruptions
> (broken pack files) in the new repos (after they already had been clean).
>
> Maybe it has something to do with a cronjob which frequently GC's
> all the repos, and it could get even worse if the fs sometimes
> goes full within this process.
>
> Could multiple GCs running on the same repo cause this ?

Multiple simultaneous gc's shouldn't be a problem - git locks things
as it needs them.  Plus, git only removes objects after it has safely
created a new packfile that contains them.  Maybe a filesystem filling
up could cause a problem, but git should be detecting that if it
happens (maybe there's a bug that causes it to not notice, though).

You could experience corruption if your computer crashed before
everything was synced to disk.

Do you know which packfiles are corrupted?  Does 'git index-pack' on
the files reveal anything?

Be sure to make a backup copy of your corrupted repositories before
doing any experiments, or you might accidentally fix the problem and
make it harder to trace.

Good luck.

Avery
