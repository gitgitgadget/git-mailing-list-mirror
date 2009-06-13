From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v3 0/3] automatically skip away from broken commits
Date: Sat, 13 Jun 2009 12:03:00 -0700
Message-ID: <4A33F7E4.4020201@zytor.com>
References: <20090606043853.4031.78284.chriscool@tuxfamily.org>	 <c07716ae0906101237o5038fc4dle9f11b6f2216652a@mail.gmail.com>	 <7vtz2nlrfs.fsf@alter.siamese.dyndns.org>	 <200906110602.54861.chriscool@tuxfamily.org>	 <4A308B5D.2010704@zytor.com> <4A309083.9090907@zytor.com> <c07716ae0906120456j1a14af52n47c3a3542201aaf@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Christian Couder <chriscool@tuxfamily.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Sam Vilain <sam@vilain.net>, Ingo Molnar <mingo@elte.hu>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 13 21:09:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MFYbt-00035s-L7
	for gcvg-git-2@gmane.org; Sat, 13 Jun 2009 21:09:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753849AbZFMTJj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Jun 2009 15:09:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753546AbZFMTJi
	(ORCPT <rfc822;git-outgoing>); Sat, 13 Jun 2009 15:09:38 -0400
Received: from terminus.zytor.com ([198.137.202.10]:59628 "EHLO
	terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753326AbZFMTJi (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Jun 2009 15:09:38 -0400
Received: from mail.hos.anvin.org (c-98-210-181-100.hsd1.ca.comcast.net [98.210.181.100])
	(authenticated bits=0)
	by terminus.zytor.com (8.14.3/8.14.1) with ESMTP id n5DJ33Tn002185
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 13 Jun 2009 12:03:04 -0700
Received: from tazenda.hos.anvin.org (tazenda.hos.anvin.org [172.27.0.16])
	by mail.hos.anvin.org (8.14.3/8.14.3) with ESMTP id n5DJ33Kj024193;
	Sat, 13 Jun 2009 12:03:03 -0700
Received: from tazenda.hos.anvin.org (localhost.localdomain [127.0.0.1])
	by tazenda.hos.anvin.org (8.14.3/8.13.6) with ESMTP id n5DJ30NB005412;
	Sat, 13 Jun 2009 12:03:00 -0700
User-Agent: Thunderbird 2.0.0.14 (X11/20080501)
In-Reply-To: <c07716ae0906120456j1a14af52n47c3a3542201aaf@mail.gmail.com>
X-Virus-Scanned: ClamAV 0.94.2/9464/Sat Jun 13 00:44:17 2009 on terminus.zytor.com
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121515>

Christian Couder wrote:
> On Thu, Jun 11, 2009 at 7:05 AM, H. Peter Anvin<hpa@zytor.com> wrote:
>> Urk, I managed to get myself completely confused -- I did the series
>> approximation on the wrong side of inverting the function.  The correct
>> power is actually 1.5 (over the range 0 to 1), a value > 1 is necessary
>> to bias the PRNG toward the beginning (x = 0) of the list.
> 
> I started working on this, but I wonder if it's better to add a
> #include <math.h> and link with -lm than to provide a custom sqrt
> implementation. Too bad the best power is not 2.
> 

That's what I would do.  It's not like sqrt() is a strange, unportable
function.

> To implement the PRNG, I guess that using something based on the
> function given by "man 3 rand" should be ok:
> 
> int get_prn(int count) {
>     count = count * 1103515245 + 12345;
>     return((unsigned)(count/65536) % 32768);
> }
> 
> where the "count" we pass is the count of elements in the list rather
> than the static seed.

Yes, or perhaps better we could use some combination of the SHA-1s
involved as seeds... they are rather nice for this as they are wide and
much better PRNGs than most classical algorithms.

The main problem with the above algorithm is that it only produces 16
bits of output, which when biased can turn into a fairly significant
granularity.

	-hpa

-- 
H. Peter Anvin, Intel Open Source Technology Center
I work for Intel.  I don't speak on their behalf.
