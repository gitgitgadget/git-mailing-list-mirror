From: Santiago Torres <santiago@nyu.edu>
Subject: Re: [PATCH v3 4/4] tag: use pgp_verify_function in tag -v call
Date: Mon, 4 Apr 2016 00:12:04 -0400
Message-ID: <20160404041203.GE28933@LykOS>
References: <1459638975-17705-1-git-send-email-santiago@nyu.edu>
 <1459638975-17705-5-git-send-email-santiago@nyu.edu>
 <20160403045600.GD1519@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Apr 04 06:12:16 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1amvs7-0004YI-KW
	for gcvg-git-2@plane.gmane.org; Mon, 04 Apr 2016 06:12:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751115AbcDDEMI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Apr 2016 00:12:08 -0400
Received: from mail-qk0-f180.google.com ([209.85.220.180]:33361 "EHLO
	mail-qk0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750705AbcDDEMH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Apr 2016 00:12:07 -0400
Received: by mail-qk0-f180.google.com with SMTP id s5so58334744qkd.0
        for <git@vger.kernel.org>; Sun, 03 Apr 2016 21:12:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nyu-edu.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=1HznTSn1bTYI7Feg42aB2A/2XIjPt1ezNIqrnkrLjcs=;
        b=IFFI8gAD41Op0NaeFKhY7LUBA9aFC20lPxBV7ATB/X68W8LihgDzmRO2ar20hjHD8X
         v5HHnqgQr4jzIyS58PoIZJFYfo5PgtNrazI8iJL7g8ytSY76NdDTQiggs096MiYKuX3E
         agcOAQymGpYUURc9jIdwbchu/47Ra57qGIkyvM3W6PpDeQwS9hAaUb7sbb6dqH8P1Neq
         1rcROPPy5duS0VVBT9J/ZUc0XgHl56hTY87rB5J3B6XQl/MKRWtteqNOX+EQnExCh/bl
         GtXvWWDXMDtzLTlFfZrLRd8VBT18PJ5BU2UcFBI3y8mL9FHFs4Jz+ktgTJaJ5UDhuoXR
         h/pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1HznTSn1bTYI7Feg42aB2A/2XIjPt1ezNIqrnkrLjcs=;
        b=hL0BvUsiHD7GYGbJoKSRSm5CgJlDQvR+unsQnFGTiYF8cthp+lcxZ+taosCdBcE1HI
         LtnjdEWt1LXR42IrprUdEM36qhCv19ADLZDucjYyAUeef0S0k5tuweDe1lI6jG/9LvAQ
         Rackpsh1qKI8kLrzaPVTgoDyomhoWtOK4blnaJ5ud1JdZYRR+Jn3uaf96LlwUUf9uqtq
         zHrcMZTL6/VZYVjVbu1A99yjnA893oeh0kOMm6mCKME3zvZ0zrI7yTXGgjj/7pik4HsY
         Y/pPAq95y/TCMfj6hvwYTupdXOOmniszSop5YiNCrMqEssQPdudtPd58k47CqBjJJAZp
         kKaw==
X-Gm-Message-State: AD7BkJI1yj2fV3BRmr761phUPtYixRGVHgB527a3Q5+vJk8WG3l2sN0ArAHJzeyyU4zt2XPQ
X-Received: by 10.55.82.6 with SMTP id g6mr6287376qkb.40.1459743126834;
        Sun, 03 Apr 2016 21:12:06 -0700 (PDT)
Received: from LykOS ([2604:2000:8183:da00:b6b6:76ff:fe46:8151])
        by smtp.gmail.com with ESMTPSA id x189sm11509863qhb.43.2016.04.03.21.12.05
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 03 Apr 2016 21:12:06 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20160403045600.GD1519@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290671>

> > diff --git a/builtin/verify-tag.c b/builtin/verify-tag.c
> > index f776778..8abc357 100644
> > --- a/builtin/verify-tag.c
> > +++ b/builtin/verify-tag.c
> > @@ -30,6 +30,8 @@ int cmd_verify_tag(int argc, const char **argv, const char *prefix)
> >  {
> >  	int i = 1, verbose = 0, had_error = 0;
> >  	unsigned flags = 0;
> > +	unsigned char sha1[20];
> > +	const char *name;
> >  	const struct option verify_tag_options[] = {
> >  		OPT__VERBOSE(&verbose, N_("print tag contents")),
> >  		OPT_BIT(0, "raw", &flags, N_("print raw gpg status output"), GPG_VERIFY_RAW),
> > @@ -46,8 +48,16 @@ int cmd_verify_tag(int argc, const char **argv, const char *prefix)
> >  	if (verbose)
> >  		flags |= GPG_VERIFY_VERBOSE;
> >  
> > -	while (i < argc)
> > -		if (pgp_verify_tag(argv[i++], flags))
> > +	while (i < argc) {
> > +		name = argv[i++];
> > +		if (get_sha1(name, sha1)) {
> > +			error("tag '%s' not found.", name);
> >  			had_error = 1;
> > +		}
> > +
> > +		if (pgp_verify_tag(name, NULL, sha1, flags))
> > +			had_error = 1;
> > +
> > +	}
> 
> So this is a good example of the rippling I mentioned earlier.
> 
> As a side note, it might actually be an improvement for pgp_verify_tag
> to take a sha1 (so that git-tag is sure that it is verifying the same
> object that it is printing), but that refactoring should probably come
> separately, I think.
> 
> -Peff

Just to be sure, this refactoring is something we should still include
in this set of patches, right? I think that otherwise we'd lose the
desambigutaion that git tag -v does in this patch.

I also think that most of the rippling is gone if we use and adaptor as
you suggested. Should I add a patch on top of this to support a sha1 as
part for gpg_verify_tag()?

Thanks!
-Santiago.
