From: Sam Vilain <sam@vilain.net>
Subject: Re: [PATCH] Documentation: add a planning document for the next 
	CLI revamp
Date: Thu, 30 Oct 2008 10:44:26 -0700
Message-ID: <1225388666.19891.22.camel@maia.lan>
References: <1225338485-11046-1-git-send-email-sam@vilain.net>
	 <20081030143918.GB14744@mit.edu> <20081030144321.GF24098@artemis.corp>
	 <20081030163056.GA8899@mit.edu>  <20081030164357.GJ24098@artemis.corp>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Theodore Tso <tytso@mit.edu>, git@vger.kernel.org,
	Sam Vilain <samv@vilain.net>
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Thu Oct 30 18:46:40 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KvbbI-0001qT-Eq
	for gcvg-git-2@gmane.org; Thu, 30 Oct 2008 18:46:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756989AbYJ3Ro5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Oct 2008 13:44:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757171AbYJ3Ro5
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Oct 2008 13:44:57 -0400
Received: from watts.utsl.gen.nz ([202.78.240.73]:58283 "EHLO mail.utsl.gen.nz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755710AbYJ3Ro4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Oct 2008 13:44:56 -0400
Received: by mail.utsl.gen.nz (Postfix, from userid 1004)
	id D0B7221C83C; Fri, 31 Oct 2008 06:44:54 +1300 (NZDT)
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on
	mail.musashi.utsl.gen.nz
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=5.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.5
Received: from [127.0.0.1] (longdrop.musashi.utsl.gen.nz [192.168.253.12])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.utsl.gen.nz (Postfix) with ESMTPSA id 306FD21C318;
	Fri, 31 Oct 2008 06:44:29 +1300 (NZDT)
In-Reply-To: <20081030164357.GJ24098@artemis.corp>
X-Mailer: Evolution 2.22.3.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99506>

On Thu, 2008-10-30 at 17:43 +0100, Pierre Habouzit wrote:
> In fact I believe that what we lack is a shorthand for:
> 
> $sha1^..$sha1 because that would solve both of your issues, and it's
> something that has bothered me in the past too for other commands.

There is already a shorthand for that;

  $sha1^!

Indeed passing that to git-format-patch has the intended effect; it
causes it to save a patch for just the commit in question.

I agree that it would make more sense for the current behaviour to be
changed;

  git format-patch origin/master..

Isn't that much more to type than:

  git format-patch origin/master

And it makes the case where you just want to format a single patch work
better.

However, I worry about the backwards incompatibility.  The other changes
I listed didn't really violate existing expectations.

That being said, the case where a single commit reference is passed,
with no range, should be relatively easy to detect.  In this situation
it could return an error, and encourage the user to use "--since" or
"--only"; or to configure one of those to be the default.

I'm wondering whether it's worth building some kind of mechanism to
notice that settings like this have not been set, and to print a warning
like "warning: you are using a git that introduced minor command
changes; use 'git config --new' to pick your defaults" - that way,
changes to command operation could be introduced that would not annoy
older users so much.

Sam.
