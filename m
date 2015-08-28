From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 7/9] fetch: fetch submodules in parallel
Date: Fri, 28 Aug 2015 11:59:43 -0700
Message-ID: <CAGZ79kboFpySoTTwLQ5N2pOZSvw9HjEBhB-vmQ4-nP8RD7b63Q@mail.gmail.com>
References: <1440724495-708-1-git-send-email-sbeller@google.com>
	<1440724495-708-8-git-send-email-sbeller@google.com>
	<CAGZ79kbTAVDVmw+MrXvky6tJWZcG97tT_KAxV7S-pKCiNqRp3g@mail.gmail.com>
	<20150828170141.GB8165@google.com>
	<xmqqfv332v84.fsf@gitster.mtv.corp.google.com>
	<20150828182008.GC8165@google.com>
	<xmqqpp271d6v.fsf@gitster.mtv.corp.google.com>
	<20150828183501.GA17222@sigill.intra.peff.net>
	<CAGZ79kZALSJ9oY+6ZwyQ9CPFiV-AAq7c-r9mxw3N+gvsDw8m4A@mail.gmail.com>
	<20150828184405.GA17721@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Aug 28 20:59:53 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZVOsS-00087a-Jh
	for gcvg-git-2@plane.gmane.org; Fri, 28 Aug 2015 20:59:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752394AbbH1S7o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Aug 2015 14:59:44 -0400
Received: from mail-yk0-f180.google.com ([209.85.160.180]:36649 "EHLO
	mail-yk0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751920AbbH1S7o (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Aug 2015 14:59:44 -0400
Received: by ykek5 with SMTP id k5so10868186yke.3
        for <git@vger.kernel.org>; Fri, 28 Aug 2015 11:59:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=VwXXqx+A1uNe7X/ZpuHPYs+b4ILCIAmqFvLhopc3kdo=;
        b=Jlb1IzvXiesguEJ0QCpdqjvyql1MwGvpYHLYcqmg23j0XP38RycQRet5jgQhT6fdXj
         RPoOskrBxNqXT+OYAygFNbco+UIZSLTepwf/dVH1J1yg8VTxyp9rb0P/UiIhkooHuj83
         96pYDiwyYQnxtNhEQ6ew56niH2Ze9Jxhzxt3Dp2Wm74bj+FfkiV8yYT58Jll19TyuEYQ
         2UugWXI0Z5ekXN+Hx5fD3pUdH5YAijd79cDiZ9D6PgAjqChbuBeTbmd6FbSk0d1uwR2c
         mfXaw7AKele6tDXEPOXNqffNkM4038lXGoXJl4/YQNRSvS9dNNVFfEW3sa7JG2rJN5F9
         WiFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=VwXXqx+A1uNe7X/ZpuHPYs+b4ILCIAmqFvLhopc3kdo=;
        b=gihtB+g5OQpgldD6A9EZ7ooLjtjfej7n/mjz+KYomGFRPbqheSn/AKVfpzA8qdPudB
         jYAo8PLXmZfa+k97qqgmpGZ7BZuobkDVfT4bbe3cf51Y765XI0OrOPytthlG/kjthFZA
         lyeAQcBORLF8tbG352KLIFbuuKMmlzvOZ+B+H+vwzz1npF1CKbOrvGDmGEnxaLPukqK4
         lnU8kE7VsvdaIYzSVWZyvfpVl17jlHRm9FisY6s/arjVvce9/wa4aWdpzJTIXZeHbcNT
         C37PBc4N2Q0W3VmkELGK+mud7yBReEhKPmJmYdBpoBdvqdHBRuOhlg1t3XPrUniWalaK
         iZRw==
X-Gm-Message-State: ALoCoQlWBSdKCyX5zRpyEwHfpI1M53bBGFyhyx2kZ4Tz5rFOzR6xc5I0h6bCkSkmHU9wwqQygBJ+
X-Received: by 10.13.222.1 with SMTP id h1mr10379989ywe.174.1440788383362;
 Fri, 28 Aug 2015 11:59:43 -0700 (PDT)
Received: by 10.37.21.132 with HTTP; Fri, 28 Aug 2015 11:59:43 -0700 (PDT)
In-Reply-To: <20150828184405.GA17721@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276756>

On Fri, Aug 28, 2015 at 11:44 AM, Jeff King <peff@peff.net> wrote:
> On Fri, Aug 28, 2015 at 11:41:17AM -0700, Stefan Beller wrote:
>
>> > So to an observer, it would look like a serial operation, but subsequent
>> > operations after the first would magically go much faster (because
>> > they'd been working and buffering in the background).
>> >
>> > And that doesn't require any additional IPC magic (though I am not sure
>> > how we get progress in the first place if the child stderr is a
>> > pipe...).
>>
>> Moving the contents from the pipe to a strbuf buffer which we can grow
>> indefinitely
>> (way larger than pipe limits, but the output of a git fetch should be
>> small enough for that).
>
> Right, clearly we can't rely on pipe buffers to be large enough here
> (though we _may_ want to rely on tempfiles if we aren't sure that the
> stdout is bounded in a reasonable way).
>
> But what I meant was: the child will only show progress if stderr is a
> tty, but here it is not.

Oh, I forgot about that.

>
> I wonder if we need to set GIT_STDERR_IS_TTY=1 in the parent process,
> and then respect it in the children (this is similar to what
> GIT_PAGER_IN_USE does for stdout).

The use of GIT_PAGER_IN_USE looks straightforward to me. I'll try to add
GIT_STDERR_IS_TTY then.


>
> -Peff
