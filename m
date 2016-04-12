From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH v2 12/21] bisect: replace clear_distance() by unique markers
Date: Wed, 13 Apr 2016 01:20:54 +0200
Message-ID: <CAP8UFD3ORx9dgWUo81BocTrpKSOdAHV-DUYTZAynH70SD2bqbQ@mail.gmail.com>
References: <1460294354-7031-1-git-send-email-s-beyer@gmx.net>
	<1460294354-7031-13-git-send-email-s-beyer@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Stephan Beyer <s-beyer@gmx.net>
X-From: git-owner@vger.kernel.org Wed Apr 13 01:21:00 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aq7cC-0001FN-CO
	for gcvg-git-2@plane.gmane.org; Wed, 13 Apr 2016 01:21:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966690AbcDLXU4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Apr 2016 19:20:56 -0400
Received: from mail-wm0-f47.google.com ([74.125.82.47]:36577 "EHLO
	mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965202AbcDLXUz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Apr 2016 19:20:55 -0400
Received: by mail-wm0-f47.google.com with SMTP id v188so145294590wme.1
        for <git@vger.kernel.org>; Tue, 12 Apr 2016 16:20:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=SQveGqc0M5OGNGT8HqzSN5FWWEY8s3DOqqEkTg623co=;
        b=0iDbbQ9EDr8msGlFq/Q5yL0IT5s0leSEHi3/KpL4Q7HLf3rfeRXtn6LDK+EdrI4Vpo
         zxVysCMuIuZ2Uz1aJ2GywF8Aea2PhXsGOfAttQk9+gnquGOWdsJ0l8qWLyUpRe3gWy7X
         DXYFCVvIPDHSbo/Kc/NJfMVfcA2pLDLrYQw15BrfRDQSccZI1H/Yf5N7zgTbV189aG+B
         n1qd7NwhABbPNB3sM2mLuUPeS7fdPbQ4XCfQ9OMU7evYYobAzNM4I4Mq0Pl0G2vAmbT7
         /fbVkUB6uovMRGMgIPXy9QPp4PikgFrOkDOmf02+1zJoAjejXi8dfuBIHI3U5xi4Srxy
         xLHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=SQveGqc0M5OGNGT8HqzSN5FWWEY8s3DOqqEkTg623co=;
        b=YYQ6C3Ixg0MhyNmoZwa3uavvG3jd7/Ipqwz/YMHDZ1UauGnFzSxS7W6+yn8qTLowKU
         tzia1Xk9SffJlheLZhZNYpvQ8/HRTsL/Qod79wPrkAd8Tjb4Ihzu4DJR6ZgZMOJ9NXhx
         68JWLYUh1Sf13nFWbNwjMwrf5djEuSP0XZAhVVr+Nu6rvrmJ2iDInwpQsaB4Cuytv/pv
         S7cJ+UW+e7WwsrDmGRGA+BGHH2J3tLGZIwNaAehjtsNCz8QIFsioD5MLNC1KhJ+GJNj1
         IZCNHofCiY9oj9i4uHmMvr+OinSGvr5tnHXJYTDlB/OrIz9kcRlNe0CE2JxSZoKMzGMG
         45rw==
X-Gm-Message-State: AOPr4FXs5xjVzK4SnTltNO9xq5jRjee41eqsjK2qg5k1CenvpxRoO3PbQmUkyGFFD+JisRIk6JxNOsjCa2MLEg==
X-Received: by 10.194.21.102 with SMTP id u6mr6290452wje.124.1460503254500;
 Tue, 12 Apr 2016 16:20:54 -0700 (PDT)
Received: by 10.194.95.129 with HTTP; Tue, 12 Apr 2016 16:20:54 -0700 (PDT)
In-Reply-To: <1460294354-7031-13-git-send-email-s-beyer@gmx.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291324>

On Sun, Apr 10, 2016 at 3:19 PM, Stephan Beyer <s-beyer@gmx.net> wrote:
>
> @@ -123,10 +116,9 @@ static void show_list(const char *debug, int counted, int nr,
>                 const char *subject_start;
>                 int subject_len;
>
> -               fprintf(stderr, "%c%c%c ",
> +               fprintf(stderr, "%c%c ",
>                         (flags & TREESAME) ? ' ' : 'T',
> -                       (flags & UNINTERESTING) ? 'U' : ' ',
> -                       (flags & COUNTED) ? 'C' : ' ');
> +                       (flags & UNINTERESTING) ? 'U' : ' ');

Maybe node_data(commit)->marked could be printed instead of  'C' or ' '.

>                 if (commit->util)
>                         fprintf(stderr, "%3d", node_data(commit)->weight);
>                 else
