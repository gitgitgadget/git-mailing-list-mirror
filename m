From: Tim Harper <timcharper@gmail.com>
Subject: Re: using rev-list to tell if a branch is behind or ahead
Date: Tue, 20 May 2008 14:33:57 -0600
Message-ID: <19466E30-0877-4AE9-BA1D-A8A32C8989C5@gmail.com>
References: <F3CD27F7-D509-41A3-B3C8-0B9124537DDA@gmail.com>
Mime-Version: 1.0 (Apple Message framework v919.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 20 22:35:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JyYXw-0006rl-BS
	for gcvg-git-2@gmane.org; Tue, 20 May 2008 22:34:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760133AbYETUeF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 May 2008 16:34:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758608AbYETUeF
	(ORCPT <rfc822;git-outgoing>); Tue, 20 May 2008 16:34:05 -0400
Received: from rn-out-0910.google.com ([64.233.170.188]:2660 "EHLO
	rn-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757624AbYETUeD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 May 2008 16:34:03 -0400
Received: by rn-out-0910.google.com with SMTP id k40so182512rnd.17
        for <git@vger.kernel.org>; Tue, 20 May 2008 13:34:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:from:to:content-type:content-transfer-encoding:mime-version:subject:date:references:x-mailer;
        bh=QYzPiRtm8EY6xIrnC8kgkUBe68sovAA5yWi07XtNUPU=;
        b=PN7SDn5jeyNgRSZFp7gDsx7qHUxwEjV9StCOegGJBezbqcQry2jSXzvdh2LDsJS3L4IvjMQnDvHi+DtQCVh1rg5vzTokTogmQHRcdOkXl6WEtgimF8upbPEG/gDKtf6VfiO7dK9+V2p7YATz6TSYTdConumaJI0RyeGSq+0DM7U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:from:to:content-type:content-transfer-encoding:mime-version:subject:date:references:x-mailer;
        b=RUWa2RrYZsgjvNY438haLjnJ7PXH/oeqlkT/vFG36ftbdOnDJwqObeScfH5KZgsnK8nnnmbZwcbDUx6bMHXyzfnmyf+EWOhjdYgsSrh6Y8TEAF7RBgOKwn5lRJ1z717Llcm3EcofTMHyCJZJQQXZ+XhqkM0Fs425vPQX6R95lv4=
Received: by 10.142.128.6 with SMTP id a6mr3187957wfd.68.1211315641712;
        Tue, 20 May 2008 13:34:01 -0700 (PDT)
Received: from timcharper.SME ( [168.103.178.89])
        by mx.google.com with ESMTPS id 20sm1026599wfi.11.2008.05.20.13.33.59
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 20 May 2008 13:34:00 -0700 (PDT)
X-Mailer: Apple Mail (2.919.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82501>

On May 20, 2008, at 2:24 PM, Shawn O. Pearce wrote:
> Tim Harper <timcharper@gmail.com> wrote:
>> I'm implementing a ruby interface to git and am wanting to be able to
>> ask if a branch is ahead or behind.
>>
>> I looked in the builtin-checkout.c file and see this code:
>>
>> /* Run "rev-list --left-right ours...theirs" internally... */
> ...
>> It looks like it's calling rev-parse.  But, when I call it with the
>> same arguments (using branches or commit sha1's), it only will list
>> commits that are in right and not in left.  I need it to show both
>> ways: commits that are in the right and not in left, and commits that
>> are in the left but not in right.
>>
>> Do I need to call rev-parse twice to achieve this?
>
> No.  You need to use the triple dot operator ("...") not the
> double dot operator ("..").
>

Ugh... figured it was something simple.  Funny thing is, when I was  
looking at the c code:
strcpy(symmetric, sha1_to_hex(ours->object.sha1));
strcpy(symmetric + 40, "...");
strcpy(symmetric + 43, sha1_to_hex(theirs->object.sha1));

I was like "I wonder why the 3rd line is +43, and not +42".



>> Here's a sample of what I'm trying currently:
>> ~ $ mkdir test
>> ~ $ cd test/
>> ~/test $ git init
>> Initialized empty Git repository in .git/
>> ~/test $ git
>> ~/test $ echo content > file.txt
>> ~/test $ git add file.txt && git commit -m "Initial commit"
>> Created initial commit f5e4160: Initial commit
>> 1 files changed, 1 insertions(+), 0 deletions(-)
>> create mode 100644 file.txt
>> ~/test master$ git co -b task
>> Switched to a new branch "task"
>> ~/test task$ echo changes >> file.txt
>> ~/test task$ git add file.txt && git commit -m "Some changes"
>> Created commit 96492ee: Some changes
>> 1 files changed, 1 insertions(+), 0 deletions(-)
>> ~/test task$ git rev-list --left-right task..master --
>
> You need an extra "." between task and master, this should be:
>
> git rev-list --left-right task...master --
>
>> ~/test task$ git rev-list --left-right master..task --
>>> 96492ee80143f43417b00699ff29330d0027df7f
>
> -- 
> Shawn.

That did it, thanks

Tim
