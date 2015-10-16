From: Jerry Snitselaar <jsnitsel@redhat.com>
Subject: git tag --contains now takes a long time
Date: Fri, 16 Oct 2015 15:07:39 -0700
Message-ID: <20151016220739.GF17700@cantor.redhat.com>
Reply-To: Jerry Snitselaar <jsnitsel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 17 00:07:47 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZnDA9-00058o-6h
	for gcvg-git-2@plane.gmane.org; Sat, 17 Oct 2015 00:07:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751815AbbJPWHk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Oct 2015 18:07:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60125 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751201AbbJPWHk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Oct 2015 18:07:40 -0400
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	by mx1.redhat.com (Postfix) with ESMTPS id 098B571
	for <git@vger.kernel.org>; Fri, 16 Oct 2015 22:07:40 +0000 (UTC)
Received: from localhost (ovpn-113-81.phx2.redhat.com [10.3.113.81])
	by int-mx09.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id t9GM7dds023368
	for <git@vger.kernel.org>; Fri, 16 Oct 2015 18:07:39 -0400
Content-Disposition: inline
User-Agent: Mutt/1.5.23.1 (2014-03-12)
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.22
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279773>

Is this known and being looked into? I've seen a jump from 12 seconds
to over 9 minutes with running git tag --contains on my kernel repo.


snits ~/dev/linux> git --version
git version 2.6.1.145.gb27dacc

snits ~/dev/linux> time git tag --contains 825fcfc
next-20151012
next-20151013
v4.3-rc5

real	9m4.765s
user	8m56.157s
sys	0m2.450s



snits ~/dev/linux> git --version
git version 2.5.0.275.gac4cc86

snits ~/dev/linux> time git tag --contains 825fcfc
next-20151012
next-20151013
v4.3-rc5

real	0m12.842s
user	0m11.536s
sys	0m1.098s



b7cc53e92c806b73e14b03f60c17b7c29e52b4a4 is the first bad commit
commit b7cc53e92c806b73e14b03f60c17b7c29e52b4a4
Author: Karthik Nayak <karthik.188@gmail.com>
Date:   Fri Sep 11 20:36:16 2015 +0530

    tag.c: use 'ref-filter' APIs

    Make 'tag.c' use 'ref-filter' APIs for iterating through refs, sorting
    and printing of refs. This removes most of the code used in 'tag.c'
    replacing it with calls to the 'ref-filter' library.

    Make 'tag.c' use the 'filter_refs()' function provided by 'ref-filter'
    to filter out tags based on the options set.

    For printing tags we use 'show_ref_array_item()' function provided by
    'ref-filter'.

    We improve the sorting option provided by 'tag.c' by using the sorting
    options provided by 'ref-filter'. This causes the test 'invalid sort
    parameter on command line' in t7004 to fail, as 'ref-filter' throws an
    error for all sorting fields which are incorrect. The test is changed
    to reflect the same.

    Modify documentation for the same.

    Mentored-by: Christian Couder <christian.couder@gmail.com>
    Mentored-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
    Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
    Signed-off-by: Junio C Hamano <gitster@pobox.com>
