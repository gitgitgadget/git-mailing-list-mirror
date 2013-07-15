From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 7/7] push: document --lockref
Date: Sun, 14 Jul 2013 21:44:54 -0700
Message-ID: <20130715044454.GA2962@elie.Belkin>
References: <7vy59biih4.fsf@alter.siamese.dyndns.org>
 <51E0F93A.8050201@kdbg.org>
 <7vwqougwec.fsf@alter.siamese.dyndns.org>
 <51E1B5DB.9080904@kdbg.org>
 <7v61wdgdd1.fsf@alter.siamese.dyndns.org>
 <51E3084D.2040504@kdbg.org>
 <20130714203403.GE8564@google.com>
 <51E31131.3070005@kdbg.org>
 <20130714212800.GA11009@google.com>
 <7v4nbwfooj.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 15 06:45:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uyaex-0008WG-D8
	for gcvg-git-2@plane.gmane.org; Mon, 15 Jul 2013 06:45:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752593Ab3GOEpH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Jul 2013 00:45:07 -0400
Received: from mail-pa0-f41.google.com ([209.85.220.41]:42076 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751881Ab3GOEpC (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Jul 2013 00:45:02 -0400
Received: by mail-pa0-f41.google.com with SMTP id bj3so10851319pad.14
        for <git@vger.kernel.org>; Sun, 14 Jul 2013 21:45:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=+qm1c4iEQudLOyAQzHav71+fYMcsYa1hiISf+imVy+4=;
        b=zvNbaJ7ufSF3flZH3UN4WgZRinrQBBYEnju5BsrdUBnzdbPD2V8ADajjm9XqIvsSHm
         gZSLG4OnPizEhmb8EU8wKpVH7EHOsiHAqveWpPHR0qSpVidojKCO0iQWoo+I0QeLg7RF
         eMMoZeX3rjvSvy2iTIZjLP8MnJMTQuSgEv4OZSoV4zanSKbl29w+8iUo2cYtsmVXus5V
         +hSANN2jXyIT99N49cDMNFktTeqzjx5U1t+lDEVLXDCsCcAgPO9qy7aMeMjUE/bcoqgP
         PgjKpX7KqCjDGieY84NRcD9luN9lOUMnLMuVqKV3F3ojs06KtezYEd1nIfCFR5n5BG7A
         0e6A==
X-Received: by 10.68.201.226 with SMTP id kd2mr51720993pbc.45.1373863501456;
        Sun, 14 Jul 2013 21:45:01 -0700 (PDT)
Received: from elie.Belkin (c-107-3-135-164.hsd1.ca.comcast.net. [107.3.135.164])
        by mx.google.com with ESMTPSA id mr3sm58537626pbb.27.2013.07.14.21.44.59
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 14 Jul 2013 21:45:00 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7v4nbwfooj.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230417>

Junio C Hamano wrote:
> Jonathan Nieder <jrnieder@gmail.com> writes:

>> Then I will use
>>
>> 	(5c) git push --force
>>
>> which means not to use this new lockref trick that looks at my
>> remote-tracking branch and instead to just force the ref update.
>
> I am not sure I follow.  Do other contributors update this remote
> repository?  They are "only using fast-forward updates", so their
> updates may not lose anything we pushed, but with "--force", aren't
> you losing their work on top of yours?

Yep, I meant that when you really *do* want to force a push
regardless of what's on the remote end, the current --force behavior
is more useful than --lockref.

The example I used to introduce (5c) is too vague to be useful.  A
more compelling example (to me, at least) is the one from later in
that message involving a relay, which does not involve other
contributors at all.

That is, suppose I maintain a mirror of the branches from
git://repo.or.cz/git.git by pushing regularly to a hosting service
where I do not have shell access.  Since I can't fetch from the target
repository or push from the source, I instead fetch and then push from
a relay, like this:I might push like this:

	git fetch upstream
	git push --force origin refs/remotes/upstream/*:refs/heads/*

Or, in the same spirit, with a detached HEAD:

	git fetch upstream refs/heads/*:refs/heads/*
	git push --force origin :

The --force is to account for "pu" and "next" rewinding.

In this scenario, assuming I have exclusive access to the repository
and the push updates the remote-tracking branches, --lockref and
--force work equally well.  The commands might run once every 6 hours
using a cronjob.

Now suppose my relay has some downtime.  That's fine --- I can still
maintain the mirror by running the same commands on another machine.
But when the old relay comes back up, "push --lockref" will fail and
"pu" and "next" in my mirror are not updated any more.

That is why I said that --force is more appropriate than --lockref
for this application.

Thanks,
Jonathan
