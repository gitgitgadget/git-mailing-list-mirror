From: "Kees-Jan Dijkzeul" <k.j.dijkzeul@gmail.com>
Subject: Re: Fwd: git-svn dcommit fail
Date: Thu, 5 Jul 2007 13:06:21 +0200
Message-ID: <fa0b6e200707050406i831816co80ff1500dae6bf54@mail.gmail.com>
References: <4b3406f0707040256x31f0909cie126d950c60374f1@mail.gmail.com>
	 <468C999C.60701@midwinter.com>
	 <fa0b6e200707050126m17a23de6uad4909533306eb06@mail.gmail.com>
	 <fa0b6e200707050128h6bc3caa4rd661c64128ac7367@mail.gmail.com>
	 <7v1wfndyow.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 05 13:06:28 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I6PAI-0004V5-TC
	for gcvg-git@gmane.org; Thu, 05 Jul 2007 13:06:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758874AbXGELGY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 5 Jul 2007 07:06:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758887AbXGELGY
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Jul 2007 07:06:24 -0400
Received: from wr-out-0506.google.com ([64.233.184.235]:28651 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755795AbXGELGX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Jul 2007 07:06:23 -0400
Received: by wr-out-0506.google.com with SMTP id i30so244886wra
        for <git@vger.kernel.org>; Thu, 05 Jul 2007 04:06:22 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=eccGkFwpuEgZzsmLsOs45nkBYq6SKT8M1z/6B9lkyO3kT5km0tTklXUqNe+DgXzIBeKGOHfwabQiYuoZMGe4dl6wyYb0YNMfl6To6wGjRguvmfQp5S1wZVFP+q044EaeYNqVAWT/ROpVyMtkHikyeYYSf5YCB1dfkBsSpBqGt3c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=hH2C9Cl/0jf0jVAKJoAjZACVnfTvt+fN1vcN9wwtS5n+WFEHNxyo9tWEsbu92IK0zhXggBXjXljwWbmDM9S3zb+Tj3uAezb4lOBcO8sAQ88FiJ3eDLIQmw14HL5pzxn0gSgovK49YLDru444jH4Ua3i0cY1WGFPqMjx1tEmmpl4=
Received: by 10.143.161.3 with SMTP id n3mr572296wfo.1183633581679;
        Thu, 05 Jul 2007 04:06:21 -0700 (PDT)
Received: by 10.143.5.9 with HTTP; Thu, 5 Jul 2007 04:06:21 -0700 (PDT)
In-Reply-To: <7v1wfndyow.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51667>

On 7/5/07, Junio C Hamano <gitster@pobox.com> wrote:
> Could you double check?

*Blush*. I should have caught that one myself. I'm now at commit
114fd812f78ea375ee6782d4ff0203f3ae20b076, which still exhibits the
same problem.

Basically, the problem is as follows: My head commit is a merge:
$ git show HEAD
commit e135f26dbae66f539b486646a12aa51e71c196a1
Merge: bb8ac98... f453e1e...

Both parents are svn-commits.

When I do a dry-run, I get
$ git-svn dcommit -n
diff-tree e135f26dbae66f539b486646a12aa51e71c196a1~1
e135f26dbae66f539b486646a12aa51e71c196a1

As far as I'm concerned, this is correct. This is the delta that
should be committed to the svn branch who's head is
e135f26dbae66f539b486646a12aa51e71c196a1~1 (obviously).

However, function "working_head_info" of git-svn returns the other
parent as the working head. As a result, committing the diff to svn
fails.

I've observed that the call to cmt_metadata("$d~1") (line 382 of
git-svn) does return the correct svn branch, so it would seem to me
that it makes much more sense to commit to that.

Any thoughts, tips, tricks?

Thanks!

Kees-Jan
