From: "David Tweed" <david.tweed@gmail.com>
Subject: Understanding git filter-branch --subdirectory-filter behaviour
Date: Tue, 20 May 2008 21:11:55 +0100
Message-ID: <e1dab3980805201311m3cbde4f2id8c3493a25745238@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "gi mailing list" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue May 20 22:13:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JyYCb-0006LS-1Q
	for gcvg-git-2@gmane.org; Tue, 20 May 2008 22:12:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759425AbYETUMA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 May 2008 16:12:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759024AbYETUMA
	(ORCPT <rfc822;git-outgoing>); Tue, 20 May 2008 16:12:00 -0400
Received: from rn-out-0910.google.com ([64.233.170.188]:44559 "EHLO
	rn-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755931AbYETUL7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 May 2008 16:11:59 -0400
Received: by rn-out-0910.google.com with SMTP id k40so173625rnd.17
        for <git@vger.kernel.org>; Tue, 20 May 2008 13:11:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=igbRFK71wn+nAchH+wbvWR5x+I5EAC5CDYFlvuIj7Mo=;
        b=Jl84Mg1EMfCViPR4tKX/cGwvpdaAebm552YbNhTTbYJF+MrJ9fMqutBLHLsf5Cf4um9I1nQDOs0OHMXi0ObzT38INGOJoGdzqWUR8UeIJUQ4nTKjYaPQN+UqnE8Tp3nB01BrrSTnoQxjAc/L09L0t8ZNezzF65xc9maf8D8x9G4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=I9dFBe0tAXhHjKMB7ZLLQYmQvw1+5hOMZJK9nJmPXh4mKnAueQVbGlMc1we55vWEy7kaTkSuh19LQ85PGvgDOgSQzKQQhhVybn1g850/SrxaKiihS4AbC/zV0dp+xDP8SkQENUR5fBL1EsmFFUw89zlZAFICG6u2hBzcMjNsf7o=
Received: by 10.150.95.16 with SMTP id s16mr8025443ybb.247.1211314315787;
        Tue, 20 May 2008 13:11:55 -0700 (PDT)
Received: by 10.150.225.18 with HTTP; Tue, 20 May 2008 13:11:55 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82494>

Hi, I'm experimenting with git filter-branch --subdirectory-filter
(being specific since it appears to have several special code branches
in the script) and getting results that I don't understand. Firstly,
can I confirm what appears implied by the man-page but I can't find
explicitly stated:

git filter-branch <how to filter> HEAD

is expected to do its filtering on the branch HEAD is on the entire
DAG all the way back to the initial commit, even if this is a DAG with
multiple branches splitting off and remerging?

I'm trying this on a repo (copy) containing a directory WRITING,
although not quite all the way back to the repo creation getting:

$ git filter-branch --subdirectory-filter WRITING/ HEAD
Rewrite 42f24be8d8198738134a19471697b39359199fa3 (351/351)
Ref 'refs/heads/master' was rewritten

$ git rev-list HEAD | wc
     55      55    2255

Looking at this with gitk and git log confirms 55 commits, and the
first commit is the one immediately after the first merge encountered
(the commit that occured just after the merge) when walking backwards
in history. Is this something that would be expected?

Digging a little into the shell-script I find the list of commits is
generated with

git rev-list --reverse --topo-order --default HEAD --parents HEAD
--full-history -- WRITING

and (adding --pretty so I can easily read it) running this manually
gives 351 entries and looks to contain the expected commits. So I'm
confused what's happening?

If this is expected, is there an refspec I'm missing to get
filter-branch to filter the entire repo?

(FWIW, git version 1.5.5.1.316.g377d9 on x86-64 Linux.)

Many thanks,

-- 
cheers, dave tweed__________________________
david.tweed@gmail.com
Rm 124, School of Systems Engineering, University of Reading.
"while having code so boring anyone can maintain it, use Python." --
attempted insult seen on slashdot
