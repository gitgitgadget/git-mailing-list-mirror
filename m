From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3] http: add support for specifying the SSL version
Date: Thu, 13 Aug 2015 12:49:16 -0400
Message-ID: <CAPig+cQZczCShRKeaQ=UP02OmUG5D2-ZCtaEO0qbm=LQ4m=ctw@mail.gmail.com>
References: <1439479731-16018-1-git-send-email-gitter.spiros@gmail.com>
	<CAPig+cTug2Q3v1K5r76fhJ6OQY9V1e6MbiXQBGQJD51TCOGW=A@mail.gmail.com>
	<CA+EOSBkSkvvBQDpxL_ygj+2haMk1U7T00-Xmxn8iyXcnV6RN5Q@mail.gmail.com>
	<CAPig+cSC2a07RYioQ4+sw=pujFW8=sv_d5vv=XiayuSg7FBcHw@mail.gmail.com>
	<CA+EOSBkOGzyOB-NRGTNm0b==OZH7eB=sZaGa0mRa4798_v-EHQ@mail.gmail.com>
	<CAPig+cQj4-4tnZv1JkUZdGHzgL=x2f6Zg7JeYn5bBgp991WNhg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	=?UTF-8?Q?Galan_R=C3=A9mi?= 
	<remi.galan-alfonso@ensimag.grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>
To: Elia Pinto <gitter.spiros@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 13 18:49:32 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZPvh3-0003in-Up
	for gcvg-git-2@plane.gmane.org; Thu, 13 Aug 2015 18:49:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753470AbbHMQtU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Aug 2015 12:49:20 -0400
Received: from mail-yk0-f170.google.com ([209.85.160.170]:33242 "EHLO
	mail-yk0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753459AbbHMQtR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Aug 2015 12:49:17 -0400
Received: by ykaz130 with SMTP id z130so46397806yka.0
        for <git@vger.kernel.org>; Thu, 13 Aug 2015 09:49:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=Fo3wIDaHC2f41E6ATr139FlRz+LlB/I91Ey7eN4YYWI=;
        b=bAKZvj67TtkU9OTOX0ZeFU4B6HlT/Ee7zXmPDVkOatJQaurwPvLd8Z0B806AqffA26
         Gez97SA6svmXY0qs29gCG9r8ntrLxYcA8x+RZfcdNfEy8TWO6WQJ2FZcAsEvXW6K+r1F
         oFClH6nQd1Kb55l/YO70KzKirsphoB1s5oeS+KNv/VSIaord8qwicZJUGXDHlJ0TME6v
         3ma5dM4I3U5bGYqPpOMPwy0x0DWJtUguf6+FCd+FF4omeWrQQjRLDhoguC5KLBVu97Da
         XTkriOKYGKdtAg0HM1pUMlSQt1169wdxR9l+jh4lrXHoc42C7amxf3qt3cdK1J9ENzaj
         YEDA==
X-Received: by 10.13.220.132 with SMTP id f126mr40552989ywe.39.1439484557052;
 Thu, 13 Aug 2015 09:49:17 -0700 (PDT)
Received: by 10.37.208.78 with HTTP; Thu, 13 Aug 2015 09:49:16 -0700 (PDT)
In-Reply-To: <CAPig+cQj4-4tnZv1JkUZdGHzgL=x2f6Zg7JeYn5bBgp991WNhg@mail.gmail.com>
X-Google-Sender-Auth: fVRTF1oSsDW0ZUDNDoGv-hIKZt0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275861>

On Thu, Aug 13, 2015 at 12:37 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> So, your loop can either look like this, if you use the NULL sentinel:
>
>     struct ssl_map *p = sslversions;
>     while (p->name) {
>         if (!strcmp(ssl_version, p->name))
>             ...
>     }

That's not quite correct. 'p' needs to be incremented, of course, so:

    struct ssl_map *p;
    for (p = sslversions; p->name; p++) {
        if (!strcmp(ssl_version, p->name))
            ...
    }

would be nicely idiomatic.
