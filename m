From: Johannes Sixt <J.Sixt@eudaptics.com>
Subject: Re: grafts+repack+prune = history at danger
Date: Fri, 26 Jan 2007 09:13:02 +0100
Organization: eudaptics software gmbh
Message-ID: <45B9B80E.E2534F97@eudaptics.com>
References: <45B8E61E.C9C5E6C6@eudaptics.com> <7vireu7lj0.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Fri Jan 26 09:12:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HAMBj-0000ux-Rh
	for gcvg-git@gmane.org; Fri, 26 Jan 2007 09:12:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030813AbXAZILs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 26 Jan 2007 03:11:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030815AbXAZILs
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Jan 2007 03:11:48 -0500
Received: from cm56-163-160.liwest.at ([86.56.163.160]:16949 "EHLO
	linz.eudaptics.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030814AbXAZILr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Jan 2007 03:11:47 -0500
Received: from eudaptics.com (tethys.linz.eudaptics [192.168.1.88])
	by linz.eudaptics.com (Postfix) with ESMTP
	id ACCF86D9; Fri, 26 Jan 2007 09:11:45 +0100 (CET)
X-Mailer: Mozilla 4.73 [en] (Windows NT 5.0; U)
X-Accept-Language: en
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37810>

Junio C Hamano wrote:
> 
> Johannes Sixt <J.Sixt@eudaptics.com> writes:
> 
> > Isn't there a major hole in the logic how repack works when grafts are
> > in effect?
> >
> > I did this (details follow):
> >
> > 1. specify grafts
> > 2. repack
> > 3. prune
> > 4. clone
> >
> > Result: Broken history in the clone; info/grafts was not copied.
> 
> That is expected.
> 
> If you had problem in the original repository (i.e. the one with
> grafts) that lost objects after step 3., that would be serious
> and needs to be fixed,

Oh, the original repo *does* loose the object after step 3, but you
would not notice it until you remove the grafts file.

> grafts are local matter for archaeologist's convenience to glue
> two independent histories together, and not much more.

Agreed. Then grafts must be disregarded by (almost) all plumbing, most
notably fsck-objects, prune, pack-objects, but also
{fetch,upload,send,receive}-pack. They should be obeyed only by the log
and diff families and certainly also rev-list on request.

-- Hannes
