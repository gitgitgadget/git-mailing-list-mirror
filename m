From: Thomas Pasch <thomas.pasch@jentro.com>
Subject: git-http-push / webDAV
Date: Mon, 01 Oct 2007 15:31:40 +0200
Organization: Jentro Technologies GmbH
Message-ID: <4700F6BC.2070701@jentro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 01 15:38:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IcLTc-0006ui-Ih
	for gcvg-git-2@gmane.org; Mon, 01 Oct 2007 15:38:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751917AbXJANiR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Oct 2007 09:38:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751691AbXJANiQ
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Oct 2007 09:38:16 -0400
Received: from mail2.infra.net ([212.89.96.7]:4193 "EHLO gamma.m.infra.net"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751566AbXJANiP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Oct 2007 09:38:15 -0400
X-Greylist: delayed 391 seconds by postgrey-1.27 at vger.kernel.org; Mon, 01 Oct 2007 09:38:15 EDT
Received: from epsilon.m.infra.net (epsilon.m.infra.net [212.89.96.8])
	by gamma.m.infra.net (8.13.4/8.13.4/Debian-3sarge3) with ESMTP id l91DVgnA007983
	for <git@vger.kernel.org>; Mon, 1 Oct 2007 15:31:42 +0200
Received: from [192.1.1.184] (u19-17.dsl.vianetworks.de [194.231.42.17])
	(authenticated bits=0)
	by epsilon.m.infra.net (8.13.4/8.13.4/Debian-3) with ESMTP id l91DVejh028794
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT)
	for <git@vger.kernel.org>; Mon, 1 Oct 2007 15:31:41 +0200
User-Agent: Thunderbird 2.0.0.6 (X11/20070801)
X-Enigmail-Version: 0.95.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59614>

Hello,

trying to set up a webDAV enabled http push
git server (1.5.3.3) like it is described in

http://www.kernel.org/pub/software/scm/git/docs/howto/setup-git-server-over-http.txt

Tested the apache2 (2.2.6) DAV setup with
cadaver (and tried the browser as well).
With cadaver I could lock files, download
and upload content.

However,

> git push -v upload master
Pushing to http://test@x.x.x.x/git/DepTrack.git/
Fetching remote heads...
  refs/
  refs/heads/
  refs/tags/
updating 'refs/heads/master'
  from 0000000000000000000000000000000000000000
  to   d75dce3fe0e9ec5915feda5574f214bd432ccb14
    sending 89 objects
    done
Updating remote server info
UNLOCK HTTP error 400

Also tried:

> git-http-push --all --verbose http://x.x.x.x/git/DepTrack.git/ master
Getting pack list
Fetching remote heads...
  refs/
  refs/heads/
  refs/tags/
'refs/heads/master': up-to-date

... and then tried to clone:

> git clone http://test@x.x.x.x/git/DepTrack.git
Initialized empty Git repository in /home/tpasch/tmp/tmp/DepTrack/.git/
Getting alternates list for http://test@x.x.x.x/git/DepTrack.git
Getting pack list for http://test@x.x.x.x/git/DepTrack.git
error: Unable to find d75dce3fe0e9ec5915feda5574f214bd432ccb14 under
http://test@x.x.x.x/git/DepTrack.git
Cannot obtain needed object d75dce3fe0e9ec5915feda5574f214bd432ccb14

Finally, tried a *non-empty* repo at the server:

> git clone --bare /home/tpasch/tmp/tmp/trunk DepTrack.git
Initialized empty Git repository in /data/git/DepTrack.git/
22911 blocks
> cd DepTrack.git/
> git --bare update-server-info
> chmod a+x hooks/post-update
> chown -R wwwrun:www /data/git

... cloned:

> git clone http://test@x.x.x.x/git/DepTrack.git
Initialized empty Git repository in /home/tpasch/tmp/tmp/DepTrack/.git/
got d75dce3fe0e9ec5915feda5574f214bd432ccb14
walk d75dce3fe0e9ec5915feda5574f214bd432ccb14
got 8a459da1fb520cbc2534b87d3c0d8539fa010f45
got 31c3b20e1d7d7ca414a273fe80f4c49466250709
walk 31c3b20e1d7d7ca414a273fe80f4c49466250709
got ca647ac42188a8ed859260503abc41f98fd21be6
[...]
got 7e089ccc1819d4e69b228b3359690f685728248b
Checking 66 files out...
 100% (66/66) done

... then modified a file and pushed:

> git add test.txt
> git commit
> git push -v
Pushing to http://test@x.x.x.x/git/DepTrack.git

But this never returns. (Also tried:
> git-http-push --all --verbose http://x.x.x.x/git/DepTrack.git/ master
Getting pack list
Fetching remote heads...
  refs/
  refs/heads/
  refs/tags/
updating 'refs/heads/master'
  from d75dce3fe0e9ec5915feda5574f214bd432ccb14
  to   07002e0423e803096eb07eb5c46651b00ed20725
    sending 3 objects
    done
Updating remote server info
UNLOCK HTTP error 400
)

Any suggestions?

Cheers,

Thomas

PS:
This is how I initialized the repo:

> git --bare init
Initialized empty Git repository in /data/git/DepTrack.git/
> git --bare update-server-info
> chmod a+x hooks/post-update
> chown -R wwwrun:www /data/git
> /etc/init.d/apache2 restart
