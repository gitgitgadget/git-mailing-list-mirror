From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH v2 2/3] strbuf: Add method to convert byte-size to
	human  readable form
Date: Fri, 15 Aug 2008 01:24:59 +0200
Message-ID: <20080814232459.GF10360@machine.or.cz>
References: <1218752308-3173-1-git-send-email-marcus@griep.us> <1218752308-3173-2-git-send-email-marcus@griep.us> <1218752308-3173-3-git-send-email-marcus@griep.us> <20080814223429.GC10544@machine.or.cz> <7viqu3ci5k.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Marcus Griep <marcus@griep.us>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 15 01:26:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KTmCl-00032r-Vw
	for gcvg-git-2@gmane.org; Fri, 15 Aug 2008 01:26:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751799AbYHNXZE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Aug 2008 19:25:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751872AbYHNXZE
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Aug 2008 19:25:04 -0400
Received: from w241.dkm.cz ([62.24.88.241]:48906 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751706AbYHNXZC (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Aug 2008 19:25:02 -0400
Received: by machine.or.cz (Postfix, from userid 2001)
	id B8270393A2C9; Fri, 15 Aug 2008 01:24:59 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7viqu3ci5k.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92439>

On Thu, Aug 14, 2008 at 04:04:55PM -0700, Junio C Hamano wrote:
> Petr Baudis <pasky@suse.cz> writes:
> 
> > My point still stands - in case of binary units, we should always
> > consistently use the i suffix. So having an example in the commit
> > message that advertises "bps" is simply wrong when it should read "iB/s"
> > (like it does with the current progress.c code).
> >
> > I may sound boring, but it seems to me that you're still ignoring my
> > point quitly without proper counter-argumentation and I think it's an
> > important want, and since it's so hard to keep things consistent across
> > the wide Git codebase, we should do all we can to keep it.
> 
> I pretty much agree with everything you said in this thread.  In addition,
> I wonder if we would want to be able to say:
> 
> 	960 bps
>         0.9 KiB/s
> 	2.3 MiB/s

I dont hink it would be a big deal to say bytes/s or B/s (which is as
long as bps).

> IOW, I do not think it is a good idea to have the list of "prefixes" in
> this function and force callers to _append_ unit.  You might be better off
> by making the interface to the function to pass something like this:
> 
> 	struct human_unit {
> 		char *unitname;
>                 unsigned long valuescale;
> 	} bps_to_human[] = {
>         	{ "bps", 1 },
>                 { "KiB/s", 1024 },
>                 { "MiB/s", 1024 * 1024 },
>                 { NULL, 0 },
> 	};
> 
> and perhaps give canned set of unit list for sizes and throughputs as
> convenience.
> 
> By doing so, you could even do this:
> 
> 	struct human_unit bits_to_human[] = {
>         	{ "bits", 1 },
>                 { "bytes", 8 },
>                 { "Kbytes", 8 * 1024 },
>                 { "Mbytes", 8 * 1024 * 1024 },
>                 { NULL, 0 },
> 	};

Frankly, my gut feeling here is that we are overengineering the whole
thing quite a bit, which is the same reason I dislike maxlen.

If it turns out we really do need to have custom prefixes somewhere, we
would have to go with something like this, but on the other hand this
goes against the consistency of output, and I have a bit of trouble
imagining a convincing use-case. So far we have two fairly different
users of such a code and just tailoring it to these two seems to make it
general enough for now.

-- 
				Petr "Pasky" Baudis
The next generation of interesting software will be done
on the Macintosh, not the IBM PC.  -- Bill Gates
