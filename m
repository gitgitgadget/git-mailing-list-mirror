From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 03/11] git p4: work around p4 bug that causes empty symlinks
Date: Tue, 21 Jan 2014 20:26:16 -0500
Message-ID: <CAPig+cTbC9HN3REb0Lib7pzUvkLSG6te2ka4zUzcA5y5bcK_hg@mail.gmail.com>
References: <1390346208-9207-1-git-send-email-pw@padd.com>
	<1390346208-9207-4-git-send-email-pw@padd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Pete Wyckoff <pw@padd.com>
X-From: git-owner@vger.kernel.org Wed Jan 22 02:26:26 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W5maI-00039y-0k
	for gcvg-git-2@plane.gmane.org; Wed, 22 Jan 2014 02:26:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754527AbaAVB0T convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 21 Jan 2014 20:26:19 -0500
Received: from mail-la0-f52.google.com ([209.85.215.52]:51935 "EHLO
	mail-la0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754494AbaAVB0S convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 21 Jan 2014 20:26:18 -0500
Received: by mail-la0-f52.google.com with SMTP id c6so7127882lan.39
        for <git@vger.kernel.org>; Tue, 21 Jan 2014 17:26:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=mmg/mDPYyW8Lw6qjm6HReVSAOp0S0nCsXFBLBiEHHx8=;
        b=dxOSh1VCQabq6V9gGbR4LH1hZTCiBH6bhQzDlVtsCrIv5ANMUgM3qyozI6G1RIsa4M
         9ux5RDh+dYGdB2WlQZICdt4Dw9xW7cVWs/UJNgzjawZwnxBtW/U/jZypYR9C+IXcpYlj
         U3Ry6oCpwiHDP2VF8r5s0OVGk/4v7Mlyld3j2nsqFMcGjcG7BEqEQsJ1ZdrtR9aqj9zl
         0DS+MoqUGpeVw0nPK91TQZUMmx+U6ikt+w6rg0RUT7Bi8nNZXf55ZWj7qhqSOG4vifBZ
         VQM0R5MTAxM4T5M9CCeQlXf/ve2E3QxJEPRGfF8x/f4Ugu6Fgf6kLjuJ2M3z1Q7dnJU7
         kdAQ==
X-Received: by 10.152.28.230 with SMTP id e6mr18308676lah.3.1390353976938;
 Tue, 21 Jan 2014 17:26:16 -0800 (PST)
Received: by 10.114.81.106 with HTTP; Tue, 21 Jan 2014 17:26:16 -0800 (PST)
In-Reply-To: <1390346208-9207-4-git-send-email-pw@padd.com>
X-Google-Sender-Auth: ld78VTjUB6od0umncw3oEV-kDJk
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240811>

On Tue, Jan 21, 2014 at 6:16 PM, Pete Wyckoff <pw@padd.com> wrote:
> Damien G=E9rard highlights an interesting problem.  Some p4
> repositories end up with symlinks that have an empty target.  It
> is not possible to create this with current p4, but they do
> indeed exist.
>
> The effect in git p4 is that "p4 print" on the symlink returns an
> empty string, confusing the curret symlink-handling code.
>
> Such broken repositories cause problems in p4 as well, even with
> no git involved.  In p4, syncing to a change that includes a
> bogus symlink causes errors:
>
>     //depot/empty-symlink - updating /home/me/p4/empty-symlink
>     rename: /home/me/p4/empty-symlink: No such file or directory
>
> and leaves no symlink.
>
> In git, replicate the p4 behavior by ignoring these bad symlinks.
> If, in a later p4 revision, the symlink happens to point to
> something non-null, the symlink will be replaced properly.
>
> Add a big test for all this too.
>
> This happens to be a regression introduced by 1292df1 (git-p4:
> Fix occasional truncation of symlink contents., 2013-08-08) and
> appeared first in 1.8.5.  But it only shows up only in p4

Redundant "only".

> repositories of dubious character, so can wait for a proper
> release.
>
> Tested-by: Damien G=E9rard <damien@iwi.me>
> Signed-off-by: Pete Wyckoff <pw@padd.com>
