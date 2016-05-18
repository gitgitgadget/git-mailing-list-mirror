From: Eric Wong <e@80x24.org>
Subject: Re: [RFD PATCH 0/3] Free all the memory!
Date: Wed, 18 May 2016 07:23:29 +0000
Message-ID: <20160518072329.GA1723@dcvr.yhbt.net>
References: <20160517032247.25092-1-sbeller@google.com>
 <CAPig+cT9UKEcNXvsQsFDrQycKwMJR5bCter76UL-zpkncniPBw@mail.gmail.com>
 <CAGZ79kaJoAxqtsTuErQSgJiVeD_vdZ1MQXKr-LTtyro-FbscTQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	David Turner <dturner@twopensource.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Git List <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Wed May 18 09:23:35 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b2vpO-0003Zu-Jx
	for gcvg-git-2@plane.gmane.org; Wed, 18 May 2016 09:23:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752211AbcERHXa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 May 2016 03:23:30 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:38972 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752042AbcERHXa (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 May 2016 03:23:30 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6B8821FA7C;
	Wed, 18 May 2016 07:23:29 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <CAGZ79kaJoAxqtsTuErQSgJiVeD_vdZ1MQXKr-LTtyro-FbscTQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294937>

Stefan Beller <sbeller@google.com> wrote:
> Eric Wong writes:
> > I haven't checked for git, but I suspect we get speedups by not
> > calling free().  I've never needed to profile git, but free() at
> > exit has been a measurable bottleneck in other projects I've
> > worked on.  Often, free() was more expensive than *alloc().
> 
> Thanks for reiterating that original response I got back then :)

Heh, I suspected I missed some of the original discussion.

> > #ifdef FREE_ALL_MEMORY
> > static inline void optional_free(void *ptr) {}
> > #else
> > #  define FREE_ALL_MEMORY (0)
> > #  define optional_free(ptr) free(ptr)
> > #endif
> 
> Shouldn't that be "#ifndef" instead? I really like the
> "optional_free", I'll keep it in mind!

Yes, I got my conditionals backwards.  That's what I get
for being awake way past my bedtime :x

We may also want to find a way to annotate *alloc calls as
"lifetime" so they can pair with optional_free.
Maybe sparse can help with that?
