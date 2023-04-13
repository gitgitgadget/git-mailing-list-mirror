Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0074C77B6E
	for <git@archiver.kernel.org>; Thu, 13 Apr 2023 14:00:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231766AbjDMOAU (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Apr 2023 10:00:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231738AbjDMOAJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Apr 2023 10:00:09 -0400
Received: from mout.web.de (mout.web.de [212.227.17.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2528E9EC3
        for <git@vger.kernel.org>; Thu, 13 Apr 2023 07:00:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
        t=1681394398; i=markus.heidelberg@web.de;
        bh=VkJtk2I+NqCzO/fCrIUau53TuuW86YGkqrp3uWAAhjw=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=UP3cCmh++ze1hjRKwBrYpO07lETrNttKEWJ65MqHX47GgdtwRFisb2D36J0kcJ852
         5m2V+pNpzodTfjZ3PytQecnw/klT0n+NR6sPwdtzE1mSjv4rWW4m+wn73/KFlyeH5d
         48yjbBNJ9XhCkoJuh956RHc/w2scs+X4LU/XiuPZ3yEZo5N0/ulSrRkN2gAKcQsUZW
         hijVLavP7a+aJ2fqZb6uBX9lFV9kJEsQHheks35i+mX2oXjoW1wb5vijK4VxQiULcr
         HAurHPXthojoUkccJZK1dlBg8Sj++ZcEu0jawqeOE2dAxlHTyt26seULDJp74I4TUY
         rta7SN45URh9g==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from evo.localnet ([46.223.163.182]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M3V28-1pnVSG1yL4-000vhz; Thu, 13
 Apr 2023 15:59:58 +0200
From:   Markus Heidelberg <markus.heidelberg@web.de>
To:     Elijah Newren <newren@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [filter-repo PATCH] convert-svnexternals: fix parsing of wrongly
 transformed SVN revisions
Date:   Thu, 13 Apr 2023 15:59:53 +0200
Message-ID: <12097307.TzdMVdA1NY@evo>
In-Reply-To: <xmqqbkjs9a1j.fsf@gitster.g>
References: <20230412134119.28257-1-markus.heidelberg@web.de>
 <CABPp-BH1172tfZn5i0PvNm6Fw5OObKEKCqT1gjTr+hux86TexQ@mail.gmail.com>
 <xmqqbkjs9a1j.fsf@gitster.g>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Provags-ID: V03:K1:qDJxTFGGF2Q4x+kt5xBoe9A3MVn+oeZ2DC+RYrpEfK51TYhJiLE
 BuCt4OitRCe2YFHM6CGSDgg3sJLcx5pXOJc2Uk4d0MtZGIoUQ7usKFcv4j56cqK+kpgchHP
 6eIRov+fOd2oL8Q1nfQ3x9Vfn/GTDHyDg+VBdfj0yEup2+jxC4CHBsYBaacXZQ3siIDxYkG
 WEJ1Akz0Jils0e4fCp3CA==
UI-OutboundReport: notjunk:1;M01:P0:T5Fk/34UD8k=;EoQ9RrpcX13a17WS73ZxzdG8up9
 Cuv4tR96VuI7EptU6P4Zs3i7RqG1I5CU2FxchW6PtAwSdlHlLAQ87euMw4ZiCg48TEMKLQqaz
 4hIPgy8kkzT3yZ5FHgKYiPEMZJyJ9CZbpke18qcYk2il8mu/xmaSXTbZa93UtMAczKpsT88UN
 an0TpDR79q7lY0XoBKbYPcWA4nM6NpoXkirzOdIPCh8ii/GriPwSfkTTRmbJs7B8XuQmlYFcO
 jXoOvrvjj7SekrWOod107Ufr5ofA/V8/UUMAP23i1OIc5Q4uoEwKbfkhUZy94Wy2p2ykVTGG2
 tHugw1AQ6bWvJxZjcKbuOB7VCqV5S87nZR3Wmjhme30BU1oVckOJyxibYYelXs8KZGj/p3wev
 juDSNqHIUW5zW5SPzZeJGw6Ke8dcBBwF5zkBli1lzXQXqqip6q2GtwAnYL4C+JfoVB/sY+vZA
 u7z6R6fAOa88PkrfhBGMcmVk9s5wya63s2+lYuz6zGj4H94612WMT6fwnDs8OPw/Zbfhk2ExY
 iVBl2J8NUR5LcjRugkdhXQZF444H+T+faUmQE91a0oyJ1y3Lh8jomBJeTUMzud/WZE8xvJ7//
 hrK8GmNi3O/67ZxZYe//7c9gDMkZ7WHT4LsFELtEWA8pUpNAMdujaxC4MypQzVygAHOPBRjAX
 +BHSa+7ynOYfXjueU3KZRZ3uj5gk3MKKUzA2a7rDrk2G5LxISVwpQKKQw8iSOmjCVoaeIhqLT
 LD01xQV3s+3OROZH6stDOLdZ3uFpNPm5EbIFQe80OEvhnNmXAb9iDYIbgXSu4tWKMivCct8l1
 BE3hfc9drR/E8A2lNx/OmmWxBGsq/o38yk3tgDs/IwuAVYtejswYktd1F4xMpTogoy047aXA0
 KPB9fZ75MGsbWEqJNM8VMVXkMWLIkQ59OJ3rmDk/5mQYoRi4Z3LSUgesxBb9U/xoyXTKOcXQl
 h7qtuQ==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am Mittwoch, 12. April 2023, 21:26:32 CEST schrieb Junio C Hamano:

> It may work around the issue, but sounds like it is SubGit that
> needs fixing, at least seeing the problem description from the
> sideline.

Indeed the commit log should have been something like
  "work around wrongly transformed SVN revisions"
to make it clear that it wasn't a bug in the script.

Thanks to your comment I have now reported this SubGit issue in the
TMate Support Forum.



