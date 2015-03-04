From: Mike Hommey <mh@glandium.org>
Subject: Re: git describe --contains doesn't work properly for a commit
Date: Thu, 5 Mar 2015 07:05:53 +0900
Message-ID: <20150304220553.GA24801@glandium.org>
References: <20150226133534.GB14878@dhcp22.suse.cz>
 <20150226142314.GC14878@dhcp22.suse.cz>
 <20150304105408.GA19693@peff.net>
 <54F71F69.3080500@drmicha.warpmail.net>
 <20150304180529.GA28074@peff.net>
 <xmqq7fuw8pgq.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Michal Hocko <mhocko@suse.cz>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 04 23:06:28 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YTHQy-0003AC-1c
	for gcvg-git-2@plane.gmane.org; Wed, 04 Mar 2015 23:06:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753214AbbCDWGX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Mar 2015 17:06:23 -0500
Received: from ks3293202.kimsufi.com ([5.135.186.141]:39175 "EHLO glandium.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753124AbbCDWGW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Mar 2015 17:06:22 -0500
Received: from glandium by zenigata with local (Exim 4.84)
	(envelope-from <glandium@glandium.org>)
	id 1YTHQP-00078z-Pt; Thu, 05 Mar 2015 07:05:53 +0900
Content-Disposition: inline
In-Reply-To: <xmqq7fuw8pgq.fsf@gitster.dls.corp.google.com>
X-GPG-Fingerprint: 182E 161D 1130 B9FC CD7D  B167 E42A A04F A6AA 8C72
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264790>

On Wed, Mar 04, 2015 at 12:41:57PM -0800, Junio C Hamano wrote:
> Jeff King <peff@peff.net> writes:
> 
> > On Wed, Mar 04, 2015 at 04:06:17PM +0100, Michael J Gruber wrote:
> >
> >> Complexity: Was that due to replace refs? Other than that, it seemed to
> >> be simple: max(parent generation numbers)+1.
> >
> > Calculating them is simple. Caching and storage is the bigger question.
> 
> Yes, also having to handle the ones whose generation numbers haven't
> been computed yet adds to the complexity.
> 
> This one, and $gmane/264101, are a few instances of this known issue
> raised here recently.  I have been wondering if we can do something
> along the following (these are not alternatives) as a cheaper
> workaround:
> 
>  (1) Introduce '--skewed-timestamps[=(allow|warn|reject)' to all
>      commands that create new commit objects.  If the committer
>      timestamp being used is older than any of the parent commits,
>      "warn" or "reject" depending on the setting.
> 
>      Make 'reject' the default for commands that are purely local
>      (i.e. recording your own progress by cherry-picking,
>      committing, rebasing, reverting, etc.) and 'warn' the default
>      for commands that merge other peoples' history that you may
>      lack the power to rewind and correct (e.g. 'pull' and 'merge'
>      from remote tracking refs).

Please note that a common cause (for me, at least) of skewed timestamps
is importing from a foreign VCS.

Mike
