Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E381A10F4
	for <git@vger.kernel.org>; Thu, 16 Nov 2023 12:16:19 -0800 (PST)
Received: (qmail 25993 invoked by uid 109); 16 Nov 2023 20:16:19 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 16 Nov 2023 20:16:19 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18393 invoked by uid 111); 16 Nov 2023 20:16:20 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 16 Nov 2023 15:16:20 -0500
Authentication-Results: peff.net; auth=none
Date: Thu, 16 Nov 2023 15:16:18 -0500
From: Jeff King <peff@peff.net>
To: Todd Zullinger <tmz@pobox.com>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	=?utf-8?B?T25kxZllaiBQb2hvxZllbHNrw70=?= <opohorel@redhat.com>
Subject: Re: [PATCH v3 1/2] perl: bump the required Perl version to 5.8.1
 from 5.8.0
Message-ID: <20231116201618.GB1146561@coredump.intra.peff.net>
References: <20231116193014.470420-1-tmz@pobox.com>
 <20231116193014.470420-2-tmz@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231116193014.470420-2-tmz@pobox.com>

On Thu, Nov 16, 2023 at 02:30:10PM -0500, Todd Zullinger wrote:

> The following commit will make use of a Getopt::Long feature which is
> only present in Perl >= 5.8.1.  Document that as the minimum version we
> support.
> 
> Many of our Perl scripts will continue to run with 5.8.0 but this change
> allows us to adjust them as needed without breaking any promises to our
> users.
> 
> The Perl requirement was last changed in d48b284183 (perl: bump the
> required Perl version to 5.8 from 5.6.[21], 2010-09-24).  At that time,
> 5.8.0 was 8 years old.  It is now over 21 years old.

Thanks, IMHO this is long overdue. You mentioned 5.10 elsewhere in the
thread, and it came up recently in a discussion (it would allow the use
of "//" for defined-or). So we could perhaps go a bit farther. But I am
also fine with 5.8.1 for now, if that is all it takes for this fix (and
I expect the chance that it causes a problem for anybody to be close to
zero).

> Signed-off-by: Todd Zullinger <tmz@pobox.com>
> ---
> I debated changing all the 'use 5.008;' lines here, as most don't
> actually require a newer Perl, but the previous bump did the same.
> 
> I can see the merit in either direction.
> 
> Changing it allows future contributors to be confident in relying on
> 5.8.1 features.
> 
> Not changing it allows anyone stuck on 5.8.0 to continue using the perl
> scripts which don't actually require 5.8.1.

Yeah, I can see both sides of the argument. I think I'd err on the side
of bumping (as you did here). That lets somebody who will be affected
know immediately, rather than only finding out when we randomly depend
on a feature later.

All of this discussion could likewise go in the commit message. :)

> Tangentially, the Perl docs for 'use' function recommend against the
> 5.008001 form[1]:
> 
>     Specifying VERSION as a numeric argument of the form 5.024001 should
>     generally be avoided as older less readable syntax compared to
>     v5.24.1. Before perl 5.8.0 released in 2002 the more verbose numeric
>     form was the only supported syntax, which is why you might see it in
>     older code.
> 
>         use v5.24.1;    # compile time version check
>         use 5.24.1;     # ditto
>         use 5.024_001;  # ditto; older syntax compatible with perl 5.6
> 
> I'm not enough of a Perl coder to have a strong preference or desire to
> push for such a change, but I thought it was worth mentioning in case
> others wonder why we're using the 5.008001 form.

I doubt it matters too much either way. I suspect at the time we moved
to v5.8 the nicer syntax was still pretty new (having only been
introduced by v5.6, which we were moving off of) and that older versions
of perl might not give as nice a message when they see it. But given
that 5.6 is now 23 years old, we can probably assume nobody will use it
(or at least they will be accustomed to whatever ugly message it
produces).

But IMHO that should be done as a separate patch anyway.

-Peff
