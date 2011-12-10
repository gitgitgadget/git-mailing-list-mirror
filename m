From: Jesse Keating <jkeating@redhat.com>
Subject: Bug in filter-branch example for moving into a subdirectory
Date: Fri, 9 Dec 2011 16:07:49 -0800
Message-ID: <BD3976C6-7F37-40EF-9FB1-CF55828A807D@redhat.com>
Mime-Version: 1.0 (Apple Message framework v1251.1)
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 10 01:07:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RZATr-0004Ow-Mq
	for gcvg-git-2@lo.gmane.org; Sat, 10 Dec 2011 01:07:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754952Ab1LJAHv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 9 Dec 2011 19:07:51 -0500
Received: from mx1.redhat.com ([209.132.183.28]:25460 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752541Ab1LJAHv convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 9 Dec 2011 19:07:51 -0500
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id pBA07o2D029995
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <git@vger.kernel.org>; Fri, 9 Dec 2011 19:07:50 -0500
Received: from [10.3.229.212] (vpn-229-212.phx2.redhat.com [10.3.229.212])
	by int-mx09.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id pBA07nNC031488
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO)
	for <git@vger.kernel.org>; Fri, 9 Dec 2011 19:07:50 -0500
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.22
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186714>

I ran into a bug with the example in the man page for filter-branch, fo=
r moving everything into a subdir:

           git filter-branch --index-filter \
                   'git ls-files -s | sed "s-\t\"*-&newsubdir/-" |
                           GIT_INDEX_FILE=3D$GIT_INDEX_FILE.new \
                                   git update-index --index-info &&
                    mv "$GIT_INDEX_FILE.new" "$GIT_INDEX_FILE"' HEAD

The problem seems to be when a commit happens that is just a file remov=
al with no added file.  In those cases, git ls-files doesn't output any=
thing.  Trying to throw a -d option in doesn't seem to improve matters.

So the problem is that if a commit is just file removals, this example =
will actually crash.  Unfortunately I don't have a suggested solution a=
t the moment.

--
Jesse Keating
=46edora -- Freedom=B2 is a feature!
identi.ca: http://identi.ca/jkeating
