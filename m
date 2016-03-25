From: Santiago Torres <santiago@nyu.edu>
Subject: Re: [PATCH] tag.c: move PGP verification code from plumbing
Date: Fri, 25 Mar 2016 10:45:10 -0400
Message-ID: <20160325144509.GA20375@LykOS>
References: <1458866017-15490-1-git-send-email-santiago@nyu.edu>
 <CAPig+cQe5bwHXq4_qegBCM8Kqoqiz7K2ZtVk0FGMSEUPWQHyYA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Fri Mar 25 15:45:24 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ajSzK-0001Sq-Gx
	for gcvg-git-2@plane.gmane.org; Fri, 25 Mar 2016 15:45:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753155AbcCYOpQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Mar 2016 10:45:16 -0400
Received: from mail-qg0-f49.google.com ([209.85.192.49]:36508 "EHLO
	mail-qg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751989AbcCYOpN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Mar 2016 10:45:13 -0400
Received: by mail-qg0-f49.google.com with SMTP id u110so62567888qge.3
        for <git@vger.kernel.org>; Fri, 25 Mar 2016 07:45:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nyu-edu.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/qrPC0uifLCPXQlK+y5ecZj7ylgL5kUnVVObnnHqp9M=;
        b=PsTW5gmw1ruOsauZTmx18ftvy67AucCRyWtBnFKYp/kOqEXlVS618ULzkz8txj34eF
         t3RNxZU3VRzW62iNaSdRxfLJCkoaaHGWF8zkrkDxsY3Xw1V9PHfkkcHmBIJWejw73sgV
         /92o/xc+G1rawcWqGR7yMDHFrcJpEUZedV26DJfVk38tWOYnPCCL1v7CYHe+QFrca9GA
         Fgb57qgSMHU7mGPu/AtGPPOMthz3tcTrVynb1qhUCxlKgArDarHKn/NasxnLPBR38mwh
         4zIuVtMm+vmY25LRUybMDtmRt/wRI/JtZN/4U65JRR3pCf8yEFFwX7VDiWIhd7ZevglF
         KzuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/qrPC0uifLCPXQlK+y5ecZj7ylgL5kUnVVObnnHqp9M=;
        b=WQVSOUUtQYdGDBBh+C0s+6Q9hOSxD9LeKZQefNUFpIMvUfHDSoaeeB6Sq+PYM6SWql
         LnW83JuJZv+w6u0UBjpDAuK2eb3oA3GOXlfbzcN81cYjZmpraxykDP/18PPTeeuCEdR7
         sAOepFd3IbOE0Rg0W++Bk6ODcsYIyDSmUaflb5AxwfQ+mhO3TsWWaIdM6A7lm6XEblQT
         8AAjm4ojl/uAj1uPsuyEhaWVcRTMbEeu5CEUvt485Ql2Ra4W4LY6xqWwb1FaydMPh/aM
         TELuo2JRUvXsNf3kcw1MYRjwAmgGzxOwvd1L87lUbXSdgSdSZhCyFBbQD7mMn31u88TJ
         ZBag==
X-Gm-Message-State: AD7BkJJ+xXKo5wlrUjIf0brZd+jvinhpCWBB9790LVsqUczeVrD29FWvxlwSEDkh0zjOwyHt
X-Received: by 10.140.101.147 with SMTP id u19mr18294952qge.71.1458917112266;
        Fri, 25 Mar 2016 07:45:12 -0700 (PDT)
Received: from LykOS ([2604:2000:8183:da00:b6b6:76ff:fe46:8151])
        by smtp.gmail.com with ESMTPSA id y206sm5444422qhc.0.2016.03.25.07.45.11
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 25 Mar 2016 07:45:11 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAPig+cQe5bwHXq4_qegBCM8Kqoqiz7K2ZtVk0FGMSEUPWQHyYA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289892>

> > -       signal(SIGPIPE, SIG_IGN);
> >         while (i < argc)
> > -               if (verify_tag(argv[i++], flags))
> > +               name = argv[i++];
> > +               if (get_sha1(name, sha1))
> > +                       return error("tag '%s' not found.", name);
> > +
> > +               if (pgp_verify_tag(NULL, NULL, sha1, flags))
> >                         had_error = 1;
> 
> Meh, this isn't Python. Due to the missing braces, the only thing
> inside the while() loop is the assignment to 'name'; all the other
> indented code is outside the while().
> 
> Did you run the test suite following this change? Did it all pass? If
> so, perhaps an additional test or two to catch this sort of error
> would be warranted.

Wow, you're right! I just re-ran the tests again to make sure I didn't
miss anything. All the tests pass for me, so I'll write an extra case to
avoid this. Just to be sure, I should include it in t7030-verify-tag.sh
right?

All your other comments seem straightforward and on point. I'll apply
them right away :)

Thanks!
-Santiago.
