From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 2/3] Add a lot of dummy returns to avoid warnings with
 NO_NORETURN
Date: Mon, 20 Jun 2011 17:46:19 -0500
Message-ID: <20110620224619.GB695@elie>
References: <1308445625-30667-1-git-send-email-andi@firstfloor.org>
 <1308445625-30667-2-git-send-email-andi@firstfloor.org>
 <7vsjr4b3tf.fsf@alter.siamese.dyndns.org>
 <20110620213001.GB32765@one.firstfloor.org>
 <7vfwn4b1vb.fsf@alter.siamese.dyndns.org>
 <20110620220347.GE32765@one.firstfloor.org>
 <20110620223156.GA695@elie>
 <20110620223705.GG32765@one.firstfloor.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Andi Kleen <ak@linux.intel.com>
To: Andi Kleen <andi@firstfloor.org>
X-From: git-owner@vger.kernel.org Tue Jun 21 00:46:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QYnEj-00041T-QJ
	for gcvg-git-2@lo.gmane.org; Tue, 21 Jun 2011 00:46:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756079Ab1FTWqZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Jun 2011 18:46:25 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:47020 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755099Ab1FTWqY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Jun 2011 18:46:24 -0400
Received: by iwn6 with SMTP id 6so1584381iwn.19
        for <git@vger.kernel.org>; Mon, 20 Jun 2011 15:46:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=RAT7kMWXMH5d//uw3Ia8L/C7Tl/JxchaNfim/gp0ZEw=;
        b=aOSg/oc8+5qYkuBX8rQ5RPUByK7pF5Kv0SZ7oMk57HSdhxv51yz4jfJWY1zT9WoH9+
         YSzYkbMi7t0cyEjAOzKWpSVnPu44hp+EnDuKfJMqcErr1kAgIBx6P4zagYzaStXzX/WD
         yKN/VQO9cI79sbvh8nIkVYqukWhX7ZL7nT2yM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=vrbuTiV6p1uVktxfjGbHWRVAMidPanN5qUOwnCkhk5nc5cCbkWkP1W1WMcJ2xWtaCf
         4IY59j94dTLrpG6JbutkD9T55Zn3v746UCQCzA1ouoBU+FfIC+BZDvgksoW0lUaBoRZA
         h+hZbp4CGLYgDknjgg48GndXM5+6mmX+9ENyc=
Received: by 10.231.193.202 with SMTP id dv10mr5721721ibb.136.1308609983864;
        Mon, 20 Jun 2011 15:46:23 -0700 (PDT)
Received: from elie (adsl-69-209-79-158.dsl.chcgil.ameritech.net [69.209.79.158])
        by mx.google.com with ESMTPS id 10sm3447468ibn.20.2011.06.20.15.46.21
        (version=SSLv3 cipher=OTHER);
        Mon, 20 Jun 2011 15:46:22 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20110620223705.GG32765@one.firstfloor.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176106>

Andi Kleen wrote:

> To be honest it's still not clear to me what was wrong with patch (2).

Ah, ok.  From my point of view the patch was problematic since it adds
code that would be distracting to both humans and static analyzers.
For example, a person might wonder "why this return value and not
another?".  Even worse, if someone removes a die() call and introduces
a bug, we lose the benefit of the warnings you are suppressing.

>> In this case, since the NO_NORETURN knob is to work around a gcc bug,
>> wouldn't it make sense to add a -Wno-something-or-other option to
>> BASIC_CFLAGS or COMPAT_CFLAGS when it is set?
>
> The problem is that only relatively new gccs have options to do
> fine grained control on all warnings. So this would add more complications
> in the Makefile to check the compiler version

The default CFLAGS is very simple because git is supposed to be
possible to build with other compilers, too, and I wasn't suggesting
changing that.  But I suspect making NO_NORETURN assume a modern
enough gcc to trigger the bug might be ok.

Anyway, thanks for writing these patches.  I'm happy to see git get
faster.  As a side question, do you know if gcc provides a way to
print output about what profile-driven optimizations were especially
compelling, so they could help people think about how to reorganize
code to improve the non profile-driven builds, too?

Regards,
Jonathan
