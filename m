From: "=?ISO-8859-1?Q?Santi_B=E9jar?=" <santi@agolina.net>
Subject: Slow "git rev-list origin/master --not --all" or "git fetch" slow when downloading nothing
Date: Wed, 5 Nov 2008 10:38:31 +0100
Message-ID: <adf1fd3d0811050138j7b8bbed1nd94a999f55e38d61@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Nov 05 10:40:02 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kxerd-0006ma-FS
	for gcvg-git-2@gmane.org; Wed, 05 Nov 2008 10:39:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754210AbYKEJif (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Nov 2008 04:38:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754198AbYKEJif
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Nov 2008 04:38:35 -0500
Received: from ey-out-2122.google.com ([74.125.78.24]:63510 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754164AbYKEJie (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Nov 2008 04:38:34 -0500
Received: by ey-out-2122.google.com with SMTP id 6so1230927eyi.37
        for <git@vger.kernel.org>; Wed, 05 Nov 2008 01:38:32 -0800 (PST)
Received: by 10.103.222.1 with SMTP id z1mr239601muq.51.1225877911726;
        Wed, 05 Nov 2008 01:38:31 -0800 (PST)
Received: by 10.103.179.20 with HTTP; Wed, 5 Nov 2008 01:38:31 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100151>

Hi *,

  In cold cache "git rev-list origin/master --not --all" is slow
reading many files:

cold cache:
$ /usr/bin/time git rev-list origin/master --not --all
0.03user 0.02system 0:04.57elapsed 1%CPU (0avgtext+0avgdata 0maxresident)k
77848inputs+0outputs (410major+1798minor)pagefaults 0swaps

hot cache:
$ /usr/bin/time git rev-list origin/master --not --all
0.01user 0.00system 0:00.06elapsed 31%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (0major+2207minor)pagefaults 0swaps

I think that, in this particular case (when the arguments are the tips
of some of the branches), this should not read that many files.

Moreover, this is used in "git fetch" (git rev-list --quiet --objects
<list_of_remote_sha1> --not --all) to detect if all the objects are
reachable from the local repository. When nothing has changed in the
remote repository (so refs/<remote>/* has all the remote refs) the
"git fetch" could be almost instantaneous (even in coldcache), but
currently it is not because of the above.

Thanks,
Santi
