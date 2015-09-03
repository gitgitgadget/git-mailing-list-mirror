From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] pack-protocol: document newline behavior in push commands
Date: Thu, 03 Sep 2015 15:17:18 -0700
Message-ID: <xmqq4mjbi1w1.fsf@gitster.mtv.corp.google.com>
References: <20150903080205.GA20182@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Dave Borowitz <dborowitz@google.com>,
	Shawn Pearce <spearce@spearce.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Sep 04 00:17:42 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZXcp9-0006TS-66
	for gcvg-git-2@plane.gmane.org; Fri, 04 Sep 2015 00:17:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752581AbbICWRU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Sep 2015 18:17:20 -0400
Received: from mail-pa0-f43.google.com ([209.85.220.43]:34434 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751093AbbICWRU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Sep 2015 18:17:20 -0400
Received: by padhy16 with SMTP id hy16so685936pad.1
        for <git@vger.kernel.org>; Thu, 03 Sep 2015 15:17:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=z+E3Ws36Gd2SwvEWl3C04jHGCxLjcrjpPkUDcvOFLxk=;
        b=i9/cHO5HPmV287bGayMtHn+uP1Lf4Rhf+HQDS9xXjjp0oHNPvhITY//c9YYR0Oxzlb
         v8P9OZD8HYBQJ71Q6K/x8wy5GIuLUcrjx+Olr3qk2zrWIfFmgAEyGB3ZQXUQrQEnBz8u
         OosTfVz3BLiWrqSI31efA8LIeWm8F3TctoRCiwxC80/zTCkcwr/0/YiMJ0xWePnYKph1
         dwfNfMwTjh1CAjAVI0RSgI3xMMtkyXk+XaaNr+pSNVO4fRNJumgmpo2H3CdN6lygsa1C
         Bsq3w5SxA1dGnUQN0eT4Ax4GYZLOZBMloRvsY8ekD+6hsFGxIGLWTDQ/vjX4HoLCwcmO
         uk0A==
X-Received: by 10.66.120.75 with SMTP id la11mr569345pab.14.1441318639565;
        Thu, 03 Sep 2015 15:17:19 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:71da:b56c:f873:e611])
        by smtp.gmail.com with ESMTPSA id fl6sm150487pab.12.2015.09.03.15.17.18
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 03 Sep 2015 15:17:18 -0700 (PDT)
In-Reply-To: <20150903080205.GA20182@sigill.intra.peff.net> (Jeff King's
	message of "Thu, 3 Sep 2015 04:02:05 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277274>

Jeff King <peff@peff.net> writes:

> Frankly, this feels a bit like a step backwards to me. I am tempted to
> suggest instead that git start sending the newlines, but I'm not sure
> it's worth any potential fallout.

I actually think we should do both in the longer term.

If we say sender "SHOULD" and we know no existing receiver violates
the "MUST NOT reject", our sender should follow that "SHOULD".

This documentation update is good in that it makes the examples
easier to read (by the way, the first pre-context line ends with
'\n', which we would eventually also address) by making the reader
understand that the convention used in this S:/C: exchange
illustration the optional LF is not shown.

> I'm also tempted to scrap this and say it just falls under the rule
> that every PKT-LINE is "sender SHOULD include LF" and "receiver MUST NOT
> complain about missing LF" (which does appear earlier in the document,
> though in a different context). Or maybe we should write out that rule
> explicitly and drop the "LF" from all parts of the grammar (which is
> what the thread above advocates).

Hmm, I view this patch as a first step in that direction.

>
>  Documentation/technical/pack-protocol.txt | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/Documentation/technical/pack-protocol.txt b/Documentation/technical/pack-protocol.txt
> index 4064fc7..9ce53b4 100644
> --- a/Documentation/technical/pack-protocol.txt
> +++ b/Documentation/technical/pack-protocol.txt
> @@ -469,8 +469,8 @@ references.
>  
>    shallow           =  PKT-LINE("shallow" SP obj-id LF)
>  
> -  command-list      =  PKT-LINE(command NUL capability-list LF)
> -		       *PKT-LINE(command LF)
> +  command-list      =  PKT-LINE(command NUL capability-list)
> +		       *PKT-LINE(command)
>  		       flush-pkt
>  
>    command           =  create / delete / update
> @@ -586,8 +586,8 @@ An example client/server communication might look like this:
>     S: 003f74730d410fcb6603ace96f1dc55ea6196122532d refs/heads/team\n
>     S: 0000
>  
> -   C: 003e7d1665144a3a975c05f1f43902ddaf084e784dbe 74730d410fcb6603ace96f1dc55ea6196122532d refs/heads/debug\n
> -   C: 003e74730d410fcb6603ace96f1dc55ea6196122532d 5a3f6be755bbb7deae50065988cbfa1ffa9ab68a refs/heads/master\n
> +   C: 003e7d1665144a3a975c05f1f43902ddaf084e784dbe 74730d410fcb6603ace96f1dc55ea6196122532d refs/heads/debug
> +   C: 003e74730d410fcb6603ace96f1dc55ea6196122532d 5a3f6be755bbb7deae50065988cbfa1ffa9ab68a refs/heads/master
>     C: 0000
>     C: [PACKDATA]
