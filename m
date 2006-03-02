From: Junio C Hamano <junkio@cox.net>
Subject: Re: git-annotate dies when a patch is missing trailing newline
Date: Wed, 01 Mar 2006 18:07:33 -0800
Message-ID: <7vwtfdd2fu.fsf@assigned-by-dhcp.cox.net>
References: <46a038f90603011653l7956d5dat99d88a7da98d21b6@mail.gmail.com>
	<20060302015303.GA27871@mythryan2.michonline.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 02 03:07:46 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FEdEA-0005gW-ON
	for gcvg-git@gmane.org; Thu, 02 Mar 2006 03:07:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751383AbWCBCHg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 1 Mar 2006 21:07:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751385AbWCBCHf
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Mar 2006 21:07:35 -0500
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:58784 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S1751383AbWCBCHf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Mar 2006 21:07:35 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060302020454.XHII17006.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 1 Mar 2006 21:04:54 -0500
To: Ryan Anderson <ryan@michonline.com>
In-Reply-To: <20060302015303.GA27871@mythryan2.michonline.com> (Ryan
	Anderson's message of "Wed, 1 Mar 2006 20:53:04 -0500")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17040>

Ryan Anderson <ryan@michonline.com> writes:

>> git-annotate is dying when a patch is missing trailing newline. There
>> _are_ valid situations where code files are not expected to have
>> trailing newlines. Just thing of that glorious programming language,
>> PHP.
>
> Can you point me at a tree that has this problem?  I'll see what I can
> do about fixing it tonight.

$ cat script
#!/bin/sh

mkdir test-dir || exit
cd test-dir
git init-db
echo 'A quick brown fox jumps over the' >file
echo 'lazy dog' | tr -d '\012' >>file
git add file
git commit -a -m 'Initial.'
echo 'A quick brown fox
jumps over the' >file
echo 'lazy dog' | tr -d '\012' >>file
git commit -a -m 'Second.'

git annotate file
$ rm -fr test-dir
$ sh script
defaulting to local storage area
Committing initial tree 2850f9a320885b57bb410baffe972b19b17e9270
Use of uninitialized value in string ne at /home/junio/bin/Linux/git-annotate line 308, <$kid> line 10.
Use of uninitialized value in sprintf at /home/junio/bin/Linux/git-annotate line 309, <$kid> line 10.
Line 3 (3) does not match:
| No newline at end of file
|
1e698bcc5b142b542bf99a1a6f17864bc709dbf5 => 780bca516444e94219d4158b7fea97e763dcee6e
$ echo $?
9
$ exit
