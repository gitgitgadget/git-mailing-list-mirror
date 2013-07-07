From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 0/2] allow git-svn fetching to work using serf
Date: Sat, 6 Jul 2013 18:37:47 -0700
Message-ID: <20130707013747.GM30132@google.com>
References: <CB53C901-3643-46AE-AA80-CED5E20AC3B7@gmail.com>
 <51D7C47D.5070700@acm.org>
 <20130707002804.GF30132@google.com>
 <1D11122F-5C75-4FAC-80EA-D5DC65902403@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Rothenberger <daveroth@acm.org>, git@vger.kernel.org
To: Kyle McKay <mackyle@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 07 03:38:10 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UvdvW-000827-6O
	for gcvg-git-2@plane.gmane.org; Sun, 07 Jul 2013 03:38:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751200Ab3GGBhv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Jul 2013 21:37:51 -0400
Received: from mail-pa0-f42.google.com ([209.85.220.42]:63404 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751119Ab3GGBhv (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Jul 2013 21:37:51 -0400
Received: by mail-pa0-f42.google.com with SMTP id rl6so3274523pac.15
        for <git@vger.kernel.org>; Sat, 06 Jul 2013 18:37:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=UQms05ZSx7RzNkHXK36sJzEICas9q7/slL8uNqBsrzY=;
        b=C8jMCw+7Mb2FL3hv6WqLBu8tvTvT332ewSwbd3Va838KCxuozic4i3cWd4BLPjTREo
         NzxHN8Ks7HL1ZeFtJLxwQnRLlTm0wGOIK9dOMduED34lnlOR0DmPTyS7cSb6L+M6VSiF
         4o3iuWn1CjLjGoU2mggsUES1uubsM0yflqRCSe563SEsgcxjqi3jkk1AAfjcFRwOUSfB
         U7WSgqeZYSV5TG1MQLbvcckYkbRw5HdQ1OZE2exD/H4p7gHTGxf9swvSkZY8cGXfbe0a
         jM4Bd1gDj5S/+OwLDHQxn+7Tbh3djRmUUkrXSX4+myGoWqshdm5VmVb6ScJsqIsF947J
         IUaQ==
X-Received: by 10.66.5.195 with SMTP id u3mr16781887pau.79.1373161070621;
        Sat, 06 Jul 2013 18:37:50 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id yj2sm14576316pbb.40.2013.07.06.18.37.49
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sat, 06 Jul 2013 18:37:49 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1D11122F-5C75-4FAC-80EA-D5DC65902403@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229714>

Kyle McKay wrote:
> On Jul 6, 2013, at 17:28, Jonathan Nieder wrote:
>> David Rothenberger wrote:
>>> On 7/5/2013 8:41 PM, Kyle McKay wrote:

>>>> Daniel Shahaf has suggested also setting
>>>> "servers:global:http-bulk-updates=on".
>>>
>>> I have a patch that does this, but since turning on bulk updates has
>>> a possible performance penalty, I prefer your approach.
>>
>> I assume that's because http-bulk-updates defeats caching.  If so,
>> makes sense.
>>
>> Please forgive my ignorance: is there a bug filed about ra_serf's
>> misbehavior here?  Is it eventually going to be fixed and this is
>> just a workaround, or is the growth in temp file use something we'd
>> live with permanently?
[...]
>
> Begin forwarded message:
[...]
>> [2] http://subversion.tigris.org/issues/show_bug.cgi?id=2932

Ah, thanks for the context.

It's still not clear to me how we know that ra_serf driving the editor
in a non depth-first manner is the problem here.  Has that explanation
been confirmed somehow?

For example, does the workaround mentioned by danielsh work?  Does
using ra_neon instead of ra_serf avoid trouble as well?  Is there a
simple explanation of why violating the depth-first constraint would
lead to multiple blob (i.e., file, not directory) deltas being opened
in a row without an intervening close?

Jonathan
