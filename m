From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFH] gcc constant expression warning...
Date: Sun, 28 Oct 2007 10:09:10 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0710281000260.30120@woody.linux-foundation.org>
References: <7vy7dnvd6w.fsf@gitster.siamese.dyndns.org>
 <slrnfi8pj7.mb4.antti-juhani@kukkaseppele.kaijanaho.fi>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: git@vger.kernel.org
To: Antti-Juhani Kaijanaho <antti-juhani@kaijanaho.fi>
X-From: git-owner@vger.kernel.org Sun Oct 28 18:09:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ImBdj-0006Um-7L
	for gcvg-git-2@gmane.org; Sun, 28 Oct 2007 18:09:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751097AbXJ1RJR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Oct 2007 13:09:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751141AbXJ1RJR
	(ORCPT <rfc822;git-outgoing>); Sun, 28 Oct 2007 13:09:17 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:47520 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750841AbXJ1RJQ (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 28 Oct 2007 13:09:16 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l9SH9BNn012716
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 28 Oct 2007 10:09:12 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l9SH9AbS014255;
	Sun, 28 Oct 2007 10:09:11 -0700
In-Reply-To: <slrnfi8pj7.mb4.antti-juhani@kukkaseppele.kaijanaho.fi>
X-Spam-Status: No, hits=-3.235 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62574>



On Sun, 28 Oct 2007, Antti-Juhani Kaijanaho wrote:
>
> A correct fix would be to check for the size of off_t in some other (and
> defined) manner, but I don't know off_t well enough to suggest one.

In this case, it's trying to make sense that "off_t" can hold more than 32
bits. So I think that test can just be rewritten as

	if (sizeof(off_t) <= 4) {
		munmap(idx_map, idx_size);
		return error("pack too large for current definition of off_t in %s", path);
	}

instead.

			Linus
