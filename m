From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 01/10] strbuf: Add strbuf_read_noblock
Date: Thu, 17 Sep 2015 10:45:40 -0700
Message-ID: <CAGZ79kYnZr3nb_5n-5J0vCMi7xb91y-OkrAEq8-uH2PvzmkSmA@mail.gmail.com>
References: <1442453948-9885-1-git-send-email-sbeller@google.com>
	<1442453948-9885-2-git-send-email-sbeller@google.com>
	<xmqqtwqtja6j.fsf@gitster.mtv.corp.google.com>
	<20150917163012.GB25837@sigill.intra.peff.net>
	<xmqq6139j84n.fsf@gitster.mtv.corp.google.com>
	<20150917171308.GA28046@sigill.intra.peff.net>
	<CAGZ79kaZOyqwbf+BpG2oPBBt5zj3=q-abk+F-HdkZPL3GzTzsw@mail.gmail.com>
	<20150917173536.GA28987@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Vitali Lovich <vlovich@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Sep 17 19:45:51 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZcdFm-0002fX-Hv
	for gcvg-git-2@plane.gmane.org; Thu, 17 Sep 2015 19:45:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751986AbbIQRpl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Sep 2015 13:45:41 -0400
Received: from mail-yk0-f182.google.com ([209.85.160.182]:32850 "EHLO
	mail-yk0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751371AbbIQRpk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Sep 2015 13:45:40 -0400
Received: by ykft14 with SMTP id t14so24226045ykf.0
        for <git@vger.kernel.org>; Thu, 17 Sep 2015 10:45:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=zUFm6ez8FMBnktBjzAveArdCtNRMz04JkZEkdvAw5kI=;
        b=eqhS+GNU+jYWAP2t8xMfiFKOUaHFNMu1a2OYFwpbvhZEDoCYBE9dh+0Lg2pMjmjDKf
         h73bH3SUkSssnriC9Feoh419LkYiMDNuHnHCKCp2oiW2h1jSC2a92ZVCW79Sp61usw6O
         nvPOJTMsNCUHA8XF0kSvTUcNRiZyLbmUum73ttrj2UjoYd59rKHJJbmOjBC2iqBi91QT
         9okFR4i+MAKfQ64ZYeDOffX7ozJgJKkQ1F24wKNOOZdHDQVtpd8TKDyLHXqxjp4x0555
         Kgh2vTCRDYCeEXdJa+zKqaubu4amdSSI6wjV9eHBxPQUuWJwqTY/oo1nSOB7cAsv+Dx1
         N7iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=zUFm6ez8FMBnktBjzAveArdCtNRMz04JkZEkdvAw5kI=;
        b=kE4nyWJ4LOkh2PhCeU7h4REfYlWVLGJTDF5SjhHP12jq/hg68h2xFHBeveTKrWku75
         g0Ae5z5RtpbC6+ww4JsJLN+ZstLge7rYO4Z85dRZIJQGaDAP9UBkTu7PPMTJ5Se3rScb
         jR7760GJeJI0AcMPO6QgZPywqrnJSLejoxV9PvAb0016LONz0x6mDC/2qOUnaUSfV1Sg
         +7CsYfSAaEH9TolbCgPkD+stzOhN5NgMbXP6fk3Y2NMP6jBdneZRiF7kwxPT2ucZ2uvC
         nK/1h/2aMrNg/jmoIxYbYIGJ1ZWfG7IkOEnWmB07A22Qa+vpgrU3Kg5rOuir98TRdVNQ
         NnqQ==
X-Gm-Message-State: ALoCoQmyutkyVFd4SPWe2wlCP9mUfEH5BsgWPamYoHoBGJENxjp6HP9lvtAzWjQipG72iOoCQqqK
X-Received: by 10.170.122.88 with SMTP id o85mr344080ykb.119.1442511940176;
 Thu, 17 Sep 2015 10:45:40 -0700 (PDT)
Received: by 10.37.29.213 with HTTP; Thu, 17 Sep 2015 10:45:40 -0700 (PDT)
In-Reply-To: <20150917173536.GA28987@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278151>

On Thu, Sep 17, 2015 at 10:35 AM, Jeff King <peff@peff.net> wrote:
>

>
> You _can_ loop on read until you hit EAGAIN, but I think in general you
> shouldn't; if you get a lot of input on this fd, you'll starve all of
> the other descriptors you're polling.  You're better off to read a
> finite amount from each descriptor, and then check again who is ready to
> read.

That's what I do with the current implementation. Except it's not as clear and
concise as I patched it into the strbuf_read.

>
> And then the return value becomes a no-brainer, because it's just the
> return value of read(). Either you got some data, you got EOF, or you
> get an error, which might be EAGAIN. You never have the case where you
> got some data, but then you also got EOF and EAGAIN, and the caller has
> to figure out which.
>
> So I think you really want something like:
>
>   ssize_t strbuf_read_once(struct strbuf *sb, int fd, size_t hint)
>   {
>         ssize_t cnt;
>
>         strbuf_grow(hint ? hint : 8192);
>         cnt = xread(fd, sb->buf + sb->len, sb->alloc - sb->len - 1);
>         if (cnt > 0)
>                 strbuf_setlen(sb->len + cnt);
>         return cnt;
>   }
>
> (where I'm assuming xread passes us back EAGAIN; we could also replace
> it with read and loop on EINTR ourselves).

Yeah that's exactly what I am looking for (the hint may even be over
engineered here, as I have no clue how much data comes back).

So I guess I could just use that new method now.


> I actually wonder if callers who are _expecting_ non-blocking want to
> loop in strbuf_read() at all.
>
> strbuf_read() is really about reading to EOF, and growing the buffer to
> fit all of the input. But that's not at all what you want to do with
> non-blocking. There you believe for some reason that data may be
> available (probably due to poll), and you want to read one chunk of it,
> maybe act, and then go back to polling.

As a micro project (leftover bit maybe?):
When strbuf_read is reading data out from a non blocking pipe, we're currently
spinning (with the EAGAIN/EWOULDBLOCK). Introduce a call to poll
to reduce the spinning.

>
> -Peff
