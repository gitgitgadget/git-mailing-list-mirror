From: Shawn Pearce <spearce@spearce.org>
Subject: shallow clone not very shallow due to tags
Date: Sun, 14 Aug 2011 16:58:24 -0700
Message-ID: <CAJo=hJuyZMj+qwFr_=stbQtGh2SCCpjfsBxm+2wbfJK=i_VTdw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Aug 15 01:58:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qska0-0001v3-Kx
	for gcvg-git-2@lo.gmane.org; Mon, 15 Aug 2011 01:58:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751492Ab1HNX6r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Aug 2011 19:58:47 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:57672 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751231Ab1HNX6q (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Aug 2011 19:58:46 -0400
Received: by bke11 with SMTP id 11so2689396bke.19
        for <git@vger.kernel.org>; Sun, 14 Aug 2011 16:58:44 -0700 (PDT)
Received: by 10.204.173.2 with SMTP id n2mr765251bkz.11.1313366324192; Sun, 14
 Aug 2011 16:58:44 -0700 (PDT)
Received: by 10.204.116.207 with HTTP; Sun, 14 Aug 2011 16:58:24 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179353>

$ git clone --depth 1 git://repo.or.cz/alt-git.git tmp_cgit_5
Cloning into tmp_cgit_5...
remote: Counting objects: 20234, done.
remote: Compressing objects: 100% (9454/9454), done.
remote: Total 20234 (delta 16355), reused 13587 (delta 10421)
Receiving objects: 100% (20234/20234), 9.15 MiB | 1.17 MiB/s, done.
Resolving deltas: 100% (16355/16355), done.

$ cd tmp_cgit_5
$ git tag -l | grep 0.99
v0.99

Uhm. That is not a very shallow clone. The clone copied 20234 objects
at 9.15 MiB... so its ~20 MiB lighter than a full clone. But nearly
all of the tags exist, because the clone client is declaring want
lines for them, making the server generate up to 1 commit back from
the wanted tag. I know shallow support is the feature nobody wants to
think about, but this just seems broken to me. Clients performing a
shallow clone shouldn't be asking for tags... but they should be using
the include-tag protocol option so that if they do happen to receive a
tagged commit, the tag object will also be sent.

-- 
Shawn.
