From: Stephen Boyd <bebarino@gmail.com>
Subject: Re: [PATCH 1/2] parse-options: Add support for dumping out long options
Date: Thu, 12 Apr 2012 00:42:50 -0700
Message-ID: <4F86877A.9020703@gmail.com>
References: <1334140165-24958-1-git-send-email-bebarino@gmail.com> <1334140165-24958-2-git-send-email-bebarino@gmail.com> <CAMP44s37wm2G0vSmtND83ghrjHHfbyCbsKEoaUew-YxE73T=6A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, spearce@spearce.org, szeder@ira.uka.de,
	jrnieder@gmail.com
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 12 09:43:02 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SIEgG-0006yS-0Y
	for gcvg-git-2@plane.gmane.org; Thu, 12 Apr 2012 09:43:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761700Ab2DLHmy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Apr 2012 03:42:54 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:40781 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751803Ab2DLHmw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Apr 2012 03:42:52 -0400
Received: by obbtb18 with SMTP id tb18so2378893obb.19
        for <git@vger.kernel.org>; Thu, 12 Apr 2012 00:42:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=E611Rpc4luiMFyRWxD6PXWBDUKhz8Ljn4UWgxcfdm2k=;
        b=pg3S6LBHoQivgtCalZvLW8QaYMtkL5ZusMM5lDNGWbla7b5F/QvJMEkZWKUkfZeVl+
         +uKnSeM8ifrSy3f8FBmLO8jh7cfXP0lU+DTfSe7WAshQQ0cRtpuVOJ7AmR3c94ArrLFb
         BjcVZ8dn1ImBrnMOL5qTYEzwBLqnTgnIrGjstqWa0RDX2iCYhf7t/QegEzAX6vvGa8Bc
         l/mnD+ULCqjU450pWPbpKw6J/2TpEilFJX9fH/a9kCgV5U3l1vME+NKSBQihECGJSVhW
         oQUhxm+aG/YyUB8SINVwzhLs++LT9g2Lxzy9Sa7jlZ0TSfyUGn92NY+jrx5W6J2BB7Ic
         AnbA==
Received: by 10.60.20.10 with SMTP id j10mr1841935oee.33.1334216572248;
        Thu, 12 Apr 2012 00:42:52 -0700 (PDT)
Received: from [192.168.2.10] (ip68-105-100-241.sd.sd.cox.net. [68.105.100.241])
        by mx.google.com with ESMTPS id aj16sm5022801oec.4.2012.04.12.00.42.50
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 12 Apr 2012 00:42:51 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:6.0) Gecko/20110911 Thunderbird/6.0
In-Reply-To: <CAMP44s37wm2G0vSmtND83ghrjHHfbyCbsKEoaUew-YxE73T=6A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195308>

On 04/11/2012 03:51 AM, Felipe Contreras wrote:
> On Wed, Apr 11, 2012 at 1:29 PM, Stephen Boyd <bebarino@gmail.com> wrote:
>> The bash completion script wants to know what the long options are for a
>> certain command at runtime. Add a magical long option that nobody could
>> possibly ever use (--dump-raw-long-options) to get this information.
> 
> I thought about doing this, but I would like more than just dumping
> the options. In zsh one can show more than just the options; each
> option can have a description.

Cool. I don't use zsh but it sounds interesting. Perhaps the magical
long option should grow an optional argument? i.e.

	--dump-raw-long-option=zsh

which would dump the options in a format that zsh would like?

Alternatively, we can make a tiny option description grammar that's
easily parsed. I probably won't have time for this any time soon though.

> 
> I was thinking on something like 'git help --raw'. We also need
> something like that to list all the plumbing commands, and options for
> certain options, like merge strategies, and so on. Perhaps it would
> even make sense to have a new 'git raw-help' command.
> 

I'd like to avoid tying the long option stuff to git help so that other
users of parse-options besides git (perhaps perf?) get the dumping
support for free. Actually it works well for 'git notes <subcommand>'
right now so it probably has to stay tied to each git command. Plus I
think we've covered merge strategies and command lists already so I
don't know how useful 'git help --raw' would be.

I have been pondering ways to get all the possible config keys
dynamically. That would remove a huge list (~2000 lines) in the
completion script that always needs updating. Doing that would probably
require some sort of grep over all the source files and a special key
comparison function to look for (#define CONFIG_MATCH strcmp might
work). Even then I don't know how we would handle color.branch.* and
similar things. Maybe we would just do those by hand.
