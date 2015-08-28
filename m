From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 7/9] fetch: fetch submodules in parallel
Date: Fri, 28 Aug 2015 11:41:17 -0700
Message-ID: <CAGZ79kZALSJ9oY+6ZwyQ9CPFiV-AAq7c-r9mxw3N+gvsDw8m4A@mail.gmail.com>
References: <1440724495-708-1-git-send-email-sbeller@google.com>
	<1440724495-708-8-git-send-email-sbeller@google.com>
	<CAGZ79kbTAVDVmw+MrXvky6tJWZcG97tT_KAxV7S-pKCiNqRp3g@mail.gmail.com>
	<20150828170141.GB8165@google.com>
	<xmqqfv332v84.fsf@gitster.mtv.corp.google.com>
	<20150828182008.GC8165@google.com>
	<xmqqpp271d6v.fsf@gitster.mtv.corp.google.com>
	<20150828183501.GA17222@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Aug 28 20:41:22 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZVOaX-0005dP-VX
	for gcvg-git-2@plane.gmane.org; Fri, 28 Aug 2015 20:41:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752270AbbH1SlS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Aug 2015 14:41:18 -0400
Received: from mail-yk0-f173.google.com ([209.85.160.173]:34987 "EHLO
	mail-yk0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751787AbbH1SlR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Aug 2015 14:41:17 -0400
Received: by ykay144 with SMTP id y144so8922882yka.2
        for <git@vger.kernel.org>; Fri, 28 Aug 2015 11:41:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=xNJsxfvGmolramHyhgphYiivVlGwA0V6hGdaYnFJpkM=;
        b=TLSJK9TFmTc0912fToIeaubIepxqeuo9ZHgqpgQt2XkgVe6pDF7tD8i9N3Lqo6FwhI
         qx5faDZwYWA5UOzstiIaT9fvCrrQov6IgcRyUMz3Ek82YW3Od/Vt3xBxqLjZGwaP+jRl
         r6V11VuFJMVCFphkIn8Il1z0zrkVSsG6n2K5Y1qhR3Mub3Fc5Ra8iK2iuCwA9mo8FtIQ
         QL/FCbKJ4iqnV2siQWUg2gXz+E5jAXtsrtIMuOCA4xkMF5V38S3UTCtE5YfsXq7bk3Wd
         TbD1l799AqLSh7xe3VAA9cI9ZJJqseT0eXFLMrU0V4SkTGg3HKqCd419mSY3LnGG7zkt
         AWBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=xNJsxfvGmolramHyhgphYiivVlGwA0V6hGdaYnFJpkM=;
        b=XVR35c58NN7xrnAx/62ZdLsl/1O0BLmLWIVhxG021u8SrjNx17ENBSGeY1YdVjjoVv
         9D9FafXsPoFICVrgAF8fYoCT+GKlHrhLfPBar7Usi0xXEk4PlPnZW+apckUoGZ7ltSsK
         UHHW4pCOduWAcTPeNZBQ1cIV0b5GJKAt3jhA4ITRnCbrvIkjfLIdkC26Rd+8TWuZW8Cz
         37VXXNA0kWyGP1ffQ9mYGFBjNgRDiDVfU/cn/otcwDvohHgPH8SGKmducheXb8W7BzPX
         TJdvbwEIxXXV1LP8QLc4Rlu/IsjXto6vS8wmmyo+uMiM3creYJw2iU8JQVAmTyerb5Px
         pajA==
X-Gm-Message-State: ALoCoQlTkYuJoCYAZNgLl1jCn+qzSluR0sdGmpew43795zxwQ4wEBelrgMUUCFpEWWmypGDYMkvS
X-Received: by 10.129.90.196 with SMTP id o187mr10079746ywb.32.1440787277208;
 Fri, 28 Aug 2015 11:41:17 -0700 (PDT)
Received: by 10.37.21.132 with HTTP; Fri, 28 Aug 2015 11:41:17 -0700 (PDT)
In-Reply-To: <20150828183501.GA17222@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276750>

On Fri, Aug 28, 2015 at 11:35 AM, Jeff King <peff@peff.net> wrote:
> On Fri, Aug 28, 2015 at 11:27:04AM -0700, Junio C Hamano wrote:
>
>> > But for commands that show progress like "git clone", "git checkout",
>> > and "git fetch", it does not work well at all.  They provide output
>> > that updates itself by putting a carriage return at the end of each
>> > chunk of output, like this:
>> >
>> >  remote: Finding sources:  11% (18/155)           \r
>> >  remote: Finding sources:  12% (19/155)           \r
>> >
>> > With multiple commands producing such output, they will overwrite each
>> > other's lines, producing a mixture that is confusing and unuseful.
>>
>> That example also illustrates why it is not a useful to buffer all
>> of these lines and showing them once.
>
> I think Jonathan's point is that you could pick _one_ active child to
> show without buffering, while simultaneously buffering everybody else's
> output. When that finishes, pick a new active child, show its buffer,
> and then start showing its output in realtime. And so on.

or better yet, pick that child with the most progress (i.e. flush all finished
children and then pick the next active child), that would approximate
the progress in the output best, as it would reduce the hidden
buffered progress.

>
> So to an observer, it would look like a serial operation, but subsequent
> operations after the first would magically go much faster (because
> they'd been working and buffering in the background).
>
> And that doesn't require any additional IPC magic (though I am not sure
> how we get progress in the first place if the child stderr is a
> pipe...).

Moving the contents from the pipe to a strbuf buffer which we can grow
indefinitely
(way larger than pipe limits, but the output of a git fetch should be
small enough for that).



>
> -Peff
