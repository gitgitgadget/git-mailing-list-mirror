From: Kristian Amlie <kristian.amlie@trolltech.com>
Subject: Re: How to find the first commit belonging to any branch
Date: Tue, 22 Jul 2008 13:18:09 +0200
Message-ID: <4885C1F1.7060907@trolltech.com>
References: <4885A39F.5080209@trolltech.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII";
	format="flowed"
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jul 22 13:19:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLFtg-0002f6-Ku
	for gcvg-git-2@gmane.org; Tue, 22 Jul 2008 13:19:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751189AbYGVLSN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Jul 2008 07:18:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751277AbYGVLSN
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Jul 2008 07:18:13 -0400
Received: from hoat.troll.no ([62.70.27.150]:33935 "EHLO hoat.troll.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750899AbYGVLSM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Jul 2008 07:18:12 -0400
Received: from hoat.troll.no (tedur.troll.no [62.70.27.154])
	by hoat.troll.no (Postfix) with SMTP id 84CE620B06
	for <git@vger.kernel.org>; Tue, 22 Jul 2008 13:18:07 +0200 (CEST)
Received: from sx01.troll.no (sx01.troll.no [62.70.27.21])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by hoat.troll.no (Postfix) with ESMTP id 7D8F220A6B
	for <git@vger.kernel.org>; Tue, 22 Jul 2008 13:18:07 +0200 (CEST)
Received: from sx01.troll.no (localhost.localdomain [127.0.0.1])
	by sx01.troll.no (8.13.8/8.13.8) with ESMTP id m6MBI767020709
	for <git@vger.kernel.org>; Tue, 22 Jul 2008 13:18:07 +0200
Received: from [10.3.5.25] (axis.troll.no [10.3.5.25])
    by sx01.troll.no (Scalix SMTP Relay 11.3.0.11339)
    via ESMTP; Tue, 22 Jul 2008 13:18:07 +0200 (CEST)
In-Reply-To: <7vej5mmfp9.fsf@gitster.siamese.dyndns.org>
References: <7vej5mmfp9.fsf@gitster.siamese.dyndns.org>
x-scalix-Hops: 1
User-Agent: Thunderbird 2.0.0.14 (X11/20080519)
X-Enigmail-Version: 0.95.6
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89485>

Junio C Hamano wrote:
> Kristian Amlie <kristian.amlie@trolltech.com> writes:
> 
>> I have a question about git: I have one commit sha1, and I would like
>> to know the nearest commit that appears in *any* other branch. The
>> sha1 that I have does not belong to any branch.
>>
>> The obvious thing to do would be to make a for loop and iterate over
>> existing branches while calling git merge-base, but I'm wondering if
>> there's a more clever method.
> 
> If the $commit does not belong to any branch, then:
> 
>     $ git rev-list --bounardy $commit^0 --not --branches | sed -ne 's/^-//p'
> 
> would give you boundary commits of the above traversal, which says:
> 
>     Traverse from $commit following the parents, but stop at anything that
>     is reachable from any breanch.
> 
> which means that the ones that are output are the candidates that are on
> some branch.
> 
> So pipe that to name-rev like this, perhaps (untested)?
> 
>     $ git rev-list --bounardy $commit^0 --not --branches |
>       sed -ne 's/^-//p' |
>       git name-rev --stdin
> 
> 

Thanks! That did the trick!

Kristian
