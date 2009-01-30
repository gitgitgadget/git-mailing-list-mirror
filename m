From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: [PATCH] Switch receive.denyCurrentBranch to "refuse"
Date: Fri, 30 Jan 2009 13:50:25 -0500
Message-ID: <76718490901301050h1f0f5b2bq902de384d954d99b@mail.gmail.com>
References: <cover.1233275583u.git.johannes.schindelin@gmx.de>
	 <alpine.DEB.1.00.0901300133070.3586@pacific.mpi-cbg.de>
	 <76718490901300817x3f31460k59b6fe75d136372d@mail.gmail.com>
	 <alpine.DEB.1.00.0901301756560.3586@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@pobox.com
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Jan 30 19:51:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LSyT2-0000Xt-1Q
	for gcvg-git-2@gmane.org; Fri, 30 Jan 2009 19:51:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753301AbZA3Su1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Jan 2009 13:50:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752906AbZA3Su0
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Jan 2009 13:50:26 -0500
Received: from rv-out-0506.google.com ([209.85.198.233]:13198 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753030AbZA3Su0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Jan 2009 13:50:26 -0500
Received: by rv-out-0506.google.com with SMTP id k40so563698rvb.1
        for <git@vger.kernel.org>; Fri, 30 Jan 2009 10:50:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=DFLAGZsALDPi+Ti0bgU0O2IkvAkP1hKibhkZQgdnMZ8=;
        b=qHiS7RWnrbNIrqscK2g41aYqnv+evm9B3kdXLrhuwhr1TQomNHduv5jQ0WcztpQ+SN
         0gSRN/12fvfZM6xaG6V9mFsonjDGKdIBfWRFD/kP2QRiEMhYJMBDMcHQtenxyUQKMvmp
         Lint+FbviVBaSIU/tZlytDWEvtpdmdlE3YMQ4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=FlG9JjY12cKBe5THpkEtJ+cLA55zJzkEU+aWM3Kz3B4JF35dNrj1mJHjoOw9AzDIM7
         hEnSeT25mBxi6cbM4F/3WrkaF1XosLyyvVUFuX/iRakvcx0/AKMBftZ7gCT3enjn1f9/
         Ouq682T1mgIhju6pl3hxP2EzTmDhzdKw/4d2Y=
Received: by 10.141.63.11 with SMTP id q11mr761091rvk.60.1233341425295; Fri, 
	30 Jan 2009 10:50:25 -0800 (PST)
In-Reply-To: <alpine.DEB.1.00.0901301756560.3586@pacific.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107862>

On Fri, Jan 30, 2009 at 12:01 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> As Peff commented, this would be horribly wrong if the remote has a
> different "origin" remote.  Not forcing the push does not help either, it
> is still wrong.

Got it. Here was my impression of the work-flow we're trying to help
beginners with:

machineA$ mkdir repo
machineA$ cd repo
machineA$ git init
machineA$ add, commit, add, commit...

machineB$ git clone ssh://machine1/repo
machineB$ add, commit, add, commit...
machineB$ git push

(And if my impression is wrong, then stop me right here and I'll
shut-up on this thread.)

In this case, the clone operation sets up the repo on B to fetch all
of the branches from the repo on A. But it doesn't do anything to help
the user with pushing the repo from B back to machine A. So perhaps:

git clone --origin machineA --push-as machineB ssh://machineA/repo

[remote "machineA"]
	url = ...
	fetch = +refs/heads/*:refs/remotes/machineA/*
	push = +refs/heads/*:refs/remotes/machineB/*

Now fetch and push are symmetric operations on machineB.

> But I think there is an even more fundamental problem: You do not want
> that default push.  We have "push only those refs the remote and the local
> repository share" rule for a reason.  It is way too easy to publish
> something you did not mean to publish otherwise.

I don't have a good answer for that, other than to say that if user is
setting up symmetric repositories, user wants to push everything.

j.
