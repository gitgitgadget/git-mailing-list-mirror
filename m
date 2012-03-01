From: Tom Grennan <tmgrennan@gmail.com>
Subject: Re: [PATCH-w 101/105] t6300 (for-each-ref): modernize style
Date: Wed, 29 Feb 2012 21:10:10 -0800
Message-ID: <20120301051010.GE2572@tgrennan-laptop>
References: <1330566326-26075-1-git-send-email-tmgrennan@gmail.com>
 <1330566326-26075-7-git-send-email-tmgrennan@gmail.com>
 <7v62epqd9a.fsf@alter.siamese.dyndns.org>
 <20120301032053.GD2572@tgrennan-laptop>
 <7vty29ovcd.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Carlos Rica <jasampler@gmail.com>,
	Andy Parkins <andyparkins@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Amos Waterland <apw@rossby.metr.ou.edu>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 01 06:10:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S2yI0-0001tz-G0
	for gcvg-git-2@plane.gmane.org; Thu, 01 Mar 2012 06:10:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751200Ab2CAFKg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Mar 2012 00:10:36 -0500
Received: from mail-vx0-f174.google.com ([209.85.220.174]:36967 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750772Ab2CAFKQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Mar 2012 00:10:16 -0500
Received: by mail-vx0-f174.google.com with SMTP id p1so180394vcq.19
        for <git@vger.kernel.org>; Wed, 29 Feb 2012 21:10:16 -0800 (PST)
Received-SPF: pass (google.com: domain of tmgrennan@gmail.com designates 10.52.28.167 as permitted sender) client-ip=10.52.28.167;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of tmgrennan@gmail.com designates 10.52.28.167 as permitted sender) smtp.mail=tmgrennan@gmail.com; dkim=pass header.i=tmgrennan@gmail.com
Received: from mr.google.com ([10.52.28.167])
        by 10.52.28.167 with SMTP id c7mr5110479vdh.96.1330578616367 (num_hops = 1);
        Wed, 29 Feb 2012 21:10:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=KdDNdD6Mwu48CclmvUHb7GHPFlEKK79Eq7Ln2V6GDSk=;
        b=WDM+KHC1FapuJ7w+iIO3JtgxxLomeKzZlhB9u3kGIuT69Q96+1h5nD7bU4JTLhJLYB
         lptOE89cL6Y85sqkGQKBw+qAsoX9HoVdyWdMXkAVsSQeKLTaakM9alAUtodR/pdmltN7
         QUhnucyMb/5nrG4WXL3vINMkdKYSwrORnbuyQ=
Received: by 10.52.28.167 with SMTP id c7mr4336146vdh.96.1330578616134;
        Wed, 29 Feb 2012 21:10:16 -0800 (PST)
Received: from localhost (c-98-207-169-74.hsd1.ca.comcast.net. [98.207.169.74])
        by mx.google.com with ESMTPS id fd10sm1367205vdc.1.2012.02.29.21.10.12
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 29 Feb 2012 21:10:15 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <7vty29ovcd.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191893>

On Wed, Feb 29, 2012 at 07:26:10PM -0800, Junio C Hamano wrote:
>Tom Grennan <tmgrennan@gmail.com> writes:
>
>> It's trivial to remove these "quiet" and "silent", but to me that's the
>> only value added by these patches.  More seriously, the remaining
>> modernization still seems much larger than its value.
>
>Don't do that, then ;-).
>
>Some older scripts do redirect the output from the commands to /dev/null
>but that dates back before we made the default reasonably silent, and in
>"modern" style we tend to keep them sent to their standard output to help
>debuggability. These quiet/silent takes us to the prehistoric times.

Hey! I am prehistoric:-)

Like I said, I think there is currently a debug distraction with verbose
mode.  However, rather than hiding expected failures and diverting other
output as I had, perhaps we should dup stderr to stdout in verbose mode
so error messages show up near the logged invocation when piped through
a pager (i.e. mimic "|&").  With this, one can quickly scan past the
noise to focus on the broken cases.

  exec 5>&1
  exec 6<&0
  if test "$verbose" = "t"
  then
- 	exec 4>&2 3>&1
+ 	exec 4>&1 3>&1
  else
  	exec 4>/dev/null 3>/dev/null
  fi

For example, try this w/ and w/o the above change.
	(cd t && ./t5512-ls-remote.sh) | less

I still think git-branch and git-tag should have a -q option; better
yet, the wrapper itself (i.e. git --quiet/--silent XXX).

-- 
TomG
