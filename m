From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH] Check order when reading index
Date: Thu, 21 Aug 2014 20:59:45 +0700
Message-ID: <CACsJy8A-aMmU0oYgo=eR21CZT6X__-Mnrg6O74sCQ9Ta4QPWPQ@mail.gmail.com>
References: <CAPuZ2NEksZzt29XpAaszK8oc4iXH4OTGzRSsHUrtwgrv6bU_0Q@mail.gmail.com>
 <1408628606-12975-1-git-send-email-jsorianopastor@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Jaime Soriano Pastor <jsorianopastor@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 21 16:00:23 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XKSud-0005t0-1C
	for gcvg-git-2@plane.gmane.org; Thu, 21 Aug 2014 16:00:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755421AbaHUOAQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Aug 2014 10:00:16 -0400
Received: from mail-ie0-f178.google.com ([209.85.223.178]:54850 "EHLO
	mail-ie0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755042AbaHUOAP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Aug 2014 10:00:15 -0400
Received: by mail-ie0-f178.google.com with SMTP id rd18so4566799iec.23
        for <git@vger.kernel.org>; Thu, 21 Aug 2014 07:00:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=xeuA/91lH172DgQ95koL+JtoQJ3ZFzRJWkq9pNSovVo=;
        b=WSjcuwohM/mOzhw0rMNmLs0H4irlpLUcCqWKjH1x7HWzgqvZ4TbGnC8vQq62OncLZ2
         H76vWo8ukkpMAHT1amuE7qX5TQ/X/DtnlBc5RCBgjKqTCDeCE9/+gVYnl5i2gwoa7UOc
         DipzNHlYDTC0ml4QfeKrK0QW2vJpPTJWXm27zrtyE1Ofcq3lEYgnuvS27ToodhnLneZ1
         GGsy28NGHJ2exQEcd39BvHlQwhGNOULLfAC3/bCp4UMpON8K8nlOWd62kNcGkcl3KTPF
         yQYopQsXba7y/OLG6zZlw+w9kMr6ETM2adpfmo9SEP3PluvnI57sayvgBJrldk0GDYDg
         l9Tw==
X-Received: by 10.42.109.79 with SMTP id k15mr3867144icp.42.1408629615284;
 Thu, 21 Aug 2014 07:00:15 -0700 (PDT)
Received: by 10.107.13.80 with HTTP; Thu, 21 Aug 2014 06:59:45 -0700 (PDT)
In-Reply-To: <1408628606-12975-1-git-send-email-jsorianopastor@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255616>

On Thu, Aug 21, 2014 at 8:43 PM, Jaime Soriano Pastor
<jsorianopastor@gmail.com> wrote:
> @@ -1499,6 +1514,9 @@ int read_index_from(struct index_state *istate, const char *path)
>                 ce = create_from_disk(disk_ce, &consumed, previous_name);
>                 set_index_entry(istate, i, ce);
>
> +               if (i > 0)
> +                       check_next_ce(istate->cache[i-1], ce);
> +
>                 src_offset += consumed;
>         }
>         strbuf_release(&previous_name_buf);

It may be nice to save the "good index" stamp as an index extension so
we don't have to check this over and over. I'm thinking about big
indexes where compare cost might matter (I'm not so sure yet, will do
some testing when I have time).
-- 
Duy
