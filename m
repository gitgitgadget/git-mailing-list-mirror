From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v3 0/3] automatically skip away from broken commits
Date: Sun, 07 Jun 2009 23:06:14 -0700
Message-ID: <4A2CAA56.1030707@zytor.com>
References: <20090606043853.4031.78284.chriscool@tuxfamily.org> <7vskidcf9s.fsf@alter.siamese.dyndns.org> <200906070932.36913.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Sam Vilain <sam@vilain.net>, Ingo Molnar <mingo@elte.hu>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Mon Jun 08 08:06:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MDY0I-000643-Es
	for gcvg-git-2@gmane.org; Mon, 08 Jun 2009 08:06:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751895AbZFHGGc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Jun 2009 02:06:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751804AbZFHGGb
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Jun 2009 02:06:31 -0400
Received: from terminus.zytor.com ([198.137.202.10]:58063 "EHLO
	terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751579AbZFHGGa (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Jun 2009 02:06:30 -0400
Received: from mail.hos.anvin.org (c-98-210-181-100.hsd1.ca.comcast.net [98.210.181.100])
	(authenticated bits=0)
	by terminus.zytor.com (8.14.3/8.14.1) with ESMTP id n5866IFm022258
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 7 Jun 2009 23:06:19 -0700
Received: from tazenda.hos.anvin.org (tazenda.hos.anvin.org [172.27.0.16])
	by mail.hos.anvin.org (8.14.3/8.14.3) with ESMTP id n5866IBv003980;
	Sun, 7 Jun 2009 23:06:18 -0700
Received: from tazenda.hos.anvin.org (localhost.localdomain [127.0.0.1])
	by tazenda.hos.anvin.org (8.14.3/8.13.6) with ESMTP id n5866EII002745;
	Sun, 7 Jun 2009 23:06:15 -0700
User-Agent: Thunderbird 2.0.0.14 (X11/20080501)
In-Reply-To: <200906070932.36913.chriscool@tuxfamily.org>
X-Virus-Scanned: ClamAV 0.94.2/9436/Sun Jun  7 17:21:18 2009 on terminus.zytor.com
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121035>

Christian Couder wrote:
>>
>> I think this shows that the "skip ratio" heuristics based on the distance
>> in the "goodness scale" space does not help in avoiding commits that are
>> close in topological space.  There may be cases where the version with
>> patch gives fewer rounds especially when the history is very linear, but
>> I was mostly interested in the number of commits at least in the
>> thousands, which I think is what we should optimize things for, not a toy
>> history of linear 100 commits.
> 
> I get the same results as yours, and I think that in these tests cases "git 
> bisect" was not stuck with having only untestable commits with the 
> highest "goodness" values. So in these cases the original behavior does 
> quite well and that's why the updated behavior can't do better.
> 

It's not entirely clear to me that this is any better than simply
randomly picking a commit from the list of plausible commits -- in other
words, eliminate the commits we can totally rule out, and then just pick
a random commit among the list of plausible commits.  This is not
*quite* as crazy as it sounds; it has the advantage of being an
extremely simple algorithm which shouldn't have any pathological behaviours.

The average information gain for a randomly picked commit is 1/(2 ln 2)
=~ 0.7213 bits, or an increase in the total bisect time by 39% over a
pure binary search.

	-hpa

-- 
H. Peter Anvin, Intel Open Source Technology Center
I work for Intel.  I don't speak on their behalf.
