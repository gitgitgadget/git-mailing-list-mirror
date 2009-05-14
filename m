From: Cory Sharp <cory.sharp@gmail.com>
Subject: Re: [Q] merge squash unexpected conflicts
Date: Wed, 13 May 2009 19:42:36 -0700
Message-ID: <bb9d69200905131942t7a43a29fh9638d2548e9f12dc@mail.gmail.com>
References: <bb9d69200905131706m61b0dda1xc347ca2e719ec142@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 14 04:42:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M4QuE-0005r7-GR
	for gcvg-git-2@gmane.org; Thu, 14 May 2009 04:42:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754750AbZENCmh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 13 May 2009 22:42:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754717AbZENCmh
	(ORCPT <rfc822;git-outgoing>); Wed, 13 May 2009 22:42:37 -0400
Received: from an-out-0708.google.com ([209.85.132.249]:41124 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754236AbZENCmg convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 13 May 2009 22:42:36 -0400
Received: by an-out-0708.google.com with SMTP id d40so1933332and.1
        for <git@vger.kernel.org>; Wed, 13 May 2009 19:42:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=p1zf2Zb1c/NW/RjFUdV3tXlLDZ/0CqPMOj3g4g4sdxc=;
        b=OBPk6VN4YnGr3na8idYB6Hk0wvJdQICpJB9imOTZiV308YLKPuGykXq4rhZGXvPZsG
         BgTWGdmDBUHd+f/fq80nDg7fj0fF0vobunBKxbcFgFDPUV6WqVgWI4mHObek4I/Orbxo
         iUucGyiAY42ZMx+s26Ona7NWfypOb6U8A/TNE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        b=KobkQrbUXn+r6NWYeVVlF9vEwxotjE8aeB9PclYKjFdlMbMjJdu+BLBQCZDI3rAAsV
         JUMRt0CIU4kOkJKbB2EnUtgEk3mxIur7uftus7ek69DKiudzJkTiQ5kvAJncHYhayCSY
         HI8Mxg++cPV9eWOqR7Vl/hpuxsgw4h9/Unun4=
Received: by 10.100.46.4 with SMTP id t4mr2382094ant.80.1242268956882; Wed, 13 
	May 2009 19:42:36 -0700 (PDT)
In-Reply-To: <bb9d69200905131706m61b0dda1xc347ca2e719ec142@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119125>

Using git 1.6.3.1, when using "git merge --squash" I get unexpected
conflicts when merging an update to a file that was added after the
original branch point, like this

=A0 * Initialize git repo
=A0 * Add hello to master
=A0 * Create topic branch
=A0 * Add goodbye to master
=A0 * Merge squash master into topic, gets new goodbye
=A0 * Update goodbye in master
=A0 * Again merge squash master into topic, update goodbye

The second merge squash produces a conflict in goodbye.

Am I doing something a little wrong or unexpected?=A0 Is there a way
around this squash conflict behavior?=A0 This doesn't seem to happen
with plain merge without squash.  I've appended a small bash script to
show this behavior - run it from an empty directory.

Thanks,
Cory


#!/bin/sh

try() {
=A0=A0=A0 echo "$@"
=A0=A0=A0 "$@" || exit 1
}

note() {
=A0=A0=A0 echo
=A0=A0=A0 echo "##" "$@" "##"
}

[ -d .git ] && echo .git already exists, aborting. && exit 1

note "Initialize git repo"
try git init

note "Add hello to master"
echo "hello world" > hello.txt
try git add hello.txt
try git commit -m "Added hello"

note "Create topic branch"
try git checkout -b topic

note "Add goodbye to master"
try git checkout master
echo "farewell world" > goodbye.txt
try git add goodbye.txt
try git commit -m "Added goodbye"

note "Merge master into topic, gets new goodbye"
try git checkout topic
try git merge --squash master
try git commit -m "Merged master"

note "Update goodbye in master"
try git checkout master
echo "goodbye world" > goodbye.txt
try git add goodbye.txt
try git commit -m "Updated goodbye"

note "Again merge master into topic, update goodbye"
try git checkout topic
try git merge --squash master
