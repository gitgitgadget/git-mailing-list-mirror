From: Santi <sbejar@gmail.com>
Subject: Merge with local conflicts in new files
Date: Wed, 17 May 2006 00:00:10 +0200
Message-ID: <8aa486160605161500m1dd8428cj@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Wed May 17 00:00:31 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fg7aS-0002hZ-M6
	for gcvg-git@gmane.org; Wed, 17 May 2006 00:00:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750770AbWEPWAN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 16 May 2006 18:00:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750905AbWEPWAN
	(ORCPT <rfc822;git-outgoing>); Tue, 16 May 2006 18:00:13 -0400
Received: from wx-out-0102.google.com ([66.249.82.192]:13134 "EHLO
	wx-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1750893AbWEPWAM convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 16 May 2006 18:00:12 -0400
Received: by wx-out-0102.google.com with SMTP id s6so59090wxc
        for <git@vger.kernel.org>; Tue, 16 May 2006 15:00:11 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=LGqfJFO7CgLhkJ+5AO7ymqpxS0+0Lmtgp7uZMF4Ka63how+rGFM0gzrL3iMYwXxTYshI2QhvFRODYfVZ8GGRP9sQGXk9APMwt7EBiA3HAi6I4BnlZaddczPSwpLlDGjiiVEnHg82gDP/Wg1EeH6JPZkpxtk3YoCMQ3yBxfPvsrw=
Received: by 10.70.133.7 with SMTP id g7mr290361wxd;
        Tue, 16 May 2006 15:00:10 -0700 (PDT)
Received: by 10.70.20.2 with HTTP; Tue, 16 May 2006 15:00:10 -0700 (PDT)
To: git@vger.kernel.org, "Junio C Hamano" <junkio@cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20138>

Hi *,

       In the case of:

- You merge from a branch with new files
- You have these files in the working directory
- You do not have these files in the HEAD.

   The end result is that you lose the content of these files.

   So an additional check for the merge is to check for these dirty
but not in HEAD files.

   Here is a test that reproduce it. I expect the merge to fail and
with the content of foo being bar.

test_description='Test merge with local conflicts in new files'
. ./test-lib.sh

test_expect_success 'prepare repository' \
'echo "Hello" > init &&
git add init &&
git commit -m "Initial commit" &&
git branch B &&
echo "foo" > foo &&
git add foo &&
git commit -m "File: foo" &&
git checkout B &&
echo "bar" > foo '

test_expect_code 1 'Merge with local conflicts in new files' 'git
merge "merge msg" B master'

test_done

Thanks.
