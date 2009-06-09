From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 5/5] builtin-remote: Make "remote -v" display push urls
Date: Tue, 09 Jun 2009 09:25:16 -0700
Message-ID: <7vvdn5nzmb.fsf@alter.siamese.dyndns.org>
References: <1244563298-15479-1-git-send-email-git@drmicha.warpmail.net>
	<1244563298-15479-2-git-send-email-git@drmicha.warpmail.net>
	<1244563298-15479-3-git-send-email-git@drmicha.warpmail.net>
	<1244563298-15479-4-git-send-email-git@drmicha.warpmail.net>
	<1244563298-15479-5-git-send-email-git@drmicha.warpmail.net>
	<1244563298-15479-6-git-send-email-git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Tue Jun 09 18:25:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ME48b-0005Eu-7P
	for gcvg-git-2@gmane.org; Tue, 09 Jun 2009 18:25:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755973AbZFIQZQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Jun 2009 12:25:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751779AbZFIQZP
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Jun 2009 12:25:15 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:32976 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755812AbZFIQZO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Jun 2009 12:25:14 -0400
Received: from fed1rmimpo03.cox.net ([70.169.32.75])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090609162516.FBJ17670.fed1rmmtao101.cox.net@fed1rmimpo03.cox.net>;
          Tue, 9 Jun 2009 12:25:16 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo03.cox.net with bizsmtp
	id 1sRG1c00J4aMwMQ04sRGBY; Tue, 09 Jun 2009 12:25:16 -0400
X-VR-Score: 0.00
X-Authority-Analysis: v=1.0 c=1 a=sIeVhkn_z2MA:10 a=JRC6Y12iPbEA:10
 a=cCri8_SAAAAA:8 a=VwQbUJbxAAAA:8 a=vkd3mHGt-h9J7_ENFQcA:9
 a=OYPuYdbTBgs1qXZRWwj9ryCCJEUA:4
X-CM-Score: 0.00
In-Reply-To: <1244563298-15479-6-git-send-email-git@drmicha.warpmail.net> (Michael J. Gruber's message of "Tue\,  9 Jun 2009 18\:01\:38 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121186>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> Example with "mjg" having 1 url and 1 pushurl, "origin" having 3 urls,
> sb having 1 url:
>
> mjg     git://repo.or.cz/git/mjg.git (fetch)
> mjg     repoor:/srv/git/git/mjg.git (push)
> origin  git://repo.or.cz/git.git (fetch)
> origin  git://repo.or.cz/git.git (push)
> origin  git://git2.kernel.org/pub/scm/git/git.git (push)
> origin  git://repo.or.cz/alt-git.git (push)
> sb      git://repo.or.cz/git/sbeyer.git (fetch)
> sb      git://repo.or.cz/git/sbeyer.git (push)

The readers will get distracted, saying "eh, git:// can be used for push?"
(and the answer is "yes, sometimes, but not for repo.or.cz") even though
that is not the point of these illustrations.  For these examles, I think
it is better to use "repo.or.cz:foo.git" style, instead of "git://".

I am debating myself if the last two should be just one line,
without "(fetch)" nor "(push)" tacked at the end, like this:

        sb     git://repo.or.cz/git/sbeyer.git

If we change the rule in your patch to format a remote.*.url used for both
push and fetch as a single line to achieve this, however, it would make
your "origin" example come out like this instead:

	origin git://repo.or.cz/git.git
        origin git://git.kernel.org/pub/scm/git/git.git (push)
        origin git://repo.or.cz/alt-git.git (push)

which is arguably better (one less line) and worse (it is unclear if the
top one is only for fetching) at the same time.

Or perhaps we could go with something like this.

	origin git://repo.or.cz/git.git (fetch/push)
        origin git://git.kernel.org/pub/scm/git/git.git (push)
        origin git://repo.or.cz/alt-git.git (push)
        sb     git://repo.or.cz/git/sbeyer.git

i.e. make the rule such that a URL used for both are shown with (fetch/push)
only if there are other lines for the same remote.

Hmm?
