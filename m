From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: receive.denyCurrentBranch
Date: Mon, 9 Feb 2009 10:43:31 -0500
Message-ID: <76718490902090743j6f1bfdcdkdf9f64ca51c4a0af@mail.gmail.com>
References: <20090208042910.19079.qmail@science.horizon.com>
	 <alpine.DEB.1.00.0902081128420.10279@pacific.mpi-cbg.de>
	 <76718490902080950r798ca02es4e560da35e499046@mail.gmail.com>
	 <alpine.DEB.1.00.0902082149380.10279@pacific.mpi-cbg.de>
	 <76718490902081451xd953e84y33de64cc82c1da42@mail.gmail.com>
	 <alpine.DEB.1.00.0902090038550.10279@pacific.mpi-cbg.de>
	 <76718490902081747s7a1ebe12yaf08665429a594c6@mail.gmail.com>
	 <20090209050659.GA12655@mini-me.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	George Spelvin <linux@horizon.com>, gitster@pobox.com,
	git@vger.kernel.org
To: Theodore Tso <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Mon Feb 09 16:45:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LWYJg-0002GN-2G
	for gcvg-git-2@gmane.org; Mon, 09 Feb 2009 16:45:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754804AbZBIPnc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Feb 2009 10:43:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754704AbZBIPnc
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Feb 2009 10:43:32 -0500
Received: from rv-out-0506.google.com ([209.85.198.234]:40462 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753262AbZBIPnb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Feb 2009 10:43:31 -0500
Received: by rv-out-0506.google.com with SMTP id k40so1845621rvb.1
        for <git@vger.kernel.org>; Mon, 09 Feb 2009 07:43:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=T824MKrcq0djtD37suyLgmF8cK7WpOK3hDDvzlz5e9E=;
        b=nDBpLqmykjyIJuSIerDRsTMBPwDRyfcRRZVvn/zXky97pKlLveEB9Bzmq3Mp5b2N+K
         RYXYJsjX4XCP4nXEGVsyUKPLX24yHmsgj4WZItBunXNBlPuGACU0P1IoYXIq/TcsySW1
         MvXOQWyUmiaq63ssObRPI2YQTGEuiovxzYBQA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=SsWzO8HsBEWrpO1pvvPExIdhFSSzKRWLXuMH162fN2PymiN2EGan8Oza+Z9/h9HB13
         wBxT/q3Rj/Juh4SYb7nc0NUGA43I6BkymXsuYsC/FAALwtsOvczuxbfxQ1a37Hct9T2m
         vtbdyIMEaUaaaN5WdI7THBP9aJlhm+SOn4LoM=
Received: by 10.141.155.15 with SMTP id h15mr3876619rvo.220.1234194211138; 
	Mon, 09 Feb 2009 07:43:31 -0800 (PST)
In-Reply-To: <20090209050659.GA12655@mini-me.lan>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109083>

On Mon, Feb 9, 2009 at 12:06 AM, Theodore Tso <tytso@mit.edu> wrote:
> On Sun, Feb 08, 2009 at 08:47:26PM -0500, Jay Soffian wrote:
>>
>> [receive]
>>      prefix = refs/remotes/incoming
>>
>> Then a push to refs/heads/master was automatically stored as
>> refs/remotes/incoming/master instead.
>
> What happens when the next person pushes to the same remote repo, and
> their refs/heads/master push is not a fast-forward merge of the
> current refs/remotes/incoming/master?
>
> Do you lose the first user's push at that point?  Or do you refuse the
> push?

The idea initially was to give a place to store the push head for the
checked-out branch, but that isn't what HEAD points to. But it seemed
confusing to do this for just the checked-out branch, so I was playing
with having all incoming pushes go into their own namespace, hence the
prefix.

Also, the use case I have in mind here is an individual with a
workstation and a laptop, and the repository on the workstation and
its clone on the laptop are both non-bare. There are not multiple
individuals pushing to the non-bare repo. Someone please correct me if
I'm wrong, but it is my impression that these are the users that have
motivated the receive.denyCurrentBranch option (and its eventual
default changing to refuse) in the first place.

In that case, the work-flow is typically:

server$ mkdir repo && cd repo && git init
server$ ... add, commit, add, commit ...
  [...time passes...]
laptop$ git clone ssh://server/~/repo
laptop$ ... add, commit, add, commit ...
laptop$ git push
laptop$ ssh server
server$ cd repo
server$ git merge incoming/master
server$ git branch -dr incoming/master

But, to answer your question, the non-fast-forward push is rejected,
unless the user forces it, unless receive.denyNonFastForwards prevents
the force.

j.
