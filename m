From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] unblock and unignore SIGPIPE
Date: Thu, 18 Sep 2014 08:04:37 -0700
Message-ID: <CAPc5daWHUvV1tyUsz0kN0i53cSF43YeNVsC9hGdudpq60Pfzyg@mail.gmail.com>
References: <1408080565-33234-1-git-send-email-patrick.reynolds@github.com>
 <xmqqd2av1bsg.fsf@gitster.dls.corp.google.com> <20140917081148.GB16200@peff.net>
 <CAJrMUs-68cNXdh1dbRbjGBdrT0hukR7DH=mf7v05EDjL7qzP-Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Chris Packham <judge.packham@gmail.com>,
	Johannes Sixt <j6t@kdbg.org>
To: Patrick Reynolds <piki@github.com>
X-From: git-owner@vger.kernel.org Thu Sep 18 17:05:09 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XUdGb-0002rl-RO
	for gcvg-git-2@plane.gmane.org; Thu, 18 Sep 2014 17:05:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756995AbaIRPFA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Sep 2014 11:05:00 -0400
Received: from mail-la0-f52.google.com ([209.85.215.52]:41087 "EHLO
	mail-la0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756899AbaIRPE7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Sep 2014 11:04:59 -0400
Received: by mail-la0-f52.google.com with SMTP id gq15so1345558lab.11
        for <git@vger.kernel.org>; Thu, 18 Sep 2014 08:04:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=2dhG+D8G6V+HlSvIWxMqf05RGB7+LvyoYf/pcaCvj/4=;
        b=HMe5QUpZTA7VHUYyH6BBhlRcjuGtBHHoQGkFgRImWdjrrOuQQXp+PgFPUSHguL9AYu
         HYSAZQcoavjBAmpYJAoGa/78aDSG94ZlSrXS+GJU0dhkyX86ub81tWJbw/Cx+hKV3gEa
         8oxLU/0WLSBiIBnwdSVSVp7xJk10l5iPhip+MsNSh8RWAIcJs+pEHlijjHACOsFPnYiQ
         FjB7E+mpxTjOtly39Bdxz4Xw6KqkYfRCPxJOiHlfP5SP/5PsYSpbEzijBe7Mh+h+loFT
         5Dlng6XZ5J20M/fC2E2fttB8bRM9SbbvmRE4tt2OQAAkxiXz/Yf6CTRYIznSoRDbCEw1
         z8mw==
X-Received: by 10.112.54.135 with SMTP id j7mr199363lbp.51.1411052697250; Thu,
 18 Sep 2014 08:04:57 -0700 (PDT)
Received: by 10.112.209.35 with HTTP; Thu, 18 Sep 2014 08:04:37 -0700 (PDT)
In-Reply-To: <CAJrMUs-68cNXdh1dbRbjGBdrT0hukR7DH=mf7v05EDjL7qzP-Q@mail.gmail.com>
X-Google-Sender-Auth: EKgmUX7Au9kZl7OqinUSkRIQG8Q
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257261>

Thanks; just to save time, you may want to look at what has already
been queued on 'pu'.


On Thu, Sep 18, 2014 at 7:35 AM, Patrick Reynolds <piki@github.com> wrote:
> On Wed, Sep 17, 2014 at 3:11 AM, Jeff King <peff@peff.net> wrote:
>> Would we want to call it from external C commands, too? For the most
>> part, git.c is the entry point for running git commands, and any
>> sanitizing it does will be inherited by sub-commands. But it _is_ still
>> legal to call dashed commands individually, and even required in some
>> cases (e.g., git-upload-pack for ssh clients).
>
> git-upload-pack is protected pretty well from SIGPIPE shenanigans,
> because its stdout all goes through write_or_die, as of cdf4fb8.  We
> did, long ago, have some EPIPE problems with upload-pack and SSH
> clients, but it all predates cdf4fb8.
>
> So I think it's redundant to unblock SIGPIPE in git-upload-pack.
>
> I'll tidy up as Junio recommended, recheck the tests, and submit
> an updated patch shortly.
>
> --Patrick
