From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re: [FYI] How I compile on SunOS 5.7 with the SUNWspro compiler	and
 ksh
Date: Mon, 18 Aug 2008 19:47:39 -0500
Message-ID: <L3gfLYBAXG5GUGcbdLqOnZab_UfskZC4FTgP9d47MJuoAiJRa2V5ZQ@cipher.nrlssc.navy.mil>
References: <IH0MHSTEimhAN93AedvpRKq4qfzm1QA814ZYyhbSBtSdNbq8vuE6aw@cipher.nrlssc.navy.mil> <20080819002047.GA15770@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Aug 19 02:48:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KVFP2-00045I-Qm
	for gcvg-git-2@gmane.org; Tue, 19 Aug 2008 02:48:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753736AbYHSArt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Aug 2008 20:47:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753274AbYHSArt
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Aug 2008 20:47:49 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:59674 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752544AbYHSArs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Aug 2008 20:47:48 -0400
Received: by mail.nrlssc.navy.mil id m7J0ldOC003951; Mon, 18 Aug 2008 19:47:39 -0500
In-Reply-To: <20080819002047.GA15770@coredump.intra.peff.net>
X-OriginalArrivalTime: 19 Aug 2008 00:47:39.0440 (UTC) FILETIME=[2E3EEB00:01C90195]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92798>

Jeff King wrote:
> On Mon, Aug 18, 2008 at 06:39:40PM -0500, Brandon Casey wrote:
> 
>> 1) the t5000 tests which fail are due to the installed gnu tar being
>> too old, and
> 
> Hmm. I thought I had t5000 working on Solaris 5.7 a few months ago.
> Unfortunately, the Solaris box I test on is down at the moment, so I
> can't take a closer look. What is the problem?

Probably:
$ gtar --version
tar (GNU tar) 1.12


If I stop t5000-tar-tree.sh by inserting an exit before the 10th test
(which is the first one that fails):

    t5000-tar-tree.sh:
    ...
    test_expect_success \
       'git get-tar-commit-id' \
       'git get-tar-commit-id <b.tar >b.commitid &&
        diff .git/$(git symbolic-ref HEAD) b.commitid'

    exit

    test_expect_success \
       'extract tar archive' \
       '(cd b && "$TAR" xf -) <b.tar'
    ...

and then execute the test commands manually, I get:

$ cd t/trash\ directory
$ cd b
$ gtar xf - < ../b.tar
/apps/bin/gtar: Unknown file type 'g' for pax_global_header, extracted as normal file
/apps/bin/gtar: : Could not create directory: No such file or directory
/apps/bin/gtar: Error exit delayed from previous errors
$ find .
.
./a
./a/a
./a/l1
./a/substfile1
./a/long_path_to_a_file
./a/long_path_to_a_file/long_path_to_a_file
./a/long_path_to_a_file/long_path_to_a_file/long_path_to_a_file
./a/long_path_to_a_file/long_path_to_a_file/long_path_to_a_file/long_path_to_a_file
./a/bin
./a/bin/sh
./a/substfile2
./pax_global_header
./file_with_long_path


The native tar returns:
$ tar xf - < ../b.tar
tar: directory checksum error

-brandon
