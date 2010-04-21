From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 0/3] running tests as fakeroot
Date: Wed, 21 Apr 2010 08:12:55 -0500
Message-ID: <20100421131255.GA2750@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Sylvain Rabot <sylvain@abstraction.fr>,
	"Robin H. Johnson" <robbat2@gentoo.org>,
	"Fernando J. Pereda" <ferdy@ferdyx.org>,
	Lea Wiemann <lewiemann@gmail.com>,
	Panagiotis Issaris <takis@issaris.org>,
	Mike Hommey <mh@glandium.org>,
	Marco Nelissen <marcone@xs4all.nl>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 21 15:13:04 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O4Zjh-00034w-87
	for gcvg-git-2@lo.gmane.org; Wed, 21 Apr 2010 15:13:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754079Ab0DUNMz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 21 Apr 2010 09:12:55 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:52849 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753197Ab0DUNMy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Apr 2010 09:12:54 -0400
Received: by pwj9 with SMTP id 9so5043632pwj.19
        for <git@vger.kernel.org>; Wed, 21 Apr 2010 06:12:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:mime-version:content-type:content-disposition
         :content-transfer-encoding:user-agent;
        bh=voaXLkB+T2rr4Niu0/EHcNK5eP6TyEPSLSm7axJATqc=;
        b=Z6Z1SOVJs7dq8zt8mT+LeTByUCVkLwwdOD8K6MphB2XrOWHbGokp+N5RNdB6rXUUiV
         nlu0G+3w5G+UDK2UO/hLtntJ9gSPSjgWzjHAIRshul7UTu3ef+dAJjmHNwY2ywqWjo4j
         +QKz8k+HMjjOcucaa7Kg8DA5YpgEqQHtDrgAQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:mime-version:content-type
         :content-disposition:content-transfer-encoding:user-agent;
        b=jlR3eGeZDo0pSbcEHCrX/pf8wrev6MPbe14+zFMQXBDLWeFlif2RFOlDnrT/kGFot1
         1TPiX4Ux5tQJDusQEmbuk3PX4kz1+0VxIm6ZzsxARMdnCsotVxU7pxknfLCK09hncC9D
         yY4IyNXGnjLV5/TKOcj6IEuyF8GHfBuwQpxfY=
Received: by 10.114.187.29 with SMTP id k29mr7114528waf.208.1271855574125;
        Wed, 21 Apr 2010 06:12:54 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 22sm6595920iwn.8.2010.04.21.06.12.52
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 21 Apr 2010 06:12:53 -0700 (PDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145427>

Hi,

The Debian build system makes it very tempting to build as
fakeroot: basically, one has a choice of

  debian/rules build
  fakeroot debian/rules binary

or just

  fakeroot debian/rules binary

to build a .deb from the current sources.  I hadn=E2=80=99t succumbed
to temptation until today; but now that I have, I want to fix it.
I=E2=80=99ll discuss whether this is a good idea more in patch 3.

Patches 1 and 2 are a bit simpler.  Patch 1 allows tests to have
multiple prerequisites, which seems like a good idea generally;
patch 2 adds a missing POSIXPERM prerequisite to an existing test.

I hope you like the patches.  Sorry for the huge cc list; I did a
quick search to find people interested one way or another, and
aparently there are many.  I am sending patches 1 and 2 only to the
git list to avoid making the problem worse.

Thoughts?
Jonathan Nieder (3):
  test-lib: tests can have multiple prerequisites
  t1004 (read-tree): the unremovable symlink test requires POSIXPERM
  Permit tests to be run as a (fake) root user

 t/t1004-read-tree-m-u-wf.sh |    2 +-
 t/test-lib.sh               |   22 ++++++++++++++--------
 2 files changed, 15 insertions(+), 9 deletions(-)
