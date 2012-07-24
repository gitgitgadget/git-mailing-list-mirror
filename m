From: Michael G Schwern <schwern@pobox.com>
Subject: Re: git-svn SVN 1.7 fix, take 2
Date: Tue, 24 Jul 2012 15:50:39 -0700
Message-ID: <500F26BF.7090501@pobox.com>
References: <500F17A3.60307@pobox.com> <20120724220207.GA15969@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@pobox.com,
	"Robin H. Johnson" <robbat2@gentoo.org>,
	Eric Wong <normalperson@yhbt.net>,
	Ben Walton <bwalton@artsci.utoronto.ca>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 25 00:50:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1StnwL-0005fY-1U
	for gcvg-git-2@plane.gmane.org; Wed, 25 Jul 2012 00:50:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755848Ab2GXWun (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jul 2012 18:50:43 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60079 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755750Ab2GXWum (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jul 2012 18:50:42 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 38ED08189;
	Tue, 24 Jul 2012 18:50:41 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=message-id
	:date:from:mime-version:to:cc:subject:references:in-reply-to
	:content-type:content-transfer-encoding; s=sasl; bh=VX4YlBkObdzh
	hA2FK/euZN22qkw=; b=ieH6g9PbAcqL7cnN7JQmKfKdl4WrgZK+xTe/EeUkn5ln
	u2wdlHko0O8LJJYmeRdQGnzshjRREQqQh8rjDEikq5VFm69lg5rIneLGBYdhOpLb
	Pf1L0nbUv3534WHoYIDdA/xFR5ezpr7Gfj/6IprZsgHcQ0szJOQhWMYRL9M57xI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=message-id:date
	:from:mime-version:to:cc:subject:references:in-reply-to
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=xq+0Iq
	1yiwMEVIb5bdDB89XDpawQhqnMUz9sAW2IFcb0nvfxLQGdci6kBE6j4n1vqvoNpd
	YSn+kDYIzpf5CZ1/AUMvSTYbpFMUv/dgm/n8u8CpgMRCYtfzpq9k+sils1m3lzxP
	HX7B5V4p34Gt5QyuBgrVlnii1TIuGZ7ClkRfo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 256178188;
	Tue, 24 Jul 2012 18:50:41 -0400 (EDT)
Received: from windhund.local (unknown [71.236.173.173]) (using TLSv1 with
 cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested)
 by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2A1898186; Tue, 24 Jul
 2012 18:50:40 -0400 (EDT)
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.7; rv:14.0)
 Gecko/20120713 Thunderbird/14.0
In-Reply-To: <20120724220207.GA15969@burratino>
X-Enigmail-Version: 1.4.3
X-Pobox-Relay-ID: FE3C74C4-D5E1-11E1-8E4E-01B42E706CDE-02258300!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202081>

On 2012.7.24 3:02 PM, Jonathan Nieder wrote:
>> The Git::SVN extraction is more complicated than the rest, so I'll probably do
>> that separately and bust it up into a few commits.
> 
> All of these changes are supposed to have zero functional effect,
> right?

Right.  They're just class extraction refactoring.  I don't even need to make
new classes, they already exist.  It's just moving them into their own file.


> Could you send the first five patches that *are* supposed to have a
> functional effect?  I know that they will not apply cleanly to git-svn
> from git "master" or on top of each other; that's fine with me.  If
> the approach looks right, interested people (read: probably Ben or I :))
> can make the corresponding change in the code layout from "master".
> Afterwards, we can look into all that refactoring to make later
> changes easier.
> 
> What do you think?

I think that would be a lot of extra work for me, create a big mess and be
harder to understand. :-/

Since I'm creating new files to store the classes, the functional changes
cannot be applied without the class extractions, so I'd have to rewrite them.
 And they will be harder to review since the main git-svn code and the class
code is mixed up in one file.  And they won't have unit tests, since git-svn
cannot be loaded without it running.

The Git::SVN extraction isn't really complicated, it just requires a handful
more work than the other classes.  Just a few method extractions.  The rest
are essentially cut, paste & fix lexicals.

I'm not sure what you're going for, but you can glance through the existing
changes here
https://github.com/schwern/git/commits/git-svn/fix-canonical

or you can do grab it as a remote and...

  git log -p schwern/git-svn/extract-classes..schwern/git-svn/fix-canonical

That should give you the information you need... if I understand what you
need.  I feel like I don't and we're talking past each other.


-- 
Ahh email, my old friend.  Do you know that revenge is a dish that is best
served cold?  And it is very cold on the Internet!
