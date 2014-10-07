From: "David M. Lloyd" <david.lloyd@redhat.com>
Subject: Apparent bug in git rebase with a merge commit
Date: Tue, 07 Oct 2014 13:30:06 -0500
Message-ID: <5434312E.6040407@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Oct 07 20:30:15 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XbZWY-0002xl-NK
	for gcvg-git-2@plane.gmane.org; Tue, 07 Oct 2014 20:30:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754793AbaJGSaI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Oct 2014 14:30:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50798 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753242AbaJGSaH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Oct 2014 14:30:07 -0400
Received: from int-mx11.intmail.prod.int.phx2.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id s97IU7Nm014918
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
	for <git@vger.kernel.org>; Tue, 7 Oct 2014 14:30:07 -0400
Received: from behemoth.home.flurg.com (ovpn01.gateway.prod.ext.phx2.redhat.com [10.5.9.1])
	by int-mx11.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id s97IU6C2010873
	for <git@vger.kernel.org>; Tue, 7 Oct 2014 14:30:06 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.5.0
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.24
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If you have a git tree and you merge in another, independent git tree so 
that they are the same, using a merge strategy like this:

$ git merge importing/master -s recursive -Xours

And if you later on want to rebase this merge commit on a newer upstream 
for whatever reason, you get something like this:

$ git rebase -s recursive -Xours
First, rewinding head to replay your work on top of it...
fatal: Could not parse object 'ca59931ee67fc01b4db4278600d3d92aece898f4^'
Unknown exit code (128) from command: git-merge-recursive 
ca59931ee67fc01b4db4278600d3d92aece898f4^ -- HEAD 
ca59931ee67fc01b4db4278600d3d92aece898f4

The reason this occurs is that the first commit of the newly-merged-in 
code obviously has no parent, so I guess the search for the common 
ancestor is going to be doomed to fail.

It is possible that I'm misunderstanding the recursive merge strategy; 
however if this were the case I'd still expect a human-readable error 
message explaining my mistake rather than a 128 exit code.

For a workaround I'll just re-create the commit, but I thought I'd 
report this behavior anyway.
-- 
- DML
