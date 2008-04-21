From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: mark parsing in fast-import
Date: Mon, 21 Apr 2008 19:59:40 -0400
Message-ID: <20080421235940.GQ29771@spearce.org>
References: <1208132469-26471-3-git-send-email-joerg@alea.gnuu.de> <1208169584-15931-1-git-send-email-joerg@alea.gnuu.de> <20080414232958.GE20979@spearce.org> <20080420234438.GC12865@alea.gnuu.de> <20080421002626.GJ29771@spearce.org> <20080421084151.GA31344@alea.gnuu.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, gitster@pobox.com
To: =?utf-8?B?SsO2cmc=?= Sommer <joerg@alea.gnuu.de>
X-From: git-owner@vger.kernel.org Tue Apr 22 02:00:35 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jo5w2-0007xx-DP
	for gcvg-git-2@gmane.org; Tue, 22 Apr 2008 02:00:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754796AbYDUX7q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Apr 2008 19:59:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754769AbYDUX7p
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Apr 2008 19:59:45 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:59401 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754745AbYDUX7o (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Apr 2008 19:59:44 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1Jo5v1-0004tT-7u; Mon, 21 Apr 2008 19:59:31 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 4016D20FBAE; Mon, 21 Apr 2008 19:59:40 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <20080421084151.GA31344@alea.gnuu.de>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80044>

Jrg Sommer <joerg@alea.gnuu.de> wrote:
> Shawn O. Pearce schrieb am Sun 20. Apr, 20:26 (-0400):
> > Jrg Sommer <joerg@alea.gnuu.de> wrote:
> > > +static inline int parse_mark(const const char *str, uintmax_t* mark,
> 
> Is inline okay?

Yea, inline is fine.  We use "static inline" often in Git when it
is a good idea.
 
> > >  static void cmd_mark(void)
> > >  {
> > > -	if (!prefixcmp(command_buf.buf, "mark :")) {
> > > -		next_mark = strtoumax(command_buf.buf + 6, NULL, 10);
> > > +	uintmax_t mark = 0;
> > > +	char *after_mark = NULL;
> > > +
> > > +	if (!prefixcmp(command_buf.buf, "mark ") &&
> > > +		parse_mark(&command_buf.buf[5], &mark, &after_mark) &&
> > 
> > Hmm.  Shouldn't this be ! parse_mark given that it returns 0
> > on success and 1 on failure?
> 
> Yes, you're right. I've checked some other functions and found this
> behaviour. Can I use a different behabiour, i.e. return 0 on failure and
> !0 on success?

I wasn't objected to the return values as written, but more to the
fact that it seemed like a logic error to me.  We use both patterns
in Git.  Perhaps the best example to follow is get_sha1_hex();
it returns -1 on error and 0 on success.  So a common pattern is
"!get_sha1_hex()" to ensure a successful conversion of a hex string
to an unsigned char array.

-- 
Shawn.
