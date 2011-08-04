From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [RFC 4/6] git-check-attr: Normalize paths
Date: Thu, 04 Aug 2011 05:32:09 +0200
Message-ID: <4E3A12B9.1010800@alum.mit.edu>
References: <1311849425-9057-1-git-send-email-mhagger@alum.mit.edu> <1311849425-9057-5-git-send-email-mhagger@alum.mit.edu> <7v4o1zg20r.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 04 05:35:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qooid-000164-E2
	for gcvg-git-2@lo.gmane.org; Thu, 04 Aug 2011 05:35:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755745Ab1HDDcP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Aug 2011 23:32:15 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:39451 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754882Ab1HDDcN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Aug 2011 23:32:13 -0400
X-Envelope-From: mhagger@alum.mit.edu
Received: from [192.168.69.133] (p54BEB339.dip.t-dialin.net [84.190.179.57])
	(authenticated bits=0)
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id p743WADa026828
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 4 Aug 2011 05:32:10 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.18) Gecko/20110617 Lightning/1.0b2 Thunderbird/3.1.11
In-Reply-To: <7v4o1zg20r.fsf@alter.siamese.dyndns.org>
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178662>

On 08/02/2011 07:24 PM, Junio C Hamano wrote:
> Michael Haggerty <mhagger@alum.mit.edu> writes:
> 
>> 1. I'm not sure whether it is correct to fix this problem at the level
>>    of git-check-attr, or whether the fix belongs in the API layer.
>>    What is the convention for API functions?  Do they typically take
>>    path names relative to the CWD or relative to the working tree
>>    root, or ...?
> 
> I think passing down "prefix" (i.e. where your $(cwd) was relative to the
> root level of the working tree) and the user-supplied "pathspec" (which
> typically is relative to that original $(cwd)) is the canonical approach.
> The very original git worked only at the root level of the working tree,
> with paths specified relative to the root level of the tree, so many code
> do:
> 
> 	- find out the root of the working tree;
>         - note where the $(cwd) was in "prefix";
>         - chdir to the root of the working tree;
> 	- prepend the "prefix" to user supplied pathspec;
>         - forget all the complexity and work on the whole tree.
> 
> Then the "prefix" gets stripped away from the beginning of the paths when
> reporting.
> 
> Your patch from a cursory look seems to follow that pattern, which is
> good.

Thanks for the explanation.

Yes, my code follows the pattern, except that in this case it is
unnecessary to chdir to the root of the working tree.

All this chdiring is going to be a nightmare for the libification of
git, since the cwd is a program-wide global variable with implicit
side-effects on almost any code that deals with the filesystem.  It is
obviously not permissible for a library to change directories (not even
temporarily, if the library is intended to be used in a multithreaded
application).  But that is a topic for another day.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
