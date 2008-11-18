From: "Marcel M. Cary" <marcel@oak.homeunix.org>
Subject: Re: purging unwanted history
Date: Tue, 18 Nov 2008 06:28:55 -0800
Message-ID: <4922D127.1020305@oak.homeunix.org>
References: <93c3eada0811161626h69929cd7va3fa4007a2341bae@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: geoffrey.russell@gmail.com
X-From: git-owner@vger.kernel.org Tue Nov 18 15:37:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L2RhO-0003pB-7y
	for gcvg-git-2@gmane.org; Tue, 18 Nov 2008 15:37:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752029AbYKROfr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Nov 2008 09:35:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752027AbYKROfr
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Nov 2008 09:35:47 -0500
Received: from smtp124.sbc.mail.sp1.yahoo.com ([69.147.64.97]:41929 "HELO
	smtp124.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752026AbYKROfq (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 18 Nov 2008 09:35:46 -0500
X-Greylist: delayed 403 seconds by postgrey-1.27 at vger.kernel.org; Tue, 18 Nov 2008 09:35:46 EST
Received: (qmail 25818 invoked from network); 18 Nov 2008 14:29:03 -0000
Received: from unknown (HELO ordinateur.home.org) (marcel@76.231.190.99 with plain)
  by smtp124.sbc.mail.sp1.yahoo.com with SMTP; 18 Nov 2008 14:29:02 -0000
X-YMail-OSG: 7n15J9kVM1nmE9SsjrFE9SejBtfROiqiK42ZquVgk.FlKXv2GQRJ.qQWyfe2.tbAFc0UMckFXGMWaCUinml6hoiuSylBFXy.kCtVe_zyfNrslct1NQPCWP5YBXg9tU0f4Wa9sbNm1b4SKVKHz0JXtPVl
X-Yahoo-Newman-Property: ymail-3
Received: from polliwog.home.org ([192.168.0.18])
	by ordinateur.home.org with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <marcel@oak.homeunix.org>)
	id 1L2RZd-0008U6-Np; Tue, 18 Nov 2008 06:29:01 -0800
User-Agent: Thunderbird 2.0.0.6 (X11/20070801)
In-Reply-To: <93c3eada0811161626h69929cd7va3fa4007a2341bae@mail.gmail.com>
X-Enigmail-Version: 0.95.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101272>

Geoff,

I'm able to prune history with git filter-branch.  For example, to throw
away history on the current branch before commit
171d7661eda111d3e35f6e8097a1a3a07b30026c, I tried:

git filter-branch --parent-filter '
    if [ $GIT_COMMIT = 171d7661eda111d3e35f6e8097a1a3a07b30026c ]; then
        echo "";
    else
        read line;
        echo $line;
    fi'

I found the diff between that commit and it's rewritten version was
empty, and diffs to subsequent commits looked sane.  It took an hour on
the git repository with about 16k commits.  I probably should have
excluded all the commits I didn't want to keep to reduce processing time.

However, after deleting all but the rewritten branch and cloning the
repository, I didn't notice any decrease in the size of .git/, so I'm
not sure why you'd want to do that.  Also, all the remaining commitIDs
changed so any previous clones would have a tough time merging with yours.

Another possibility whose results might be similar in runtime and
repository size would be to run git rebase --interactive and squash all
the commits together before the ones you want to keep.

Marcel


Geoff Russell wrote:
> I have a repository with 5 years worth of history, I only want to keep
> 1 year, so I want to purge the
> first 4 years. As it happens, the repository only has a single branch
> which should
> simplify the problem.
> 
> Cheers,
> 
> Geoff Russell
> 
> P.S. Apologies, but I've asked this question before but didn't get an
> answer which
> I understood or which worked, so perhaps my description of the problem
> was faulty. This
> is a second attempt.
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
