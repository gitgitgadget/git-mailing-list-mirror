From: Torstein Hegge <hegge@resisty.net>
Subject: Re: [PATCH] bisect: Store first bad commit as comment in log file
Date: Mon, 15 Apr 2013 11:53:39 +0200
Message-ID: <20130415095339.GA28480@pvv.ntnu.no>
References: <20130413152257.GB16040@pvv.ntnu.no>
 <20130415.063809.1055555229072260139.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Mon Apr 15 11:53:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1URg6c-0005UD-5C
	for gcvg-git-2@plane.gmane.org; Mon, 15 Apr 2013 11:53:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751377Ab3DOJxm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Apr 2013 05:53:42 -0400
Received: from microbel.pvv.ntnu.no ([129.241.210.179]:60273 "EHLO
	microbel.pvv.ntnu.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751229Ab3DOJxl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Apr 2013 05:53:41 -0400
Received: from torstehe by microbel.pvv.ntnu.no with local (Exim 4.72)
	(envelope-from <torstehe@pvv.ntnu.no>)
	id 1URg6V-00025i-UL; Mon, 15 Apr 2013 11:53:39 +0200
Content-Disposition: inline
In-Reply-To: <20130415.063809.1055555229072260139.chriscool@tuxfamily.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221217>

On Mon, Apr 15, 2013 at 06:38:09 +0200, Christian Couder wrote:
> I wonder if we should also write something into the bisect log if for
> example the bisection stopped because there are only 'skip'ped commits
> left to test. But maybe this could go into another patch after this
> one.

Yes, that would be useful, but I wasn't able to determine all the cases
that would be relevant to log. Only skipped commits left to test is one,
but bisect--helper also exits on various problems related to merge base
handling. The handling of problems related to inconsistent user input is
probably not relevant to log.

I think the successful bisect case is most important to log and the one
that requires the least amount of invasive changes.

> > diff --git a/git-bisect.sh b/git-bisect.sh
> > index 99efbe8..c58eea7 100755
> > --- a/git-bisect.sh
> > +++ b/git-bisect.sh
> > @@ -311,7 +311,13 @@ bisect_next() {
> >  	res=$?
> >  
> >  	# Check if we should exit because bisection is finished
> > -	test $res -eq 10 && exit 0
> > +	if test $res -eq 10
> > +	then
> > +		bad_rev=$(git show-ref --hash --verify refs/bisect/bad)
> 
> I had a look to make sure that refs/bisect/bad always refered to the
> first bad commit at this point, and it is true indeed.

According to Documentation/git-bisect.txt, refs/bisect/bad is the proper
way to determine the first bad commit at the end of a bisection.

> Maybe you could have used "git rev-parse --verify" instead of "git
> show-ref --hash --verify". It looks simpler to me.

I was wondering why "git grep show-ref *.sh" gave so few users. It looks
like rev-parse is more common.

> And maybe, just in case, you could have added: || die "$(gettext "Bad rev: refs/bisect/bad")"

Yes, I should probably have done that.

> Otherwise this patch looks good to me.

Thanks.


Torstein
