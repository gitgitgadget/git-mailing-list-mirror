From: Mike Hommey <mh@glandium.org>
Subject: Re: git pull & git gc
Date: Thu, 19 Mar 2015 11:01:17 +0900
Message-ID: <20150319020117.GA31689@glandium.org>
References: <5509836D.2020304@aegee.org>
 <CACsJy8ChKgwr5OBRDG1p5nxwPC0vei7J=Lr3NefLYoReTMuhPA@mail.gmail.com>
 <55098A49.1020003@aegee.org>
 <CACsJy8AtoeSv7uZc3P2xXN0A15gpj-OUTRyNhMe__=HqtTkD2Q@mail.gmail.com>
 <CACsJy8DCdF1YmfFF1aCuhMJ0v4+FW7EkDiwBnBF2OFhE=kcbFg@mail.gmail.com>
 <20150318145815.GN1369@serenity.lan>
 <20150318210458.GA3376@peff.net>
 <CACsJy8AJfx8id+oHmhsLODBJeNLgRqD+5B295TtS+c-hrC5raQ@mail.gmail.com>
 <20150319012722.GA26867@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Duy Nguyen <pclouds@gmail.com>, John Keeping <john@keeping.me.uk>,
	=?iso-2022-jp?B?GyRCJyUnWiddJ3EnXxsoQiAbJEInMSdRJ10nUSdlJ1knYCdTGyhC?= 
	<dilyan.palauzov@aegee.org>, Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Mar 19 03:02:15 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YYPmb-0004ZG-SX
	for gcvg-git-2@plane.gmane.org; Thu, 19 Mar 2015 03:02:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751544AbbCSCB4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Mar 2015 22:01:56 -0400
Received: from ks3293202.kimsufi.com ([5.135.186.141]:58244 "EHLO glandium.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751150AbbCSCBz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Mar 2015 22:01:55 -0400
Received: from glandium by zenigata with local (Exim 4.84)
	(envelope-from <glandium@glandium.org>)
	id 1YYPlt-0008K0-1k; Thu, 19 Mar 2015 11:01:17 +0900
Content-Disposition: inline
In-Reply-To: <20150319012722.GA26867@peff.net>
X-GPG-Fingerprint: 182E 161D 1130 B9FC CD7D  B167 E42A A04F A6AA 8C72
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265776>

On Wed, Mar 18, 2015 at 09:27:22PM -0400, Jeff King wrote:
> On Thu, Mar 19, 2015 at 07:31:48AM +0700, Duy Nguyen wrote:
> 
> > Or we could count/estimate the number of loose objects again after
> > repack/prune. Then we can maybe have a way to prevent the next gc that
> > we know will not improve the situation anyway. One option is pack
> > unreachable objects in the second pack. This would stop the next gc,
> > but that would screw prune up because st_mtime info is gone.. Maybe we
> > just save a file to tell gc to ignore the number of loose objects
> > until after a specific date.
> 
> I don't think packing the unreachables is a good plan. They just end up
> accumulating then, and they never expire, because we keep refreshing
> their mtime at each pack (unless you pack them once and then leave them
> to expire, but then you end up with a large number of packs).

Note, sometimes I wish unreachables were packed. Recently, I ended up in
a situation where running gc created something like 3GB of data as per
du, because I suddenly had something like 600K unreachable objects, each
of them, as a loose object, taking at least 4K on disk. This made my
.git take 5GB instead of 2GB. That surely didn't feel like garbage
collection.

Mike
