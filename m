From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Git commit generation numbers
Date: Fri, 22 Jul 2011 14:18:51 +0200
Message-ID: <201107221418.52414.jnareb@gmail.com>
References: <20110721202722.3765.qmail@science.horizon.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: Anthony Van de Gejuchte <anthonyvdgent@gmail.com>,
	David Lang <david@lang.hm>, git@vger.kernel.org,
	Phil Hord <hordp@cisco.com>, Nicolas Pitre <nico@fluxnic.net>,
	Shawn Pearce <spearce@spearce.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: "George Spelvin" <linux@horizon.com>
X-From: git-owner@vger.kernel.org Fri Jul 22 14:19:08 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QkEhA-0005T5-2P
	for gcvg-git-2@lo.gmane.org; Fri, 22 Jul 2011 14:19:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754078Ab1GVMS7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Jul 2011 08:18:59 -0400
Received: from mail-fx0-f52.google.com ([209.85.161.52]:51597 "EHLO
	mail-fx0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753779Ab1GVMS6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Jul 2011 08:18:58 -0400
Received: by fxd18 with SMTP id 18so5215383fxd.11
        for <git@vger.kernel.org>; Fri, 22 Jul 2011 05:18:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=NZXjqbnDUy8nD8bnHstmGA8cABq5T+B+KfwTINGwSdQ=;
        b=R9EeSNAbGGKIBzY9Bc/hRBEIKEJSwbEfbAmm/4WdnPLuOE7YYV3RyJgBjaE7kF/phq
         deAw6uMTSQQh8MOVEwIJd7Ce5Q33RGl8Hx1elxg7nlxvwbicpKCmmcrLFrrSBg9visKf
         6EtxPDAn5zO+iZRjcC/tfJ+T1jAZYzFzSXk04=
Received: by 10.223.45.71 with SMTP id d7mr111069faf.47.1311337137168;
        Fri, 22 Jul 2011 05:18:57 -0700 (PDT)
Received: from [192.168.1.13] (abvt94.neoplus.adsl.tpnet.pl [83.8.217.94])
        by mx.google.com with ESMTPS id f7sm1264417faa.32.2011.07.22.05.18.54
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 22 Jul 2011 05:18:55 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <20110721202722.3765.qmail@science.horizon.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177640>

On Thu, 21 Jul 2011, George Spelvin wrote:

> > There is also another issue that I have mentioned, namely incomplete
> > clones - which currently means shallow clone, without access to full
> > history.
> 
> As far as history walking is concerned, you can just consider "missing
> parent" the same as "no parent" and start the generation numbers at 0.
> As long as you recompute.

Well, shallow clone case can be considered both for putting 'true'
generation numbers in commit header, and against it.

For, because with generation numbers in commits you can use true
generation numbers.

Against, because if there are commits without generation numbers in
header, you cannot assign true generation number, and you can only use
"shallow" generation number, in generation numbers cache.

> > Nb. grafts are so horrible hack that I would be not against turning
> > off generation numbers if they are used.
> 
> Yeah, but it's not too miserable to add support (the logic is very similar
> to replace objects), and then you would be able to have the history walking
> code depend on the presence of generation numbers.  (The "load the cache"
> function would regenerate it if necessary.)
> 
> Only do this if you already have support for "no generation numbers" in
> the history walking code for (say) loose objects.

Grafts are non-transferable, and if you use them to cull rather than add
history they are unsafe against garbage collection... I think.
 
> > In the case of replace objects you need both non-replaced and replaced
> > DAG generation numbers.
> 
> Yes, the cache validity/invalidation criteria are the tricky bit.
> Honestly, this is where the code gets ugly, not computing and storing
> the generation numbers.

BTW. with storing generation number in commit header there is a problem
what would old version of git, one which does not understand said header,
do during rebase.  Would it strip unknown headers, or would it copy
generation number verbatim - which means that it can be incorrect?

BTW2. code size comparing in-commit and external cache cases must take
into account yet to be written fsck for in-commit generation numbers.

-- 
Jakub Narebski
Poland
