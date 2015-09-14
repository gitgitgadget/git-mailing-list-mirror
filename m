From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 2/2] fetch: fetch submodules in parallel
Date: Mon, 14 Sep 2015 10:47:31 -0700
Message-ID: <CAGZ79kZUdyLJzTiFXSgSezrPdG-aGgYJm6juAtpq8A_Je5JAfw@mail.gmail.com>
References: <1442012994-20374-1-git-send-email-sbeller@google.com>
	<1442012994-20374-3-git-send-email-sbeller@google.com>
	<xmqqpp1nxxji.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kaBvVWT1OPMxUAU9N2oaC5TT5wwWew5jS0k_o5J10sKfA@mail.gmail.com>
	<20150914171736.GA1548@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Vitali Lovich <vlovich@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Sep 14 19:47:38 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZbXqr-0003nM-5h
	for gcvg-git-2@plane.gmane.org; Mon, 14 Sep 2015 19:47:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751586AbbINRrd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Sep 2015 13:47:33 -0400
Received: from mail-yk0-f172.google.com ([209.85.160.172]:36700 "EHLO
	mail-yk0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751465AbbINRrc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Sep 2015 13:47:32 -0400
Received: by ykdt18 with SMTP id t18so140165287ykd.3
        for <git@vger.kernel.org>; Mon, 14 Sep 2015 10:47:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=kNqsyxqZ18G8zzUyDtoKR7Masku7a4jL2vqw89TGO2E=;
        b=AVuID4aVtJENV2Np5mhK9vhoK/8Qz9qwf6Xp68NHUq551oIlkmut2y0Ha4N+fehAqC
         qMIbnsFM6bNynoeCq7L4DlZ7HGPa5QUpj0Ng6dVkGF9itLJxD5D+Bgzx9LRPZ1qaj79j
         iYml2OZ2kOphLR2aewh9DFfcp2r3q2YxZW+BMZdpLQR/wL3Po99YHYcivnkIjJuffoav
         RENZoeMtKlUP9PH8rAmLwPdml11ideCqsTKTtSYtqrmzAVM/02/5jw4UXiGzHBI5HWQk
         5/8PVkKxXVx0TwRNacDYt751xM1zwe0rGwmjPNYnTYUA3jHuuWjv/uK7VMns1tUa3UrS
         iQDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=kNqsyxqZ18G8zzUyDtoKR7Masku7a4jL2vqw89TGO2E=;
        b=M/jVKvFxwY5Z2zvCjTZn//rBOBiLS9ExluWwJD1EFfOBpiZwh07n227rXl9wizsEvV
         XeBZZ3Jsd/vMwsLIzpb/8U4aoOLLuLlUy1RtFXj9V42W7BcJuh5Yx6nP9ypNKuiGx+7M
         /VrrouVVEbqNrWN+Bn/eP+62hg6+eCj4P3r4TxqgMaU5FhN04eXX5QA9QZPoaDBCGGyP
         yZjYKQRyfCpD1EWpMw/677Vk0W9alIGPPscHBqo+TyHmF/TaIC5hSL+lr4uV70KWgwJ4
         E1XE9ikYp9QtP7fHUNbQ5SMQeEG6BZ5KjjNDa+qmMz9CanSyJrVGWtKpblH5qkjn0fAi
         lLMw==
X-Gm-Message-State: ALoCoQlk4dRzzenteOQQsOMD2GsQzuKxM0VXsTO9yIBfTkxcpxHkiTRIbVsVn5U+cHAfHbNkxSoO
X-Received: by 10.13.222.1 with SMTP id h1mr15672463ywe.174.1442252851399;
 Mon, 14 Sep 2015 10:47:31 -0700 (PDT)
Received: by 10.37.29.213 with HTTP; Mon, 14 Sep 2015 10:47:31 -0700 (PDT)
In-Reply-To: <20150914171736.GA1548@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277852>

On Mon, Sep 14, 2015 at 10:17 AM, Jeff King <peff@peff.net> wrote:
> On Mon, Sep 14, 2015 at 09:46:58AM -0700, Stefan Beller wrote:
>
>> I tried implementing a buffering solution for both stdout and stderr,
>> but that doesn't really workout well if you consider interleaved output
>> on the pipes as we cannot accurately replay that later on. To do that
>> we would need to store the timing information of the channels, at least
>> the relative order of it like:
>>
>>   (stdout, First comes text to stdout),
>>   (stderr, interrupted by text in stderr)
>>   (stdout, but stdout doesn't bother, blasting more text)
>>   (stderr, continues to interrupt)
>>
>> obtaining the information is inherently racy, as all we can do is
>> polling/reading from both stdout/err as fast as possible but without
>> proper synchronization mechanisms we cannot be sure.
>
> I don't think you need exact timing information.  This is no different
> than running the commands themselves, with stdout and stderr writing to
> a pty that your terminal emulator will then read() from. If the program
> produces intermingled stdout/stderr that clogs up the terminal, that is
> its problem.
>
> The only difference is that we're going to save it and later replay it
> all very quickly.  So I think it would be sufficient just to retain the
> original order.
>
>> I will add documentation explaining why the async output case
>> will only deal with one channel. I chose stderr as that's already
>> available and needed in this use case.
>
> I suspect you could just set child->stdout_to_stderr in this case, and
> then you get your ordering for free. But probably in the general case
> people would want to run inspection commands that produce a useful
> stdout.
>
> To handle multiple channels, I think you could just do a linked list of
> buffers rather than a single strbuf. Like:

I will have no problem coding such a thing in a user program,
but how do you obtain this non racily from the child using the posix
API?

The poll/select command may return more than one fd ready, so
then you don't know the ordering in which you would need to replay
it. This may introduce subtle bugs?

So I'd rather come up with a solution buffering 2 channels once we need it,
keeping the stdout_to_stderr as a requirement for now.

>
>   struct io_chunk {
>         int channel;
>         char *buf;
>         size_t len;
>         struct io_chunk *next;
>   };
>
> and just keep appending chunks to the list (and to dump them, just walk
> the list, writing each to the appropriate channel descriptor).
>
> -Peff
