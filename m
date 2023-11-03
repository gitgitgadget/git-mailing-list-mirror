Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EA941C69B
	for <git@vger.kernel.org>; Fri,  3 Nov 2023 16:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6896D18B
	for <git@vger.kernel.org>; Fri,  3 Nov 2023 09:21:20 -0700 (PDT)
Received: (qmail 20611 invoked by uid 109); 3 Nov 2023 16:21:19 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 03 Nov 2023 16:21:19 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25105 invoked by uid 111); 3 Nov 2023 16:21:20 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 03 Nov 2023 12:21:20 -0400
Authentication-Results: peff.net; auth=none
Date: Fri, 3 Nov 2023 12:21:19 -0400
From: Jeff King <peff@peff.net>
To: rsbecker@nexbridge.com
Cc: git@vger.kernel.org
Subject: Re: [BUG] Git 2.43.0-rc0 - t4216 unpack(Q) invalid type
Message-ID: <20231103162119.GC1470570@coredump.intra.peff.net>
References: <007501da0e66$96f124d0$c4d36e70$@nexbridge.com>
 <007101da0e65$13e3c170$3bab4450$@nexbridge.com>
 <20231103155220.GA1470570@coredump.intra.peff.net>
 <007f01da0e6f$d5031a40$7f094ec0$@nexbridge.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <007f01da0e6f$d5031a40$7f094ec0$@nexbridge.com>

On Fri, Nov 03, 2023 at 12:07:17PM -0400, rsbecker@nexbridge.com wrote:

> What I get from Perl is 
> $ perl -e '
> >     my $bytes = "\1\2\3\4\5\6\7\8";
> >     my $q = eval { unpack("Q>", $bytes) };
> >     print "Q = ", defined($q) ? $q : "($@)", "\n";
> >     my ($n1, $n2) = unpack("NN", $bytes);
> >     print "n1 = $n1\n";
> >     print "n2 = $n2\n";
> >     print "computed quad = ", ($n1 << 32) | $n2, "\n";  '
> Q = (Invalid type 'Q' in unpack at -e line 3.
> )
> n1 = 16909060
> n2 = 84281144
> computed quad = 84281144

OK, that matches what I expected. Hopefully the patch I just sent (our
mails just crossed) will fix it for you.

> Because perl itself is 32-bit, not 64-bit on this platform. So even
> moving git to 64-bit will not correct the issue.

Yep, exactly.

-Peff
