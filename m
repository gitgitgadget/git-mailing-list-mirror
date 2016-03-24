From: Santiago Torres <torresariass@gmail.com>
Subject: Re: [PATCH/RFC] builtin/tag.c: move PGP verification inside builtin.
Date: Thu, 24 Mar 2016 18:24:52 -0400
Message-ID: <20160324222451.GD8830@LykOS>
References: <1458855560-28519-1-git-send-email-santiago@nyu.edu>
 <20160324221020.GA17805@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: santiago@nyu.edu, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Mar 24 23:25:00 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ajDga-00005R-Fi
	for gcvg-git-2@plane.gmane.org; Thu, 24 Mar 2016 23:25:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750888AbcCXWY4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Mar 2016 18:24:56 -0400
Received: from mail-qk0-f178.google.com ([209.85.220.178]:33699 "EHLO
	mail-qk0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750772AbcCXWYy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Mar 2016 18:24:54 -0400
Received: by mail-qk0-f178.google.com with SMTP id s5so25723930qkd.0
        for <git@vger.kernel.org>; Thu, 24 Mar 2016 15:24:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=1HIr/szkFqES16vPZtE5A6C6b2MNhmysq6q3XIq9gYQ=;
        b=SEZDI4SrZ10G4cdKGw0apOLePYmzfYHeGwKjiR1bQFUCclR+goxRjomsTEKW0Z4Rr/
         IQj9so06bBBIIOedbTYpJQDc+LOEP2s89Qd7C/IonUxfod8vAmramTG9KSQGwwo7kdfg
         K76s3MOQZDelLTKwuRmWZspSWeBpYwkIimRaA3IYouTtwfDfzVBjmdUYF7ROfO4RvT9Q
         eaVK/+Ipy8u85NtSD5C6zg7qIPZdlP7qQhnQMg1OhqWbZ2Xjf3uufWEkjIPIjFJoewe4
         JY4v9HGje4u6VuCI3HFfS4yx9h8P0MfEebiNNZCkzpcwofb1K21VE2kWVm8Q1KQFNRTo
         l3Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1HIr/szkFqES16vPZtE5A6C6b2MNhmysq6q3XIq9gYQ=;
        b=XVIpOYMDKUtJggtP2CgSwcL3ugXHlwCnERxXc6V8S9jMFiPhVbO6OOCTItiSoNvYze
         7Mc73WSn9d4AlG8qyiKw3N9NwvAwQEg3WxEm6Bd6lWppqJVp1ug4imfjXVEhqXAjpSvZ
         XPs3MkLF+gDNpF3gl5V+5dL7ukTmE2RCX3N38oRJn5L4lYUh+slIKOUknBz4uTY8YkEo
         3SFuCAmZyylcQSoYGZVC9D10odSLb48kxMnFfvculCKhqxNQ8IdtnNi1CT5Of8VgsJXt
         cgb5RGPmJq3o2S4oDZGRyM47bG5VIwrCANMrUcKwwNw3s6s/sQ15IgyhpVffVW4ldb6F
         FCFg==
X-Gm-Message-State: AD7BkJImrsJrUgcGNktGKjN56ITEdwfnfxbVml5EWJ484ZfPKEng/1NXBPccjN8fRz3VZg==
X-Received: by 10.55.192.154 with SMTP id v26mr13732240qkv.36.1458858293893;
        Thu, 24 Mar 2016 15:24:53 -0700 (PDT)
Received: from LykOS (NYUFWA-WLESSAUTHCLIENTS-11.NATPOOL.NYU.EDU. [216.165.95.0])
        by smtp.gmail.com with ESMTPSA id d62sm4163379qka.3.2016.03.24.15.24.53
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 24 Mar 2016 15:24:53 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20160324221020.GA17805@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289813>

> I know you are just copying this from the one in builtin/verify-tag.c,
> but I find the use of "size" and "len" for two different purposes
> confusing. Those words are synonyms, so how do the variables differ?
> 
> Perhaps "payload_size", or "signature_offset" would be a better term for
> "len".

I agree, I'll give this a go.
> 
> > +	if (size == len) {
> > +		write_in_full(1, buf, len);
> > +	}
> 
> If the two are the same, we have no signature. Should we be returning
> early, and skipping check_signature() in that case?

This makes sense, for both the builtin and the plumbing. Let me give
this a try.

 
> > @@ -104,13 +125,24 @@ static int delete_tag(const char *name, const char *ref,
> >  static int verify_tag(const char *name, const char *ref,
> >  				const unsigned char *sha1)
> >  {
> > -	const char *argv_verify_tag[] = {"verify-tag",
> > -					"-v", "SHA1_HEX", NULL};
> 
> So the original was passing "-v" to verify-tag. That should put
> GPG_VERIFY_VERBOSE into the flags field. But later:
> 
> > +	ret = run_gpg_verify(buf, size, 0);
> 
> We don't pass any flags. Shouldn't this unconditionally pass
> GPG_VERIFY_VERBOSE?
> 

Right, I missed this. Sorry about this.

> All of this seems like a repetition of verify_tag() in
> builtin/verify-tag.c (and ditto with run_gpg_verify()). Can we move
> those functions into tag.c and just call them from both places, or is
> there some difference that needs to be taken into account (and if the
> latter, can we refactor them to account for the differences?).
> 

Yep, this is what was troubling me (as I mentioned on the followup). I
didn't want to remove the "static" classifier for the function (as there
could be a major reason for this decision). 

If this last chage is ok with you I can send the fixed-up version right
away.

Thanks!
-Santiago.
