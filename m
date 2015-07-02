From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [RFC/PATCH] worktree: replace "checkout --to" with "worktree new"
Date: Fri, 3 Jul 2015 05:41:41 +0700
Message-ID: <CACsJy8CwnWj80=4GGY4VnHnbxb_tL1Vg8S16rybmwGpgbSEexQ@mail.gmail.com>
References: <1435640202-95945-1-git-send-email-sunshine@sunshineco.com>
 <xmqqr3orakex.fsf@gitster.dls.corp.google.com> <CAPig+cRLpJK-C7MApH1vigZS=gmHNeo6RL3S2wXv4B-TFfnq4g@mail.gmail.com>
 <CACsJy8BdvLiM8Ki=N1k-fBrqqoEONhjwcN6jzGUk=3NPRRujQw@mail.gmail.com>
 <CAPig+cT=U6LxpJuUMaCd-x=gQPvh89SDNUo12+2_3uYb_q3=Og@mail.gmail.com>
 <CACsJy8Dce4ErwaRM7zTgLmRzcHxKOr4J8St46urettr5R4DbVg@mail.gmail.com>
 <CACsJy8CYtey9d6dFhf+bKCPe0aKzm1GNURDR0sJ4NNEmdZeLGQ@mail.gmail.com> <CAPig+cR1uLa7yiDn9EnTzfkDTOoToc6BTDRn5sYr12yPr6rXPg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Fri Jul 03 00:42:21 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZAnBU-0008Sa-PC
	for gcvg-git-2@plane.gmane.org; Fri, 03 Jul 2015 00:42:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753674AbbGBWmN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Jul 2015 18:42:13 -0400
Received: from mail-ie0-f177.google.com ([209.85.223.177]:35936 "EHLO
	mail-ie0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753559AbbGBWmL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Jul 2015 18:42:11 -0400
Received: by iecvh10 with SMTP id vh10so66540997iec.3
        for <git@vger.kernel.org>; Thu, 02 Jul 2015 15:42:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=dyc9nsbv41IxW0CRscIGDPEmbDIPd/1bwqS9Wyaelxk=;
        b=lICjRrJNiz4nbEUdbuDCBdF2yRYKL4aBasfCz/y8/biORwb02+nsloB08YI2hq0PhG
         E4SFy/Cg2fmSn+GVmVQgkKpek7dTQycfh2HS065D7OfVXNuD8ATbjKDYQKBkNCJY/ZgN
         l+MduxB/jKVxKphYZ5zLKmNl+QIqultrz3EJzRu6vqXXx4H3IErNunpWHe0PxfxD5KQy
         nbWGRI8HsbwMMOHP50ksxbjTP2ot8mX1H2b97hWu/vk+41k5+AfPFOeuVxhT6nxQzCdE
         5OfNdRRR2iteNZXSj8CNRH1+E+62boIza60N/p99nirsKfH0+pEBI1aWgNGdFF2bHedW
         vBYA==
X-Received: by 10.42.244.4 with SMTP id lo4mr15462051icb.65.1435876931155;
 Thu, 02 Jul 2015 15:42:11 -0700 (PDT)
Received: by 10.107.16.15 with HTTP; Thu, 2 Jul 2015 15:41:41 -0700 (PDT)
In-Reply-To: <CAPig+cR1uLa7yiDn9EnTzfkDTOoToc6BTDRn5sYr12yPr6rXPg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273272>

On Fri, Jul 3, 2015 at 12:06 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
>> Unless we want to borrow fancy checkout options for "git worktree
>> add", we probably should just export checkout() function from clone.c
>> and use it instead of "git checkout". Much more lightweight and
>> simpler (it's one-way merge). Then we can revert checkout.c to the
>> version before "--to".
>
> Interesting idea, but doesn't this lose the ability to create a new
> branch ("worktree add foo -b bar") and other useful options like
> --track?

Those are what I call "fancy checkout options". I think we could start
simple with clone.c:checkout.c() and maybe libify switch_branches()
later on to gain --detach and stuff. There's another thing I missed,
when the new worktree is set up, HEAD contains a dummy value. It's
expected that the second checkout will update it with proper value (a
ref, detached HEAD....). So if you avoid running "git chckout" in
"worktree add" and use clone.c:checkout(), you have to re-do something
similar.
-- 
Duy
