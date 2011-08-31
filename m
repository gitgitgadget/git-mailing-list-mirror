From: Bryan Jacobs <bjacobs@woti.com>
Subject: Re: [spf:guess] Re: [PATCH] Teach dcommit --mergeinfo to handle
 multiple lines
Date: Wed, 31 Aug 2011 16:51:09 -0400
Organization: White Oak Technologies
Message-ID: <20110831165109.0ca6373f@robyn.woti.com>
References: <20110831124839.69c70486@robyn.woti.com>
	<20110831202131.GA27307@dcvr.yhbt.net>
	<4E5E9CFB.4060600@vilain.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Eric Wong <normalperson@yhbt.net>, git@vger.kernel.org
To: Sam Vilain <sam@vilain.net>
X-From: git-owner@vger.kernel.org Wed Aug 31 22:51:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qyrkn-00041Y-F6
	for gcvg-git-2@lo.gmane.org; Wed, 31 Aug 2011 22:51:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755270Ab1HaUvO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 31 Aug 2011 16:51:14 -0400
Received: from mail02.woti.us ([66.92.158.6]:52377 "EHLO roscoe.woti.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751411Ab1HaUvL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Aug 2011 16:51:11 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by roscoe.woti.com (Postfix) with ESMTP id 9CC09504D37ED;
	Wed, 31 Aug 2011 16:51:10 -0400 (EDT)
X-Virus-Scanned: amavisd-new at woti.com
Received: from roscoe.woti.com ([127.0.0.1])
	by localhost (roscoe.woti.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id t6a3-1Pf-KKT; Wed, 31 Aug 2011 16:51:10 -0400 (EDT)
Received: from robyn.woti.com (robyn.woti.com [192.168.168.187])
	by roscoe.woti.com (Postfix) with ESMTPSA id 26EF9504D37EA;
	Wed, 31 Aug 2011 16:51:10 -0400 (EDT)
In-Reply-To: <4E5E9CFB.4060600@vilain.net>
X-Mailer: Claws Mail 3.7.9 (GTK+ 2.22.0; x86_64-redhat-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180503>

On Wed, 31 Aug 2011 13:43:39 -0700
Sam Vilain <sam@vilain.net> wrote:

> On 8/31/11 1:21 PM, Eric Wong wrote:
> >> --- a/Documentation/git-svn.txt
> >> +++ b/Documentation/git-svn.txt
> >> @@ -211,8 +211,9 @@ discouraged.
> >>   	Add the given merge information during the dcommit
> >>   	(e.g. `--mergeinfo="/branches/foo:1-10"`). All svn
> >> server versions can store this information (as a property), and
> >> svn clients starting from
> >> -	version 1.5 can make use of it. 'git svn' currently does
> >> not use it
> >> -	and does not set it automatically.
> >> +	version 1.5 can make use of it. To specify merge
> >> information from multiple
> >> +	branches, use a single space character between the
> >> branches
> >> +	(`--mergeinfo="/branches/foo:1-10 /branches/bar:3,5-6,8"`)
> 
> This interface seems regrettably stupid.  Like, do I need to consider 
> the existing revisions that are already listed in the property?  Is
> it really impossible to derive the changes that were merged and
> generate the list automatically?

Nope, it's possible. I didn't create the original --mergeinfo
interface. I was very surprised when I first discovered it clobbered
instead of integrating - it's easy to nuke your SVN repo's ability to
merge with one careless use of this option. See below.

> But so long as it makes something previously impossible possible, it
> is a good change - my feeling is that it should be called something
> like --mergeinfo-raw or --mergeinfo-set to leave room for a possible 
> --mergeinfo-add which knows how the lists work and adds them (which
> is what I'd expect a plain --mergeinfo switch to do).

I completely agree. I think there should at least be a
--mergeinfo-update which fetches the current revision, merges that with
the provided set using the branch paths as keys (and compacts using
svn:mergeinfo rules), and sets the property to the final result.

I actually do this currently with external scripts, which is why I
wanted to make --mergeinfo capable of delivering my final payload. It
would make my life easier if all the logic were part of git-svn instead.

That said, this change is really small. That change would be larger.
So I submitted this first.

> Sam
