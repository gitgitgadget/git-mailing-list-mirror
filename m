From: Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [RFC PATCH, WAS: "weird diff output?" 2/2] xdiff: implement empty
 line chunk heuristic
Date: Fri, 15 Apr 2016 14:56:30 -0700
Message-ID: <CA+P7+xpqVVXNRnXNJfq7moWkuwqn8HN2iqDvd+5gLsyNc9_BgQ@mail.gmail.com>
References: <20160415165141.4712-1-jacob.e.keller@intel.com>
 <20160415165141.4712-3-jacob.e.keller@intel.com> <CAGZ79ka7h25=rHun_hPv1qjqeghXt1UwUU3Q6xT0aj4+OW87fg@mail.gmail.com>
 <xmqq8u0ebpru.fsf@gitster.mtv.corp.google.com> <CA+P7+xoWbrSaONH5xq=w5W190Jknk0Qsc5brS4UKFAs2_dTceg@mail.gmail.com>
 <xmqqzisuaa3t.fsf@gitster.mtv.corp.google.com> <CA+P7+xqe4ng9-gn1DRqhjebRXuHXbqZ6f3QsJ798k6DRo3bYyQ@mail.gmail.com>
 <CA+P7+xp7oJoOXBhexe9zhrG1dMkz8jA3yQLzyTiqMwNQ1AQVdg@mail.gmail.com> <xmqqzisu8s30.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Stefan Beller <sbeller@google.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Jeff King <peff@peff.net>, Jens Lehmann <Jens.Lehmann@web.de>,
	Davide Libenzi <davidel@xmailserver.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 15 23:56:56 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1arBjU-0003zs-62
	for gcvg-git-2@plane.gmane.org; Fri, 15 Apr 2016 23:56:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751913AbcDOV4w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Apr 2016 17:56:52 -0400
Received: from mail-ig0-f182.google.com ([209.85.213.182]:37099 "EHLO
	mail-ig0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752085AbcDOV4v (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Apr 2016 17:56:51 -0400
Received: by mail-ig0-f182.google.com with SMTP id g8so35140935igr.0
        for <git@vger.kernel.org>; Fri, 15 Apr 2016 14:56:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=oSU+N8mW/kz34mQq6zaWGk/nNfHjoNTJ+c5Aj+bJhzo=;
        b=boBXl30GQWW8HwvseJVp6W8Gz9qUCoLeBf4bB6gJuLkrh0yVa6dsTx4T623u3YO2gG
         OjHibNd5apqte7bcFHgYloL8sUbka/2c3pWVCw3PUbLXUQW2NzDhjPSpIgiNFnTLW5Qq
         cCWS1vybWyzhhOPFay54ifDya1V9qeCuvDMQJxFDez6FAnYKYPBXuIN3YNz4dEnOo2C2
         iUfbpxCmsfNBClRrXqgTGzbA7yHVlhVRc5e5GXsLO7KloMlv5EuyzFNv2CzuQbDa977h
         cP10iZv/LbxDqeZFQ1L4Q3JA2X8WRd8iwXaH+YACdIeTtwUe7mnqf5Iwyf00N2sBY1GL
         j2Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=oSU+N8mW/kz34mQq6zaWGk/nNfHjoNTJ+c5Aj+bJhzo=;
        b=BVn9RKrvuzL6ao4Ft3Y28h3wAyM6HnhA3XqzaJW2nk9EyT90SUw9jI5V2ZDfX2tHuR
         06aNvEAo8tAKxcAfXbd7nVpaPQVw/lDgcL/tBpLZtfQbGjSEsWpEaVqJ2Zs0zN4Mh5za
         imaTE1reVEw48Gg1ilxONRcmGS2XvZ0HSPipXteAZrPPvVGhmuGQF2EVv6WQRS3kHBDZ
         OWlpd44UfZw/ciJFmKAlEw7fJvLyyzsleIc4MnSdFlV+I7gdiBfp9uVresqFmzrI1Os9
         4udzPmM0lV7jl8wPhBNpYvtZWJ6x+ppzlrYU3ulju3B3En+SD+pkfXPgT4hbiNGsAGjM
         mlJw==
X-Gm-Message-State: AOPr4FXA7eg8U2d0EVA6A9X4nA6pROBjZp8cwOZpyktOLa9VGLWgB3WjTkOZNoMEtNriSIoN+tlIJI2tBvykSA==
X-Received: by 10.50.189.233 with SMTP id gl9mr7065993igc.73.1460757410251;
 Fri, 15 Apr 2016 14:56:50 -0700 (PDT)
Received: by 10.107.59.78 with HTTP; Fri, 15 Apr 2016 14:56:30 -0700 (PDT)
In-Reply-To: <xmqqzisu8s30.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291675>

On Fri, Apr 15, 2016 at 2:44 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Jacob Keller <jacob.keller@gmail.com> writes:
>
>>>> What you have is a pure developer support; aim to come up with "good
>>>> enough" way, giving developers an easier way to experiment with, and
>>>> remove it before the feature is shipped to the end user.
>>
>> What are your thoughts on adding this do the gitattributes diff
>> section? Ie: modifications to the diff driver.
>
> I do try to foresee the future needs but I try to limit the forecast
> to "just enough so that we won't waste engineering effort on a wrong
> thing".  "It may need to be turned off conditionally" suggests we
> would want attributes added per path, and that is sufficient to make
> me say "don't waste time on bikeshedding configuration variable
> names, it will not be in the final product".
>
> We do not need yet to know what the final name of the attributes
> are, or how exactly the bit to affect the low level mechanism will
> be set by the attribute mechanism.  I do not think this topic is
> there yet, and it is a waste of engineering effort to prematurely
> trying to make things too flexible and customizable, when the thing
> that will eventually become flexible by conditionally enabled is not
> even there yet.
>
> As long as the low-level thing has a knob, set of internal bits, to
> enable and disable it, that is all that is necessary to know at this
> point.
>
> Having said all that, I'd expect we'd compute the right bit to use
> in the same place where we currently pick the custom textconv
> driver, diff backend, etc., by consulting the attribute system
> before running the diff.
>
> But again, I'd think it would be waste of time to think beyond that
> at this point, identifying exactly at which line of which source
> file the new code would go and what that new code would look like,
> until we are ready to start integrating it.

Ok, for now I'll leave this as is then.

Thanks,
Jake
