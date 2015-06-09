From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: On undoing a forced push
Date: Wed, 10 Jun 2015 06:24:26 +0700
Message-ID: <CACsJy8BDhuk8efFrCPH4FWxbFt-3iqrS6AMLeQso5YPUHmTZwg@mail.gmail.com>
References: <20150609121221.GA14126@lanh> <5576F2DC.7040603@gmail.com> <012a980b0b9f1aa394e2b3701e4e6f97@www.dscho.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Cc: Sitaram Chamarty <sitaramc@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Jun 10 01:25:04 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z2StC-0003ZW-1D
	for gcvg-git-2@plane.gmane.org; Wed, 10 Jun 2015 01:25:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754011AbbFIXY5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Jun 2015 19:24:57 -0400
Received: from mail-ie0-f179.google.com ([209.85.223.179]:35889 "EHLO
	mail-ie0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752970AbbFIXY5 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 9 Jun 2015 19:24:57 -0400
Received: by ieclw1 with SMTP id lw1so23579915iec.3
        for <git@vger.kernel.org>; Tue, 09 Jun 2015 16:24:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=tpYQX7NWd8Ag7JUUg0TCcl7RZfRFi83ZECt3fvOd0cY=;
        b=bWSHU25SUtg8YygQMpl0CI5l37+iIvkLE+dLfq/3WOlomLXqjDANrNbT6w7J9I2ZxT
         pzimitVu0QjdpDet+YOIKuhScrZWP4ygOodm46IesMB2kkwdehEHEA7tNVF/1Kj/+zSi
         jdxGnLZiwfwNBur6t61ZwTGJhNqpg6HwuKOOGggLfWosXmnrkwYx5oahTwrobpJ8LTPE
         4U+FcZO2DlCyZeSabic/XV00GhCGclTSkmYej1fsWHOzHkFdstrgvPNxHjbXdDyhkXM4
         lLrqvEEa2roi/6BGUPmbwdMyObNzprqH3bLg77ctRv3sXbaZxtiM9crpDC03B6OGX3kR
         MT1w==
X-Received: by 10.50.7.68 with SMTP id h4mr1853888iga.40.1433892296514; Tue,
 09 Jun 2015 16:24:56 -0700 (PDT)
Received: by 10.107.6.9 with HTTP; Tue, 9 Jun 2015 16:24:26 -0700 (PDT)
In-Reply-To: <012a980b0b9f1aa394e2b3701e4e6f97@www.dscho.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271241>

On Tue, Jun 9, 2015 at 11:29 PM, Johannes Schindelin
<johannes.schindelin@gmx.de> wrote:
> Sorry to chime in so late in the discussion, but I think that the `--force-with-lease` option is what you are looking for. It allows you to force-push *but only* if the forced push would overwrite the ref we expect, i.e. (simplified, but you get the idea) `git push --force-with-lease <remote> <ref>` will *only* succeed if the remote's <ref> agrees with the local `refs/remotes/<remote>/<ref>`.
>
> If you use `--force-with-lease`, you simply cannot force-forget anything on the remote side that you cannot undo (because you have everything locally you need to undo it).

Yeah I recall Junio did something about pushes.. I was about to
suggest that we promote force-with-lease to default --force and
current --force becomes --force --force. But there's this from commit
2233ad4 (Merge branch 'jc/push-cas' - 2013-09-09) that makes me
hesitate

    The logic to choose the default implemented here is fragile
    (e.g. "git fetch" after seeing a failure will update the
    remote-tracking branch and will make the next "push" pass,
    defeating the safety pretty easily).  It is suitable only for the
    simplest workflows, and it may hurt users more than it helps them.

Either way I still want to provide an escape hatch for --force as it's
good to reduce the number of unrecoverable operations down.
-- 
Duy
