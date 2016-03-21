From: Paul Tan <pyokagan@gmail.com>
Subject: Re: [PATCH/RFC/GSoC 05/17] rebase-options: implement
 rebase_options_load() and rebase_options_save()
Date: Mon, 21 Mar 2016 22:55:09 +0800
Message-ID: <CACRoPnTeb78JSN+bTM04u6E5E=fMWY1h6ef0GDDP0DoaADuTNQ@mail.gmail.com>
References: <1457779597-6918-1-git-send-email-pyokagan@gmail.com>
	<1457779597-6918-6-git-send-email-pyokagan@gmail.com>
	<CAGZ79kYeYzi=J=dY27FqXp72BRe-Vmm4MR5Q6dFTMUP9CxYZcg@mail.gmail.com>
	<alpine.DEB.2.20.1603160901520.4690@virtualbox>
	<CACRoPnS4JpNNACz4T0F0vFs3ogG+nzk-y1=zc1UrtAZKaEnggg@mail.gmail.com>
	<alpine.DEB.2.20.1603161802080.4690@virtualbox>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Stefan Beller <sbeller@google.com>, Git List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Duy Nguyen <pclouds@gmail.com>,
	Sam Halliday <sam.halliday@gmail.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Mar 21 15:55:23 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ai1Ej-0005x6-E9
	for gcvg-git-2@plane.gmane.org; Mon, 21 Mar 2016 15:55:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756022AbcCUOzM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Mar 2016 10:55:12 -0400
Received: from mail-lb0-f179.google.com ([209.85.217.179]:33655 "EHLO
	mail-lb0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755500AbcCUOzL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Mar 2016 10:55:11 -0400
Received: by mail-lb0-f179.google.com with SMTP id oe12so128129302lbc.0
        for <git@vger.kernel.org>; Mon, 21 Mar 2016 07:55:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=vdjk7VPUbXPNfZvFqLPqBbwvjUE3LGGgKoVoBTuBLXw=;
        b=yz3XsDrJk4eIRau2AR9sQ+HljQEyBqVvDw2y6pRf8nzLgAruotPykVIsqx3YcellYn
         jizANae36lMz2leZU0JTytqaMVBytssRZDoKvwsyxvqq+ec8c+Uy5siQVjb3UUCjlmSk
         OVkvwrkz3hvIkF8T1ekACyxq9gNctsTZD105yluOrD0IKsgwZBMu7O4djBs4iR+d9EJI
         59QrIiQ/q90rj8FmkJa6ZauhyEj/JncMoQM77COXd72/9rdhHK5ELOLt6ISPOB7PbWCG
         urauaOEfunpgxnc5DiZFi6gEH9tT60K5R+8EbwrD9FdA6Kjfq77Me1DAJMYEoGuIqjmv
         VjEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=vdjk7VPUbXPNfZvFqLPqBbwvjUE3LGGgKoVoBTuBLXw=;
        b=De+DeayG1jA4Xy3LpoIpB8aEVRMFmAdZOr0f+59Ul6M+nsuuEKhaQU8H/BfkifZowQ
         uLXGS1UPGrMQmTML7FqlZNsXj35cdc9equYtMj1qVKy4JWG/Tkkg36/G0e5XoA2NEUPx
         YpzGvp0VvcP2xW0E3g160s+aVxrQEukZwhjwS7HdSIdUJmdz2j/T7dUwrPYlR7jZxnmP
         q5DPkJ5NRlYcShBO1465dIHXPSjPrdGL6bLhS+C8uSpXUjF6fJyD27Z8k14qWGYvMfgY
         zS4zWlWyTigGZx5C5ftKph7jx2QwtpouV88RivIMoDKFwknxYCWfUSLddT1lzu5lIrJV
         E66A==
X-Gm-Message-State: AD7BkJJfNOy0dor1o0SANhSJ2wIUVov/0yBdzeklVTc63NvWWQgctwKDPat7nwwDpVu0TjuIO9h+GIe2PBnKXw==
X-Received: by 10.112.173.71 with SMTP id bi7mr11018442lbc.93.1458572109961;
 Mon, 21 Mar 2016 07:55:09 -0700 (PDT)
Received: by 10.112.207.74 with HTTP; Mon, 21 Mar 2016 07:55:09 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.20.1603161802080.4690@virtualbox>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289418>

Hi Dscho,

(Sorry for the very late reply, I got caught up with some unexpected
work and am still clearing my inbox ><)

On Thu, Mar 17, 2016 at 1:11 AM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> On Wed, 16 Mar 2016, Paul Tan wrote:
>> On Wed, Mar 16, 2016 at 4:04 PM, Johannes Schindelin
>> <Johannes.Schindelin@gmx.de> wrote:
>> > In addition I want to point out that sequencer's replay_opts seem to be at
>> > least related, but the patch shares none of its code with the sequencer.
>> > Let's avoid that.
>> >
>> > In other words, let's try to add as little code as possible when we can
>> > enhance existing code.
>>
>> Well, both git-rebase--am.sh and git-rebase--merge.sh do not use the
>> sequencer functionality at all, and we don't see git-am for example
>> needing to be aware of onto, orig-head, head-name etc.
>
> That is arguing that the implementation of --am and --merge is too far
> away from the sequencer and therefore should not be made closer.
>
> By that token, has_unstaged_changes() should never be allowed to call
> init_revisions(): it *never* looks at any revisions at all!
>
> And the idea of the sequencer is so much more related to --am and --merge
> than unstaged changes are to revisions: the entire purpose of the
> sequencer (no matter the *current* implementation with all its
> limitations) is to apply a bunch of patches, in sequence. That is pretty
> much precisely what *all* members of the rebase family are about.
>
> In other words: please do not let current limitations dictate that we
> should introduce diverging code for essentially the same workflow.

Ah, so you are thinking of replacing the --am and --merge scripts with
sequencer? That sounds great :-)

I'll wait for your sequencer patch series then.

Thanks!
Paul
