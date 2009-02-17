From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: disallowing push to currently checked-out branch
Date: Tue, 17 Feb 2009 00:53:31 -0500
Message-ID: <76718490902162153m6a524b2dv335be66a0f0294ca@mail.gmail.com>
References: <7veixybw7u.fsf@gitster.siamese.dyndns.org>
	 <20090216135812.GA20377@coredump.intra.peff.net>
	 <49999ED6.7010608@gmail.com>
	 <alpine.DEB.1.00.0902161839120.6289@intel-tinevez-2-302>
	 <76718490902161048i3c19bb43h30b1cfc62dd9a61e@mail.gmail.com>
	 <alpine.DEB.1.00.0902162102180.6289@intel-tinevez-2-302>
	 <76718490902161312j2aee999bga00d95231fa85647@mail.gmail.com>
	 <alpine.DEB.1.00.0902162215200.6289@intel-tinevez-2-302>
	 <76718490902161428k7d252a02i3e79e4f197608891@mail.gmail.com>
	 <20090216225226.GB23764@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Sergio Callegari <sergio.callegari@gmail.com>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Feb 17 06:55:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZIv6-0003iA-FB
	for gcvg-git-2@gmane.org; Tue, 17 Feb 2009 06:55:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751098AbZBQFxe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Feb 2009 00:53:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751095AbZBQFxd
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Feb 2009 00:53:33 -0500
Received: from rv-out-0506.google.com ([209.85.198.235]:38708 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750988AbZBQFxc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Feb 2009 00:53:32 -0500
Received: by rv-out-0506.google.com with SMTP id g9so1363548rvb.5
        for <git@vger.kernel.org>; Mon, 16 Feb 2009 21:53:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=K5Nrx/ikwXOTD2Y2PSXzynfEB6XBx+eqf8lK7GzmxiU=;
        b=TeRSImOeadDzLOA5a6/w3EMs9obVMQnxT0eytgxYOLqiYqgoYCgth3BHFLAUM/4xez
         vLgp5+Hl68xU/3urjl3GQrU/mI4RFn6vzUxejVKn4EsExYNNfXQSF2RRCqA+XxtP4cDr
         g0ld+f9U+8Sdkg++YGUkNfYlKspHLZqAQqmq4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=qawTMtmOvr/et6j8LLYnr9ntVpAbcMlS4068INm9SfdM1wYfYjixULr6l/FAa/xPgL
         WKxqoXxdOAym4T2b5iLx5MpKZej4zLVuwE28uT2PZr+GQFtPxmHub5l/kvD11DT12TGs
         YAXWC/juY1xsMetrYMzdYJmjqc5nfFgwfQgOk=
Received: by 10.140.163.12 with SMTP id l12mr2471616rve.178.1234850011623; 
	Mon, 16 Feb 2009 21:53:31 -0800 (PST)
In-Reply-To: <20090216225226.GB23764@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110314>

On Mon, Feb 16, 2009 at 5:52 PM, Jeff King <peff@peff.net> wrote:
> Actually, I think it is pulling from the non-bare repo that will get
> confusing.
>
> You are proposing to push, when pushing into a non-bare repo, into a
> push refspec like refs/incoming/ (for example). But what is your fetch
> refspec?
>
> If it fetches as usual from refs/heads/, then you have an asymmetry.
> That is, if I do "git push" on one client, then "git pull" on another
> won't fetch the changes. I have to wait for the non-bare repo to pull
> them into its refs/heads/ hierarchy (one by one, if there are multiple
> branches).
>
> So you can try putting refs/incoming into your fetch refspec if it is a
> non-bare repo. But there are two issues there:
>
>  - how do you know the remote is non-bare?
>
>  - now you have to "push" in the non-bare upstream in order to make
>    commits available. So it no longer works to do:
>
>       workstation$ cd repo && hack hack hack && commit commit commit
>       laptop$ git clone workstation:repo
>
>    since you will silently end up with stale results.
>
>    In some ways, this is nicely rigorous: non-bare repos become
>    essentially "uncontactable" remotely, and you have a de facto bare
>    repo in the form of refs/incoming sitting in between. But I'm not
>    sure it matches what most users want to do, and certainly it causes
>    more breakage to their workflows than receive.denyCurrentBranch.

My head is playing around with two ideas now that Dscho has mentioned:

receive.localBranches = (refuse | allow)

http://thread.gmane.org/gmane.comp.version-control.git/77955/focus=78065

And PUSH_HEAD.

The idea would be for side-pushes never to update a local branch, but
to be recorded in PUSH_HEAD. You'd be able to rebase/merge local
branch on-top of changes in PUSH_HEAD. I'm trying to figure out what
can make sense when pulling from such a repo.

j.
