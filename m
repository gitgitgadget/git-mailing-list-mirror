From: Frank Terbeck <ft@bewatermyfriend.org>
Subject: Re: [PATCH v2 2/4] Add format.coverauto boolean
Date: Mon, 4 May 2009 23:41:49 +0200
Message-ID: <20090504214149.GA26208@fsst.voodoo.lan>
References: <7v8wlxx18c.fsf@gitster.siamese.dyndns.org> <1241431142-8444-3-git-send-email-ft@bewatermyfriend.org> <780e0a6b0905041139x3a764768ocbbd8d9353ea568f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>
To: Stephen Boyd <bebarino@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 04 23:42:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M15va-00038D-Iy
	for gcvg-git-2@gmane.org; Mon, 04 May 2009 23:42:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753946AbZEDVl5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 May 2009 17:41:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753628AbZEDVl4
	(ORCPT <rfc822;git-outgoing>); Mon, 4 May 2009 17:41:56 -0400
Received: from smtprelay11.ispgateway.de ([80.67.29.28]:47609 "EHLO
	smtprelay11.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753582AbZEDVl4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 May 2009 17:41:56 -0400
Received: from [212.117.84.253] (helo=fsst.voodoo.lan)
	by smtprelay11.ispgateway.de with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.68)
	(envelope-from <ft@bewatermyfriend.org>)
	id 1M15v5-0006gQ-Cs; Mon, 04 May 2009 23:41:51 +0200
Received: from hawk by fsst.voodoo.lan with local (Exim 4.69)
	(envelope-from <ft@bewatermyfriend.org>)
	id 1M15v3-0007co-T7; Mon, 04 May 2009 23:41:49 +0200
Content-Disposition: inline
In-Reply-To: <780e0a6b0905041139x3a764768ocbbd8d9353ea568f@mail.gmail.com>
User-Agent: Mutt/1.5.19 (2009-01-05)
X-Df-Sender: 430444
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118265>

Stephen Boyd <bebarino@gmail.com>:
> On Mon, May 4, 2009 at 2:59 AM, Frank Terbeck <ft@bewatermyfriend.org> wrote:
> > An exception is if it is called using the --stdout option,
> > which disables format.coverauto, because users of --stdout
> > (like git-rebase.sh) usually are not interested in
> > cover letters at all.
> >
> 
> Would it make more sense to just have git-rebase.sh use
> --cover-letter=never? I thought configuration variables were defaults
> which have to be overridden.

Could be done. And in an earlier version I did that. Since that took
changes in more places, I reverted to this less intrusive approach.

Also, this will keep the scripts of people who use --stdout working,
no matter what the settings of an individual user might be.

I don't think people who use --stdout will want the cover letter
(which is always the same) in the output. Since you can still force
its output, I think this would be reasonable compromise.

> Also, why does this variable even exist? I think Jeff's suggestion is
> best, where you can set format.coverletter to always, never, or some
> number.

Well, I did this because I wanted both Junio's and Jeff's suggestions
to be incorporated.

Junio correctly stated, that nobody will usually want cover letters
for one-patch "series". Which I think is right; and the wrapper I used
for this before did take that into account as well. So coverletter had
to default to 2.

If that where to enable the generation of cover letters for all
format-patch calls with every patch series that is at least two
patches long, it would change format-patch's default behaviour;
potentially breaking people's scripts (similarly to the way
coverauto=true could break git-rebase.sh without either adding
--cover-letter=never or the exception in the --stdout codepath).

That's why I think this should be handled in two separate options.
And as I mentioned, coverauto could be left out if we'd advise users
who want that to create an git alias that does 'format-patch
--cover-letter'.

> > +	if (!strcmp(var, "format.coverauto")) {
> > +		cover_letter = git_config_bool(var, value);;
> > +		return 0;
> > +	}
> 
> Double semi-colon?

Oops, yeah. I'll resend this one (if coverauto turns out to be the way
to go).

Regards, Frank

-- 
In protocol design, perfection has been reached not when there is
nothing left to add, but when there is nothing left to take away.
                                                  -- RFC 1925
