From: javier.martinc@alumnos.unican.es
Subject: git push does not work properly on git over http server
Date: Tue, 10 Feb 2009 10:19:51 +0100
Message-ID: <20090210101951.2v9ltl1rqqskoc44@correo.alumnos.unican.es>
Mime-Version: 1.0
Content-Type: text/plain;
	charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 10 10:49:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LWpEy-0002xY-AD
	for gcvg-git-2@gmane.org; Tue, 10 Feb 2009 10:49:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753141AbZBJJrs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Feb 2009 04:47:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752947AbZBJJrs
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Feb 2009 04:47:48 -0500
Received: from ccserver2.unican.es ([130.206.5.101]:50677 "EHLO
	ccserver2.unican.es" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752722AbZBJJrq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Feb 2009 04:47:46 -0500
X-Greylist: delayed 1670 seconds by postgrey-1.27 at vger.kernel.org; Tue, 10 Feb 2009 04:47:45 EST
Received: from ccserver2.unican.es (ccserver2.unican.es [127.0.0.1])
	by ccserver2.unican.es (Postfix) with ESMTP id 7188A182490
	for <git@vger.kernel.org>; Tue, 10 Feb 2009 10:19:48 +0100 (CET)
Received: from ccserver25.unican.es (ccserver25.unican.es [130.206.5.220])by
	 ccserver2.unican.es (Postfix) with ESMTP id 66501182407for 
	<git@vger.kernel.org>; Tue, 10 Feb 2009 10:19:48 +0100 (CET)
Received: from correo.alumnos.unican.es (localhost.localdomain 
	[127.0.0.1])by ccserver25.unican.es (Postfix) with ESMTP id 61763B00A3for 
	<git@vger.kernel.org>; Tue, 10 Feb 2009 10:19:51 +0100 (CET)
Received: from localhost (localhost.localdomain [127.0.0.1])by 
	correo.alumnos.unican.es (Postfix) with ESMTP id 53CD0B009Cfor 
	<git@vger.kernel.org>; Tue, 10 Feb 2009 10:19:51 +0100 (CET)
Received: from 
	86.red-83-57-3.dynamicip.rima-tde.net(86.red-83-57-3.dynamicip.rima-tde.net
	 [83.57.3.86]) bycorreo.alumnos.unican.es (Horde MIME library) with HTTP 
	for<uc25709@correo.alumnos.unican.es>; Tue, 10 Feb 2009 10:19:51 +0100
Content-Disposition: inline
User-Agent: Internet Messaging Program (IMP) H3 (4.0.3)
X-imss-version: 2.053
X-imss-result: Passed
X-imss-scanInfo: M:P L:E SM:0
X-imss-tmaseResult: TT:0 TS:0.0000 TC:00 TRN:0 TV:5.5.1026(16454.006)
X-imss-scores: Clean:25.82164 C:2 M:3 S:5 R:5
X-imss-settings: Baseline:1 C:1 M:2 S:2 R:2 (0.0000 0.0000)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109191>

Hi,
we have set up a git server over http in our office following this
documentation:
http://www.kernel.org/pub/software/scm/git/docs/howto/setup-git-server-over-http.txt

I have made git clone locally in another PC:
git clone http://git.vsilicon.net/linux-2.6.22.y.git/

And have started developing and creating a new branch with several commits:

git checkout -b visstrim v2.6.22


Then I would like to push my new branch to the remote server:
git push --all origin
Fetching remote heads...
  refs/
  refs/tags/
  refs/heads/
'refs/heads/visstrim': up-to-date
'refs/heads/master': up-to-date

But then I do:
git branch -r
  origin/HEAD
  origin/master

And new branch hasn't gone remote.

I have tested curl succesfully and dav with cadaver and everything goes fine, I
can read/write/lock without problems.

If I check apache log in LEO I can find that command "git push --all origin"
only does GET http commands:

192.168.1.40 - - [10/Feb/2009:10:14:34 +0100] "PROPFIND /linux-2.6.22.y.git/
HTTP/1.1" 207 563 "-" "git/1.5.4.3"
192.168.1.40 - - [10/Feb/2009:10:14:35 +0100] "HEAD
/linux-2.6.22.y.git/info/refs HTTP/1.1" 200 - "-" "git/1.5.4.3"
192.168.1.40 - - [10/Feb/2009:10:14:35 +0100] "HEAD
/linux-2.6.22.y.git/objects/info/packs HTTP/1.1" 200 - "-" "git/1.5.4.3"
192.168.1.40 - javier [10/Feb/2009:10:14:35 +0100] "MKCOL
/linux-2.6.22.y.git/info HTTP/1.1" 301 337 "-" "git/1.5.4.3"
192.168.1.40 - javier [10/Feb/2009:10:14:35 +0100] "MKCOL
/linux-2.6.22.y.git/info/ HTTP/1.1" 405 328 "-" "git/1.5.4.3"
192.168.1.40 - javier [10/Feb/2009:10:14:35 +0100] "LOCK
/linux-2.6.22.y.git/info/refs HTTP/1.1" 200 481 "-" "git/1.5.4.3"
192.168.1.40 - - [10/Feb/2009:10:14:35 +0100] "GET
/linux-2.6.22.y.git/objects/info/packs HTTP/1.1" 200 54 "-" "git/1.5.4.3"
192.168.1.40 - - [10/Feb/2009:10:14:35 +0100] "HEAD
/linux-2.6.22.y.git/objects/pack/pack-344b10aeb57893911de8879e3e279847726e3151.pack
HTTP/1.1" 200 - "-" "git/1.5.4.3"
192.168.1.40 - - [10/Feb/2009:10:14:35 +0100] "PROPFIND
/linux-2.6.22.y.git/refs/ HTTP/1.1" 207 2599 "-" "git/1.5.4.3"
192.168.1.40 - - [10/Feb/2009:10:14:36 +0100] "PROPFIND
/linux-2.6.22.y.git/refs/tags/ HTTP/1.1" 207 85930 "-" "git/1.5.4.3"
192.168.1.40 - - [10/Feb/2009:10:14:36 +0100] "GET
/linux-2.6.22.y.git//refs/tags/v2.6.22.18 HTTP/1.1" 200 41 "-" "git/1.5.4.3"
..............................................................................................................................
192.168.1.40 - - [10/Feb/2009:10:14:46 +0100] "GET
/linux-2.6.22.y.git//refs/tags/v2.6.17 HTTP/1.1" 200 41 "-" "git/1.5.4.3"
192.168.1.40 - - [10/Feb/2009:10:14:46 +0100] "PROPFIND
/linux-2.6.22.y.git/refs/heads/ HTTP/1.1" 207 2600 "-" "git/1.5.4.3"
192.168.1.40 - - [10/Feb/2009:10:14:47 +0100] "GET
/linux-2.6.22.y.git//refs/heads/visstrim HTTP/1.1" 200 41 "-" "git/1.5.4.3"
192.168.1.40 - - [10/Feb/2009:10:14:47 +0100] "GET
/linux-2.6.22.y.git//refs/heads/master HTTP/1.1" 200 41 "-" "git/1.5.4.3"
192.168.1.40 - javier [10/Feb/2009:10:14:47 +0100] "UNLOCK
/linux-2.6.22.y.git/info/refs HTTP/1.1" 204 - "-" "git/1.5.4.3"

Shouldn't it show PUT commands since git push is supposed to upload data to
remote server?

Any idea? I have been looking for this problem through the net for several days
with no success.
