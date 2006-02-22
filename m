From: "Stephen C. Tweedie" <sct@redhat.com>
Subject: Re: [PATCH] send-pack: do not give up when remote has insanely
	large number of refs.
Date: Wed, 22 Feb 2006 13:30:33 -0500
Message-ID: <1140633034.3385.5.camel@orbit.scot.redhat.com>
References: <1140547568.5509.21.camel@orbit.scot.redhat.com>
	 <7vwtfotaq3.fsf@assigned-by-dhcp.cox.net>
	 <7virr8t82n.fsf@assigned-by-dhcp.cox.net>
	 <7v1wxvsovj.fsf_-_@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 22 19:30:50 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FByl8-0002nh-9c
	for gcvg-git@gmane.org; Wed, 22 Feb 2006 19:30:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751139AbWBVSaj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 22 Feb 2006 13:30:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751385AbWBVSaj
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Feb 2006 13:30:39 -0500
Received: from mx1.redhat.com ([66.187.233.31]:9389 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751139AbWBVSaj (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 22 Feb 2006 13:30:39 -0500
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.12.11/8.12.11) with ESMTP id k1MIUau3013223;
	Wed, 22 Feb 2006 13:30:36 -0500
Received: from devserv.devel.redhat.com (devserv.devel.redhat.com [172.16.58.1])
	by int-mx1.corp.redhat.com (8.11.6/8.11.6) with ESMTP id k1MIUZ131781;
	Wed, 22 Feb 2006 13:30:35 -0500
Received: from vpn83-175.boston.redhat.com (vpn83-175.boston.redhat.com [172.16.83.175])
	by devserv.devel.redhat.com (8.12.11/8.12.11) with ESMTP id k1MIUZVI024032;
	Wed, 22 Feb 2006 13:30:35 -0500
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v1wxvsovj.fsf_-_@assigned-by-dhcp.cox.net>
X-Mailer: Evolution 2.5.90 (2.5.90-2.1) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16605>

Hi,

On Wed, 2006-02-22 at 01:51 -0800, Junio C Hamano wrote:

> +	for (ref = refs, j = i + 16;
> +	     i < 900 && i < j && ref;

Looks like it's now sending just 16 additional negative refs instead of
940 for this repo.  Definitely an improvement --- push (both full and
with an explicit refspec) is now working properly, thanks!  

Adding more ^refs up to the limit of 900 should be possible, too, and
should catch more already-present objects --- while the refs count for
this repo was under 900, push still worked fine for me, so we don't
necessarily have to cut it hard to as low a number as 16.

Perhaps ultimately we may want to simply send the refs list to
git-rev-list via a pipe or similar if we want this to scale?  We'll need
this for edge cases such as sending >900 new tags to an old repository
at once, as we'll exhaust the size of the positive refs list in that
case.

Thanks again,
 Stephen
