From: Antti Halttunen <Antti.Halttunen@iki.fi>
Subject: bug: nested submodules get an absolute gitdir path
Date: Wed, 6 Apr 2016 10:02:47 +0300
Message-ID: <CALoo-5WcdMNMcCW0EQv1VqkE5Ax7bMnvo2r7niYhYyMjA8c4wg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 06 09:02:54 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1anhUM-00049R-1n
	for gcvg-git-2@plane.gmane.org; Wed, 06 Apr 2016 09:02:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752997AbcDFHCs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Apr 2016 03:02:48 -0400
Received: from mail-io0-f175.google.com ([209.85.223.175]:33858 "EHLO
	mail-io0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751187AbcDFHCs (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Apr 2016 03:02:48 -0400
Received: by mail-io0-f175.google.com with SMTP id 2so45949032ioy.1
        for <git@vger.kernel.org>; Wed, 06 Apr 2016 00:02:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:date:message-id:subject:from:to;
        bh=bApSv++90n3BPXfIX1PjU/TmxgpHpSjHGBl87koSTkk=;
        b=JRv5oGcUla2PNazSfPPBRyXphF7Y1iLfJ66JwMqjUsDvvqMHIv5NAEHI1irTUaPbzz
         5djXgg9FY1sCI27sH0H/zvo96Kg1mcHInzs+2rn7bIXjq129Zfq8rrOw8c2YCw2zj0bq
         r3QRIdAZS0dBk4VjvJ/4UJtgfTIJ3fRuZ1U6HrwiBMMSQoic5FySpSFHo8JHuk95OI/m
         qNm9Qs5l4yYhQTRgvYecXIchgb4cJLwi7xCJP3Ve/9JrBQLXy6LpHdoCLDaL7RaSKrQO
         rDFaCAXVe0Z7Yma/X7roLnf77hRNvjOlY4JpUEN3bkthHT4jAMCo8h1/90HxGpJaheDP
         508Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:date:message-id:subject:from
         :to;
        bh=bApSv++90n3BPXfIX1PjU/TmxgpHpSjHGBl87koSTkk=;
        b=C51Jn92d09LtyD5SY0xathnXYw+3nFDP1BR9b8pNz3lvYF5NaNdLhms9BERqkMdIN3
         snOAfU7zAdAyaPVyeFYBYDTPCsfU/u5PfkUHcmBFFJL4Jr3cpxpoCxKg9k7wFzM44u/w
         3cx54YwqzoGkylCjx4M2DvAUnIgtMDOcM0SW2Nh9kL5b4LotnE1ikbabKfyKZ/zT8VGc
         jg5mC0NXh72EV2fbvE2IcbLmkP/SpGktdm90UvHhbw4HHLBwmijtse4k+r0YXC2GbEen
         B5snKpAynxxLVFPt4BATgC1dagorW4La1X38vl/z4KinLBQhq9BlCbqI8ACHTM10qyRX
         /Evw==
X-Gm-Message-State: AD7BkJIVR91Gls1yFxrHmqQ89VldkLEqTdssNKWgXZLqKGLXeIpIrLo493ribkllysJCoOqI9eVt/FZdQeggoA==
X-Received: by 10.107.137.101 with SMTP id l98mr17848598iod.31.1459926167108;
 Wed, 06 Apr 2016 00:02:47 -0700 (PDT)
Received: by 10.79.74.71 with HTTP; Wed, 6 Apr 2016 00:02:47 -0700 (PDT)
X-Google-Sender-Auth: WomIQqQdd0nvR1MKdxwskVrjrkU
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290830>

Hi all,

Starting with git v2.7.0,

submodules two levels deep get a .git contents of:
 gitdir: /absolute/path/name

This breaks repos that are moved or copied:

fatal: Not a git repository:
/tmp/tmp.gIyxKWIC26/repo/.git/modules/sub/modules/sub
fatal: 'git status --porcelain' failed in submodule sub

The script https://gitlab.com/snippets/17301 reproduces the issue.

git bisect points to commit ee8838d1.

thanks,
-- 
antti
