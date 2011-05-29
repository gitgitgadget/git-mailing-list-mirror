From: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
Subject: Re: [PATCH] rebase: learn --discard subcommand
Date: Sun, 29 May 2011 13:28:26 -0400 (EDT)
Message-ID: <alpine.DEB.2.00.1105290916470.28815@debian>
References: <1306551495-26685-1-git-send-email-martin.von.zweigbergk@gmail.com> <20110528230844.GA31498@elie>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Tim Mazid <timmazid@hotmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 29 19:28:38 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QQjn4-0001VS-6d
	for gcvg-git-2@lo.gmane.org; Sun, 29 May 2011 19:28:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753826Ab1E2R2a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 May 2011 13:28:30 -0400
Received: from mail-qy0-f174.google.com ([209.85.216.174]:51941 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752153Ab1E2R2a (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 May 2011 13:28:30 -0400
Received: by qyk7 with SMTP id 7so508123qyk.19
        for <git@vger.kernel.org>; Sun, 29 May 2011 10:28:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:x-x-sender:to:cc:subject:in-reply-to
         :message-id:references:user-agent:mime-version:content-type;
        bh=V/hdAoP19SUJENgay3VhhntdFBlwmaOaw+oEpgVkeT0=;
        b=xItnsGX5w9eYm7LxbxDXw8vr1Ody4k6NZKQsSyg0qEdHIRK0e3ppra3+kMlxihAY70
         IVeLVEKxNLM/63hZK8gUGjjTe510NiRWstM1W5rH22ZjK65Ndx5XadAVlj+wFxYWUH92
         Pf4eNRj3pf/Ltje1f1qdRzPtS6dLg/vXBAGPE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:x-x-sender:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version:content-type;
        b=ZuaWp1voR3vXehXFw71jHT+u6DCit+l+dO8WMiL35A1N+Is+AiDpfVHt5MOWz92zBj
         ky58C5g1adR8isI9KPd0c1skCQGtevnsQoNYE4Cwy3USbKH0AohEoM2Dd79GJ12X2GEw
         viwDmqlCI/WwVXC+PnaxPTp1UXxDbI65+5AEk=
Received: by 10.224.212.196 with SMTP id gt4mr3027000qab.74.1306690109182;
        Sun, 29 May 2011 10:28:29 -0700 (PDT)
Received: from [192.168.1.103] (modemcable151.183-178-173.mc.videotron.ca [173.178.183.151])
        by mx.google.com with ESMTPS id g1sm2355849qck.8.2011.05.29.10.28.27
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 29 May 2011 10:28:28 -0700 (PDT)
X-X-Sender: martin@debian
In-Reply-To: <20110528230844.GA31498@elie>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174695>


On Sat, 28 May 2011, Jonathan Nieder wrote:

> At first the name --discard made me think it was going to move back to
> the original branch and discard the reset of the patch series being
> rebased.  Not sure what a better name would be, though.

Maybe --stop as Tim suggested, but I think that also makes it sound
like we're dropping the rest of the patches. Other names would be
--cancel or --forget.

> > --- a/Documentation/git-rebase.txt
> > +++ b/Documentation/git-rebase.txt
> > @@ -238,6 +238,9 @@ leave out at most one of A and B, in which case it defaults to HEAD.
> [...]
> > +--discard::
> > +	Abort the rebase operation without restoring the original branch.
> 
> A reader without a complete mental model for what "git rebase" does
> could be very confused by this.  One might think: does this mean that
> git has been scribbling over the original branch, and this switch
> almost completely cancels that but leaves the branch still
> scribbled-on?

The --abort subcommand is currently described as "Restore the original
branch and abort the rebase operation.", so that would be in need of
the same clarification.

> How about something like:
> 
>  --keep-head::
> 	When aborting a rebase, do not check out the original branch
> 	but leave the HEAD alone.  This can be useful if you forgot
> 	about a conflicted or interactive rebase in progress and have
> 	been committing on top of one of the commits being replayed.
> 
> ?

Thanks. I like it. Maybe with "... or if you have moved to an
unrelated commit" or something like that be added to the end.

> Agh, "git rebase --abort --keep-head" feels a little too long to be
> memorable.  Still, hope that helps.

I intended --discard to be used _instead_ of --abort. Do you think it
makes more sense to have it as an option to --abort or was it just
that the word "subcommand" confused you? I meant it as "subcommand of
git rebase".


/Martin
