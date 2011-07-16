From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Generation numbers and replacement objects
Date: Sat, 16 Jul 2011 23:10:25 +0200
Message-ID: <201107162310.26808.jnareb@gmail.com>
References: <20110713064709.GA18499@sigill.intra.peff.net> <m3aacf9s4k.fsf@localhost.localdomain> <20110715211033.GA1943@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Ted Ts'o <tytso@mit.edu>, Jonathan Nieder <jrnieder@gmail.com>,
	=?utf-8?q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
	<avarab@gmail.com>, Clemens Buchacher <drizzd@aon.at>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Jul 16 23:10:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QiC84-0001yc-Oq
	for gcvg-git-2@lo.gmane.org; Sat, 16 Jul 2011 23:10:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751328Ab1GPVKV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Jul 2011 17:10:21 -0400
Received: from mail-fx0-f52.google.com ([209.85.161.52]:35462 "EHLO
	mail-fx0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751084Ab1GPVKU (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Jul 2011 17:10:20 -0400
Received: by fxd18 with SMTP id 18so4458201fxd.11
        for <git@vger.kernel.org>; Sat, 16 Jul 2011 14:10:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=eq/+1d+0cdMrx8EwIhnslQ6HOd3lXEDBJ+/eF1gxVaY=;
        b=UACDWE7IfXjPZ15W6qtcWDY0+C+Bi17sEq8oTYDcoRw1Qfb6Mk2eUJzYsnOSaPOnlH
         a943SKv3tH8a1TeDaORQFwVLiH62PqQlBBHB87XxPWXBT/dskvMfMoAm6Ut3DyX3xMwm
         mWEw+am1aQKYniKKO6pzuQSeNvouiGPbfSA4w=
Received: by 10.223.55.8 with SMTP id s8mr7390623fag.141.1310850619306;
        Sat, 16 Jul 2011 14:10:19 -0700 (PDT)
Received: from [192.168.1.15] (abwk203.neoplus.adsl.tpnet.pl [83.8.234.203])
        by mx.google.com with ESMTPS id x13sm1745715fah.29.2011.07.16.14.10.16
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 16 Jul 2011 14:10:17 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <20110715211033.GA1943@sigill.intra.peff.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177285>

On Fri, Jul 15, 2011, Jeff King wrote:
> On Fri, Jul 15, 2011 at 02:01:36PM -0700, Jakub Narebski wrote:
> 
> > Peff, as Junio said somewhere else either in this thread, or the one
> > started by Linus, we would want generation numbers both without taking
> > into account replacement objects (e.g. for object traversal during
> > push / fetch), and with taking it into account (e.g. when showing log
> > or blame for end user).
> > 
> > So we would need two generation number caches: one with and one
> > without replaces.
> 
> Right. And I already outlined a solution for that by indexing the caches
> by the validity token (I haven't written the patches yet, but it's a
> pretty trivial change).

Actually we wouldn't probably want a separate cache for each validity
token, but two caches: one with and one without... well, perhaps one per
namespace.  But certainly not one per replacement.
 
> > Nb. generation header stored in commit object can give only the one
> > without replaces, i.e. speed up object enumeration (what happened to
> > caching GSoC project code?) but not git-log.
> 
> Yes. It is a weakness of putting the generation number in the header. I
> think Linus has already said he doesn't care about grafting. You are
> welcome to argue with him about that.

I tried, but he isn't responding to questions about replacement objects.

I can agree that grafts are terrible hack, and for me turning off using
generation numbers if there are grafts is reasonable solution.  Not so
with replace objects.

> > Also if replacement object has the same generation as the commit it
> > replaces, and I think also if it has lower generation number, current
> > generation numbers would still work (ne need to invalidate cache).
> 
> Yes, that is why I said elsewhere "you could be more clever about seeing
> how the cache's validity constraints changed". But ultimately, it is not
> that expensive to regenerate the cache under the new conditions, grafts
> don't change very often, and the code to figure out exactly which parts
> of the cache could be saved would be complex.

True.  Well, at least taking hash of only replacements of commit objects
that change generation number could be a reasonable thing... but probably
too complicated anyway.

-- 
Jakub Narebski
Poland
