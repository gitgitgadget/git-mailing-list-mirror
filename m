Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="dZiKeG/5"
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A400C3
	for <git@vger.kernel.org>; Mon, 27 Nov 2023 18:07:08 -0800 (PST)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id D5DBF25001;
	Mon, 27 Nov 2023 21:07:07 -0500 (EST)
	(envelope-from tmz@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=date:from
	:to:cc:subject:message-id:references:mime-version:content-type
	:in-reply-to; s=sasl; bh=7Tsw5dCh7ZAgvI8rZ1OCdH6stV9AjyhBnVIOkfu
	oW1g=; b=dZiKeG/58Zg0q9qgfiFoKZs8kcbSv0d/l7Mym0KAvAu1QgCzHR8B25z
	n9sR+rE/cOrBDArVFFDzHGDd+7z14SSA5ABYytA56vOQYLUpxnL5PCUUXtvLfSOE
	tWaqtijWKuHtvCsRLsP5qRwiArbNg9SHXgZIw5f9UzE9XwRygE8Y=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id CE45525000;
	Mon, 27 Nov 2023 21:07:07 -0500 (EST)
	(envelope-from tmz@pobox.com)
Received: from pobox.com (unknown [108.15.224.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 3170824FFD;
	Mon, 27 Nov 2023 21:07:03 -0500 (EST)
	(envelope-from tmz@pobox.com)
Date: Mon, 27 Nov 2023 21:07:00 -0500
From: Todd Zullinger <tmz@pobox.com>
To: "H.Merijn Brand" <linux@tux.freedom.nl>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: Fix git-send-email.perl w.r.t. recent Getopt::Long update
Message-ID: <ZWVLRIfARhRhz-7L@pobox.com>
References: <20231124103932.31ca7688@pc09>
 <xmqqzfz03tbn.fsf@gitster.g>
 <20231127093810.2092fe1d@pc09>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231127093810.2092fe1d@pc09>
X-Pobox-Relay-ID:
 D2ADC040-8D92-11EE-8ECF-A19503B9AAD1-09356542!pb-smtp21.pobox.com

Hi,

H.Merijn Brand wrote:
> On Mon, 27 Nov 2023 09:58:52 +0900, Junio C Hamano <gitster@pobox.com> wrote:
>> One downside of unconditional upgrade of the call is, of course,
>> that it would no longer work for those with older Getopt::Long that
>> did not support the "!" suffix.  Fortunately, Getopt::Long 2.33
>> started shipping with Perl 5.8.1 that is more than 20 years old, so
>> with the series we accepted, we also have a change to bump the
>> required version of Perl from 5.8.0 to 5.8.1 to make it clear that
>> it is deliberate that we drop the support for anything older at the
>> same time.
> 
> The is a no-issue ...
> 
> Just the 'use Getopt::Long' is enough to guarantee a working version:
> 
> The '!' was already implemented in version 2.10 (April 1997):
> --8<---
> =item !
> 
> Option does not take an argument and may be negated, i.e. prefixed by
> "no". E.g. "foo!" will allow B<--foo> (with value 1) and B<-nofoo>
> (with value 0).
> The option variable will be set to 1, or 0 if negated.
> -->8---

The real issue is the lack of support for the '--no-' prefix
when used with the '!' parameter.  The '--no-' form is what
has always been documented by git-send-email(1).  It was not
supported until Getopt::Long 2.33, included in perl 5.8.1.

Prior, 'foo!' provided --foo and --nofoo but not --no-foo.

But as Junio said, we can accept requiring a perl which was
released sometime in the past 2 decades in order to run the
most recent git release. ;)

Thanks for noticing this and sending a patch!

-- 
Todd
