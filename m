From: Geert Bosch <bosch@adacore.com>
Subject: Re: git gc & deleted branches
Date: Fri, 9 May 2008 11:00:59 -0400
Message-ID: <E1B43061-69C7-43D7-9A57-34B7C55DF345@adacore.com>
References: <20080508210125.GC32762@sigill.intra.peff.net> <alpine.LFD.1.10.0805081712270.23581@xanadu.home> <20080508211734.GA819@sigill.intra.peff.net> <48236F69.2060900@nrlssc.navy.mil> <20080508213107.GA1016@sigill.intra.peff.net> <48237344.6070405@nrlssc.navy.mil> <20080508214454.GA1939@sigill.intra.peff.net> <48237650.5060008@nrlssc.navy.mil> <20080508224827.GA2938@sigill.intra.peff.net> <loom.20080509T011318-478@post.gmane.org> <20080509041921.GA14773@sigill.intra.peff.net>
Mime-Version: 1.0 (Apple Message framework v919.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Brandon Casey <drafnel@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri May 09 17:02:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JuU6g-0003wX-6h
	for gcvg-git-2@gmane.org; Fri, 09 May 2008 17:01:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756083AbYEIPBG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 May 2008 11:01:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755982AbYEIPBG
	(ORCPT <rfc822;git-outgoing>); Fri, 9 May 2008 11:01:06 -0400
Received: from rock.gnat.com ([205.232.38.15]:36264 "EHLO rock.gnat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755679AbYEIPBC (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 May 2008 11:01:02 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by filtered-rock.gnat.com (Postfix) with ESMTP id 4D6032A9A84;
	Fri,  9 May 2008 11:01:00 -0400 (EDT)
Received: from rock.gnat.com ([127.0.0.1])
	by localhost (rock.gnat.com [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id Wp5eT5qDyxun; Fri,  9 May 2008 11:01:00 -0400 (EDT)
Received: from potomac.gnat.com (potomac.gnat.com [205.232.38.124])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rock.gnat.com (Postfix) with ESMTP id 2922E2A973B;
	Fri,  9 May 2008 11:01:00 -0400 (EDT)
In-Reply-To: <20080509041921.GA14773@sigill.intra.peff.net>
X-Mailer: Apple Mail (2.919.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81614>


On May 9, 2008, at 00:19, Jeff King wrote:

> I like it. It makes an easy rule to say "packed objects _never_ get
> pruned, they only get demoted to loose objects." And then of course
> we have sane rules for pruning loose objects.

Isn't there an issue with the "git gc" triggering because there
may be too many loose unreferenced objects?
Still, I do like the approach.

Maybe unreferenced objects and old refs should go to a .git/lost+found
directory and be expired from there. This has a couple of benefits:

   -  Easy to manually inspect or blow away any crud
   -  One git-gc run can make one pack in lost+found,
      avoiding huge numbers of loose objects (and massive disk use)
      when trying to do a large cleanup (to possibly reclaim disk space)
   -  Objects will not be accessible by ordinary git commands for a  
while,
      before they are really removed, avoiding surprises

Only some tools would look in the lost+found to restore stuff.

   -Geert
