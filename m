From: "Marcel M. Cary" <marcel@oak.homeunix.org>
Subject: Re: [PATCH] rev-parse: Fix shell scripts whose cwd is a symlink into
 a git work-dir
Date: Tue, 25 Nov 2008 08:16:20 -0800
Message-ID: <492C24D4.1010306@oak.homeunix.org>
References: <cover.1226759762.git.marcel@oak.homeunix.org> <1227389614-10946-1-git-send-email-marcel@oak.homeunix.org> <492BA998.5050106@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: gitster@pobox.com, git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Tue Nov 25 17:17:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L50bd-0001ZX-JG
	for gcvg-git-2@gmane.org; Tue, 25 Nov 2008 17:17:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752044AbYKYQQ0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Nov 2008 11:16:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751676AbYKYQQZ
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Nov 2008 11:16:25 -0500
Received: from smtp118.sbc.mail.sp1.yahoo.com ([69.147.64.91]:47108 "HELO
	smtp118.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751287AbYKYQQZ (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 25 Nov 2008 11:16:25 -0500
Received: (qmail 19590 invoked from network); 25 Nov 2008 16:16:24 -0000
Received: from unknown (HELO ordinateur.home.org) (marcel@76.231.190.99 with plain)
  by smtp118.sbc.mail.sp1.yahoo.com with SMTP; 25 Nov 2008 16:16:23 -0000
X-YMail-OSG: DPsfdcIVM1k1s4ddniszsj1soBfgRYjWmWiUL1kXHFQsTTCINW02Z4lrkpOW1AUPvexbYeZr6o2xKNvW1hXhPjKOyVQOIxHL1tPoKVe0SeHP6EyaVQQKt0AAhGZwS5ZEgeyC1WtXCZZyHmae2rsj.VVy
X-Yahoo-Newman-Property: ymail-3
Received: from polliwog.home.org ([192.168.0.18])
	by ordinateur.home.org with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <marcel@oak.homeunix.org>)
	id 1L50aM-0001yn-4r; Tue, 25 Nov 2008 08:16:22 -0800
User-Agent: Thunderbird 2.0.0.6 (X11/20070801)
In-Reply-To: <492BA998.5050106@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101666>

Johannes Sixt wrote:
> Marcel M. Cary schrieb:
>> * Change "git rev-parse --show-cdup" to print a full path instead of
>>   a series of "../" when it prints anything
> 
> http://thread.gmane.org/gmane.comp.version-control.git/88557/focus=88562
> 
> I don't see that you bring in any new arguments.

To be clear, as mentioned here:

http://thread.gmane.org/gmane.comp.version-control.git/88557/focus=88573

I'm not talking about a situation where the symlink is in the working
tree pointing outwards.  I'm talking about a symlink outside pointing
in.  And as mentioned later in that thread, the --work-tree workaround
doesn't actually work.


One new thing I have to add is that the reason --show-cdup prints a
correct path but pull fails is because it's the *shell* who
misinterprets the path.  So telling git rev-parse where the work-tree is
helps nothing.  It already knows.

http://thread.gmane.org/gmane.comp.version-control.git/88557/focus=88581

So far I've seen no response to the idea, which Yves mentions, about
trying to restrict the absolute path behavior to times when bash would
interpret the "../" incorrectly.

Nor have I seen a response to the idea of correcting the shell's
behavior in cd_to_toplevel, for example by adding a "cd `pwd`", and I
don't really understand the scenario where this would be a performance
concern; I think I haven't found a particular discussion that several
people have referenced.  Perhaps I should prepare a patch for that so I
can verify that it works as I expect and so we have something more
concrete to discuss?

Any tips on how to follow the reference
7vk5sly3h9.fsf@assigned-by-dhcp.cox.net in the first url above?  It
looks to be about performance.  Message-Id seems to not be indexed for
searching.

Marcel
