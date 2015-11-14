From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 1/3] prepare_packed_git(): find more garbage
Date: Fri, 13 Nov 2015 16:43:41 -0800
Message-ID: <CAGZ79kYPv2OLzMX6t9=mejes9F8CzxAJiERs8GGxDnaAG8Q64g@mail.gmail.com>
References: <1447459853-28838-1-git-send-email-dougk.ff7@gmail.com>
	<1447459853-28838-2-git-send-email-dougk.ff7@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Doug Kelly <dougk.ff7@gmail.com>
X-From: git-owner@vger.kernel.org Sat Nov 14 01:43:50 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZxOwW-0006QI-A7
	for gcvg-git-2@plane.gmane.org; Sat, 14 Nov 2015 01:43:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752690AbbKNAno (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Nov 2015 19:43:44 -0500
Received: from mail-yk0-f180.google.com ([209.85.160.180]:35774 "EHLO
	mail-yk0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752663AbbKNAnm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Nov 2015 19:43:42 -0500
Received: by ykba77 with SMTP id a77so174257465ykb.2
        for <git@vger.kernel.org>; Fri, 13 Nov 2015 16:43:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=Vvi50QuZDNd7o8DykwjDw53BHVgE4Fb83W+rnBlKSrI=;
        b=o6Be37KNjYHjS4x0ECeVllBRxa9cyGy7jQ9vYSu9JgrhaurEYDfWs2wrF5pQwcSKhX
         baxQ40uW6wpCeYQK4eY2jngydGQp1cP/FL2hj3HM1SAQQpYruBupmXumPw/KT6NaVpFx
         DCF0kF3P3QLTbBgTO8+tz2WpEvsUK47ft7Iij5kO//hrBE2ogjJ/lcTnK8T+PfRScNnn
         PYkrCMl2Jyd4Hf2cdJ1IG2CSLNrNNiR+CNJTbEZcQPtPgexHLNT25UXTIiHIk1D7mmuJ
         /oEvCuyVZFNRFNx7j7JvtRJjZGdta6j8RKjM6+VJEGDwS9zY8lQ9ZQcc0qHYQ3jQ83+P
         iPPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=Vvi50QuZDNd7o8DykwjDw53BHVgE4Fb83W+rnBlKSrI=;
        b=ggBFP2e1xjLZ5d9k1rqQeo37/W0eMWQUI8eM5BWsNcqyrjC+FH3JoGfLg60EwOR6c9
         Wpq9063Rj8guJ0Tm6UpqtZZVdyWVa3s7KbBPaxltF565Z8CKA3YF5mpXPDro/BGLeUb4
         JFPXpO4EbG7PH/xinFmTxF0WhutggMpXgLAeY9cc/Wvzeup9u5wyIIOE5zI6YpxPcHAQ
         GI/LtA/OSQqojlNkWLDUHjSmKM3DBbGCLj14oXhEgLbR6KxsZVAjK8OSsPxjb8e1g9re
         fdiXCyxzCt8NH3nMI4MGbPJlRK+MXWFGL+YqGAo4Ke9WAB8+Ix6jUYsfHBMhtMEQ/DGS
         t0YQ==
X-Gm-Message-State: ALoCoQnL3U2ys16t77kJ7zz4w6Phsvf35mDDREM7jGDWI316kGk93fQu889wRYjYgRrdBEfxeLTp
X-Received: by 10.129.81.147 with SMTP id f141mr5774292ywb.176.1447461821593;
 Fri, 13 Nov 2015 16:43:41 -0800 (PST)
Received: by 10.37.196.70 with HTTP; Fri, 13 Nov 2015 16:43:41 -0800 (PST)
In-Reply-To: <1447459853-28838-2-git-send-email-dougk.ff7@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281284>

> +       else if (seen_bits & PACKDIR_FILE_PACK && seen_bits ^ ~PACKDIR_FILE_IDX)

as just talked about: did you mention && !(seen_bits & FILE_IDX)
>
> +       if (seen_bits == (PACKDIR_FILE_PACK|PACKDIR_FILE_IDX|PACKDIR_FILE_BITMAP))
> +               return;
> +
> +       if (seen_bits == (PACKDIR_FILE_PACK|PACKDIR_FILE_IDX|PACKDIR_FILE_KEEP))
> +               return;
> +
> +       if (seen_bits == (PACKDIR_FILE_PACK|PACKDIR_FILE_IDX|PACKDIR_FILE_BITMAP|PACKDIR_FILE_KEEP))
> +               return;

I wonder if this should be rewritten as
    if (seen_bits & FILE_PACK && seen_bits & FILE_IDX
        && (seen_bits & FILE_KEEP || seen_bits & BITMAP))
            return;

to dense it a bit. ;)
