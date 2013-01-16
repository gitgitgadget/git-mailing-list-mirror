From: John Keeping <john@keeping.me.uk>
Subject: Re: [PATCH] git-remote: distinguish between default and configured
 URLs
Date: Wed, 16 Jan 2013 10:42:22 +0000
Message-ID: <20130116104222.GA15125@farnsworth.metanate.com>
References: <7v4nii5tp2.fsf@alter.siamese.dyndns.org>
 <a5bf3511b3ecf4e9243d550d11ab977f95ecea30.1358331096.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jardel Weyrich <jweyrich@gmail.com>,
	Sascha Cunz <sascha-ml@babbelbox.org>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Wed Jan 16 12:14:06 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TvQwU-0005GX-U9
	for gcvg-git-2@plane.gmane.org; Wed, 16 Jan 2013 12:14:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758158Ab3APLNl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jan 2013 06:13:41 -0500
Received: from dougal.metanate.com ([90.155.101.14]:49279 "EHLO metanate.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1758112Ab3APLNk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jan 2013 06:13:40 -0500
X-Greylist: delayed 1874 seconds by postgrey-1.27 at vger.kernel.org; Wed, 16 Jan 2013 06:13:40 EST
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=simple/simple; d=metanate.com; s=stronger;
	h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=UKp1LnQUNkkPDMkmTWTmfi05y/yoxaEw8acAVi/Yc+8=;
	b=DLmSbyoCGPHvoyvMZqGOleQgWFiYys85Nq82owDf6B7RlWBYYv2SjJvRkG2YiCM510tpxaNsowOL4kXSGpGBbk/P/4tzvYHwpS+xcIsu8DqEkjzU9OARBaIl7vqcMtd3igwx8cDtOp71JYy+0r/8Zl6BG5lD2+TSuth0oWbnkljLTerrjr7t7qVkvms2mzlbsVz37iF5hXK7b4jqqj3lUSFvbMDBHv8erF/Lko/Fh6GQikf61Jw3K6kRBgjLjpezB8HXwESS+eF7yPO9LKJkHdHkF+KjPisxfLOYvXh5oNwvcz32R10R7wRqRg9tpO3OgCjbw9p9k3m6rUk0whhHDw==;
Received: from brian.metanate.com ([192.168.88.1] helo=farnsworth.metanate.com)
	by shrek.metanate.com with esmtps (TLSv1:DHE-RSA-AES128-SHA:128)
	(Exim 4.80.1)
	(envelope-from <john@keeping.me.uk>)
	id 1TvQRr-0001WO-1I; Wed, 16 Jan 2013 10:42:23 +0000
Content-Disposition: inline
In-Reply-To: <a5bf3511b3ecf4e9243d550d11ab977f95ecea30.1358331096.git.git@drmicha.warpmail.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213746>

On Wed, Jan 16, 2013 at 11:14:48AM +0100, Michael J Gruber wrote:
> The current output of "git remote -v" does not distinguish between
> explicitly configured push URLs and those coming from fetch lines.
> 
> Revise the output so so that URLs are distinguished by their labels:
> 
> (fetch): fetch config used for fetching only
> (fetch/push): fetch config used for fetching and pushing
> (fetch fallback/push): fetch config used for pushing only
> (fetch fallback): fetch config which is unused
> (push): push config used for pushing

How does this interact with url.<base>.pushInsteadOf?

I have a global rule to convert git:// URLs to ssh:// for pushing:

    [url "git@example.com:"]
        pushInsteadOf = git://example.com/

With only a URL configured for a remote (no pushURL), I get (with Git
1.8.1):

    origin git://example.com/repository.git (fetch)
    origin git@example.com:repository.git (push)

>From the original discussion in this thread, I think that if I did
"git remote set-url --add --push <url>" it would replace my current push
URL, and the change to "(fetch/push)" doesn't help in this case.

Should there be special handling for pushInsteadOf here?


John
