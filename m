From: Pete Wyckoff <pw@padd.com>
Subject: Re: [PATCH 1/4] git p4: bring back files in deleted client directory
Date: Mon, 30 Apr 2012 08:36:50 -0400
Message-ID: <20120430123650.GB25045@padd.com>
References: <1335747437-24034-1-git-send-email-pw@padd.com>
 <1335747437-24034-2-git-send-email-pw@padd.com>
 <4F9E376B.1000107@diamand.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Gary Gibbons <ggibbons@perforce.com>
To: Luke Diamand <luke@diamand.org>
X-From: git-owner@vger.kernel.org Mon Apr 30 14:37:07 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SOpqe-0004dq-Bb
	for gcvg-git-2@plane.gmane.org; Mon, 30 Apr 2012 14:37:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755682Ab2D3Mgz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Apr 2012 08:36:55 -0400
Received: from honk.padd.com ([74.3.171.149]:54999 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755354Ab2D3Mgy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Apr 2012 08:36:54 -0400
Received: from arf.padd.com (unknown [50.55.155.59])
	by honk.padd.com (Postfix) with ESMTPSA id A0A9025F9;
	Mon, 30 Apr 2012 05:36:53 -0700 (PDT)
Received: by arf.padd.com (Postfix, from userid 7770)
	id AF094313F8; Mon, 30 Apr 2012 08:36:50 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <4F9E376B.1000107@diamand.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196558>

luke@diamand.org wrote on Mon, 30 Apr 2012 07:55 +0100:
> On 30/04/12 01:57, Pete Wyckoff wrote:
> >The code to auto-create the client directory, added in 0591cfa
> >(git-p4: ensure submit clientPath exists before chdir,
> >2011-12-09), works when the client directory never existed.
> >
> >But if the directory is summarily removed without telling p4,
> >the sync operation will not bring back all the files.  Always
> >do "sync -f" if the client directory is newly created.
> 
> I'm possibly missing something obvious here, but
> ./t9807-git-p4-submit.sh fails with this change.
> 
> Rebasing the current branch onto remotes/p4/master
> First, rewinding head to replay your work on top of it...
> File file1 doesn't exist. file1
> not ok - 3 submit with no client dir

I can't figure it out.  Will you help debug a bit?  Something
like this maybe.

diff --git a/t/t9807-git-p4-submit.sh b/t/t9807-git-p4-submit.sh
index f23b4c3..e98cc5e 100755
--- a/t/t9807-git-p4-submit.sh
+++ b/t/t9807-git-p4-submit.sh
@@ -31,6 +31,7 @@ test_expect_success 'submit with no client dir' '
 	) &&
 	(
 		cd "$cli" &&
+		pwd && ls -la && p4 sync && ls -la &&
 		test_path_is_file file1 &&
 		test_path_is_file file2
 	)

And if the other "submit modify" etc. tests don't work, it
could be fallout from this one.  Deleting "$cli" is perhaps
at fault:  permissions, ... ?

Or somehow I completely broke things.

I'll try with a newer version of p4, to see if there's a
dependency there.

Thanks for checking!

		-- Pete
