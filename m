From: Ingo Molnar <mingo@elte.hu>
Subject: Re: git-rerere observations and feature suggestions
Date: Mon, 16 Jun 2008 22:46:30 +0200
Message-ID: <20080616204630.GA552@elte.hu>
References: <20080616110113.GA22945@elte.hu> <20080616112709.GG12260@mit.edu> <20080616195252.GA18848@elte.hu> <7v4p7tb00l.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Theodore Tso <tytso@mit.edu>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 16 22:48:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K8LcW-0000SS-7P
	for gcvg-git-2@gmane.org; Mon, 16 Jun 2008 22:48:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754187AbYFPUrK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Jun 2008 16:47:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754255AbYFPUrJ
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Jun 2008 16:47:09 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:37721 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754156AbYFPUrI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jun 2008 16:47:08 -0400
Received: from elvis.elte.hu ([157.181.1.14])
	by mx2.mail.elte.hu with esmtp (Exim)
	id 1K8Laz-0006dQ-7Q
	from <mingo@elte.hu>; Mon, 16 Jun 2008 22:46:43 +0200
Received: by elvis.elte.hu (Postfix, from userid 1004)
	id 63F393E21DD; Mon, 16 Jun 2008 22:46:28 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7v4p7tb00l.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Received-SPF: neutral (mx2: 157.181.1.14 is neither permitted nor denied by domain of elte.hu) client-ip=157.181.1.14; envelope-from=mingo@elte.hu; helo=elvis.elte.hu;
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: -1.5
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-1.5 required=5.9 tests=BAYES_00 autolearn=no SpamAssassin version=3.2.3
	-1.5 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85230>


* Junio C Hamano <gitster@pobox.com> wrote:

> Ingo Molnar <mingo@elte.hu> writes:
> 
> > right now that is simply not possible technically - it's even very 
> > hard to share a .git/rr-cache with a co-maintainer whom i can trust 
> > with my index file. (which is an otherwise unsafe private binary 
> > cache that i'd not put into a public repository as it could in 
> > theory contain lots of unrelated data and is not endian-safe, etc.)
> 
> Where did you get the idea that .git/index is involved in any way, I 
> wonder...

so it's only the rr-cache metadata that is involved? We had a few cases 
where git-rerere sessions were not repeatable by copying the 
.git/rr-cache, so i just assumed that there's some extra metadata in the 
index file. When that happened i took a look at git/builtin-rerere.c:

 static int find_conflict(struct path_list *conflict)
 {
        int i;
        if (read_cache() < 0)
                return error("Could not read index");

and (mistakenly) assumed that git-rerere depends on having something in 
the index file - but on a second look it just checks out the conflicting 
file(s) from the index file, right?

	Ingo
