From: Bill Lear <rael@zopyra.com>
Subject: Re: git-push through git protocol
Date: Sun, 21 Jan 2007 19:31:44 -0600
Message-ID: <17844.5120.316805.794579@lisa.zopyra.com>
References: <17843.29798.866272.414435@lisa.zopyra.com>
	<ep00nl$mop$1@sea.gmane.org>
	<Pine.LNX.4.64.0701211034490.14248@woody.osdl.org>
	<17843.55730.456139.247155@lisa.zopyra.com>
	<Pine.LNX.4.64.0701211341300.14248@woody.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Jakub Narebski <jnareb@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jan 22 02:32:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H8o2i-0000ca-Lb
	for gcvg-git@gmane.org; Mon, 22 Jan 2007 02:32:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751851AbXAVBcO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 21 Jan 2007 20:32:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751862AbXAVBcO
	(ORCPT <rfc822;git-outgoing>); Sun, 21 Jan 2007 20:32:14 -0500
Received: from mail.zopyra.com ([65.68.225.25]:60164 "EHLO zopyra.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751851AbXAVBcN (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Jan 2007 20:32:13 -0500
Received: (from rael@localhost)
	by zopyra.com (8.11.6/8.11.6) id l0M1W3Q16041;
	Sun, 21 Jan 2007 19:32:03 -0600
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0701211341300.14248@woody.osdl.org>
X-Mailer: VM 7.18 under Emacs 21.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37378>

On Sunday, January 21, 2007 at 14:00:16 (-0800) Linus Torvalds writes:
>On Sun, 21 Jan 2007, Bill Lear wrote:
>> I did the steenking testing and it appears to fail.
>
>Ok, I did the test too. It does _appear_ to fail, where the keyword is 
>actually the "appear". 

I applied the patches and I get failure.  I have appended the entire
test case after my sig.  The last part reads:

% git push
updating 'refs/heads/master'
  from fee4efae4f3b98cce0fe85efc746291157fffbcd
  to   e1179a3bf842ddcf4643740a396b46ce7ebd4ada
Generating pack...
Done counting 5 objects.
Result has 3 objects.
Deltifying 3 objects.
 100% (3/3) done
Writing 3 objects.
 100% (3/3) done
Total 3 (delta 0), reused 0 (delta 0)
unpack unpacker exited with error code
ng refs/heads/master n/a (unpacker error)

This is on a Centos 4.3 system, under bash.  I am pushing to a git
server running on my local host.


Bill

% cat /etc/xinet.d/git-daemon
service git
{
        disable         = no
        type            = UNLISTED
        port            = 9418
        socket_type     = stream
        wait            = no
        user            = nobody
        server          = /opt/git-1.5.0-rc2/bin/git-daemon
        server_args     = --enable=receive-pack --verbose --syslog --inetd --export-all --base-path=/repos/git
        log_on_failure  += USERID
}
% mkdir /repos/git/foo
% cd /repos/git/foo
% git --bare init-db --shared
Initialized empty shared Git repository in /home/repos/git/foo/
% mkdir ~/foo
% cd ~/foo
% git init-db
% echo foo > foo
% git add foo
% git commit -a -m foo
% git push /repos/git/foo master
updating 'refs/heads/master'
  from 0000000000000000000000000000000000000000
  to   fee4efae4f3b98cce0fe85efc746291157fffbcd
Generating pack...
Done counting 3 objects.
Deltifying 3 objects.
 100% (3/3) done
Writing 3 objects.
 100% (3/3) done
Total 3 (delta 0), reused 0 (delta 0)
Unpacking 3 objects
 100% (3/3) done
refs/heads/master: 0000000000000000000000000000000000000000 -> fee4efae4f3b98cce0fe85efc746291157fffbcd
% cd ~/
% rm -rf foo
% git clone git://localhost/foo
Initialized empty Git repository in /home/blear/foo/.git/
remote: Generating pack...
remote: Done counting 3 objects.
remote: Deltifying 3 objects.
remote: /3) done/3) done
remote: Total 3 (delta 0), reused 0 (delta 0)
Indexing 3 objects.
 100% (3/3) done
% cd foo
% echo bar >> foo
% git commit -a -m bar
Created commit e1179a3bf842ddcf4643740a396b46ce7ebd4ada
 1 files changed, 1 insertions(+), 0 deletions(-)
% git push
updating 'refs/heads/master'
  from fee4efae4f3b98cce0fe85efc746291157fffbcd
  to   e1179a3bf842ddcf4643740a396b46ce7ebd4ada
Generating pack...
Done counting 5 objects.
Result has 3 objects.
Deltifying 3 objects.
 100% (3/3) done
Writing 3 objects.
 100% (3/3) done
Total 3 (delta 0), reused 0 (delta 0)
unpack unpacker exited with error code
ng refs/heads/master n/a (unpacker error)
