From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 1/5] Documentation/remote-helpers: Rewrite description
Date: Sun, 18 Apr 2010 10:28:57 +0530
Message-ID: <1271566331-sup-9608@kytes>
References: <1271551934-sup-1118@kytes> <20100418022900.GA1669@progeny.tock>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Gabriel Filion <lelutin@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Junio C Hamano <gitster@pobox.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 18 07:01:17 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O3Md8-00063m-8b
	for gcvg-git-2@lo.gmane.org; Sun, 18 Apr 2010 07:01:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751392Ab0DRFBG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Apr 2010 01:01:06 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:38490 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751016Ab0DRFBF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Apr 2010 01:01:05 -0400
Received: by pwj9 with SMTP id 9so2764752pwj.19
        for <git@vger.kernel.org>; Sat, 17 Apr 2010 22:01:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:content-type:cc:subject:from
         :to:in-reply-to:references:date:message-id:user-agent
         :content-transfer-encoding;
        bh=cPbt/PwrCVU6rSIpi/EEfNfcjmPOmC3gRBm1wzfQ4Qg=;
        b=chpiEcN6v74rI0iOF0HWo89En8d6MaPArnjaYTHuIc0o/ihnSuHpMiNT8258H0Tnaj
         RzxLjo5llUW6uSQvCbGm6GRmQqQT3wGmsB+dRcm+U9PbcAVtqZafsHDnrm7bHnv5Tngp
         xKnOD0WSJtvezg8vQWiBGrzaV3cJumSJm3Ajg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=content-type:cc:subject:from:to:in-reply-to:references:date
         :message-id:user-agent:content-transfer-encoding;
        b=SKVCInwcDvx+79MeCpy7hw1DMdO3IlDYIYFLHc+hr+tydevwQZu3XkZ2M2uXdibnir
         5Vgq8G4tACbiYpKugb36CgRh0j54O2/t4TpQyimfx/NS55kEi36YfBE8P3rZhn6naFf4
         n5sa568lzhQmzxFIiRTMMYk+1Ow3yXnuy1bD4=
Received: by 10.115.112.22 with SMTP id p22mr2958101wam.53.1271566864618;
        Sat, 17 Apr 2010 22:01:04 -0700 (PDT)
Received: from localhost ([203.110.240.41])
        by mx.google.com with ESMTPS id 23sm4018103pzk.10.2010.04.17.22.01.01
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 17 Apr 2010 22:01:03 -0700 (PDT)
In-reply-to: <20100418022900.GA1669@progeny.tock>
User-Agent: Sup/git
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145211>

Hi Jonathan,

Since patch has already been reviewed many times, and signed off by
Junio before going into pu, I've tried to minimize changes and prepare
a fixup patch while addressing all your concerns. Do tell me if it's
alright.

diff --git a/Documentation/git-remote-helpers.txt b/Documentation/git-remote-helpers.txt
index 6ffc0da..52332ed 100644
--- a/Documentation/git-remote-helpers.txt
+++ b/Documentation/git-remote-helpers.txt
@@ -12,26 +12,27 @@ SYNOPSIS
 DESCRIPTION
 -----------
 
-Remote helper programs are normally not used directly by end users,
+Remote helper programs are normally not used directly by end users
 but are invoked by git when it needs to interact with remote
 repositories. They implement a subset of the capabilities documented
-here, and conform to the "remote helper protocol". When git needs
+here and conform to the "remote helper protocol". When git needs
 needs to interact with a repository served by a remote helper, it
-spawns the helper as an independent process and interacts with it over
-the specified protocol. git sends commands to the helper
-over standard input, and receives the result written to standard
+spawns the helper as an independent process, sends it commands
+over standard input, and receives the results written to standard
 output by the helper over a pipe. Because a remote helper runs as
 an independent process to interact with remote repositories, there
 is no need to re-link git when adding a new helper nor need to link
 the helper with the implementation of git.
 
-All the capabilities of remote helpers have to do with discovering and
+Every helper must support the "capabilities" command, which lists a
+set of commands corresponding to the capabilities of the helper.
+The capabilities have to do with discovering and
 updating remote refs, transporting objects between local and remote,
-and updating the local object store. Using the 'fetch' capability,
-they can discover refs on the remote, transfer objects from the remote
-reachable via those refs to local, and update the local object
+and updating the local object store. Helpers supporting the 'fetch'
+capability can discover refs on the remote, transfer objects from the
+remote reachable via those refs to local, and update the local object
 store. Using the 'push' capability, they can transfer objects from
-local to remote, and update the corresponding refs as necessary.
+local to remote, and update remote refs.
 
 Git comes with a "curl" family of remote helpers, that handle various
 transport protocols, such as 'git-remote-http', 'git-remote-https',
