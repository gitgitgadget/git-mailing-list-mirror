From: Jakob Stoklund Olesen <stoklund@2pi.dk>
Subject: Re: git svn's performance issue and strange pauses, and other thing
Date: Sun, 19 Oct 2014 07:41:16 -0700
Message-ID: <0F2DF34C-8134-4888-B081-216660F67BB6@2pi.dk>
References: <1412706046.90413.YahooMailBasic@web172303.mail.ir2.yahoo.com> <20141019041238.GA8944@dcvr.yhbt.net>
Mime-Version: 1.0 (1.0)
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Hin-Tak Leung <htl10@users.sourceforge.net>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	"sam@vilain.net" <sam@vilain.net>,
	"stevenrwalter@gmail.com" <stevenrwalter@gmail.com>,
	"waste.manager@gmx.de" <waste.manager@gmx.de>,
	"amyrick@apple.com" <amyrick@apple.com>
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Sun Oct 19 16:41:50 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xfrg4-0008C5-U9
	for gcvg-git-2@plane.gmane.org; Sun, 19 Oct 2014 16:41:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751975AbaJSOlf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Oct 2014 10:41:35 -0400
Received: from hapkido.dreamhost.com ([66.33.216.122]:48052 "EHLO
	hapkido.dreamhost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751942AbaJSOle convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 19 Oct 2014 10:41:34 -0400
Received: from homiemail-a92.g.dreamhost.com (sub5.mail.dreamhost.com [208.113.200.129])
	by hapkido.dreamhost.com (Postfix) with ESMTP id 8E225890AF
	for <git@vger.kernel.org>; Sun, 19 Oct 2014 07:41:34 -0700 (PDT)
Received: from homiemail-a92.g.dreamhost.com (localhost [127.0.0.1])
	by homiemail-a92.g.dreamhost.com (Postfix) with ESMTP id 2FBE03DC05E;
	Sun, 19 Oct 2014 07:41:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=2pi.dk; h=references
	:mime-version:in-reply-to:content-type:content-transfer-encoding
	:message-id:cc:from:subject:date:to; s=2pi.dk; bh=+n2KIzCyPK9daR
	4ZFznTgLri9+E=; b=ZAdtfWvqtsBQD5MsPfzMRsJCJymECy5EaKBEqVIZ4NTeke
	3oAnMChwccsR+GRpp7faHh5sMx0ZHWjWoN/F1CMUEs2Z82nLU9puum7E6l15qG4q
	TuPNIvA/R2W5oL+5yMHul+3e9RYyx6daajGpAyPg0Ip1QJRLVpPcmFONi8Eek=
Received: from [100.159.216.178] (unknown [172.56.14.52])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: stoklund@2pi.dk)
	by homiemail-a92.g.dreamhost.com (Postfix) with ESMTPSA id 4A4FF3DC05B;
	Sun, 19 Oct 2014 07:41:23 -0700 (PDT)
In-Reply-To: <20141019041238.GA8944@dcvr.yhbt.net>
X-Mailer: iPhone Mail (11D257)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Oct 18, 2014, at 21:12, Eric Wong <normalperson@yhbt.net> wrote:

>> I am somwhat worry about the dramatic difference between the two .svn/.caches -
>> check_cherry_pick.yaml is 225MB in one and 73MB in the other, and also
>> _rev_list.yaml is opposite - 24MB vs 73MB. How do I reconcile that?
> 
> Calling patterns changed, and it looks like Jakob's changes avoided some
> calls.

It is possible that those functions don't need to be memoized any more. My patch is trying to avoid calling them with the same arguments over and over, and memoizing doesn't help when arguments are changing.

Thanks,
/jakob