From: Alan Franzoni <mailing@franzoni.eu>
Subject: Re: [PATCH] Fix: wrong offset for CET timezone
Date: Fri, 27 Jun 2014 10:24:23 +0200
Message-ID: <CAF3z5=m5Ac5qWuXNXZaRqfDjbmt37qHjbj6YxkaE12VYsZegcg@mail.gmail.com>
References: <1403790812-29174-1-git-send-email-mailing@franzoni.eu> <166360487.125996.1403820532765.JavaMail.zimbra@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Alan Franzoni <username@franzoni.eu>,
	schwab@linux-m68k.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Fri Jun 27 10:24:50 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X0RSk-0006Ul-Ai
	for gcvg-git-2@plane.gmane.org; Fri, 27 Jun 2014 10:24:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753046AbaF0IYq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Jun 2014 04:24:46 -0400
Received: from mail-ie0-f178.google.com ([209.85.223.178]:64047 "EHLO
	mail-ie0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752986AbaF0IYo (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jun 2014 04:24:44 -0400
Received: by mail-ie0-f178.google.com with SMTP id rd18so4149301iec.9
        for <git@vger.kernel.org>; Fri, 27 Jun 2014 01:24:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=Vo3f9/kQN54K/2B3MP7GNFa3YAprRH4y2KZbbgH8pAA=;
        b=az+/YmMnyWjUBpbiwdwL/+XpRr1XJ5auJ+wwlyzpGcw89LBg3TMP8HLCYyhooVjkGj
         bnX8O9G8cgIkiozxaFmn8yTwz45HJKnHAHTzs0Uy7qEbkUA8tQDMY53aktHG2t4ZeuJO
         hRPDHJ7NqOBWqvpRiH/dwIAsf2M+w3cpgi2tn2Fsv7c1vNahxK2Y+zKNep+HDhtMQjRJ
         PnWezlzrOmYISkr6aYobSaHPOb1asl2Ong/A/H337RxHKM0hcjMuVGR7eEpoqHBmPVlu
         QXgZQEMKXqCh+tPjar2u7AzFFNN7X4Uy9q5mxNgNR7ZvnjVovv2MpPMSm5yJ430tb7d1
         esMw==
X-Gm-Message-State: ALoCoQnaSjM0ZKl83mLRSfuhdI332B7V+wfveCZlpDf6dx80MrX6duZ6iO9YSWac7PVwakBfFp7i
X-Received: by 10.50.134.135 with SMTP id pk7mr10632193igb.31.1403857483534;
 Fri, 27 Jun 2014 01:24:43 -0700 (PDT)
Received: by 10.64.11.225 with HTTP; Fri, 27 Jun 2014 01:24:23 -0700 (PDT)
In-Reply-To: <166360487.125996.1403820532765.JavaMail.zimbra@dewire.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252541>

On Fri, Jun 27, 2014 at 12:08 AM, Robin Rosenberg
<robin.rosenberg@dewire.com> wrote:
> 1 hour in winter and 2 in summer, although some standards seem to say
> that summer time is really called CEST, computers apply DST to CET in summer.
>
> $ TZ=UTC date
> Tor 26 Jun 2014 22:08:01 UTC
>
> $ TZ=CET date
> Fre 27 Jun 2014 00:08:05 CEST

Like Andreas pointed out, this seems an implementation detail. CET is
still +1, while CEST is +2.

If you take a look at the official IANA tzdata:

http://www.iana.org/time-zones/repository/releases/tzdata2014e.tar.gz

For europe, it's something like "std: CET" and "dst: CEST".

The current doc is not correct either; we should write something like
"either +1 or +2 depending on DST" (there seems to be a 2dst as well
which gets +3 offset);

Usually the best way of handling timezones is to use the proper
location format (e.g. TZ='Europe/Rome') and then letting the system
pick the proper offset; we might say something like ' "Europe/Rome"
which is +1 in winter ' in the doc, but I'd say that's nitpicking.


-- 
contact me at public@[mysurname].eu
