Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C0AA15AE8
	for <git@vger.kernel.org>; Fri, 20 Oct 2023 10:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7767793
	for <git@vger.kernel.org>; Fri, 20 Oct 2023 03:03:45 -0700 (PDT)
Received: (qmail 15364 invoked by uid 109); 20 Oct 2023 10:03:44 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 20 Oct 2023 10:03:44 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12606 invoked by uid 111); 20 Oct 2023 10:03:49 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 20 Oct 2023 06:03:49 -0400
Authentication-Results: peff.net; auth=none
Date: Fri, 20 Oct 2023 06:03:43 -0400
From: Jeff King <peff@peff.net>
To: Michael Strawbridge <michael.strawbridge@amd.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
Subject: [PATCH 0/3] some send-email --compose fixes
Message-ID: <20231020100343.GA2194322@coredump.intra.peff.net>
References: <ZSal-mQIZAUBaq6g@debian.me>
 <95b9e5d5-ab07-48a6-b972-af5348f653be@amd.com>
 <7e2c92ff-b42c-4b3f-a509-9d0785448262@amd.com>
 <xmqq1qe0lui2.fsf@gitster.g>
 <20231011221844.GB518221@coredump.intra.peff.net>
 <xmqqzg0oiy4s.fsf@gitster.g>
 <20231011224753.GE518221@coredump.intra.peff.net>
 <b4385543-bee0-473b-ab2d-df0d7847ddf3@amd.com>
 <20231020064525.GB1642714@coredump.intra.peff.net>
 <20231020071402.GC1642714@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231020071402.GC1642714@coredump.intra.peff.net>

[culling the rather large cc, as we moving off the original topic]

On Fri, Oct 20, 2023 at 03:14:03AM -0400, Jeff King wrote:

> and there's your perl array ref (from the square brackets, which are
> necessary because we're sticking it in a hash value). But even before
> your patch, this seems to end up as garbage. The code which reads
> $parsed_line does not dereference the array.
> 
> The patch to fix it is only a few lines (well, more than that with some
> light editorializing in the comments):

So here's the fix in a cleaned up form, guided by my own comments from
earlier. ;) I think this is actually all orthogonal to the patch you are
working on, so yours could either go on top or just be applied
separately.

  [1/3]: doc/send-email: mention handling of "reply-to" with --compose
  [2/3]: Revert "send-email: extract email-parsing code into a subroutine"
  [3/3]: send-email: handle to/cc/bcc from --compose message

 Documentation/git-send-email.txt |  10 +--
 git-send-email.perl              | 132 ++++++++++++-------------------
 t/t9001-send-email.sh            |  41 ++++++++++
 3 files changed, 98 insertions(+), 85 deletions(-)

-Peff
