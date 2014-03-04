From: Johan Herland <johan@herland.net>
Subject: Re: [PATCH] git submodule foreach: Skip eval for more than one argument
Date: Tue, 4 Mar 2014 16:23:47 +0100
Message-ID: <CALKQrgcDZD=eDnK5ssqZ3bCpB2gvWPts2W22_ZsCq5UtCxtmhg@mail.gmail.com>
References: <alpine.DEB.2.00.1309261605330.20647@dr-wily.mit.edu>
	<20140304135106.GD11566@login.drsnuggles.stderr.nl>
	<CALKQrgfC1Cf=ZnwhaDUz-2q=vLa0UbO4ONybvCPu7RiF+3sm3w@mail.gmail.com>
	<20140304145703.GE11566@login.drsnuggles.stderr.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Matthijs Kooijman <matthijs@stdin.nl>,
	Johan Herland <johan@herland.net>,
	Anders Kaseorg <andersk@mit.edu>,
	Junio C Hamano <gitster@pobox.com>,
	Git mailing list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Mar 04 16:24:00 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WKrCJ-0005A2-MA
	for gcvg-git-2@plane.gmane.org; Tue, 04 Mar 2014 16:24:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757259AbaCDPXz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Mar 2014 10:23:55 -0500
Received: from mail12.copyleft.no ([188.94.218.224]:58274 "EHLO
	mail12.copyleft.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757188AbaCDPXy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Mar 2014 10:23:54 -0500
Received: from locusts.copyleft.no ([188.94.218.116] helo=mail.mailgateway.no)
	by mail12.copyleft.no with esmtp (Exim 4.76)
	(envelope-from <johan@herland.net>)
	id 1WKrCC-0000UR-Hz
	for git@vger.kernel.org; Tue, 04 Mar 2014 16:23:52 +0100
Received: from mail-pb0-f42.google.com ([209.85.160.42])
	by mail.mailgateway.no with esmtpsa (TLSv1:RC4-SHA:128)
	(Exim 4.72 (FreeBSD))
	(envelope-from <johan@herland.net>)
	id 1WKrCC-00045g-46
	for git@vger.kernel.org; Tue, 04 Mar 2014 16:23:52 +0100
Received: by mail-pb0-f42.google.com with SMTP id rr13so5375740pbb.1
        for <git@vger.kernel.org>; Tue, 04 Mar 2014 07:23:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type;
        bh=cahxKYUljcwT7lePjxORKugfm1/wdFp/bw49dt80YEQ=;
        b=Wu+AqysBXwicinUAuG6xb2pLJXWVeGwBCEaX50xl0U07riW83x/p2msssO9Yv9h8+a
         dYT92tKfnAal6kPkf/VwlPEWo3JcbUrs78+cxHIMWErrV3vyxQ8hr5ld+PmOgOhwXr2H
         K0L7VX0GRb8oy0eqbUclIleW+4aQJwK2/SRwJHNRaCUaz985wRmFS5inVr+1O1DG401O
         paaF7WP63rdjUrZHGuflnJDAtNRadcQLiP68NPNqRspOko36GxMCJZOIpRAKludOY0zW
         lfNbFctk8GTcgxO0TREEVXRfjctXigFYJAaXkLfkpOY2OPrVjp4DO+4T68qEa6B2SCg/
         gmOw==
X-Received: by 10.66.20.10 with SMTP id j10mr76295pae.11.1393946628035; Tue,
 04 Mar 2014 07:23:48 -0800 (PST)
Received: by 10.70.48.228 with HTTP; Tue, 4 Mar 2014 07:23:47 -0800 (PST)
In-Reply-To: <20140304145703.GE11566@login.drsnuggles.stderr.nl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243347>

On Tue, Mar 4, 2014 at 3:57 PM, Matthijs Kooijman <matthijs@stdin.nl> wrote:
> On Tue, Mar 04, 2014 at 03:53:24PM +0100, Johan Herland wrote:
>> What would you expect echo '$name' to do?
> If I run git submodule foreach each '$name', then my shell eats the
> single quotes (which are only to prevent my shell from interpreting
> $name). git submodule will see $name, so it will run echo $name, not
> echo '$name'.
>
>> What happens if you use double instead of single quotes?
> Then my shell eats up the double quotes _and_ replaces $name with
> nothing, so I can't expect git submodule to replace it with the
> submodule name then :-)
>
> Does that help to clarify what I mean?

Ok, so IINM, Anders' original commit was about making "git submodule
foreach <command>" behave more like "<command>" (from a naive user's
perspective), while you rather expect to insert quotes/escapes to
finely control exactly when shell interpretation happens. Aren't these
POVs mutually incompatible? Is the only 'real' solution to forbid
multitple arguments, and force everybody to quote the entire command?

I don't particularly care which way it goes, as long as (a) the common
case behaves as most users would expect, (b) the uncommon/complicated
case is still _possible_ (though not necessarily simple), and (c) we
don't break a sizable number of existing users.

...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
