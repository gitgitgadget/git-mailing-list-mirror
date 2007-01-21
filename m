From: Bill Lear <rael@zopyra.com>
Subject: Re: git-push through git protocol
Date: Sun, 21 Jan 2007 15:22:58 -0600
Message-ID: <17843.55730.456139.247155@lisa.zopyra.com>
References: <17843.29798.866272.414435@lisa.zopyra.com>
	<ep00nl$mop$1@sea.gmane.org>
	<Pine.LNX.4.64.0701211034490.14248@woody.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Jakub Narebski <jnareb@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jan 21 22:23:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H8k9t-0006SX-PV
	for gcvg-git@gmane.org; Sun, 21 Jan 2007 22:23:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751652AbXAUVXX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 21 Jan 2007 16:23:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751653AbXAUVXW
	(ORCPT <rfc822;git-outgoing>); Sun, 21 Jan 2007 16:23:22 -0500
Received: from mail.zopyra.com ([65.68.225.25]:61669 "EHLO zopyra.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751652AbXAUVXW (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Jan 2007 16:23:22 -0500
Received: (from rael@localhost)
	by zopyra.com (8.11.6/8.11.6) id l0LLNEG24295;
	Sun, 21 Jan 2007 15:23:14 -0600
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0701211034490.14248@woody.osdl.org>
X-Mailer: VM 7.18 under Emacs 21.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37344>

I did the steenking testing and it appears to fail.  This is with
1.4.4.1 (applied the patch by hand to daemon.c, rebuilt and installed
on my local workstation).  I get this (clone worked fine) on my test
repo:

% git push git://localhost/fongo
updating 'refs/heads/master'
  from a54b51ffc155737d8ccebd645f0d2036072d669f
  to   c5599ebdeae970eaa0163374a6c5d8b216fc390a
fatal: read error (Bad file descriptor)
Generating pack...
Done counting 5 objects.
Result has 3 objects.
Deltifying 3 objects.
 100% (3/3) done
Writing 3 objects.
 100% (3/3) done
fatal: sha1 file '<stdout>' write error (Bad file descriptor)

My /etc/xinet.d/git-daemon looks like this:

service git
{
        disable         = no
        type            = UNLISTED
        port            = 9418
        socket_type     = stream
        wait            = no
        user            = nobody
        server          = /usr/bin/git-daemon
        server_args     = --enable=receive-pack --verbose --syslog --inetd --export-all --base-path=/repos/git
        log_on_failure  += USERID
}

Will try to dig into this more if I can...


Bill

On Sunday, January 21, 2007 at 11:04:13 (-0800) Linus Torvalds writes:
>
>
>On Sun, 21 Jan 2007, Jakub Narebski wrote:
>> > 
>> > It seems there should be a way to configure a repo or the git daemon
>> > to say "Allow push operations".
>> > 
>> > I looked through the release notes Junio posted for 1.5.0-rc2, but
>> > found no reference to the git daemon.
>> 
>> git:// protocol is not authenticated. git by design allow push only through
>> authenticated protocols, i.e. local, ssh:// (git+ssh://), http(s):// with
>> WebDAV, probably in the future ftps://. 
>
>Well, it _should_ actually be truly fairly trivial to allow pushing over 
>the git:// protocol, ...
