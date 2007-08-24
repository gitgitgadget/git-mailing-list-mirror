From: "Josh England" <jjengla@sandia.gov>
Subject: Re: tracking perms/ownership
Date: Fri, 24 Aug 2007 12:15:17 -0600
Message-ID: <1187979317.6357.155.camel@beauty>
References: <1187716461.5986.71.camel@beauty>
 <20070821134030.b763e9d3.seanlkml@sympatico.ca>
 <1187817948.5986.159.camel@beauty>
 <alpine.LFD.0.999.0708221618510.30176@woody.linux-foundation.org>
 <1187905879.5986.199.camel@beauty>
 <7vtzqpsy3q.fsf@gitster.siamese.dyndns.org>
 <alpine.LFD.0.999.0708231626580.30176@woody.linux-foundation.org>
 <85ir75h2zb.fsf@lola.goethe.zz>
 <alpine.LFD.0.999.0708232327100.25853@woody.linux-foundation.org>
 <86mywhfk17.fsf@lola.quinscape.zz>
 <alpine.LFD.0.999.0708241039250.25853@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: "David Kastrup" <dak@gnu.org>, git@vger.kernel.org
To: "Linus Torvalds" <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri Aug 24 20:14:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IOdgE-0008Vu-1D
	for gcvg-git@gmane.org; Fri, 24 Aug 2007 20:14:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761883AbXHXSOl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 24 Aug 2007 14:14:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760886AbXHXSOl
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Aug 2007 14:14:41 -0400
Received: from mm04snlnto.sandia.gov ([132.175.109.21]:2228 "EHLO
	sentry.sandia.gov" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756884AbXHXSOk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Aug 2007 14:14:40 -0400
Received: from [132.175.109.1] by sentry.sandia.gov with ESMTP (SMTP
 Relay 01 (Email Firewall v6.3.1)); Fri, 24 Aug 2007 12:14:19 -0600
X-Server-Uuid: 6CEB1540-FE13-491B-9872-FD67060ED864
Received: from [134.253.112.134] (sacv8030ee.sandia.gov
 [134.253.112.134]) by mailgate.sandia.gov (8.14.0/8.14.0) with ESMTP id
 l7OIEH57004043; Fri, 24 Aug 2007 12:14:18 -0600
In-Reply-To: <alpine.LFD.0.999.0708241039250.25853@woody.linux-foundation.org>
X-Mailer: Evolution 2.10.1
X-PMX-Version: 5.3.3.310218, Antispam-Engine: 2.5.2.311128,
 Antispam-Data: 2007.8.24.104723
X-PerlMx-Spam: Gauge=IIIIIII, Probability=7%, Report='__CP_MEDIA_BODY 0,
 __CT 0, __CTE 0, __CT_TEXT_PLAIN 0, __HAS_MSGID 0, __HAS_X_MAILER 0,
 __MIME_TEXT_ONLY 0, __MIME_VERSION 0, __SANE_MSGID 0'
X-TMWD-Spam-Summary: TS=20070824181422; SEV=2.2.2; DFV=B2007082415;
 IFV=2.0.4,4.0-9; AIF=B2007082415; RPD=5.02.0125; ENG=IBF;
 RPDID=7374723D303030312E30413031303230352E34364346314646452E303041363A53434A535441543838363133332C73733D312C6667733D30;
 CAT=NONE; CON=NONE
X-MMS-Spam-Filter-ID: B2007082415_5.02.0125_4.0-9
X-WSS-ID: 6AD1C0712E0268610-01-01
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56586>

On Fri, 2007-08-24 at 10:51 -0700, Linus Torvalds wrote:
> Because full permissions and ownership (think ACL's) simply aren't 
> "content" enough. The way to _reliably_ turn them into "content" that can 
> be tracked, is to make it some form of file content.
> 
> Because otherwise, you will always hit situations where you simply cannot 
> access it sanely. Even as an administrator you might need to do some 
> emergency fixup, but you may be on vacation, and the only thing you have 
> access to is some machine that you're not root on - and you'd like to send 
> a "git bundle" with the fix to your less-than-stellar stand-in that is 
> knee-deep in sh*t because he doesn't know the system, and you're on some 
> sunny tropical island.

Using the .gitattributes approach essentially does turn perms/ownership
into trackable content.  A non-root user could specify the ownership of
certain files just by editing the .gitattributes, much in the same way a
non-root user can create an initramfs filesystem.

> Or just imagine the case where you have slightly different setups for 
> different people - some have ACL's, some have just basic permissions. But 
> you want to maintain an image that works for both cases. What do you do?

punt  :)   Simple unix ownership and perms are a good first cut.  ACL's
could probably be handled in much the same way, but converting between
unix perms and ACLs might have to be a separate attribute/filter
entirely.

> See? If you just accept the fact that ownership and permissions are 
> totally "separate content" that is tracked AS CONTENT, and not as the 
> filesystem thing, you solve all these problems.
> 
> > git is a content _tracker_.  It tracks contents, also contents that
> > move around.  If it can't track the permissions moving around as well,
> > it's sort of pointless to integrate this into git: if you have to
> > manage the stuff yourself, anyway, there is no point in creating the
> > illusion that it is done by git.
> 
> Fair enough - I'll certainly agree with the notion that we don't 
> necessarily need any integration of permissions/ownership into git at 
> all, and you can always do it as a totally independent layer.
> 
> > > Your choice. But I know which one I'd choose.
> > 
> > That's fine.  But you don't actually need git at all to implement your
> > choice, so this is orthogonal to whether having an option to do it
> > inside of git might be worth having.
> 
> But I care about git having a *sane*design*, whether I use all the 
> features or not. Because I simply care about my tools at a higher level 
> than most users do. Which means that it doesn't matter whether I'll use 
> permissions/ownership tracking or not - I still require that git do it 
> *sanely* from my standpoint of having a good content tracker.
> 
> And that means tracking those things *separately*, and not trying to mess 
> up the "tree" structure, for example.

Do you think its OK to cache this stuff in the index, though?
write-tree could then just dump the perms/ownership out as gitattributes
somewhere.

-JE
