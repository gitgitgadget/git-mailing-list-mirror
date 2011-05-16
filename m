From: Johan Herland <johan@herland.net>
Subject: Re: [PATCHv3 6/9] receive-pack: Prepare for addition of the new
 'limit-*' family of capabilities
Date: Mon, 16 May 2011 11:53:17 +0200
Message-ID: <201105161153.18025.johan@herland.net>
References: <201105151942.29219.johan@herland.net>
 <1305495440-30836-7-git-send-email-johan@herland.net>
 <7vaaenm957.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, Shawn Pearce <spearce@spearce.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 16 11:53:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QLuUP-0003ms-Jv
	for gcvg-git-2@lo.gmane.org; Mon, 16 May 2011 11:53:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753942Ab1EPJxU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 May 2011 05:53:20 -0400
Received: from smtp.getmail.no ([84.208.15.66]:56407 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753809Ab1EPJxT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 May 2011 05:53:19 -0400
Received: from get-mta-scan02.get.basefarm.net ([10.5.16.4])
 by get-mta-out01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0LLA002728SV5BA0@get-mta-out01.get.basefarm.net> for
 git@vger.kernel.org; Mon, 16 May 2011 11:53:19 +0200 (MEST)
Received: from get-mta-scan02.get.basefarm.net
 (localhost.localdomain [127.0.0.1])	by localhost (Email Security Appliance)
 with SMTP id 06BA81EA56D8_DD0F40FB	for <git@vger.kernel.org>; Mon,
 16 May 2011 09:53:19 +0000 (GMT)
Received: from smtp.getmail.no (unknown [10.5.16.4])
	by get-mta-scan02.get.basefarm.net (Sophos Email Appliance)
 with ESMTP id B8B481EA2A57_DD0F40EF	for <git@vger.kernel.org>; Mon,
 16 May 2011 09:53:18 +0000 (GMT)
Received: from alpha.localnet ([84.215.68.234])
 by get-mta-in02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0LLA00FGA8SUGY10@get-mta-in02.get.basefarm.net> for
 git@vger.kernel.org; Mon, 16 May 2011 11:53:18 +0200 (MEST)
User-Agent: KMail/1.13.7 (Linux/2.6.38-ARCH; KDE/4.6.3; x86_64; ; )
In-reply-to: <7vaaenm957.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173719>

On Monday 16 May 2011, Junio C Hamano wrote:
> Johan Herland <johan@herland.net> writes:
> > +const char *server_supports(const char *feature)
> > 
> >  {
> > 
> > -	return server_capabilities &&
> > -		strstr(server_capabilities, feature) != NULL;
> > +	if (server_capabilities)
> > +		return strstr(server_capabilities, feature);
> > +	return NULL;
> > 
> >  }
> 
> I've been meaning to fix this part, but currently the feature set is
> given as space separated list " featurea featureb featurec" and we check
> with a token without any space around, e.g. "if
> (server_supports("no-done"))", which is quite broken.
> 
> We should tighten this strstr() to make sure we are not matching in the
> middle of a string, and the need to do so is even greater now that you
> are going to introduce "foo=<value>" and the value could even be strings
> in the future.
> 
> How about implementing rules like these:
> 
> [...]

Agreed. I'll take a stab at this in the re-roll.


...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
