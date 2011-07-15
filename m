From: Jakub Narebski <jnareb@gmail.com>
Subject: Generation numbers and replacement objects
Date: Fri, 15 Jul 2011 14:01:36 -0700 (PDT)
Message-ID: <m3aacf9s4k.fsf@localhost.localdomain>
References: <20110713064709.GA18499@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	"Ted Ts'o" <tytso@mit.edu>, Jonathan Nieder <jrnieder@gmail.com>,
	=?iso-8859-15?q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>,
	Clemens Buchacher <drizzd@aon.at>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Jakub Narebski <jnareb@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jul 15 23:01:45 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QhpW4-0006We-9d
	for gcvg-git-2@lo.gmane.org; Fri, 15 Jul 2011 23:01:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751999Ab1GOVBk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Jul 2011 17:01:40 -0400
Received: from mail-fx0-f52.google.com ([209.85.161.52]:51755 "EHLO
	mail-fx0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751556Ab1GOVBj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jul 2011 17:01:39 -0400
Received: by fxd18 with SMTP id 18so3320381fxd.11
        for <git@vger.kernel.org>; Fri, 15 Jul 2011 14:01:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=Qn6Sj6+tgh9HCAesWsNYwQXJ8an9LSQCSs16oU61mIk=;
        b=Jx1MNi2hvFPc3om/KisF0F9bQELRo5NIZ24OvzwnTzKBDx0IQlvPVKwBGKsSUHUsE3
         ZQJjKG7+2ezJpkkgBSHhLHeER4bAzsj+Sy3Tp8hFPLZZS309YT3J8p6VP3Bcfh72DdLp
         4ngSLugWO9MihC8XwEyvg7RVjT89qxvhy4dFc=
Received: by 10.204.127.156 with SMTP id g28mr1288528bks.114.1310763697978;
        Fri, 15 Jul 2011 14:01:37 -0700 (PDT)
Received: from localhost.localdomain (abva38.neoplus.adsl.tpnet.pl [83.8.198.38])
        by mx.google.com with ESMTPS id s16sm1030934fah.2.2011.07.15.14.01.30
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 15 Jul 2011 14:01:36 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id p6FL0sN3022060;
	Fri, 15 Jul 2011 23:01:04 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id p6FL0Cbp022045;
	Fri, 15 Jul 2011 23:00:12 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <20110713064709.GA18499@sigill.intra.peff.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177229>

[Sorry for sending this email like this, but I forgot where
 I wanted to attach it to threads]

Peff, as Junio said somewhere else either in this thread, or the one
started by Linus, we would want generation numbers both without taking
into account replacement objects (e.g. for object traversal during
push / fetch), and with taking it into account (e.g. when showing log
or blame for end user).

So we would need two generation number caches: one with and one
without replaces.  Nb. generation header stored in commit object can
give only the one without replaces, i.e. speed up object enumeration
(what happened to caching GSoC project code?) but not git-log.

Also if replacement object has the same generation as the commit it
replaces, and I think also if it has lower generation number, current
generation numbers would still work (ne need to invalidate cache).

-- 
Jakub Narebski
