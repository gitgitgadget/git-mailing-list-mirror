Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4526020329
	for <git@vger.kernel.org>; Fri, 10 Nov 2023 21:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2489F4205
	for <git@vger.kernel.org>; Fri, 10 Nov 2023 13:41:06 -0800 (PST)
Received: (qmail 14900 invoked by uid 109); 10 Nov 2023 21:41:05 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 10 Nov 2023 21:41:05 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 782 invoked by uid 111); 10 Nov 2023 21:41:06 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 10 Nov 2023 16:41:06 -0500
Authentication-Results: peff.net; auth=none
Date: Fri, 10 Nov 2023 16:41:04 -0500
From: Jeff King <peff@peff.net>
To: Alejandro Colomar <alx@kernel.org>
Cc: git@vger.kernel.org
Subject: Re: git-send-email: Send with mutt(1)
Message-ID: <20231110214104.GA2758295@coredump.intra.peff.net>
References: <ZUocFhmPHstwKCkZ@devuan>
 <20231107174803.GA507007@coredump.intra.peff.net>
 <ZUqDwnmu9d1dD1tb@devuan>
 <20231107201655.GA507701@coredump.intra.peff.net>
 <ZUv3gjjmuqvCaJEd@debian>
 <20231108212702.GA1586965@coredump.intra.peff.net>
 <ZUz6H3IqRc1YGPZM@debian>
 <20231109180308.GA2711684@coredump.intra.peff.net>
 <ZU1-l4PwMU5H4_VN@debian>
 <ZU4widBlHljjg9lL@debian>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZU4widBlHljjg9lL@debian>

On Fri, Nov 10, 2023 at 02:30:49PM +0100, Alejandro Colomar wrote:

> > Having it directly in sendmailcmd causes some glitch: It repeats all CCs
> > in TO.  See a log:

Ah, right. That makes sense. send-email has to pass all of the envelope
recipients on the command-line, which mutt then interprets as
destinations to add to "to". Mutt is smart enough to de-duplicate the
"to", but it (correctly) allows duplicate to/cc. (My basic test didn't
have any cc's).

> > So maybe we need the wrapper script to ignore the arguments.
> 
> Heh!  The following trick works as well, without needing a script:
> 
> [sendemail]
> 	sendmailcmd = mutt -H - && true
> 
> It probably relies too much on git-send-email(1)'s current
> implementation, but it works.  :)

I was going to suggest the same thing. And no, I don't think it is
relying on any send-email implementation details. Git always tries to
feed command-invoking config like this to the shell for consistency (and
to allow tricks like this).

-Peff
