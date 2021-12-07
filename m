Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C5A0C433F5
	for <git@archiver.kernel.org>; Tue,  7 Dec 2021 14:50:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237926AbhLGOx6 convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Tue, 7 Dec 2021 09:53:58 -0500
Received: from elephants.elehost.com ([216.66.27.132]:16325 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbhLGOx5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Dec 2021 09:53:57 -0500
X-Virus-Scanned: amavisd-new at elehost.com
Received: from Mazikeen (cpe00fc8d49d843-cm00fc8d49d840.cpe.net.cable.rogers.com [99.229.22.139] (may be forged))
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id 1B7EoMlW072535
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 7 Dec 2021 09:50:22 -0500 (EST)
        (envelope-from rsbecker@nexbridge.com)
Reply-To: <rsbecker@nexbridge.com>
From:   <rsbecker@nexbridge.com>
To:     "'Robert Coup'" <robert.coup@koordinates.com>
Cc:     <git@vger.kernel.org>, <avarab@gmail.com>
References: <001501d7eaf6$79d8e170$6d8aa450$@nexbridge.com> <CAFLLRp+yakYKxeGHjvg-8s-5QP8GqMeA5t+azfny=v6wtPPW2A@mail.gmail.com>
In-Reply-To: <CAFLLRp+yakYKxeGHjvg-8s-5QP8GqMeA5t+azfny=v6wtPPW2A@mail.gmail.com>
Subject: RE: [Question] Switching the URI from SSH to HTTPS for submodules
Date:   Tue, 7 Dec 2021 09:50:17 -0500
Organization: Nexbridge Inc.
Message-ID: <00b901d7eb79$c374f070$4a5ed150$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQLS8uQa68NLdYMjzyL1Ti0pjcbf7gMNtF3fqhifRlA=
Content-Language: en-ca
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On December 6, 2021 6:54 PM, Robert Coup wrote:
> On Mon, 6 Dec 2021 at 23:10, <rsbecker@nexbridge.com> wrote:
> >
> > git@bitbucket.org:project/module.git
> >
> > When in SSH mode, clones are simple with --recurse-submodules doing
> > what we want. However, we had to clone on a system where SSH was
> > locked down and we could only use HTTPS. The form of the URIs changed
> rather radically:
> >
> > https://user@bitbucket.org/project/repo.git
> >
> > I'm looking for better practices than I used - I'm sure there is at least one.
> 
> AFAIK the existing `url.<base>.insteadOf` config option[1] deals with this...
> 
> [1] https://git-scm.com/docs/git-config#Documentation/git-config.txt-
> urlltbasegtinsteadOf
> 
>     $ git config --global url."https://user@bitbucket.org/".insteadOf
> "git@bitbucket.org:"
> 
> If you don't want to set it globally (not a throwaway CI environment?) then
> you can do it as a one-off:
> 
>     $ git -c url."https://user@bitbucket.org/".insteadOf="git@bitbucket.org:"
> clone --recurse-submodules git@bitbucket.org:repo/project.git
> 
> But it isn't persisted into your repo config then, so subsequent fetches won't
> work. You'd need to persist it using something like:
> 
>     $ git config url."https://user@bitbucket.org/".insteadOf
> "git@bitbucket.org:"
>     $ git submodule foreach --recursive 'git config
> url."https://user@bitbucket.org/".insteadOf "git@bitbucket.org:" '
> 
> Maybe there's an opportunity to make that part easier?

Well, I gave this a shot. The mapping did not appear to work - I tried a few combinations. I was left with the original URIs. Note that I also had to do 

$ git submodule init

which reported the wrong URIs

$ git submodule update

which obviously failed since they were still using SSH.

I think there may be something not working correctly with the insteadOf operator. This is easily reproduceable. 

-Randall

