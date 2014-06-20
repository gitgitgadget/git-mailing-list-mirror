From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 14/16] fetch-pack: refactor parsing in get_ack
Date: Fri, 20 Jun 2014 01:15:20 -0400
Message-ID: <CAPig+cTBaDDigjSSeMLvJ=R701XNTtjVL1JKE8TWbHVTFC8BJA@mail.gmail.com>
References: <20140618194117.GA22269@sigill.intra.peff.net>
	<20140618195603.GN22622@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jun 20 07:15:27 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WxrAc-0000qX-Fi
	for gcvg-git-2@plane.gmane.org; Fri, 20 Jun 2014 07:15:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933838AbaFTFPW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Jun 2014 01:15:22 -0400
Received: from mail-yk0-f174.google.com ([209.85.160.174]:38930 "EHLO
	mail-yk0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933503AbaFTFPV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Jun 2014 01:15:21 -0400
Received: by mail-yk0-f174.google.com with SMTP id 19so2341968ykq.5
        for <git@vger.kernel.org>; Thu, 19 Jun 2014 22:15:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=nRGm7c4rBy6sC85RJ3/tZmwQs1YHfOdA+3W5UkhYJMQ=;
        b=h0bznYMK6WAYZEj7WNL//PEpX90wru5OHtv4HQWzQPi0oVTTnVDSUm9OJRf17Wd6l9
         PGe6JEuInXqrd7o5al7hrfxWh5rAAYA469GpBsnK0nXwCkqm0kUTA2FVo1AdyeyCx0CX
         aFKq/LGtf8SDRgy9nnMEZxu0zJgQ3wz+evKPT0eu8k/bEnLJymrXKcxyvnaBMU5rcsrw
         CqfVpcrbpNPPUapFy6NFTSzHFoiBc1b095HK/nuNTSzqI8eANlYI1PFerHaJfkGa27jf
         8jat9oSKk+Hux7Gkd3ySqNYeqgiwMf1sDOMOj0OeWmqc6EbuN7UFPJq1sYphbOx1jQK+
         JebA==
X-Received: by 10.236.117.169 with SMTP id j29mr1704191yhh.118.1403241320899;
 Thu, 19 Jun 2014 22:15:20 -0700 (PDT)
Received: by 10.170.36.80 with HTTP; Thu, 19 Jun 2014 22:15:20 -0700 (PDT)
In-Reply-To: <20140618195603.GN22622@sigill.intra.peff.net>
X-Google-Sender-Auth: v9xJG3Zb6xg_7GvQQgbCqulMDv0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252213>

On Wed, Jun 18, 2014 at 3:56 PM, Jeff King <peff@peff.net> wrote:
> There are several uses of the magic number "line+45" when
> parsing ACK lines from the server, and it's rather unclear
> why 45 is the correct number. We can make this more clear by
> keeping a running pointer as we parse, using skip_prefix to
> jump past the first "ACK ", then adding 40 to jump past
> get_sha1_hex (which is still magical, but hopefully 40 is
> less magical to readers of git code).
>
> Note that this actually puts us at line+44. The original
> required some character between the sha1 and further ACK
> flags (it is supposed to be a space, but we never enforced
> that). We start our search for flags at line+44, which
> meanas we are slightly more liberal than the old code.

s/meanas/means/

> Signed-off-by: Jeff King <peff@peff.net>
