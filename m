From: Fabien <fabien.ubuntu@gmail.com>
Subject: Is git over http (git-http-push) ready for production ?
Date: Fri, 19 Feb 2010 11:26:16 +0100
Message-ID: <hllp07$o78$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 19 11:27:11 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NiQ4b-0007jK-8E
	for gcvg-git-2@lo.gmane.org; Fri, 19 Feb 2010 11:27:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753324Ab0BSK04 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Feb 2010 05:26:56 -0500
Received: from lo.gmane.org ([80.91.229.12]:48169 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752196Ab0BSK0z (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Feb 2010 05:26:55 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1NiQ4M-0007VO-KN
	for git@vger.kernel.org; Fri, 19 Feb 2010 11:26:46 +0100
Received: from lamppc10.epfl.ch ([128.178.154.12])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 19 Feb 2010 11:26:46 +0100
Received: from fabien.ubuntu by lamppc10.epfl.ch with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 19 Feb 2010 11:26:46 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: lamppc10.epfl.ch
User-Agent: Thunderbird 1.5.0.14ubu (X11/20090319)
X-Enigmail-Version: 0.94.0.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140440>

Hi,

Following my last email about locks problem with reiserfs (see
git-http-push (git v1.5) problems with DAVLockDB on reiserfs FS), I was
wondering how reliable is git-http-push.

I was able to reproduce the same problem, also with client 1.6.6.2, when
interrupting the command in the middle.

$ git push origin master
Fetching remote heads...
  refs/
  refs/tags/
  refs/heads/
updating 'refs/heads/master'
  from a0f6d85d90a52a28628f29765eb61de559c1fd31
  to   952622ca0f55e76d810a5dc7a1dd1c8c44f8a7d7
Removing remote locks...

=> interrupted by Ctrl+C

$ git push origin master
Fetching remote heads...
  refs/
  refs/tags/
  refs/heads/
updating 'refs/heads/master'
  from a0f6d85d90a52a28628f29765eb61de559c1fd31
  to   952622ca0f55e76d810a5dc7a1dd1c8c44f8a7d7
Unable to lock remote branch refs/heads/master
Updating remote server info
fatal: git-http-push failed


I had to delete the davlock file and restart apache to solve the issue.
So, this operation doesn't seem really atomic ?

Another problem I see is the password in clear text in ~/.netrc to avoid
  to type passwords all the time.
Is there any plan to address this problem ? There used to be the same
case in subversion (yep, sorry for the comparison), and they finally
addressed that by supporting GNOME Keyring and KWallet.
For what I saw, http support is provided thru libcurl, so it may not be
that easy.

Finally, hooks don't work when using git over http (yep, I know, it's a
"dumb" protocol)...

Sorry for blaming you and thanks a lot for your help :)

--
Fabien
