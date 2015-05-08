From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 2/3] generate-cmdlist.sh: parse common group commands
Date: Thu, 7 May 2015 23:39:56 -0400
Message-ID: <CAPig+cR67f02F0q7ZjPFG4V-EdtSgmnxs2BLqzH1TwfhcObR1A@mail.gmail.com>
References: <cover.1430770308.git.sebastien.guimmara@gmail.com>
	<a787babf25481c99edea6dca5e5f7814601395fe.1430770308.git.sebastien.guimmara@gmail.com>
	<20150508032011.GA10209@flurp.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: =?UTF-8?Q?S=C3=A9bastien_Guimmara?= <sebastien.guimmara@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 08 05:40:40 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YqZ9U-0000sW-2K
	for gcvg-git-2@plane.gmane.org; Fri, 08 May 2015 05:40:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751576AbbEHDj5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 May 2015 23:39:57 -0400
Received: from mail-ig0-f177.google.com ([209.85.213.177]:38683 "EHLO
	mail-ig0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751570AbbEHDj5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 May 2015 23:39:57 -0400
Received: by igbhj9 with SMTP id hj9so11305811igb.1
        for <git@vger.kernel.org>; Thu, 07 May 2015 20:39:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=sRYJVtCJjfj1hydS//GT7aS3IGagbgpuDRkFbvNAPKc=;
        b=Guzt2nOhi8k/lbRKe4VolfbNst4YaLDDjS+xVJm9hr3sbYUqRPRd40vZJSDpbRTSR+
         Y2g0QR6bQbIaYDu9NpoFSEh8sr2y2xCYBxslYtDDCTNZ8K/+ugj+GKlAiFVTcyymNktw
         D+ZslXsXA33zEsJ6MmJfzed5ulVZPNRy99GLG6Id4gSskvGtmrwVzT5udVZ3zy34A5g4
         Df590Lx4HUDDyUQ5xmOa2hDQrcSWpCDDv7Whlzulbot1FICVqsONdfNSw5SylfbBUEkV
         ya0VXCP/NZ2eHSWqFUwVXKywGviYmzOZ7U3k9vF63cfA5eCpbDPp0YkD3UG+zTr7v7eg
         5CpA==
X-Received: by 10.107.3.163 with SMTP id e35mr2268748ioi.92.1431056396299;
 Thu, 07 May 2015 20:39:56 -0700 (PDT)
Received: by 10.107.28.132 with HTTP; Thu, 7 May 2015 20:39:56 -0700 (PDT)
In-Reply-To: <20150508032011.GA10209@flurp.local>
X-Google-Sender-Auth: Equ6ZimQDymTt-qiPfFhlkd2K3I
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268599>

On Thu, May 7, 2015 at 11:20 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> From: Eric Sunshine <sunshine@sunshineco.com>
> Subject: [PATCH] generate-cmdlist: parse common group commands
>
> Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
> ---
> diff --git a/generate-cmdlist.awk b/generate-cmdlist.awk
> new file mode 100644
> index 0000000..19b36e5
> --- /dev/null
> +++ b/generate-cmdlist.awk
> @@ -0,0 +1,39 @@
> [...]
> +state == 1 {
> +       grp[$1] = ++n
> +       sub($1"[        ][      ]*", "")
> +       printf "\tN_(\"%s\"),\n", $0
> +       next

By the way, this 'next' line can be deleted. It was leftover gunk from
an earlier iteration. It doesn't harm, but doesn't help either, and is
thus potentially confusing.

> +}
> +/\[common\]/ {
> +       state = 1
> +}
> +END { print "};" }
