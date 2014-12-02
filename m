From: Bryan Turner <bturner@atlassian.com>
Subject: Re: git status / git diff -C not detecting file copy
Date: Wed, 3 Dec 2014 08:40:47 +1100
Message-ID: <CAGyf7-EHBqZn5LCTYuA+07GSNOF0vVdszL6oTUKwY1ETRDKEwA@mail.gmail.com>
References: <CAJxwDJzzNV77cTP4nbzgCvFjjqp3C4X8d3j6uwhYvK4+g4r1YQ@mail.gmail.com>
	<CAGyf7-E_y8zRUKh5RWvAhPXzSgpnVab6e=e1v92rSVVxf+LNJg@mail.gmail.com>
	<CAJxwDJzxUEd3czHpwDtKaERKDhvyCGOzGbKO4X9z44ugTJ2q4w@mail.gmail.com>
	<CAGyf7-F9twCEUY-LN=xEf4=gfNW8oLEHJmTjHRQ2MncHZ2emZQ@mail.gmail.com>
	<20141202065550.GB1948@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Pol Online <info@pol-online.net>, Git Users <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Dec 02 22:48:14 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XvvIr-0002Xu-LH
	for gcvg-git-2@plane.gmane.org; Tue, 02 Dec 2014 22:48:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933162AbaLBVsI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Dec 2014 16:48:08 -0500
Received: from na6sys009bog027.obsmtp.com ([74.125.150.94]:59377 "HELO
	na6sys009bog027.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S933132AbaLBVsH (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 2 Dec 2014 16:48:07 -0500
X-Greylist: delayed 438 seconds by postgrey-1.27 at vger.kernel.org; Tue, 02 Dec 2014 16:48:07 EST
Received: from mail-oi0-f47.google.com ([209.85.218.47]) (using TLSv1) by na6sys009bob027.postini.com ([74.125.148.12]) with SMTP
	ID DSNKVH4zlhUpUTjaOrwNtAGL94oyBPmjOVlC@postini.com; Tue, 02 Dec 2014 13:48:07 PST
Received: by mail-oi0-f47.google.com with SMTP id v63so9910861oia.6
        for <git@vger.kernel.org>; Tue, 02 Dec 2014 13:48:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=ASe2J+KQN3NpNaxHgWhYqvg4bHdm7DqCOZ9AnNg0cfM=;
        b=Su+p5/rl52cialDYb8cAORqJS2ZWWwEsR8x+pPNirelLBIiRVOmx/wt0SxX43LNxDc
         IBs/Wl4myAZkcPTb/7o5AHxnG3BFY+Z/DXPeADlsS0XUNMnca4j0BcaXaYmvC0J+yjzh
         1m1B9JKILIoC20t38lYsoQQ92aCmXJfIlXlCHh2b7j7kLv5gmKH7di+fck6kZ2pEzU5x
         tLU80+5v0IBs7yVnJakZyV2zsFcBXKJTubeY+MhVC6P4T7ptvPcWsmbYCDa3QdjG3Bj3
         ZaD+ov4wM+HfGETo85dM1svDMyt4hNabKW3SLUFHUryt9ckBUn4blUdA96dLATUNQoHh
         75pg==
X-Received: by 10.202.95.9 with SMTP id t9mr993731oib.6.1417556447761;
        Tue, 02 Dec 2014 13:40:47 -0800 (PST)
X-Gm-Message-State: ALoCoQmyXdEHk0eFnj2FsFKpOWMFJ4ifBpY/wCHYu2j1KfdTiIQjxAyaxNrwQanMS3UzSTs5RwzCHZHC4MJ+qHeVD44kuvHI1dzHC0/Lbm0LtPDdEbmQIkVpZ7O0cAIdZkPnBs/L4TEUAj6sNJX8WnS3Jsf5HNy5Ow==
X-Received: by 10.202.95.9 with SMTP id t9mr993721oib.6.1417556447672; Tue, 02
 Dec 2014 13:40:47 -0800 (PST)
Received: by 10.182.245.170 with HTTP; Tue, 2 Dec 2014 13:40:47 -0800 (PST)
In-Reply-To: <20141202065550.GB1948@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260597>

On Tue, Dec 2, 2014 at 5:55 PM, Jeff King <peff@peff.net> wrote:
>
> So from these timings, I'd conclude that:
>
>   1. It's probably fine to turn on copies for "git status".
>
>   2. It's probably even OK to use "-C -C" for some projects. Even though
>      22s looks scary there, that's only 11ms for git.git (remember,
>      spread across 2000 commits). For linux.git, it's much, much worse.
>      I killed my "-C -C" run after 10 minutes, and it had only gone
>      through 1/20th of the commits. Extrapolating, you're looking at
>      500ms or so added to a "git status" run.
>
>      So you'd almost certainly want this to be configurable.
>
> Does either of you want to try your hand at a patch? Just enabling
> copies should be a one-liner. Making it configurable is more involved,
> but should also be pretty straightforward.

I'm interested in taking a stab at a patch, but I'd like to confirm
which way to go. Based on Junio's reply I'm not certain the simple
patch could get accepted (assuming I do all the submission parts
properly and the implementation itself passes review). Does that mean
the only real option is the configurable patch?

>
> -Peff
