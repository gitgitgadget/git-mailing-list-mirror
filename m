From: Shawn Pearce <spearce@spearce.org>
Subject: Re: git fetch sha1
Date: Fri, 4 Jul 2014 13:41:11 -0700
Message-ID: <CAJo=hJvjg0G+DiRhyh=9jnRTPjWma7zQv90VsW8Bx1WyvsQTLg@mail.gmail.com>
References: <CABo2x6A_cA8KoFbe4Hcg0SJw+gOGeOFun3VDM1gx3ZVWK8wy3Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>
To: Allan Gardner <allanegardner@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 04 22:41:37 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X3AIa-0000i7-QW
	for gcvg-git-2@plane.gmane.org; Fri, 04 Jul 2014 22:41:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753549AbaGDUld (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Jul 2014 16:41:33 -0400
Received: from mail-ie0-f175.google.com ([209.85.223.175]:43316 "EHLO
	mail-ie0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752107AbaGDUlc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Jul 2014 16:41:32 -0400
Received: by mail-ie0-f175.google.com with SMTP id tp5so1797805ieb.6
        for <git@vger.kernel.org>; Fri, 04 Jul 2014 13:41:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spearce.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=6a7CLbra9JY1oKfw7D9RRQd2QSAfD6wI4Wj4lcPADPU=;
        b=KQjoUZ6z2L64600Ucrmh1pgP9/G/0LspYXzXMMF5mRcl4+5+f/xVTmRBEuZGaC+LEu
         9yiISUIl3FOyPLhsTJudN9gQIZzfW3GCqLnmKvZQFFu94+JBlgsRuug4U0ia/ftdonxj
         AeLT//UL44CSNIBEBK/z2Z1oHJCO3+5n0oa78=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=6a7CLbra9JY1oKfw7D9RRQd2QSAfD6wI4Wj4lcPADPU=;
        b=hpi1Sr0EtjpekYoRyxDgxHmXnZ8Ha5CNVXMp8dKZvkWGOtU/yVp0CFSIQmGksc7Ai0
         65yFvy/bQI2XZGKCEJkikN8431qFcT9KpWMceP67Y2B/5763KhBq0knGhERTc+vu0d1g
         hEzjwh/6H23OweVVlnRVLz8nUarJEd7el+2uV27Bh4//h5aMU9MzOH6KWNZL5Ct/+8d/
         PXChOgGKOBZZMb9xnCKfRGVNdf+EmmT4uQN+vgT9y44tPy3In6m5JgWJ1rjtfXmDwdeK
         Bx5wHU4mWpKjKhEmUpCFrH7ObkXkspLnGwHr9XGJQS4X4DvB5VGiXJ0VHWSpNRjXKq5Q
         Hang==
X-Gm-Message-State: ALoCoQm29/ip28P1jbWXP76bYAkrogrtNPgLPQtQ9lQGSQMFTdOvHetgCqNjp4RzcDpxIRltU/Jt
X-Received: by 10.43.156.77 with SMTP id ll13mr4362940icc.81.1404506491476;
 Fri, 04 Jul 2014 13:41:31 -0700 (PDT)
Received: by 10.64.19.146 with HTTP; Fri, 4 Jul 2014 13:41:11 -0700 (PDT)
In-Reply-To: <CABo2x6A_cA8KoFbe4Hcg0SJw+gOGeOFun3VDM1gx3ZVWK8wy3Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252903>

On Fri, Jul 4, 2014 at 10:51 AM, Allan Gardner <allanegardner@gmail.com> wrote:
> Currently fetching a sha1 fails on git.kernel.org:
>
> $ git --version && uname -a
> git version 1.9.4
> Linux nixos 3.12.23 #1-NixOS SMP Thu Jan 1 00:00:01 UTC 1970 x86_64 GNU/Linux
>
> $ rm -rf test && mkdir test && cd test && git init
> Initialized empty Git repository in ~/test/.git/
>
> $ git fetch --depth 1 https://git.kernel.org/pub/scm/git/git.git
> 782735203c316041df120748e5e88c1787cdf4da
> error: no such remote ref 782735203c316041df120748e5e88c1787cdf4da
>
> I tried with head, same error. However, if I clone the full repository
> and then manually execute git upload-pack, it successfully fetches the
> commit:
>
> $ git fetch https://git.kernel.org/pub/scm/git/git.git master
> <wait an hour>
> $ git checkout -b sha1 782735203c316041df120748e5e88c1787cdf4da
> $ printf "0045want %s multi_ack_detailed\n000Ddeepen
> 1\n00000009done\n0000" "782735203c316041df120748e5e88c1787cdf4da"
>>input
> $ cat input | git upload-pack --stateless-rpc . > output
> $ sed -z "s/.*0008NAK\n//" < output > output.pack
> $ git index-pack output.pack && git verify-pack -v output.pack | grep commit
> f239687a5dbbd1bbb761d09edec582418c66c297
> 782735203c316041df120748e5e88c1787cdf4da commit 374 234 12
>
> So theoretically this is supported server-side. Unfortunately
> kernel.org does not agree:

No, it is not supported server side. Your test didn't even test what
you think it tested.

$ curl https://git.kernel.org/pub/scm/git/git.git/info/refs?service=git-upload-pack
2>/dev/null | head -n 2
001e# service=git-upload-pack
0000009b6f92e5ff3cdc813de8ef5327fd4bad492fb7d6c9 HEADmulti_ack
thin-pack side-band side-band-64k ofs-delta shallow no-progress
include-tag multi_ack_detailed

The capability you are asking about is allow-tip-sha1-in-want which
does not appear in the server advertisement. So its not supported on
this server.
