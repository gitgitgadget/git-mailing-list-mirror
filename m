Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4562018029
	for <git@vger.kernel.org>; Fri, 20 Oct 2023 10:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from bluemchen.kde.org (bluemchen.kde.org [209.51.188.41])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 268AC1BE7
	for <git@vger.kernel.org>; Fri, 20 Oct 2023 03:45:48 -0700 (PDT)
Received: from ugly.fritz.box (localhost [127.0.0.1])
	by bluemchen.kde.org (Postfix) with ESMTP id E824E23F67;
	Fri, 20 Oct 2023 06:45:43 -0400 (EDT)
Received: by ugly.fritz.box (masqmail 0.3.6-dev, from userid 1000)
	id 1qtn0h-t9w-00; Fri, 20 Oct 2023 12:45:43 +0200
Date: Fri, 20 Oct 2023 12:45:43 +0200
From: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
To: Jeff King <peff@peff.net>
Cc: Michael Strawbridge <michael.strawbridge@amd.com>,
	Junio C Hamano <gitster@pobox.com>,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 2/3] Revert "send-email: extract email-parsing code into
 a subroutine"
Message-ID: <ZTJaVzt75r0iHPzR@ugly>
References: <20231020100343.GA2194322@coredump.intra.peff.net>
 <20231020101310.GB2673716@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20231020101310.GB2673716@coredump.intra.peff.net>

On Fri, Oct 20, 2023 at 06:13:10AM -0400, Jeff King wrote:
>But one thing that gives me pause is that the neither before or after
>this patch do we handle continuation lines like:
>
>  Subject: this is the beginning
>    and this is more subject
>
>And it would probably be a lot easier to add when storing the headers in
>a hash (it's not impossible to do it the other way, but you basically
>have to delay processing each line with a small state machine).
>
that seems like a rather significant point, doesn't it?

>So another option is to just fix the individual bugs separately.
>
... so that seems preferable to me, given that the necessary fixes seem 
rather trivial.

> I guess "readable" is up for debate here, but I find the inline handling
> a lot easier to follow
>
any particular reason for that?

> (and it's half as many lines; most of the diffstat is the new tests).

>-	if ($parsed_email{'From'}) {
>-		$sender = delete($parsed_email{'From'});
>-	}

this verbosity could be cut down somewhat using just

   $sender = delete($parsed_email{'From'});

and if the value can be pre-set and needs to be preserved,

   $sender = delete($parsed_email{'From'}) // $sender;

but this seems kind of counter-productive legibility-wise.

regards
