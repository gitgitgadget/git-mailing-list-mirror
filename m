From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH v2] blame: avoid checking if a file exists on the working
 tree if a revision is provided
Date: Tue, 17 Nov 2015 15:00:08 -0800
Message-ID: <CAGZ79kbM7ZezVFSt7oHYppd=CcgoQMCyYqXB6H1k-rK82kzUPg@mail.gmail.com>
References: <1447723762-32309-1-git-send-email-eantoranz@gmail.com>
	<CAPig+cTjg8yvmLO0uuWZt4nATUnfxJOj4f_AmvRP9mHsGRmEOg@mail.gmail.com>
	<20151117224809.GE27862@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Edmundo Carmona Antoranz <eantoranz@gmail.com>,
	Git List <git@vger.kernel.org>, Max Kirillov <max@max630.net>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Nov 18 00:00:26 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZypEc-0004pA-08
	for gcvg-git-2@plane.gmane.org; Wed, 18 Nov 2015 00:00:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932557AbbKQXAM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Nov 2015 18:00:12 -0500
Received: from mail-yk0-f178.google.com ([209.85.160.178]:36346 "EHLO
	mail-yk0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754930AbbKQXAJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Nov 2015 18:00:09 -0500
Received: by ykdr82 with SMTP id r82so34120834ykd.3
        for <git@vger.kernel.org>; Tue, 17 Nov 2015 15:00:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=ksT/Uu9iV1PH7rijDjA6A1AG/6G93TxwAUdmJ3kJ3fo=;
        b=khMx7BU7MeACHRBpN63fo5oJMN4zuF8Jci8WbjNRa2gZ8obksJhJg0M/fRYfwesRNE
         3lD6A7deRmX0oebatovlxbnG7IIxhGeYeA8jqc2oCYQkJ3sHOpPo4X2U81iiWmn2Auen
         A0Qw+3qbF1ISZFXS5Aa2tOvgMA5yckyM7FaL3bXyS4Dn6/yyzmeJKlNapDsRQ29v1AmP
         g43o/yR2ACF8AvSbTnfN/jl/ik8Ws+hpjmkp6lc/b00K5MgoOn/rORIP3owP5Bg5aBmJ
         ARsP/sVnI7ijaU0ZIs3eD0fJqbyTWmOx3TRA5HbotXNox5aS6MUPqkRYjEFC+WLmkCGd
         rguw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=ksT/Uu9iV1PH7rijDjA6A1AG/6G93TxwAUdmJ3kJ3fo=;
        b=MdPQg7Fg2pB1tvQ7XLqaVuBwHrA9SThUp2kyDtC5mM/z7TUIWrciSBc1lKT1JuCorm
         swCSkkU0jeidxIgxTCZzZuvdldVSXTACR3faiUXj23kH+W4jlUA3GGKTf/K2fDCPxOb1
         PpqhMupI81jMqD7ZUY+cDvJipSXuyuLDN9zuk+CITtTHFLLUSKi6nv3WhOqZ88T8wpNp
         N0DmR2qrIG71d59tP65Nm1TiGBJMUr8DypZi881TeM0URhW8h0WPKCQwBZu2voVXo2rO
         nn4TFfRdn+zcenW7IXXKCvz0oFuuRxw/lwn+/LwBXILD3IyqJiPQXt2hTjACUQn3Neym
         YBfg==
X-Gm-Message-State: ALoCoQkp8QjE4wEETpIKppd6ZG4wLHuslr70IZWTBsmJJzcnQ4JQh1DHUFa1nbpUjqo3UnjlvQJM
X-Received: by 10.13.214.19 with SMTP id y19mr44374250ywd.63.1447801209056;
 Tue, 17 Nov 2015 15:00:09 -0800 (PST)
Received: by 10.37.196.70 with HTTP; Tue, 17 Nov 2015 15:00:08 -0800 (PST)
In-Reply-To: <20151117224809.GE27862@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281427>

On Tue, Nov 17, 2015 at 2:48 PM, Jeff King <peff@peff.net> wrote:
> On Tue, Nov 17, 2015 at 12:11:25AM -0500, Eric Sunshine wrote:
>
>> > blame content even if the path provided does match an existing
>> > blob on said revision.
>>
>> git-blame documentation does not advertise "blame <file> <rev>" as a
>> valid invocation. It does advertise "blame <rev> -- <file>", and this
>> case already works correctly even when <file> does not exist in the
>> worktree.
>
> Hmm. Out of curiosity I tried:
>
>   git blame v2.4.0 -- t/t6031-merge-recursive.sh
>
> and it segfaults. This bisects to Max's recent 1b0d400 (blame: extract
> find_single_final, 2015-10-30), but I do not see anything obviously
> wrong with it from a quick glance.

it did not fail when running through gdb, so I conclude it is a memory issue
(like using an uninitialized pointer, or memory allocation too small).

valgrind produces:

==18444== Process terminating with default action of signal 11 (SIGSEGV)
==18444==  General Protection Fault
==18444==    at 0x4032121: strcmp (valgrind/memcheck/mc_replace_strmem.c:725)
==18444==    by 0x41A86F: get_origin
(/usr/local/google/home/sbeller/OSS/git/builtin/blame.c:483)
==18444==    by 0x4201EF: cmd_blame
(/usr/local/google/home/sbeller/OSS/git/builtin/blame.c:2763)
==18444==    by 0x405896: run_builtin
(/usr/local/google/home/sbeller/OSS/git/git.c:350)
==18444==    by 0x405AA4: handle_builtin
(/usr/local/google/home/sbeller/OSS/git/git.c:536)
==18444==    by 0x405BC0: run_argv
(/usr/local/google/home/sbeller/OSS/git/git.c:582)
==18444==    by 0x405DB8: main
(/usr/local/google/home/sbeller/OSS/git/git.c:690)
==18444==


>
> -Peff
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
