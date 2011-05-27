From: Markus Duft <mduft@gentoo.org>
Subject: Re: [PATCH 2/2] Include unistd.h.
Date: Fri, 27 May 2011 08:27:12 +0200
Message-ID: <4DDF4440.4040405@gentoo.org>
References: <1306332924-28587-1-git-send-email-mduft@gentoo.org> <1306332924-28587-3-git-send-email-mduft@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 27 08:27:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QPqVy-0004YT-4m
	for gcvg-git-2@lo.gmane.org; Fri, 27 May 2011 08:27:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752829Ab1E0G1M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 May 2011 02:27:12 -0400
Received: from smtp.salomon.at ([193.186.16.13]:54236 "EHLO sauxb.salomon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751525Ab1E0G1L (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 May 2011 02:27:11 -0400
Received: from servex01.wamas.com (servex01.salomon.at [172.28.2.2])
	by sauxb.salomon.at (8.12.10/8.12.10) with ESMTP id p4R6R2JR004662;
	Fri, 27 May 2011 08:27:02 +0200 (METDST)
Received: from [172.28.8.166] ([172.28.8.166]) by servex01.wamas.com with Microsoft SMTPSVC(6.0.3790.4675);
	 Fri, 27 May 2011 08:27:02 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.17) Gecko/20110506 Lightning/1.0b3pre Thunderbird/3.1.10
In-Reply-To: <1306332924-28587-3-git-send-email-mduft@gentoo.org>
X-OriginalArrivalTime: 27 May 2011 06:27:02.0060 (UTC) FILETIME=[16F166C0:01CC1C37]
X-Scanned-By: MIMEDefang 2.54 on 172.28.2.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174600>

(still not getting mail from the list, so copied from the archive...).

> Markus Duft <mduft <at> gentoo.org> writes:
> 
[snip]
>>
>> Yes. suacomp installs itself as libc.{a,so}. Of course the path to the
>> suacomp prefix needs to be told to the compiler. Without it, interix (at
>> least the newer versions) are near unusable,...
> 
> You are much more familiar with Interix than I am, and if you were the
> only person who uses Interix with git, I would buy that argument
> unconditionally.
> 
> How has one built and used git before suacomp days? Are these users
> extinct? Are there users who do not still use suacomp and for whatever
> reason do not want to use it, but still want to use git?

I did start the git porting when i ported Gentoo Prefix [1] to interix. I only ever tried to build it in there, and i actually don't think that there is any other build-case for interix (ATM). Maybe someday someone has the great idea of building/using git without Gentoo Prefix (good luck .. :)), but currently this is (AFAICT) not the case. In Gentoo Prefix in turn, suacomp is always there, on interix, and all versions are supported right now (interix 3.5 was not, but i did the work). Also, the compiler and linker are set up accordingly there.

so, in order:
 1) yes, i did in gentoo prefix, which now uses suacomp
 2) yes, with the appearence of suacomp in gentoo prefix
 3) if a user of gentoo prefix does not yet have suacomp,
    he/she will get upgraded automatically. i do not know
    of other users, and believe they don't exist.

> 
> What I am getting at is that I have to come up with a description in the
> release notes, and I cannot decide what the entry for this change should
> say, and if I can stand behind that statement.
> 
> Here is one version, based on my reading of what you said so far:
> 
>  * The build procedure for Interix now requires use of suacomp. Older
>    versions of Interix that are incompatible with suacomp are no longer
>    supported. The Makefile does not automatically tell "the path to the
>    suacomp prefix" to the compiler, so you would need to do that yourself.

The part with incompatible is no longer true. i tried building git on all interix versions, and it works fine. I feel, that if a user really installs plain interix, wan't git and isntalls suacomp himself, he/she will be power-user enough to manage and tell the build about some include/lib paths.

> 
> Doesn't sound pretty, and I hesitate to stand behind such a statement.
> Abandoning obsoleted versions of obscure platform nobody cares about is
> fine, but at least we should make it clear who are being abandoned by
> saying which version. Also "needs to be told to the compiler" part needs
> some end-user explanation in Makefile ("set HAVE_SUACOMP=/usr/lib/suacomp
> when building on/for Interix", or something).

Hm. suacomp is designed to be completely transparent to (nearly) everything involved in building a package. It should be part of the suacomp setup process to get it into the compiler/linker (by, for example, creating shell script wrappers around compiler/linker, much like colorgcc et. al.). If at all, i'd only set a HAVE_SUACOMP=YesPlease, and based on that, default some symbols to different values (exactly those that the 1/2 patch modifies).

> 
> Here is another possible version (you would need to update your patch to
> support both):
> 
>  * On Interix, it is preferrable to use suacomp to build git, but the old
>    way is still supported. Give HAVE_SUACOMP=/path/to/suacomp to Make (or
>    override it in your config.mak) when building git.

The "old way" was only supported on interix 6.0, as i found out. both interix 5.2 and 3.5 needed at least some additional workarounds, which are now gone with suacomp. I don't think that it would be worth the work (although i'd happily do it, if you want), to support an "old way" which has not a single advantage, and doesn't event work everywhere.

> 
> That is more easily justifiable, but I cannot tell from this exchange with
> you how important to keep supporting the old way is (or if it is even
> possible).

It is possible, but as i said, i don't think it is worth it.

However we proceed: thanks for contemplating about such an exotic platform. i really appreciate it!
Markus

> 
