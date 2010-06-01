From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: How to add daily tags for a central repo?
Date: Tue, 01 Jun 2010 08:43:42 +0200
Message-ID: <4C04AC1E.7040502@drmicha.warpmail.net>
References: <1275369711233-5124575.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: roylee17 <roylee17@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 01 08:44:17 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OJLCv-0001uv-6J
	for gcvg-git-2@lo.gmane.org; Tue, 01 Jun 2010 08:44:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752882Ab0FAGoH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Jun 2010 02:44:07 -0400
Received: from out5.smtp.messagingengine.com ([66.111.4.29]:44893 "EHLO
	out5.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751485Ab0FAGoF (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 1 Jun 2010 02:44:05 -0400
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id D269DF7EC0;
	Tue,  1 Jun 2010 02:44:03 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute2.internal (MEProxy); Tue, 01 Jun 2010 02:44:03 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=rPrYk/W3MWW9L0AuoQZlehDgMWA=; b=T7C+B9NzWjmSf24XH8VsJ2YeKkM2UlofVd9BRmcMZfFlL1M2cjk0ETnIOsZDs0PDut2/+zhaISlfvvyRqGAxBJKh508pLf/fMImszFRHbglZqAqKIGFFuZHxyyXf1W8v13MlPACkRguqb1deEVC6Q2+VcI6BT1mSd2HdyB3uwT8=
X-Sasl-enc: yCrXnmfJV76R8H9NqbfUx1YxHoRp+VAio+e9ncEevcau 1275374643
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 2F5594BD222;
	Tue,  1 Jun 2010 02:44:03 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.5pre) Gecko/20100526 Lightning/1.0b2pre Lanikai/3.1.1pre
In-Reply-To: <1275369711233-5124575.post@n2.nabble.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148084>

roylee17 venit, vidit, dixit 01.06.2010 07:21:
> 
> Hi,
> 
> We currently host our projects on a central server.
> For the daily build purpose, I currently using a script to do the following
> steps:
> 
>   1. clone the project from the central server
> 
>   2. find the target commit for a specified date
>       commit=`git log origin/master -n1 --format=%H --until="${timespec}
> 00:00:00"`
> 
>   3. tag the commit
>       git tag -f daily/${timespec} ${commit}
> 
>   4. push the tag up to the central server
> 
> This usually works fine and allows us to tag earlier commit with past dates
> 
> However, it depends on the "COMMIT DATE", which is a local time to the
> developer who
> committed the changes.
> And if some developer didn't have the time or date configured correctly on
> his machine,
> the changes committed by him may not be included in a tag, even it is pushed
> to the 
> on a date earlier than the target date to tag.
> 
> Alternatively, we can queue the job to do the following steps "on a target
> date":
> 
> 1. clone the project from the central server
> 2. tag the "latest commit"
> 3. push the tag to the server
> 
> But I'd like to know better ways to do the daily tag things?

Having these tags seems strange to me. Imagine someone pushing a patch
series one-by-one around midnight, or pushing a commit and, shortly
after, a fixup. You'll end up with a tag pointing to a commit in the middle.

The commit time is totally unreliable, as you noticed, also because
authors may commit locally, then push later.

That being said, if you're really interested in the state of a branch on
the central server at a certain point in time it's easiest to enable
reflogs on the central repository (by setting core.logAllRefUpdates or
enabling individually) and to tag the commit HEAD@{datetimespec} (or
branchname@...). No need for cloning.

Cheers,
Michael
