From: =?UTF-8?B?TWF0xJtqIENlcGw=?= <mcepl@redhat.com>
Subject: Monotone to git mirroring ... how to do updates
Date: Wed, 16 Nov 2011 11:49:57 +0100
Message-ID: <4EC39555.3060500@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 16 11:48:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RQd2h-0003Oa-M1
	for gcvg-git-2@lo.gmane.org; Wed, 16 Nov 2011 11:48:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755918Ab1KPKsb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 16 Nov 2011 05:48:31 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60003 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755586Ab1KPKsa (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Nov 2011 05:48:30 -0500
Received: from int-mx02.intmail.prod.int.phx2.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id pAGAmUL8009311
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <git@vger.kernel.org>; Wed, 16 Nov 2011 05:48:30 -0500
Received: from mitmanek.ceplovi.cz (ovpn-116-28.ams2.redhat.com [10.36.116.28])
	by int-mx02.intmail.prod.int.phx2.redhat.com (8.13.8/8.13.8) with ESMTP id pAGAmSSn012770
	for <git@vger.kernel.org>; Wed, 16 Nov 2011 05:48:29 -0500
Received: from mitmanek.ceplovi.cz (mitmanek.ceplovi.cz [127.0.0.1])
	by mitmanek.ceplovi.cz (Postfix) with ESMTP id D80C842B52
	for <git@vger.kernel.org>; Wed, 16 Nov 2011 11:49:57 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:8.0) Gecko/20111105 Thunderbird/8.0
X-Scanned-By: MIMEDefang 2.67 on 10.5.11.12
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185537>

Hi,

I am trying to make script to be run from crontab which would=20
periodically mirror pidgin monotone repo to my git one (using=20
https://github.com/felipec/pidgin-git-import).

The main script in this repo is import:

#!/bin/sh

export GIT_DIR=3Dpidgin.git

git init

git_marks=3D"marks-git.txt"
mtn_marks=3D"marks-mtn.txt"

touch $git_marks $mtn_marks

mtn --db pidgin.mtn pull
mtn git_export --db pidgin.mtn --authors-file=3Dauthors_map.txt \
     --branches-file=3Dbranches_map.txt \
     --refs=3Drevs --import-marks=3D$mtn_marks --export-marks=3D$mtn_ma=
rks \
     --use-one-changelog | \
   git fast-import --import-marks=3D$git_marks --export-marks=3D$git_ma=
rks

I can see what this script does on the first run (when creating new git=
=20
repo), but what it does when I try to update with it already existing=20
repo from updated pidgin.mtn database? Where I can see the new changes?=
=20
Probably remote branches should be updated, right? (yes, I don't=20
understand well what actually git fast-import does, that's the problem)=
=2E

Also, if I get eventually new changes to the remote branches on the git=
=20
repo, how can I update (preferably by one command) 140+ branches at=20
once? Or do I have to do something in the tune of?

for remote_branch in $(git branches -r) ; do
    local_branch=3D$(echo $remote_branch |sed -e 's/origin\///')
    git checkout $local_branch
    git merge $remote_branch
done

Thank you in advance for any ideas,

Mat=C4=9Bj
