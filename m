From: Stefano Lattarini <stefano.lattarini@gmail.com>
Subject: Re: master: t5800-remote-helpers.sh hangs on test "pulling from remote
 remote"
Date: Sun, 15 Apr 2012 02:00:22 +0200
Message-ID: <4F8A0F96.5060408@gmail.com>
References: <4F893CD8.5020700@gmail.com> <20120414201446.GB29999@ecki>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Clemens Buchacher <drizzd@aon.at>
X-From: git-owner@vger.kernel.org Sun Apr 15 02:01:09 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SJCtv-0003av-5R
	for gcvg-git-2@plane.gmane.org; Sun, 15 Apr 2012 02:01:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756652Ab2DOAA5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Apr 2012 20:00:57 -0400
Received: from mail-wg0-f44.google.com ([74.125.82.44]:62852 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754925Ab2DOAA1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Apr 2012 20:00:27 -0400
Received: by wgbdr13 with SMTP id dr13so4091170wgb.1
        for <git@vger.kernel.org>; Sat, 14 Apr 2012 17:00:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:mime-version:to:cc:subject:references
         :in-reply-to:content-type:content-transfer-encoding;
        bh=lDOMR1QlZYU4CjQJw1JePEeL0VymimwMOJ2FynkzI9o=;
        b=T02vj9ClLIJ4Gg63HH6gKqw4nI1gTOqf7V4X87J720O80hgFMxaV3swsMGAiyb288A
         B1+r5Y1KZdWOtlUYA1uAp4Id2FIbfZijO8qB+Baz1HSP4+rQFmG30QIpWvW60G8IkbXF
         06b+2JuANRvlLtzS1aYXU8uKRaV4XIPvZnmQw+ZR+aV3XAYUJMubkWqoDQKayQGnoUhi
         88k29uCqohlQBuW9aOq0tlJKO5CVkS8ZS/9/SM/h3UecrCLeEUjJqobMW9tZ2tzRukij
         b33I4aG+Skv04uhQk2aDLIbi7McM9Ptg7slIcS39oh0tcauPpGYtszH8Ulqoz61hWJQQ
         F0Tw==
Received: by 10.180.78.164 with SMTP id c4mr2620777wix.10.1334448026381;
        Sat, 14 Apr 2012 17:00:26 -0700 (PDT)
Received: from [87.0.103.166] (host166-103-dynamic.0-87-r.retail.telecomitalia.it. [87.0.103.166])
        by mx.google.com with ESMTPS id fl2sm13019420wib.2.2012.04.14.17.00.24
        (version=SSLv3 cipher=OTHER);
        Sat, 14 Apr 2012 17:00:25 -0700 (PDT)
In-Reply-To: <20120414201446.GB29999@ecki>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195537>

On 04/14/2012 10:14 PM, Clemens Buchacher wrote:
> On Sat, Apr 14, 2012 at 11:01:12AM +0200, Stefano Lattarini wrote:
>>
>> The test 't5800-remote-helpers.sh' hangs on my Linux desktop (where I have
>> installed a custom simple-minded firewall based on iptables).  This does
>> not happen on remote systems I use for testing, so I guess the problem
>> lies with my machine.
> 
> I don't think this particular test is related to networking. Could you
> please run the test again with the following change and paste the
> output? (You cannot set the variables on the command line, because
> test-lib.sh would unset them.)
> 
> diff --git a/t/t5800-remote-helpers.sh b/t/t5800-remote-helpers.sh
> index 1c62001..4cebd63 100755
> --- a/t/t5800-remote-helpers.sh
> +++ b/t/t5800-remote-helpers.sh
> @@ -68,7 +68,7 @@ test_expect_success 'pushing to local repo' '
>  	(cd localclone &&
>  	echo content >>file &&
>  	git commit -a -m three &&
> -	git push) &&
> +	GIT_TRANSPORT_HELPER_DEBUG=1 GIT_DEBUG_TESTGIT=1 git push) &&
>  	compare_refs localclone HEAD server HEAD
>  '
>  
Here it goes:

-*-*-

$ ./t5800-remote-helpers.sh -v

Initialized empty Git repository in /devel/stefano/src/git/t/trash directory.t5800-remote-helpers/.git/
expecting success:
        git init --bare server/.git &&
        git clone server public &&
        (cd public &&
         echo content >file &&
         git add file &&
         git commit -m one &&
         git push origin master)

Initialized empty Git repository in /devel/stefano/src/git/t/trash directory.t5800-remote-helpers/server/.git/
Cloning into 'public'...
warning: You appear to have cloned an empty repository.
done.
[master (root-commit) c1c95c0] one
 Author: A U Thor <author@example.com>
 1 file changed, 1 insertion(+)
 create mode 100644 file
