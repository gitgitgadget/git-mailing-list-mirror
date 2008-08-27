From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [JGIT PATCH 1/2] Ignore unreadable SSH private keys when
	autoloading identities
Date: Wed, 27 Aug 2008 16:29:46 -0700
Message-ID: <20080827232946.GS26523@spearce.org>
References: <1219878126-18622-1-git-send-email-spearce@spearce.org> <48B5E2A1.3030007@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Robin Rosenberg <robin.rosenberg@dewire.com>, git@vger.kernel.org
To: Marek Zawirski <marek.zawirski@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 28 01:30:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYUTU-0007n2-2W
	for gcvg-git-2@gmane.org; Thu, 28 Aug 2008 01:30:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754094AbYH0X3r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Aug 2008 19:29:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753975AbYH0X3r
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Aug 2008 19:29:47 -0400
Received: from george.spearce.org ([209.20.77.23]:55501 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753857AbYH0X3r (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Aug 2008 19:29:47 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 6C75138375; Wed, 27 Aug 2008 23:29:46 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <48B5E2A1.3030007@gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93984>

Marek Zawirski <marek.zawirski@gmail.com> wrote:
> Shawn O. Pearce wrote:
>> diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/DefaultSshSessionFactory.java b/org.spearce.jgit/src/org/spearce/jgit/transport/DefaultSshSessionFactory.java
> (...)
>> +			try {
>> +				addIdentity(k);
>> +			} catch (JSchException e) {
>> +				if (e.getMessage().startsWith("invalid privatekey: "))
>> +					continue;
>> +				throw e;
>> +			}
>
> That's extreme error handling with JSch;) Do you really think it's  
> better to rely on internal error message instead of continuing in any  
> case? Which other exceptions we would like to pass level up?

Oh, that's a good question.  In this particular code we're just
trying to prime the list of known keys so there's a chance we could
later prompt you for a passphrase during the handshaking.  So we
probably could get away with just ignoring all JSchExceptions at
this stage and treat the key as though it wasn't present...

I can't imagine what else we'd get back.  A FileNotFoundException
just means the user deleted the key before we could actually read
it (no big deal); an IOException because the key isn't readable
isn't an issue either.

I guess I can just change this to ignore everything.

-- 
Shawn.
