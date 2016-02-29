From: zacr <zacr@slingshot.co.nz>
Subject: Git 2.7.2.windows.1 fails to authenticate access to private
 repository over HTTPS
Date: Mon, 29 Feb 2016 16:24:32 +1300
Message-ID: <0eee43fe410bb5db3dc8eeec2f7ff00c@slingshot.co.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 29 05:08:51 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aaF8c-0007Yo-SW
	for gcvg-git-2@plane.gmane.org; Mon, 29 Feb 2016 05:08:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754954AbcB2EIo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Feb 2016 23:08:44 -0500
Received: from mta5.flip.co.nz ([103.9.40.8]:34518 "EHLO mta5.flip.co.nz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754429AbcB2EIn (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Feb 2016 23:08:43 -0500
X-Greylist: delayed 2648 seconds by postgrey-1.27 at vger.kernel.org; Sun, 28 Feb 2016 23:08:43 EST
Received: from fortimail2.tranzpeer.net (mx238.tranzpeer.net [202.180.66.238])
	by mta5.flip.co.nz (8.14.4/8.14.4) with ESMTP id u1T3OWBm025920
	for <git@vger.kernel.org>; Mon, 29 Feb 2016 16:24:32 +1300
Received: from webmail.slingshot.co.nz (default-rdns.callplus.co.nz [202.189.160.42] (may be forged))
	by fortimail2.tranzpeer.net  with ESMTP id u1T3OWc1012489-u1T3OWc2012489
	for <git@vger.kernel.org>; Mon, 29 Feb 2016 16:24:32 +1300
X-Sender: zacr@slingshot.co.nz
User-Agent: Roundcube Webmail/0.9.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287798>

Hi,

I have recently downloaded 64-bit Git for Windows (the file I downloaded 
was "Git-2.7.2-64-bit.exe"). This reports a version string of "git 
version 2.7.2.windows.1"
Using it from the command line, after cloning a repository, I attempted 
to "git pull" a private repository from GitHub. From prior experience, I 
expected it to ask me for my username and password, then authenticate 
with the server. It asked for my username, which I typed in, but after 
pressing Enter it suddenly failed with an error:

error: failed to execute prompt script (exit code 1)
fatal: could not read Username for 'https://github.com': Invalid 
argument


I experimented a bit, and it only occurs when trying to use HTTPS to 
pull from a repository that requires authentication. Using a personal 
access token to authenticate or using the git protocol both work.

I ran it again with GIT_TRACE=true, and here is the trace (with username 
and repository name removed):

15:55:58.615147 git.c:348               trace: built-in: git 'pull'
15:55:58.617147 run-command.c:343       trace: run_command: 'fetch' 
'--update-head-ok'
15:55:58.633149 git.c:348               trace: built-in: git 'fetch' 
'--update-head-ok'
15:55:58.636149 run-command.c:343       trace: run_command: 
'git-remote-https' 'origin' 'https://github.com/username/repository.git'
15:55:59.630248 run-command.c:343       trace: run_command: 'bash' '-c' 
'cat >/dev/tty && read -r line </dev/tty && echo "$line"'
error: failed to execute prompt script (exit code 1)
fatal: could not read Username for 'https://github.com': Invalid 
argument


It looks like it's trying to run a new bash instance for me to enter my 
password, which fails on Windows because I don't have bash installed.



For reference, here are some old threads I found while researching the 
issue. It looks like this has cropped up before, in Git 1.8.5.
https://groups.google.com/forum/#!msg/msysgit/s4dB8Nv9V4c/55-cGPdPYmAJ
https://github.com/msysgit/msysgit/issues/153
and stackoverflow for good measure (comments by Mr_and_Mrs_D, Ricardo, 
and AndyL identify it as a bug with 1.8.5):
http://stackoverflow.com/questions/20871549/error-when-push-commits-with-github-fatal-could-not-read-username


I would appreciate your help.


Yours sincerely,
Zac Roberts
zacr@slingshot.co.nz