Counting objects: 3, done.
Unpacking objects: 100% (3/3), done.
Writing objects: 100% (3/3), 219 bytes, done.
Total 3 (delta 0), reused 0 (delta 0)
To /devel/stefano/src/git/t/trash directory.t5800-remote-helpers/server
 * [new branch]      master -> master
ok 1 - setup repository

expecting success:
        git clone "testgit::${PWD}/server" localclone &&
        test_cmp public/file localclone/file

Cloning into 'localclone'...
ok 2 - cloning from local repo

expecting success:
        git clone "testgit::file://${PWD}/server" clone &&
        test_cmp public/file clone/file

Cloning into 'clone'...
ok 3 - cloning from remote repo

expecting success:
        (cd public &&
         echo content >>file &&
         git commit -a -m two &&
         git push)

[master df9eab7] two
 Author: A U Thor <author@example.com>
 1 file changed, 1 insertion(+)
Counting objects: 5, done.
Unpacking objects: 100% (3/3), done.
Writing objects: 100% (3/3), 250 bytes, done.
Total 3 (delta 0), reused 0 (delta 0)
To /devel/stefano/src/git/t/trash directory.t5800-remote-helpers/server
   c1c95c0..df9eab7  master -> master
ok 4 - create new commit on remote

expecting success:
        (cd localclone && git pull) &&
        test_cmp public/file localclone/file

>From testgit::/devel/stefano/src/git/t/trash directory.t5800-remote-helpers/server
   c1c95c0..df9eab7  master     -> origin/master
Updating c1c95c0..df9eab7
Fast-forward
 file |    1 +
 1 file changed, 1 insertion(+)
ok 5 - pulling from local repo

expecting success:
        (cd clone && git pull) &&
        test_cmp public/file clone/file

>From testgit::file:///devel/stefano/src/git/t/trash directory.t5800-remote-helpers/server
   c1c95c0..df9eab7  master     -> origin/master
Updating c1c95c0..df9eab7
Fast-forward
 file |    1 +
 1 file changed, 1 insertion(+)
ok 6 - pulling from remote remote

expecting success:
        (cd localclone &&
        echo content >>file &&
        git commit -a -m three &&
        GIT_TRANSPORT_HELPER_DEBUG=1 GIT_DEBUG_TESTGIT=1 git push) &&
        compare_refs localclone HEAD server HEAD

[master 4dcddca] three
 Author: A U Thor <author@example.com>
 1 file changed, 1 insertion(+)
Debug: Remote helper: -> capabilities
Debug: Remote helper: Waiting...
prefix: 'refs/testgit/origin/'
Got arguments ['origin', '/devel/stefano/src/git/t/trash directory.t5800-remote-helpers/server']
Got command 'capabilities' with args ''
Debug: Remote helper: <- import
Debug: Got cap import
Debug: Remote helper: Waiting...
Debug: Remote helper: <- export
Debug: Got cap export
Debug: Remote helper: Waiting...
Debug: Remote helper: <- refspec refs/heads/*:refs/testgit/origin/*
Debug: Got cap refspec refs/heads/*:refs/testgit/origin/*
Debug: Remote helper: Waiting...
Debug: Remote helper: <- *export-marks .git/info/fast-import/c6c0871f9a7f12cd3f51aa290fbed7c49f539a8c/testgit.marks
Debug: Got cap export-marks .git/info/fast-import/c6c0871f9a7f12cd3f51aa290fbed7c49f539a8c/testgit.marks
Debug: Remote helper: Waiting...
Debug: Remote helper: <- *import-marks .git/info/fast-import/c6c0871f9a7f12cd3f51aa290fbed7c49f539a8c/testgit.marks
Debug: Got cap import-marks .git/info/fast-import/c6c0871f9a7f12cd3f51aa290fbed7c49f539a8c/testgit.marks
Debug: Remote helper: Waiting...
Debug: Remote helper: <-
Debug: Capabilities complete.
Debug: Remote helper: Waiting...
Got command 'list' with args ''
? refs/heads/master
@refs/heads/master HEAD
Debug: Remote helper: <- ? refs/heads/master
Debug: Remote helper: Waiting...
Debug: Remote helper: <- @refs/heads/master HEAD
Debug: Remote helper: Waiting...
Debug: Remote helper: <-
Debug: Read ref listing.
Debug: Remote helper: -> export
Got command 'export' with args ''
Debug: Remote helper: Waiting...

-*-*-

The test hangs at this point.

Thanks,
  Stefano
