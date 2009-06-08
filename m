From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v3 0/3] automatically skip away from broken commits
Date: Mon, 08 Jun 2009 08:51:24 -0700
Message-ID: <4A2D337C.70203@zytor.com>
References: <20090606043853.4031.78284.chriscool@tuxfamily.org>	<7vskidcf9s.fsf@alter.siamese.dyndns.org>	<200906070932.36913.chriscool@tuxfamily.org>	<4A2CAA56.1030707@zytor.com> <7vws7n6vcf.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Christian Couder <chriscool@tuxfamily.org>, git@vger.kernel.org,
	Sam Vilain <sam@vilain.net>, Ingo Molnar <mingo@elte.hu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 08 21:29:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MDkX4-0006At-HP
	for gcvg-git-2@gmane.org; Mon, 08 Jun 2009 21:29:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755670AbZFHT3D (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Jun 2009 15:29:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757283AbZFHT3C
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Jun 2009 15:29:02 -0400
Received: from terminus.zytor.com ([198.137.202.10]:56899 "EHLO
	terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757307AbZFHT3A (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Jun 2009 15:29:00 -0400
Received: from mail.hos.anvin.org (c-98-210-181-100.hsd1.ca.comcast.net [98.210.181.100])
	(authenticated bits=0)
	by terminus.zytor.com (8.14.3/8.14.1) with ESMTP id n58FpRxl005418
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 8 Jun 2009 08:52:38 -0700
Received: from tazenda.hos.anvin.org (tazenda.hos.anvin.org [172.27.0.16])
	by mail.hos.anvin.org (8.14.3/8.14.3) with ESMTP id n58FpQ1C006106;
	Mon, 8 Jun 2009 08:51:26 -0700
Received: from tazenda.hos.anvin.org (localhost.localdomain [127.0.0.1])
	by tazenda.hos.anvin.org (8.14.3/8.13.6) with ESMTP id n58FpOo3007586;
	Mon, 8 Jun 2009 08:51:25 -0700
User-Agent: Thunderbird 2.0.0.14 (X11/20080501)
In-Reply-To: <7vws7n6vcf.fsf@alter.siamese.dyndns.org>
X-Virus-Scanned: ClamAV 0.94.2/9437/Mon Jun  8 06:56:50 2009 on terminus.zytor.com
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121099>

Junio C Hamano wrote:
> "H. Peter Anvin" <hpa@zytor.com> writes:
> 
>> It's not entirely clear to me that this is any better than simply
>> randomly picking a commit from the list of plausible commits -- in other
>> words, eliminate the commits we can totally rule out, and then just pick
>> a random commit among the list of plausible commits.  This is not
>> *quite* as crazy as it sounds; it has the advantage of being an
>> extremely simple algorithm which shouldn't have any pathological behaviours.
> 
> That is essentially what Christian's patch does.  It does not try to go
> away from untestable commits in topological space.  Instead, when we find
> that the commit with the best "goodness" value is known to be untestable,
> we step away from that commit by some alternating distance _in the
> goodness value space_ (which does not have much to do with how commit
> ancestry topology is laid out).  Viewed in the topology space, it is quite
> similar to picking a different commit randomly, except for a very special
> case where the remaining history is completely linear, in which case the
> goodness value space and ancestry topology have a direct correlation.
> 
> That special case, and the deterministic hence repeatable nature of the
> algorithm, are the two main advantages over picking a completely random
> commit among the list of plausible commits.

Well, the cyclic "stepping distance" is pretty much a really lame PRNG
in this case.  In the linear case I think the distances are rather
arbitrary (and suboptimal), and I'm not sure it wouldn't simply be
better to actually use a PRNG (which can be unseeded and therefore
repeateable, or perhaps even better seeded with some combination of the
hash values involved.)

The advantage of that -- and I have to admit I don't know if it will
ever matter in practice -- is that using an actual PRNG:

a) is less likely to get into pathological capture behaviors.
b) doesn't make people think later that there is something magic to the
   arbitrary chosen numbers.

	-hpa

-- 
H. Peter Anvin, Intel Open Source Technology Center
I work for Intel.  I don't speak on their behalf.
