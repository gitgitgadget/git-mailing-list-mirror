From: Jacob Keller <jacob.keller@gmail.com>
Subject: Re: git grep broken in Fedora 21 update?
Date: Thu, 3 Sep 2015 21:55:38 -0700
Message-ID: <CA+P7+xqzEHD9kR6suGBb1oXfPx0gehk7KYoUJFip_WcPWxTrPw@mail.gmail.com>
References: <9CAA4751-D295-4ACE-8ED6-720D728D24EA@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: "Rustad, Mark D" <mark.d.rustad@intel.com>
X-From: git-owner@vger.kernel.org Fri Sep 04 06:56:24 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZXj31-0003IF-1K
	for gcvg-git-2@plane.gmane.org; Fri, 04 Sep 2015 06:56:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752570AbbIDEz6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Sep 2015 00:55:58 -0400
Received: from mail-io0-f171.google.com ([209.85.223.171]:36306 "EHLO
	mail-io0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751795AbbIDEz6 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 4 Sep 2015 00:55:58 -0400
Received: by ioii196 with SMTP id i196so11580517ioi.3
        for <git@vger.kernel.org>; Thu, 03 Sep 2015 21:55:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=n15pBPD5iFGOkCHr4QBZ0+S2rEqneGosd3ESgiI8c0Q=;
        b=oAlw9jeURMdg92CoBHrQAqpN2ng6VQOkj2NkKK7lBRfNu5fhGIHmNeF6wI7SN1hOMV
         gdN7bJBSCIeqh/0PWnNKmEmS4AzMEsDmhH498SF8A33dIVHV1wrLQG7osRaW0H9gBxyQ
         /0Cc5zPIJxCQOoXQ05obx6gA5lvmFth5Ga4wrGB4UoFMkFQOr6hgCh+QXYjB4QR1CqZR
         u3c6/+5AR03SLGhm2wsnH3JUEbXjUygY/QIbqVbdZsRr+BnclwQC3zhVb3v3lKxuIgA7
         Z/G1Pbafo209qAobKO2dRJj/vG3aAWdHrIBzXAKX0ROmXSMWQpDamCtwfyVKV63IOIqC
         4J5w==
X-Received: by 10.107.166.13 with SMTP id p13mr3653760ioe.0.1441342557427;
 Thu, 03 Sep 2015 21:55:57 -0700 (PDT)
Received: by 10.107.5.203 with HTTP; Thu, 3 Sep 2015 21:55:38 -0700 (PDT)
In-Reply-To: <9CAA4751-D295-4ACE-8ED6-720D728D24EA@intel.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277285>

On Thu, Sep 3, 2015 at 5:04 PM, Rustad, Mark D <mark.d.rustad@intel.com> wrote:
> I just found a case where grep and git grep yield different results. Inside the ixgbe directory of the Linux kernel I did:
>
> $ grep enter_lplu *.[ch]
>
> And got the following:
>
> ixgbe_main.c:   if (adapter->hw.phy.ops.enter_lplu) {
> ixgbe_main.c:           adapter->hw.phy.ops.enter_lplu(&adapter->hw);
> ixgbe_type.h:   s32 (*enter_lplu)(struct ixgbe_hw *);
> ixgbe_x550.c:/** ixgbe_enter_lplu_x550em - Transition to low power states
> ixgbe_x550.c:static s32 ixgbe_enter_lplu_t_x550em(struct ixgbe_hw *hw)
> ixgbe_x550.c:                   phy->ops.enter_lplu = ixgbe_enter_lplu_t_x550em;
>
> But when I did:
>
> $ git grep enter_lplu
>
> I got:
>
> ixgbe_main.c:   if (adapter->hw.phy.ops.enter_lplu) {
> ixgbe_main.c:           adapter->hw.phy.ops.enter_lplu(&adapter->hw);
> ixgbe_type.h:   s32 (*enter_lplu)(struct ixgbe_hw *);
> ixgbe_x550.c:/** ixgbe_enter_lplu_x550em - Transition to low power states
> ixgbe_x550.c:static s32 ixgbe_enter_lplu_t_x550em(struct ixgbe_hw *hw)
>
> You can see that git grep missed the line in ixgbe_x550.c that had two hits on the string.
>
> This was with git 2.1.0 in Fedora 21. I use git grep a lot and never noticed a problem before. I just updated my Fedora 21 system yesterday, so I have to figure that has something to do with it. I checked and git didn't get updated, so I figure it must be a library that is really broken.
>
> I see in my update log that pcre was updated to:
>
> pcre.x86_64 0:8.35-12.fc21
> pcre-devel.x86_64 0:8.35-12.fc21
>
> Yet the grep command is unaffected.
>
> --
> Mark Rustad, Networking Division, Intel Corporation
>

I don't know if command line grep uses pcre?

Does git-grep by default ignore changes not yet committed? That was my
first thought but I am not very familiar with the tool.

Regards,
Jake
