From: Joe Perches <joe@perches.com>
Subject: Re: git blame vs git log --follow performance
Date: Sun, 26 Jan 2014 18:00:11 -0800
Message-ID: <1390788011.20150.32.camel@joe-AO722>
References: <1390770652.20150.25.camel@joe-AO722>
	 <CACsJy8B4dkjae3tL+_JvD63HCoi_-nNWYGvT3xRTqi8UpYX95g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>, Ian Campbell <Ian.Campbell@citrix.com>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 27 03:00:21 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W7bUr-0004Eq-9a
	for gcvg-git-2@plane.gmane.org; Mon, 27 Jan 2014 03:00:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753258AbaA0CAO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Jan 2014 21:00:14 -0500
Received: from smtprelay0209.hostedemail.com ([216.40.44.209]:50735 "EHLO
	smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753121AbaA0CAN (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 26 Jan 2014 21:00:13 -0500
Received: from filter.hostedemail.com (ff-bigip1 [10.5.19.254])
	by smtprelay01.hostedemail.com (Postfix) with ESMTP id 30A8823619;
	Mon, 27 Jan 2014 02:00:12 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::,RULES_HIT:41:355:379:541:599:800:960:968:973:988:989:1260:1261:1277:1311:1313:1314:1345:1359:1373:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2393:2553:2559:2562:2828:3138:3139:3140:3141:3142:3353:3622:3865:3866:3867:3868:3870:3871:3872:3873:3874:4321:5007:6119:7652:7875:7901:7903:10004:10400:10848:11232:11658:11914:12043:12294:12517:12519:12740:13069:13161:13229:13311:13357,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:none,Custom_rules:0:0:0
X-HE-Tag: stew19_19e452985d45
X-Filterd-Recvd-Size: 2150
Received: from [192.168.1.157] (pool-96-251-49-11.lsanca.fios.verizon.net [96.251.49.11])
	(Authenticated sender: joe@perches.com)
	by omf12.hostedemail.com (Postfix) with ESMTPA;
	Mon, 27 Jan 2014 02:00:10 +0000 (UTC)
In-Reply-To: <CACsJy8B4dkjae3tL+_JvD63HCoi_-nNWYGvT3xRTqi8UpYX95g@mail.gmail.com>
X-Mailer: Evolution 3.8.4-0ubuntu1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241129>

On Mon, 2014-01-27 at 08:33 +0700, Duy Nguyen wrote:
> On Mon, Jan 27, 2014 at 4:10 AM, Joe Perches <joe@perches.com> wrote:
> > For instance (using the Linus' linux kernel git):
> >
> > $ time git log --follow -- drivers/firmware/google/Kconfig > /dev/null
> >
> > real    0m42.329s
> > user    0m40.984s
> > sys     0m0.792s
> >
> > $ time git blame -- drivers/firmware/google/Kconfig > /dev/null
> >
> > real    0m0.963s
> > user    0m0.860s
> > sys     0m0.096s
> >
> 
> It's not fair to compare blame and log. If you compare, compare it to
> non follow version

Perhaps not, but git blame does follow renames.

$ git blame --help
[]
The origin of lines is automatically followed across
whole-file renames (currently there is no option to
turn the rename-following off). To follow lines moved
from one file to another, or to follow lines that were
copied and pasted from another file, etc., see the -C
and -M options.

> I tested a version with rename detection logic removed. It did not
> change the timing significantly. To improve --follow I think we need
> to do something about path filtering.

Perhaps the log history could stop being read when
a commit is found that creates the file without
another file being deleted in the same commit.
