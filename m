From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [BUG] unpack-objects abnormal exit when pushing
Date: Sun, 08 Nov 2009 22:28:01 +0100
Message-ID: <vpq4op4emfy.fsf@bauges.imag.fr>
References: <vpqeio8eou4.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 08 22:31:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N7FMX-0007T8-9g
	for gcvg-git-2@lo.gmane.org; Sun, 08 Nov 2009 22:31:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755372AbZKHVbY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Nov 2009 16:31:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755438AbZKHVbX
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Nov 2009 16:31:23 -0500
Received: from imag.imag.fr ([129.88.30.1]:46997 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755372AbZKHVbU (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Nov 2009 16:31:20 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id nA8LS23Y024735
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Sun, 8 Nov 2009 22:28:02 +0100 (CET)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1N7FIn-0005cf-V8; Sun, 08 Nov 2009 22:28:02 +0100
In-Reply-To: <vpqeio8eou4.fsf@bauges.imag.fr> (Matthieu Moy's message of "Sun\, 08 Nov 2009 21\:36\:19 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.1.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Sun, 08 Nov 2009 22:28:02 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132419>

Hi,

Sorry, I forgot to set the subject before sending. The bug report
still holds:

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> Hi,
>
> I'm hitting a bug when git-push-ing to a Linux PPC machine. In
> general, pushing works well, but pushing some particular commits
> breaks reproducibly with :
>
> fatal: early EOF
> error: unpack failed: unpack-objects abnormal exit
> To ssh://localhost//home/perms/moy/prive/dest
>  ! [remote rejected] master -> master (n/a (unpacker error))
>
> I've put the guilty files on my website and wrote a reproduction
> script:
>
> #!/bin/sh
>
> rm -fr source dest
> git init source
> git init --bare dest
> dest=$PWD/dest
> cd source
> echo foo > bar.txt
> git add .
> git commit -m init
> git push ssh://localhost/$dest master
> wget 'http://www-verimag.imag.fr/~moy/tmp/git-bug/Conception Manual.docx'
> wget 'http://www-verimag.imag.fr/~moy/tmp/git-bug/Extreme Programming.doc'
> git add .
> git commit -m "bug"
> git push ssh://localhost/$dest master
>
> The full output is attached (the error message for the last push is
> given above). The machine on which I get this (let's call it "A")
> says :
>
> $ ssh -Version
> OpenSSH_4.3p2, OpenSSL 0.9.8e-fips-rhel5 01 Jul 2008
> $ uname -a
> Linux A 2.6.18-128.7.1.el5 #1 SMP Wed Aug 19 04:08:13 EDT 2009 ppc64 ppc64 ppc64 GNU/Linux
> $ cat /etc/redhat-release                                                                                                                                           
> Red Hat Enterprise Linux Server release 5.4 (Tikanga)
> (it's a 32-bit distribution although the machine is 64bits)
> $ git --version
> git version 1.6.5.2
> (compiled myself, "make test" passes)
>
> According to my experiments, the problem is on the receiver side. If I
> do the same as above, with source/ and dest/ directories on two
> different machines, then if source/ in on A and dest/ anywhere else,
> it works, and if dest/ is on machine A, I get the same error.
>
> If I push using "file://" instead of "ssh://", then everything works
> well.
>
> If instead of push-ing, I go to dest/ and do a fetch, then it works
> well too.
>
> Does anyone have any idea on what's going on?
>
> If anyone has a machine similar to mine (ppc64), can he/she run my
> reproduction script and tell me if the bug happens?
>
> Thanks a lot,

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
