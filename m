From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: An idea: maybe Git should use a lock/unlock file mode for problematic files? [Was: Re: after first git clone of linux kernel repository there are changed files in working dir]
Date: Wed, 21 Jan 2009 00:25:16 +0100
Message-ID: <81b0412b0901201525w22513418p57acc19457908a3@mail.gmail.com>
References: <d304880b0812101019ufe85095h46ff0fe00d32bbd0@mail.gmail.com>
	 <d304880b0812101022u2abe5d68ub3bda68ed39f830b@mail.gmail.com>
	 <83ocy3fmez.fsf@kalahari.s2.org>
	 <20090120105228.xbo3gyc0odwcgcsc@webmail.fussycoder.id.au>
	 <alpine.LNX.1.00.0901201441480.19665@iabervon.org>
	 <1232486929.4179.7.camel@therock.nsw.bigpond.net.au>
	 <alpine.LNX.1.00.0901201651050.19665@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "John Chapman" <thestar@fussycoder.id.au>,
	"Hannu Koivisto" <azure@iki.fi>, rdkrsr <rdkrsr@googlemail.com>,
	git@vger.kernel.org
To: "Daniel Barkalow" <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Wed Jan 21 00:27:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LPPzq-0001rD-BE
	for gcvg-git-2@gmane.org; Wed, 21 Jan 2009 00:27:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757202AbZATXZY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Jan 2009 18:25:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762500AbZATXZW
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Jan 2009 18:25:22 -0500
Received: from wa-out-1112.google.com ([209.85.146.181]:26432 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762501AbZATXZS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Jan 2009 18:25:18 -0500
Received: by wa-out-1112.google.com with SMTP id v27so1920787wah.21
        for <git@vger.kernel.org>; Tue, 20 Jan 2009 15:25:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=HYpuv5+y9Z8QBtEy81vGteEIQhB+QoDThfiw6V+VM58=;
        b=piUXQ+ZdW8tRLm9sBC7ciDIDSysmrI4nBtLUHqDignVA/HIyikIlbKxyrBRMZjklaj
         LWmxKshICRjZddP7/BXFi+8tIj7OhtAz4IOKpoZO8pyzRs/j0DCq2TULPEjeKtSH7Oqs
         +odtxAL2X1Ju6FY4Fjm4YajNErjUOlYLL345Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=OCrnjtDc0L6sEFjLI78Xq+KmNGhfjnMdUNQy2JJhEk/BAvAXODrQPYzbN4hZCt1yHz
         0uOTz/PDDswW91DUPVD3SqUrj2KXlJtmE0ZKVAJdptItZrwFwD2zyz2hmI5C6Dlj2TQc
         WjEyb6Ym7tK07H7sxBa/GzzW+51qqhpfziLjE=
Received: by 10.114.161.11 with SMTP id j11mr2282034wae.24.1232493916360;
        Tue, 20 Jan 2009 15:25:16 -0800 (PST)
Received: by 10.114.179.4 with HTTP; Tue, 20 Jan 2009 15:25:16 -0800 (PST)
In-Reply-To: <alpine.LNX.1.00.0901201651050.19665@iabervon.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106539>

2009/1/20 Daniel Barkalow <barkalow@iabervon.org>:
> My impression was that this didn't happen in practice, because teams
> would tend to not have two people create the same file at the same time,
> but with different cases, and people interacting with the same file at
> different times would use whatever case it was introduced with.

It will and does happen in practice (annoingly too often even). Not with Git
yet (with Perforce), where people do "branching" by simply copying things
in another directory (perforce world does not know real branches),
renaming files randomly, and putting the new directory back in the
system (or maybe it is the strange tools here which do that - often
it is the first character of a directory or file which gets down- or up-cased).
As Perforce itself is case sensitive (like Git), using of such branches
is a nightmare: the files get overwritten in checkout order which is
not always sorted in predictable order. Combined with case-stupidity
of the file system the working directories sometimes cause "interesting
time" for unlucky users.
Luckily (sadly) it is all-opening-in-a-wall shop, so the problem with "fanthom"
files is rare (it is hard to notice) for most. Which actually makes it more
frustrating when the real shit happens.

And it will happen to Git as well, especially if development go crossplatform.
It is not that hard to accidentally rename a file on case-sensitive file system,
"git add *" it and commit without thinking (that's how most of software
development happens, come to think of it).
