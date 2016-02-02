From: Andrew Martin <amartin@xes-inc.com>
Subject: Re: git object-count differs between clones
Date: Tue, 2 Feb 2016 11:22:08 -0600 (CST)
Message-ID: <1978336183.727736.1454433728105.JavaMail.zimbra@xes-inc.com>
References: <2142875754.710575.1454428371555.JavaMail.zimbra@xes-inc.com> <vpq7finm6v8.fsf@anie.imag.fr> <203317792.714602.1454430077194.JavaMail.zimbra@xes-inc.com> <20160202165246.GA17822@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Feb 02 18:22:20 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aQeeh-0006tS-PV
	for gcvg-git-2@plane.gmane.org; Tue, 02 Feb 2016 18:22:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755851AbcBBRWN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Feb 2016 12:22:13 -0500
Received: from xes-mad.com ([216.165.139.218]:2798 "EHLO xes-mad.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755791AbcBBRWL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Feb 2016 12:22:11 -0500
Received: from zimbra.xes-mad.com (zimbra.xes-mad.com [10.52.0.127])
	by xes-mad.com (8.13.8/8.13.8) with ESMTP id u12HM8Eu009056;
	Tue, 2 Feb 2016 11:22:08 -0600
In-Reply-To: <20160202165246.GA17822@sigill.intra.peff.net>
X-Originating-IP: [10.52.16.96]
X-Mailer: Zimbra 8.0.6_GA_5922 (ZimbraWebClient - GC47 (Linux)/8.0.6_GA_5922)
Thread-Topic: git object-count differs between clones
Thread-Index: TmEf3553aOTkRPX0GjWa/vXk1QO4/w==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285284>

----- Original Message -----
> From: "Jeff King" <peff@peff.net>
> To: "Andrew Martin" <amartin@xes-inc.com>
> Cc: "Matthieu Moy" <Matthieu.Moy@grenoble-inp.fr>, git@vger.kernel.org
> Sent: Tuesday, February 2, 2016 10:52:46 AM
> Subject: Re: git object-count differs between clones
> 
> On Tue, Feb 02, 2016 at 10:21:17AM -0600, Andrew Martin wrote:
> 
> > > You may try expiring your reflog and "git gc" again.
> > 
> > Thanks, I found some commits that are not referenced in any branch. How can
> > I
> > remove these from the reflog? I tried running
> > "git reflog expire --expire=now --expire-unreachable=now --all" followed by
> > "git gc" but still the same number of objects remain.
> 
> Are the objects now loose, or still in packs? Git has a grace period for
> pruning objects, so that we do not delete objects for an in-progress
> operation. The life cycle of an unreferenced object should be something
> like:
> 
>   - reachable by reflogs, which are pruned after 30 days (or
>     gc.reflogExpireUnreachable config). Objects will be repacked as
>     normal during this time. Override with "reflog expire" as you did
>     above.
> 
>   - after the reflog expires, the objects are now unreachable. During
>     the next repack, they'll be ejected from the pack into loose
>     objects, and their mtimes set to match the pack they came from
>     (which is probably quite recent if you just repacked!).
> 
>   - after 2 weeks (or gc.pruneExpire), unreachable loose objects are
>     dropped by "git prune", which is called as part of "git gc". This is
>     based on the object mtime.
> 
>     You can accelerate this with "git gc --prune=now" (or
>     "--prune=5.minutes.ago").
> 
> -Peff

Jeff,

Thanks for the clarification. I now ran "git repack -A" followed by 
"git gc --prune=now", however I am still seeing the same number of objects. What
else can I try to successfully mark these and unreachable and garbage collect them?

Thanks,

Andrew
