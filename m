From: Johan Herland <johan@herland.net>
Subject: Re: [RFC/PATCHv10 01/11] fast-import: Proper notes tree manipulation
Date: Tue, 08 Dec 2009 02:55:17 +0100
Message-ID: <200912080255.17568.johan@herland.net>
References: <1260185254-1523-1-git-send-email-johan@herland.net>
 <1260185254-1523-2-git-send-email-johan@herland.net>
 <20091207164311.GE17173@spearce.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, gitster@pobox.com
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Dec 08 02:55:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NHpIV-000324-PM
	for gcvg-git-2@lo.gmane.org; Tue, 08 Dec 2009 02:55:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964969AbZLHBzQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Dec 2009 20:55:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934907AbZLHBzP
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Dec 2009 20:55:15 -0500
Received: from smtp.getmail.no ([84.208.15.66]:52645 "EHLO
	get-mta-out01.get.basefarm.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S934901AbZLHBzP (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 7 Dec 2009 20:55:15 -0500
Received: from smtp.getmail.no ([10.5.16.4]) by get-mta-out01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KUB00F0A9C8IN80@get-mta-out01.get.basefarm.net> for
 git@vger.kernel.org; Tue, 08 Dec 2009 02:55:20 +0100 (MET)
Received: from alpha.localnet ([84.215.102.95])
 by get-mta-in01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KUB002DM9C66H40@get-mta-in01.get.basefarm.net> for
 git@vger.kernel.org; Tue, 08 Dec 2009 02:55:20 +0100 (MET)
X-PMX-Version: 5.5.3.366731, Antispam-Engine: 2.7.0.366912,
 Antispam-Data: 2009.12.8.14531
User-Agent: KMail/1.12.4 (Linux/2.6.31-ARCH; KDE/4.3.4; x86_64; ; )
In-reply-to: <20091207164311.GE17173@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134799>

On Monday 07 December 2009, Shawn O. Pearce wrote:
> Johan Herland <johan@herland.net> wrote:
> > +static unsigned char convert_num_notes_to_fanout(uintmax_t num_notes)
> > +{
> > +	unsigned char fanout = 0;
> > +	while ((num_notes >>= 8))
> > +		fanout++;
> > +	return fanout;
> > +}
> > +
> > +static void construct_path_with_fanout(const char *hex_sha1,
> > +		unsigned char fanout, char *path)
> > +{
> > +	unsigned int i = 0, j = 0;
> > +	if (fanout >= 20)
> > +		die("Too large fanout (%u)", fanout);
> 
> Shouldn't convert_num_notes_to_fanout have a guard to prevent this
> case from happening?

Well, it sort of already does (unless uintmax_t is more than 19 * 8 = 152 
bits wide... ;)

Not sure what you're getting at:

- Should I add a "&& fanout < 19" condition to the while loop in 
convert_num_notes_to_fanout()? 

- Should I remove the "if (fanout >= 20) die(...)"? Of course, 
construct_path_with_fanout() is only supposed to be called with values 
returned from convert_num_notes_to_fanout(), so the condition only tests a 
precondition that we believe to be true (FTR, it was converted from an 
equivalent assert() in an earlier iteration), but I normally test for these 
things anyway (when they are not blindingly obvious), just to make sure... 
(and I believe a die(...) is kinder to the user than a segfault...)


...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
