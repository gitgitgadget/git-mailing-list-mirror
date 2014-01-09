From: Francesco Pretto <ceztko@gmail.com>
Subject: Re: [RFC v2] submodule: Respect requested branch on all clones
Date: Thu, 9 Jan 2014 02:09:37 +0100
Message-ID: <CALas-igFQtG1qa2+grMAtZ9mDE-xGuXkDGwGvSXL8_FzPfXBLQ@mail.gmail.com>
References: <20140106160202.GE27265@t2784.greatnet.de> <CALas-ijXQFcUHWk-jJrLifqsMHAKo6NNKya+jR6RJGGDXY76hg@mail.gmail.com>
 <CALas-ijNgaTQr77DZw3acypgaJHpDFVnGdq97ECM4zu+CPma0w@mail.gmail.com>
 <xmqqd2k3ejfr.fsf@gitster.dls.corp.google.com> <CALas-ihPmJSf9eH0P7Vf28pB4zN_dsa_2=fe+_moZgiP0C3UTA@mail.gmail.com>
 <20140107194503.GA26583@odin.tremily.us> <20140107223858.GB10782@sandbox-ub>
 <CALas-ihk6cVfosQ+Ov4QKUcfzvbXrYSonQvsN8Ay1+GTq_Ae-w@mail.gmail.com>
 <20140108010504.GE26583@odin.tremily.us> <CALas-iheQ4Rfxvty5guEieVwa8SffRnhRdHkNXUKwmuHRXD2Xg@mail.gmail.com>
 <20140109000338.GM29954@odin.tremily.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Heiko Voigt <hvoigt@hvoigt.net>,
	Junio C Hamano <gitster@pobox.com>,
	Git <git@vger.kernel.org>, Jens Lehmann <Jens.Lehmann@web.de>,
	Jonathan Nieder <jrnieder@gmail.com>
To: "W. Trevor King" <wking@tremily.us>
X-From: git-owner@vger.kernel.org Thu Jan 09 02:10:26 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W148f-0001st-GV
	for gcvg-git-2@plane.gmane.org; Thu, 09 Jan 2014 02:10:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756948AbaAIBKA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jan 2014 20:10:00 -0500
Received: from mail-ob0-f172.google.com ([209.85.214.172]:60088 "EHLO
	mail-ob0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754859AbaAIBJ6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jan 2014 20:09:58 -0500
Received: by mail-ob0-f172.google.com with SMTP id gq1so2578498obb.17
        for <git@vger.kernel.org>; Wed, 08 Jan 2014 17:09:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=L0co9X+wDs4/QDphbFmYd2TxTbkojdc5RuNM+Bxok8Q=;
        b=tpBeQ43+3nrrrCQ7AzU9qjj6r47fp3csb9xBjscZ8pdP2VNEsY4FoOwI4zabuz6OZt
         aWvhCfE2baWW+zBZSRzNLo8XkZac0Q/22A/QLwg2B1pvr/fNMGm3Avtz9MchoVMPuST7
         OIGbRQcoHB0kh+khGOypxw8eO9zVNhitXXcd3VFXnMyM/HVR7vTJ4B747Gm14kYL2cb/
         fnJGwrhBHNDcepVzXiaKfli65X8u5tLRPTsXrnJ5GbC7DLn/XWaVi/11HbhlzOYjnTNz
         41VREY8Lg1p7XCuHZbydJkvR6Rcxh79gI6kJvf9hFrqWUhBnULNeJQbHzkWr3nXbHwGK
         34Gw==
X-Received: by 10.182.16.33 with SMTP id c1mr240558obd.4.1389229798136; Wed,
 08 Jan 2014 17:09:58 -0800 (PST)
Received: by 10.76.80.165 with HTTP; Wed, 8 Jan 2014 17:09:37 -0800 (PST)
In-Reply-To: <20140109000338.GM29954@odin.tremily.us>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240239>

2014/1/9 W. Trevor King <wking@tremily.us>:
>
> However, submodule.<name>.local-branch has nothing to do with remote
> repositories or tracking branches.

My bad: this means the feature is still not entirely clear to me.

>
>   [branch "my-feature"]
>         remote = origin
>         merge = refs/heads/my-feature
>         [submodule "submod"]
>             local-branch = "my-feature"
>
> and I don't think Git's config supports such nesting.
>

Aesthetically, It doesn't look very nice.

>
> I can resuscitate that if folks want, but Heiko felt that my initial
> consolidation didn't go far enough [2].  If it turns out that we're ok
> with the current level of consolidation, would you be ok with
> "non-checkout submodule.<name>.update" as the trigger [3]?

For me it was ok with what you did:
-------------------------------------------------
if "just_cloned" and "config_branch"
then
     !git reset --hard -q"
fi
-------------------------------------------------

So yes: at the first clone 'checkout' keeps attached HEAD, while
'merge' and 'rebase' attach to the branch.
If it's not the first clone, you should take no action (and your
original patch was ok about this).

>  I think
> that adding a halfway step between the current status and full(ish)
> submodule.<name>.local-branch support is just going to confuse people

Well, for now you got some success in confusing me with this "local-branch" :)

At certain point  you may ask maintainers what are the accepted
features (because all these debates should be about getting, or not
getting, endorsement about something) and finalize a patch so people
can further review.
