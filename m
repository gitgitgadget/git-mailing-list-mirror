From: Michael Schubert <mschub@elegosoft.com>
Subject: Re: Sha1 lookup and GIT_USE_LOOKUP
Date: Fri, 10 Jun 2011 00:51:41 +0200
Message-ID: <4DF14E7D.50809@elegosoft.com>
References: <BANLkTintTECbO5X3VMvzHdGgyKmLKe65YE=0mX6Ahj5wutCJ0Q@mail.gmail.com>	<7v62og2lw1.fsf@alter.siamese.dyndns.org> <BANLkTi=b+WKy2_9VeEw5B0QqodHfVJs2XQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Marc Pegon <pegon.marc@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 10 00:52:14 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QUo5F-0006CB-PB
	for gcvg-git-2@lo.gmane.org; Fri, 10 Jun 2011 00:52:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757064Ab1FIWwJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Jun 2011 18:52:09 -0400
Received: from mx0.elegosoft.com ([78.47.87.163]:39952 "EHLO mx0.elegosoft.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756661Ab1FIWwI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Jun 2011 18:52:08 -0400
Received: from localhost (localhost [127.0.0.1])
	by mx0.elegosoft.com (Postfix) with ESMTP id 0C582DE852;
	Fri, 10 Jun 2011 00:52:07 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at mx0.elegosoft.com
Received: from mx0.elegosoft.com ([127.0.0.1])
	by localhost (mx0.elegosoft.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id DRexTzKumO8e; Fri, 10 Jun 2011 00:52:02 +0200 (CEST)
Received: from [192.168.1.101] (p5B2E5376.dip.t-dialin.net [91.46.83.118])
	by mx0.elegosoft.com (Postfix) with ESMTPSA id 1D2AADE851;
	Fri, 10 Jun 2011 00:52:02 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.17) Gecko/20110601 Thunderbird/3.1.10
In-Reply-To: <BANLkTi=b+WKy2_9VeEw5B0QqodHfVJs2XQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175586>

On 06/09/2011 11:24 AM, Marc Pegon wrote:
> On Wed, Jun 8, 2011 at 8:55 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Marc Pegon <pegon.marc@gmail.com> writes:
>>
>>> Since this environment variable is not set by default, git will always
>>> use a simple binary search, won't it ?
>>
>> Yes.
>>
>>> Also, when searching for a sha1 given a sha1 prefix, among packed
>>> objects, find_short_packed_object also does a simple binary search.
>>> Wouldn't it be simpler to just use the sha1_entry_pos method ?
>>
>> Unknown ;-).
>>
>> The environment variable is there exactly for people like you who are
>> interested in finding out which one yields better performance by
>> benchmarking.  Once we can get a convincing result, we can either
>> deprecate the more involved sha1_entry_pos() if it turns out to be not
>> worth it, or we can always use it if it turns out to be significantly
>> better.
> 
> Perhaps we could compare the two methods by counting for each one the
> average number of iterations it takes to find an object in a pack.
> But anyways, I guess GIT_USE_LOOKUP should also have an influence on
> the method used to find an object given a sha1 prefix, and the code
> that does a simple binary search should not be duplicated as it is
> now, right ?

The commit introducing sha1_entry_pos() comes with some reasoning:

628522

libgit2 dropped "old and boring binary search" some days ago:

dd453c
