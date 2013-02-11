From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [RFC/PATCH] shell: allow 'help' command to disable interactive
 shell
Date: Mon, 11 Feb 2013 00:13:46 -0800
Message-ID: <20130211081346.GP15329@elie.Belkin>
References: <20130211041706.GB15329@elie.Belkin>
 <7vwqufpj50.fsf@alter.siamese.dyndns.org>
 <20130211043247.GD15329@elie.Belkin>
 <7vpq07pgpy.fsf@alter.siamese.dyndns.org>
 <20130211061442.GI15329@elie.Belkin>
 <7vliavpc4q.fsf@alter.siamese.dyndns.org>
 <20130211071235.GL15329@elie.Belkin>
 <7v8v6vpbej.fsf@alter.siamese.dyndns.org>
 <20130211072154.GN15329@elie.Belkin>
 <7vvc9znvk6.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sitaram Chamarty <sitaramc@gmail.com>, Jeff King <peff@peff.net>,
	Ethan Reesor <firelizzard@gmail.com>, git@vger.kernel.org,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Greg Brockman <gdb@mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 11 09:14:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U4oWo-0000bG-5j
	for gcvg-git-2@plane.gmane.org; Mon, 11 Feb 2013 09:14:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753017Ab3BKINz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Feb 2013 03:13:55 -0500
Received: from mail-pa0-f49.google.com ([209.85.220.49]:59595 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752934Ab3BKINy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Feb 2013 03:13:54 -0500
Received: by mail-pa0-f49.google.com with SMTP id kp6so2944461pab.22
        for <git@vger.kernel.org>; Mon, 11 Feb 2013 00:13:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=GTicpQbZc2PzGCespXmgoo8DcsH31L/PndG+VAFW7PM=;
        b=s9/4V85/yi40HLRrbMnAXXLMkE1Uj2lBRMoEe3oxLsYrcrzldIxzOIxjkcHdEZQUT4
         At26Ybt9a3P8v0TSGLWiBTXlCtE7QzD+uYWIx8B5vYdpC5r80mbSAxiNOWZ40m2wSfdN
         YoqYb3XVU6wscgsvpPhe12zoHACatZYzOl3w86wQ+2pz9y/5OGAgnz75pgG4HsAhhTrN
         oHI+SCnJ8x4GtjjXgYe6gFi3xde0PISpY1wCOUGRkewAOZ7F1sHF3qyOkmYllcQqVudt
         THIRd9cA4wdLETsmYq1bpcNV5fx+Pd/+AIbLT1cGGUySwjsNBjHw7KE2LWFujEeRl8gL
         r71g==
X-Received: by 10.68.231.226 with SMTP id tj2mr11200308pbc.88.1360570434197;
        Mon, 11 Feb 2013 00:13:54 -0800 (PST)
Received: from elie.Belkin (c-107-3-135-164.hsd1.ca.comcast.net. [107.3.135.164])
        by mx.google.com with ESMTPS id kr9sm6934292pbc.2.2013.02.11.00.13.51
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 11 Feb 2013 00:13:52 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <7vvc9znvk6.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216023>

Junio C Hamano wrote:

> The purpose of the directory is to keep custom commands that are
> allowed.  If the site administrator does not want any command, it
> would be more natural to expect that the way to disable them would
> be _not_ to have that directory which is a collection of allowed
> commands.  Adding that directory and add a "help" that exits with
> non-zero feels quite a roundabout and counter-intuitive way, no?

I think it comes down to the reason the site admin doesn't want to
allow interactive logins.  That reason seems to be mostly that
presenting a

	git>

prompt at which you can only ask for "help" or "exit" is a bit
confusing and pointless.  I have sympathy for that, which is why I
looked for a way for the admin to ask to avoid the prompt altogether
in that case.

I do not think the reason is "because I don't want a
git-shell-commands directory".  I think it's good to have basically
one kind of setup instead of significantly different ones with and
without that special directory --- and it means that starting from a
setup like this, one can easily drop in additional commands like
set-head or create-repo without changing anything basic.  It's making
the admin's later life easier.

Maybe a better test than "help exits with special exit code" is "there
are no other custom commands than help".  Would that be more sensible?

>From a "make it possible to emulate gitolite" point of view, that
doesn't permit disabling the interactive mode when there are other
commands available, so my hunch is that it wouldn't.

Jonathan
