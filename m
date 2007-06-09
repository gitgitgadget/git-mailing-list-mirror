From: Johan Herland <johan@herland.net>
Subject: Re: [PATCH 16/21] Introduce optional "keywords" on tag objects
Date: Sun, 10 Jun 2007 00:00:45 +0200
Message-ID: <200706100000.45476.johan@herland.net>
References: <Pine.LNX.4.64.0706072348110.4046@racer.site>
 <200706090219.37289.johan@herland.net>
 <81b0412b0706091452q2957540dy95fbf13ebd89ca1f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 10 00:00:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hx8zN-0003dz-Sv
	for gcvg-git@gmane.org; Sun, 10 Jun 2007 00:00:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761594AbXFIWAw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 9 Jun 2007 18:00:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761532AbXFIWAv
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Jun 2007 18:00:51 -0400
Received: from smtp.getmail.no ([84.208.20.33]:39539 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761297AbXFIWAt (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Jun 2007 18:00:49 -0400
Received: from pmxchannel-daemon.no-osl-m323-srv-004-z2.isp.get.no by
 no-osl-m323-srv-004-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 id <0JJE007032HCGY00@no-osl-m323-srv-004-z2.isp.get.no> for
 git@vger.kernel.org; Sun, 10 Jun 2007 00:00:48 +0200 (CEST)
Received: from smtp.getmail.no ([10.5.16.1])
 by no-osl-m323-srv-004-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JJE00B592HAAL70@no-osl-m323-srv-004-z2.isp.get.no> for
 git@vger.kernel.org; Sun, 10 Jun 2007 00:00:46 +0200 (CEST)
Received: from alpha.herland ([84.210.6.167])
 by no-osl-m323-srv-004-z1.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JJE000BI2H9UQ80@no-osl-m323-srv-004-z1.isp.get.no> for
 git@vger.kernel.org; Sun, 10 Jun 2007 00:00:46 +0200 (CEST)
In-reply-to: <81b0412b0706091452q2957540dy95fbf13ebd89ca1f@mail.gmail.com>
Content-disposition: inline
User-Agent: KMail/1.9.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49632>

On Saturday 09 June 2007, Alex Riesen wrote:
> On 6/9/07, Johan Herland <johan@herland.net> wrote:
> > This patch introduces a new optional header line to the tag object, called
> > "keywords". The "keywords" line may contain a comma-separated list of
> > custom keywords associated with the tag object.
> 
> What is the character set for the keywords?

Hmm. Same as for the "tag" line, and the rest of the tag object, I guess.
I agree this should probably be specified. What are the rules for other
git objects?

> > +                       for (i = 0; i < keywords_len; ++i) {
> > +                               unsigned char c = keywords_line[i];
> > +                               if (c == ',' && keywords_line[i + 1] == ',')
> > +                                       /* consecutive commas */
> > +                                       return error("Tag object (@ char "
> > +                                               PD_FMT "): Found empty keyword",
> > +                                               keywords_line + i - data);
> > +                               if (c > ' ' && c != 0x7f)
> > +                                       continue;
> 
> And what is so special about 0x7f?

Isn't DEL a control char?

> > +               if (keywords_len) { /* optional keywords string was given */
> > +                       item->keywords = xmalloc(keywords_len + 1);
> 
> Who frees the keywords and what's wrong with strndup?

The code that should free the tag name should also free the keywords.
No code appear to do this at the moment (regardless of whether you use my patch
series or not), which is a shame. We should make sure all objects are properly
deallocated. This is currently a general problem in git, isn't it?


...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
