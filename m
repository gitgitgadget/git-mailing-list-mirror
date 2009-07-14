From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Fix extraneous lstat's in 'git checkout -f'
Date: Tue, 14 Jul 2009 07:50:56 -0700 (PDT)
Message-ID: <alpine.LFD.2.01.0907140750290.13838@localhost.localdomain>
References: <alpine.LFD.2.01.0907132040530.13838@localhost.localdomain> <7vzlb7hc7y.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 14 16:51:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MQjM4-00067h-52
	for gcvg-git-2@gmane.org; Tue, 14 Jul 2009 16:51:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754449AbZGNOvc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Jul 2009 10:51:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754373AbZGNOvb
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Jul 2009 10:51:31 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:56575 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754164AbZGNOvb (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 14 Jul 2009 10:51:31 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n6EEouxl016953
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 14 Jul 2009 07:50:57 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id n6EEousl005255;
	Tue, 14 Jul 2009 07:50:56 -0700
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <7vzlb7hc7y.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 2.01 (LFD 1184 2008-12-16)
X-Spam-Status: No, hits=-3.466 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123252>



On Tue, 14 Jul 2009, Junio C Hamano wrote:

> Linus Torvalds <torvalds@linux-foundation.org> writes:
> 
> > Quite frankly, I'd like for us to at least think about removing CE_VALID. 
> 
> This is heavy.  I personally do not use this flag, nor know anybody who
> does, but deviating from the original purpose of CE_VALID, which was to
> avoid lstat() on slow filesystems, people have advised/advocated its use
> for "narrow checkout".

Ahh. I kind of was aware of that, but had totally forgotten.

And in that case, I guess it's also fine. In fact, for that case CE_VALID 
would tend to really mean "always assume CE_UPTODATE", so then the patch I 
sent out doesn't really necessarily need the whole "known_uptodate()" 
thing, and could just use

	if (o->reset && !ce_valid(old)) {

instead.

Which also makes my other worries go away.

			Linus
