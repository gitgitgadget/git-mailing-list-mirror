From: Neil Macneale <mac4-git@theory.org>
Subject: Re: Stashing untracked files
Date: Sat, 29 Sep 2007 20:59:26 -0700
Message-ID: <46FF1F1E.2050000@theory.org>
References: <46FE9924.7080006@theory.org> <Pine.LNX.4.64.0709292201400.28395@racer.site> <EEE8F630-AE62-4425-96A0-239D54724DF4@lrde.epita.fr> <46FEC799.30803@theory.org> <Pine.LNX.4.64.0709292259070.28395@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Sep 30 05:59:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ibpxy-0006pK-GL
	for gcvg-git-2@gmane.org; Sun, 30 Sep 2007 05:59:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753598AbXI3D7b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 Sep 2007 23:59:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753202AbXI3D7b
	(ORCPT <rfc822;git-outgoing>); Sat, 29 Sep 2007 23:59:31 -0400
Received: from bucky.theory.org ([64.147.163.245]:41451 "EHLO bucky.theory.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753475AbXI3D7a (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Sep 2007 23:59:30 -0400
Received: by bucky.theory.org (Postfix, from userid 8000)
	id 2BA1CDB47; Sat, 29 Sep 2007 20:59:30 -0700 (PDT)
X-Spam-Checker-Version: SpamAssassin 3.1.7-deb (2006-10-05) on 
	bucky.theory.org
X-Spam-Level: 
X-Spam-Status: No, score=0.4 required=3.5 tests=AWL,BAYES_00,
	RCVD_IN_NJABL_DUL,RCVD_IN_PBL,RCVD_IN_SORBS_DUL autolearn=no 
	version=3.1.7-deb
Received: from [10.0.1.199] (71-35-171-1.tukw.qwest.net [71.35.171.1])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by bucky.theory.org (Postfix) with ESMTP id B7046DB44;
	Sat, 29 Sep 2007 20:59:27 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <Pine.LNX.4.64.0709292259070.28395@racer.site>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59520>

Johannes Schindelin wrote:
> Hi,
> 
> [please do not cull me from the Cc: list, especially if you quote me.]
> 
> On Sat, 29 Sep 2007, Neil Macneale wrote:
> 
>> Performing an add would require me to remove those file from the index 
>> at a later date in the event that I don't want to commit them on the 
>> next commit.
> 
> Wrong.
> 
> If you "git add <new-file>" and then "git stash", it will no longer have 
> the file in the index.  Instead, the index will agree with the HEAD (which 
> does not have <new-file>).
> 
> Ciao,
> Dscho

To be a little more clear, this is why I'd like to stash untracked files.

$ <hack hack>    # source tree is a mess
$ git stash -u   # stash everything, even untracked files. I never
                  # suggesting modifying the default behavior.
$ <fix bug>
$ git commit -a
$ git stash apply
$ hack some more
$ git add file1 file2  # I'm ready for some things to be committed,
                        # but my source tree is still a mess.
$ git commit

To do what you are suggesting would be something like this (correct me 
if I'm wrong):

$ <hack hack>
$ git add .      # Additional step, not a big deal.
$ git stash
$ <fix bug>
$ git commit -a
$ git stash apply
$ git reset HEAD <all file I don't actually need to add but was forced
                   to add in step above.>
                  # What concerns me is that I may not reset some files
                  # that need to be reset, or reset other ones which
                  # should not be reset. This is the headache I want to
                  # avoid.
$ <hack hack>
$ git add file1 file2
$ git commit

git stash is an acknowledgment that not everything needs to be 
committed, and sometimes working source trees are messy. Prior to the 
stash command, I just accepted that I'd need to commit everything and do 
  some maintenance to un-commit those changes. stash is awesome for me 
and the realities of the way I need to work. IMHO, it would be the best 
thing since sliced bread if it handled untracked files.

If this is really just a problem for me, I can write a shell script to 
do the dirty work. I just wonder if it is a common enough use case that 
it merits support in the tool itself.

Cheers,
Neil
