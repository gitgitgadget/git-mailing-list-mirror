From: Zakaria ElQotbi <zakaria@elqotbi.com>
Subject: subtree merges lose prefix after rebase
Date: Thu, 1 Mar 2012 16:18:14 +0100
Message-ID: <CALtv3HqtdUrRaGWvrwo89r3y1RQ4wy1Bzt5=RhQHaJTXS3gk9A@mail.gmail.com>
References: <CALtv3HphaC7d0QyR1DUowHn0Wrmrsw4YGyU4rE8YzhZX3ea6dA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 01 16:18:24 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S37lt-0008M0-J7
	for gcvg-git-2@plane.gmane.org; Thu, 01 Mar 2012 16:18:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758305Ab2CAPSP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 1 Mar 2012 10:18:15 -0500
Received: from mail-pw0-f46.google.com ([209.85.160.46]:59568 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755476Ab2CAPSO convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 1 Mar 2012 10:18:14 -0500
Received: by pbcup15 with SMTP id up15so995320pbc.19
        for <git@vger.kernel.org>; Thu, 01 Mar 2012 07:18:14 -0800 (PST)
Received-SPF: pass (google.com: domain of zelqotbi@gmail.com designates 10.68.229.104 as permitted sender) client-ip=10.68.229.104;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of zelqotbi@gmail.com designates 10.68.229.104 as permitted sender) smtp.mail=zelqotbi@gmail.com; dkim=pass header.i=zelqotbi@gmail.com
Received: from mr.google.com ([10.68.229.104])
        by 10.68.229.104 with SMTP id sp8mr3903207pbc.8.1330615094625 (num_hops = 1);
        Thu, 01 Mar 2012 07:18:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=b96cjBN0foyq/2S5ZEPWwdXq9YfhGHsPATuk2kk9YQ4=;
        b=GrhDK6P6kubflzJtlv+D5bQX9RkEKq3dC21Y8W7q5jicYeeTBXw4cDSNlISIqM2gYe
         w8QFN1TuXOCC+nj78k0XTSmvdpammsfBlcm6XZcC8knAGN2W9thc8Yvgw3G6MZ/9s8zd
         tMOltYB0pbglYJiHArNVqHsNCJiJrTyzFJCfE=
Received: by 10.68.229.104 with SMTP id sp8mr3339907pbc.8.1330615094595; Thu,
 01 Mar 2012 07:18:14 -0800 (PST)
Received: by 10.68.75.101 with HTTP; Thu, 1 Mar 2012 07:18:14 -0800 (PST)
In-Reply-To: <CALtv3HphaC7d0QyR1DUowHn0Wrmrsw4YGyU4rE8YzhZX3ea6dA@mail.gmail.com>
X-Google-Sender-Auth: 6tBmWW-2qYBKHnerb_hZP4shOaY
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191934>

Hi, folks!
why subtree merges lose prefix after an interactive rebase, is it a kno=
wn
issue ? or I'am missing somethings:

$ for project in a b c ; do
    mkdir $project
    ( cd $project ; git init; touch ${project^} ; git add ${project^}
; git commit -m "add ${project^}" )
   done
$ tree
=2E
|-- a
|=A0=A0 `-- A
|-- b
|=A0=A0 `-- B
`-- c
=A0=A0=A0 `-- C

$ mkdir tree && cd tree && git init
$ touch README && git add README && git commit -m "add readme"
$ for project in a b c ; do
=A0 mkdir -p projects/$project
=A0 git remote add -f $project ../$project
=A0 git merge -s ours --no-commit $project/master
=A0 git read-tree --prefix=3Dprojects/$project -u $project/master
=A0 git commit -m "merge $project into tree"
=A0 git pull -s subtree $project master
 done

$=A0tree
=2E
|-- projects
|=A0=A0 |-- a
|=A0=A0 |=A0=A0 `-- A
|=A0=A0 |-- b
|=A0=A0 |=A0=A0 `-- B
|=A0=A0 `-- c
|=A0=A0=A0=A0=A0=A0 `-- C
`-- README

$ git rebase -i -p a6d4e8e # this the hash of "merge b" commit
$ git commit --amend -m "merge b edit"
$ git rebase --continue
$ tree
=2E
|-- C
|-- projects
|=A0=A0 |-- a
|=A0=A0 |=A0=A0 `-- A
|=A0=A0 `-- b
|=A0=A0=A0=A0=A0=A0 `-- B
`-- README


Best regards
--
Zakaria ElQotbi
4096R/3DC2241A

"The secret of creativity is knowing how to hide your sources."
=A0=A0=A0=A0=A0=A0=A0 - Albert Einstein
