From: "Mikael Magnusson" <mikachu@gmail.com>
Subject: Re: [PATCH] git wrapper: DWIM mistyped commands
Date: Mon, 1 Sep 2008 16:42:44 +0200
Message-ID: <237967ef0809010742w43de9e3dj28880de484e8c48d@mail.gmail.com>
References: <20080828171533.GA6024@blimp.local>
	 <20080828212722.GF6439@steel.home>
	 <7vsksm1pmd.fsf@gitster.siamese.dyndns.org>
	 <81b0412b0808300944p29199600ie95c65404b6cb380@mail.gmail.com>
	 <20080830171331.GA26932@steel.home>
	 <7vprnqifd2.fsf@gitster.siamese.dyndns.org>
	 <237967ef0808300333t2cd4e354xd461f7bfead40f4c@mail.gmail.com>
	 <20080831135023.GA6616@blimp.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>
To: "Alex Riesen" <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 01 16:43:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KaAdF-0005aX-O0
	for gcvg-git-2@gmane.org; Mon, 01 Sep 2008 16:43:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751433AbYIAOmr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Sep 2008 10:42:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751410AbYIAOmr
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Sep 2008 10:42:47 -0400
Received: from ey-out-2122.google.com ([74.125.78.25]:22460 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751362AbYIAOmq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Sep 2008 10:42:46 -0400
Received: by ey-out-2122.google.com with SMTP id 6so925660eyi.37
        for <git@vger.kernel.org>; Mon, 01 Sep 2008 07:42:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=WyA52GVxWhPuYmSEsBlidMPmyHyd9RScJdFlLptwyrk=;
        b=GlW/X14n+R5Kqq1aF23jrrDsudX8pyaa2zUu8TC7j8f144DtnkWYapy3O+BksimnyL
         XVf9ireyoEWhFZmvwUUUCEWc6qAx5VO5s7B7w2U6bE5vDRVAfPrqt6Dwy7vIWxSPMF65
         pWa/DrYUt6Zp00xP6+PZZ5vXyrYyse2noKLK4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=QLtHrW4BJUkBt7l+4hCFpYoVX+FDYsXby8Fv7VMIG2l9dPXw591twwyxGqIlKz/TvB
         2dhcIy5Qza2BM+XhrQ50/lmxZrjrR7JM0QsRRM3bcQfetuZAMnvmawT8TrnqpBjpUC+C
         4C+GUWYanuUbY0X13BtPdVMnTH2a0u9V6FEEA=
Received: by 10.210.59.3 with SMTP id h3mr6612410eba.145.1220280164600;
        Mon, 01 Sep 2008 07:42:44 -0700 (PDT)
Received: by 10.210.73.14 with HTTP; Mon, 1 Sep 2008 07:42:44 -0700 (PDT)
In-Reply-To: <20080831135023.GA6616@blimp.local>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94588>

2008/8/31 Alex Riesen <raa.lkml@gmail.com>:
> From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
>
> This patch introduces a modified Damerau-Levenshtein algorithm into
> Git's code base, and uses it with the following penalties to show some
> similar commands when an unknown command was encountered:
>
>        swap = 0, insertion = 1, substitution = 2, deletion = 4
>
> A typical output would now look like this:
>
>        $ git sm
>        git: 'sm' is not a git-command. See 'git --help'.
>
>        Did you mean one of these?
>                am
>                rm
>
> The cut-off is at similarity rating 6, which was empirically determined
> to give sensible results.
>
> As a convenience, if there is only one candidate, Git continues under
> the assumption that the user mistyped it.  Example:
>
>        $ git reabse
>        WARNING: You called a Git program named 'reabse', which does
>        not exist.
>        Continuing under the assumption that you meant 'rebase'
>        [...]

> Mikael, this also might fix the crash you're seeing: the heap was
> corrupted by clean_cmdnames(&other_cmds) names members of which were
> moved to main_cmds.

It doesn't crash now, but the cut-off appears ineffective:
% git aaaaaaaaaaaaaaa
WARNING: You called a Git program named 'aaaaaaaaaaaaaaa', which does not exist.
Continuing under the assumption that you meant 'add--interactive'
in 2.0 seconds automatically...

By my estimate, that should have a score above 6 :).

-- 
Mikael Magnusson
