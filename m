From: John Keeping <john@keeping.me.uk>
Subject: Re: [PATCH 0/2] finding the fork point from reflog entries
Date: Thu, 24 Oct 2013 21:54:34 +0100
Message-ID: <20131024205434.GC10779@serenity.lan>
References: <xmqqhac6o5hj.fsf@gitster.dls.corp.google.com>
 <1382641884-14756-1-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Martin von Zweigbergk <martinvonz@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Oct 24 22:54:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VZRvb-0000pa-QB
	for gcvg-git-2@plane.gmane.org; Thu, 24 Oct 2013 22:54:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755562Ab3JXUyo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Oct 2013 16:54:44 -0400
Received: from hyena.aluminati.org ([64.22.123.221]:34481 "EHLO
	hyena.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755151Ab3JXUyn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Oct 2013 16:54:43 -0400
Received: from localhost (localhost [127.0.0.1])
	by hyena.aluminati.org (Postfix) with ESMTP id EA438202CF;
	Thu, 24 Oct 2013 21:54:42 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at hyena.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -2.9
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, BAYES_00=-1.9] autolearn=ham
Received: from hyena.aluminati.org ([127.0.0.1])
	by localhost (hyena.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id iZZ-EbD9WW0o; Thu, 24 Oct 2013 21:54:42 +0100 (BST)
Received: from serenity.lan (banza.aluminati.org [10.0.7.182])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by hyena.aluminati.org (Postfix) with ESMTPSA id AFE8A22F86;
	Thu, 24 Oct 2013 21:54:36 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <1382641884-14756-1-git-send-email-gitster@pobox.com>
User-Agent: Mutt/1.5.22 (2013-10-16)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236620>

On Thu, Oct 24, 2013 at 12:11:22PM -0700, Junio C Hamano wrote:
> The first one is a clean-up of the code to parse command line
> options to "git merge-base".  Options such as "--independent",
> "--is-ancestor" and "--octopus" are mutually exclusive and it is
> better expressed in terms of the recently introduced OPT_CMDMODE.
> 
> The second one implements the entire logic of the for loop we see in
> "git pull --rebase" directly using get_merge_bases_many() and
> postprocessing the result.

Nice!  I tried this in the case where the target commit happens to be
the 63rd reflog entry:

$ time sh -c 'for rev in $(git rev-list -g origin/master 2>/dev/null)
do
    git merge-base --is-ancestor $rev b2edae0 && break
done
'

real    0m3.772s
user    0m3.338s
sys     0m0.440s

$ time git merge-base --reflog origin/master b2edae0

real    0m0.156s
user    0m0.138s
sys     0m0.018s


> Junio C Hamano (2):
>   merge-base: use OPT_CMDMODE and clarify the command line parsing
>   merge-base: "--reflog" mode finds fork point from reflog entries
> 
>  builtin/merge-base.c  | 115 +++++++++++++++++++++++++++++++++++++++++++-------
>  t/t6010-merge-base.sh |  27 ++++++++++++
>  2 files changed, 126 insertions(+), 16 deletions(-)

Should there be a change to Documentation/git-merge-base.txt in here?
