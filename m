From: Victor Leschuk <vleschuk@accesssoftek.com>
Subject: RE: [PATCH v4] Add git-grep threads param
Date: Mon, 9 Nov 2015 10:32:32 -0800
Message-ID: <6AE1604EE3EC5F4296C096518C6B77EE5D0FDABA19@mail.accesssoftek.com>
References: <1445980944-24000-1-git-send-email-vleschuk@accesssoftek.com>
	<xmqqvb9jc81q.fsf@gitster.mtv.corp.google.com>
	<20151104064021.GB16605@sigill.intra.peff.net>
	<6AE1604EE3EC5F4296C096518C6B77EE5D0FDABA15@mail.accesssoftek.com>
	<20151109155538.GC27224@sigill.intra.peff.net>
	<6AE1604EE3EC5F4296C096518C6B77EE5D0FDABA17@mail.accesssoftek.com>
	<20151109165343.GA29179@sigill.intra.peff.net>
	<6AE1604EE3EC5F4296C096518C6B77EE5D0FDABA18@mail.accesssoftek.com>,<CA+55aFzHic5AN05QkbERFszRC=i3aDDGy9yhXEjgzZjwzFVBLQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Victor Leschuk <vleschuk@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	"john@keeping.me.uk" <john@keeping.me.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Mon Nov 09 19:32:41 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZvrF9-0006K2-N1
	for gcvg-git-2@plane.gmane.org; Mon, 09 Nov 2015 19:32:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752099AbbKIScf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Nov 2015 13:32:35 -0500
Received: from mail.accesssoftek.com ([12.202.173.171]:37944 "EHLO
	mail.accesssoftek.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751970AbbKIScf convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 9 Nov 2015 13:32:35 -0500
Received: from mail.accesssoftek.com ([172.16.0.71]) by mail.accesssoftek.com
 ([172.16.0.71]) with mapi; Mon, 9 Nov 2015 10:32:32 -0800
Thread-Topic: [PATCH v4] Add git-grep threads param
Thread-Index: AdEbGKrmfKcA0UFUTAiUAWl9cZcnywAAxq6a
In-Reply-To: <CA+55aFzHic5AN05QkbERFszRC=i3aDDGy9yhXEjgzZjwzFVBLQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
acceptlanguage: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281074>

On Mon, Nov 9, 2015 at 9:28 AM, Victor Leschuk
<vleschuk@accesssoftek.com> wrote:
>
> Maybe use the simplest version (and keep num_numbers == 0 also as flag for all other checks in code like if(num_flags) .... ):
>
> if (list.nr || cached )
>   num_threads = 0; // do not use threads
> else if (num_threads == 0)
>   num_threads = online_cpus() <= 1 ? 0 : GREP_NUM_THREADS_DEFAULT;

> I will say this AGAIN.

> The number of threads is *not* about the number of CPU's. Stop this
craziness. It's wrong.

Actually I have never said the nCPUs played main role in it. The patch is intended to provide user ability to change this threads number according to their needs and to touch as small amount of other code as possible.

> The number of threads is about parallelism. Yes, CPU's is a small part
> of it. But as mentioned earlier, the *big* wins are for slow
> filesystems, NFS in particular. On NFS, even if you have things
> cached, the cache revalidation is going to cause network traffic
> almost every time. Being able to have several of those outstanding is
> a big deal.

> So stop with the "online_cpus()" stuff. And don't base your benchmarks
> purely on the CPU-bound case. Because the CPU-bound case is the case
> that is already generally so good that few people will care all *that*
> deeply.

I have performed a cold-cached FS test (in previous thread to minimize the CPU part in the results) and it showed high correlation between speed and thread_num. Isn't it what you said? Even on systems with small number of cores we can gain profit of multithreading. That's I why I suggest this param to be customizable and not HARDCODED.

We need to create a clear text for the documentation that this number should not based on number of CPU-s only. Currently do not mention anything on it.

--
Victor
