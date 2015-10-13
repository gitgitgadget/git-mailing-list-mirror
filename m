From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v3 18/44] refs: move transaction functions into common
 code
Date: Tue, 13 Oct 2015 13:29:44 +0200
Message-ID: <561CEB28.3090907@alum.mit.edu>
References: <1444686725-27660-1-git-send-email-dturner@twopensource.com> <1444686725-27660-19-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
To: David Turner <dturner@twopensource.com>, git@vger.kernel.org,
	"brian m. carlson" <sandals@crustytoothpaste.net>
X-From: git-owner@vger.kernel.org Tue Oct 13 13:30:00 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZlxmF-0004ek-Cg
	for gcvg-git-2@plane.gmane.org; Tue, 13 Oct 2015 13:29:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932330AbbJML3t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Oct 2015 07:29:49 -0400
Received: from alum-mailsec-scanner-8.mit.edu ([18.7.68.20]:51545 "EHLO
	alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932289AbbJML3r (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 13 Oct 2015 07:29:47 -0400
X-AuditID: 12074414-f794f6d000007852-a5-561ceb2a727c
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id 2B.13.30802.A2BEC165; Tue, 13 Oct 2015 07:29:46 -0400 (EDT)
Received: from [192.168.69.130] (p5DDB2603.dip0.t-ipconnect.de [93.219.38.3])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t9DBTiI5026855
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Tue, 13 Oct 2015 07:29:45 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.8.0
In-Reply-To: <1444686725-27660-19-git-send-email-dturner@twopensource.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpjleLIzCtJLcpLzFFi42IRYndR1NV6LRNmcHCKtMX8TScYLbqudDNZ
	tM38weTA7LH85l8mjwXP77N7fN4kF8AcxW2TlFhSFpyZnqdvl8Cd0fhsCmPBbf6KPVO7mRsY
	P/J0MXJySAiYSJy/9pwdwhaTuHBvPVsXIxeHkMBlRokZ7zqZIZyzTBJHvy9gAqniFdCW+NI1
	mRnEZhFQlWjaOQ/MZhPQlVjU0wxWIyoQJLFi+QtGiHpBiZMzn7CA2CICNRKnF/aCbRMWCJQ4
	f/YhI8SCNkaJt7cWAiU4ODgFvCTOL9IBqWEW0JPYcf0XK4QtL9G8dTbzBEb+WUjGzkJSNgtJ
	2QJG5lWMcok5pbm6uYmZOcWpybrFyYl5ealFuhZ6uZkleqkppZsYIWEqsoPxyEm5Q4wCHIxK
	PLwvImXChFgTy4orcw8xSnIwKYnyul0FCvEl5adUZiQWZ8QXleakFh9ilOBgVhLhTWoByvGm
	JFZWpRblw6SkOViUxHm/LVb3ExJITyxJzU5NLUgtgsnKcHAoSfA+fQnUKFiUmp5akZaZU4KQ
	ZuLgBBnOJSVSnJqXklqUWFqSEQ+KyfhiYFSCpHiA9p4DaectLkjMBYpCtJ5iVJQSh0gIgCQy
	SvPgxsKSzytGcaAvhXmFXwFV8QATF1z3K6DBTECDjdilQAaXJCKkpBoYF5T92bG+v2Fy/T+D
	w28K6xKrimLdmy8X7km3vlQ7b07srJbrDrK+Rt0vU7iu38l6K5V4VPNUgsYfCTfZ5fO+rl23
	wm2925mQvDfcN5pPu+dPWfmkvP3bmnfnqvfcUucr3B6zzIDrziuNC/NFUhMj3u7S 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279496>

I reviewed the patches up to here pretty carefully, and aside from the
comments I already sent, they look good.

I like the new approach where the ref_transaction-building code is
shared across backends.

It seems to me that a good breaking point for the first batch of patches
would be here, just before you start creating the VTABLE in commit
[19/44]. The patches before this point all have to do with moving code
around and a little bit of light refactoring. They cause a lot of code
churn that will soon conflict with other people's work (e.g., [1]), but
I think they are pretty uncontroversial.

After this you start making a few important design decisions that
*could* be controversial. Therefore, by making a cut, you can maximize
the chance that the earlier patches can be merged to master relatively
quickly, after which the cross section for future conflicts will be much
smaller.

Ideally, you would include a few later patches in the "pre-VTABLE" patch
series. It looks like the following patches also mostly have to do with
moving code around, and would fit logically with the "pre-VTABLE" changes:

[24] refs.c: move refname_is_safe to the common code
[25] refs.h: document make refname_is_safe and add it to header
[26] refs.c: move copy_msg to the common code
[27] refs.c: move peel_object to the common code
[28] refs.c: move should_autocreate_reflog to common code
[32] initdb: move safe_create_dir into common code
[36] refs: make files_log_ref_write functions public
[37] refs: break out a ref conflict check

I tried rebasing those commits on top of your patch 18 and it wasn't too
bad. The result is on branch "refs-backend-pre-vtable" on my GitHub repo
[2], including my suggested changes to those eight patches (which
therefore became seven because I squashed the first two together).

Michael

[1] http://article.gmane.org/gmane.comp.version-control.git/279286
[2] https://github.com/mhagger/git

-- 
Michael Haggerty
mhagger@alum.mit.edu
