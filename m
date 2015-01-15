From: Robert Schiele <rschiele@gmail.com>
Subject: Re: Unused #include statements
Date: Thu, 15 Jan 2015 05:14:39 +0100
Message-ID: <CAObFj3wC6ezNQfAYvtepBdW3S0hv8c4_fXYTo-zp4wwddx3QXg@mail.gmail.com>
References: <CAKJhZwR+iMYAMCxurgc7z2dhqoqx_RxV1G4Jh3phPAOGptp_XQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: GIT Mailing-list <git@vger.kernel.org>
To: Zoltan Klinger <zoltan.klinger@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 15 05:14:47 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YBbpW-0004iJ-F7
	for gcvg-git-2@plane.gmane.org; Thu, 15 Jan 2015 05:14:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751427AbbAOEOl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Jan 2015 23:14:41 -0500
Received: from mail-wg0-f43.google.com ([74.125.82.43]:37713 "EHLO
	mail-wg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751229AbbAOEOk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Jan 2015 23:14:40 -0500
Received: by mail-wg0-f43.google.com with SMTP id k14so12604464wgh.2
        for <git@vger.kernel.org>; Wed, 14 Jan 2015 20:14:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=JtbtY4ARopeLs3NeXf65kcllEgSWQdFTMRiHKd85axE=;
        b=GBtt0CmF33JWRgpXEnYDHw2a0UJoY4Pvf3hH5QCyQ86sq+3J5GTs+l4R65Ar0y+ov0
         urImS4hAnFSjmrlTTIkUQimNV3uJcFUjnAl54HFb0ji13XuPOrvXsJfpVDAiikmaIHE8
         c8DYiwyUFiA4cyKx8iwcRNgQG/1u8WmHfSAQZnSQvdMnQ15Vv1j7eG9wt63b1KVxGuoz
         O2AXEN0qB5yr1X+su0csWi6rPIe1oiHYemVQY2P5ym+N50BMAVQy+4LSWsyDCmyoVAyO
         cv+qHWgoxZCwSemHavLXENgPgP5prSHmvZir84hF4lksTIJ1Itkf4X7DrqPZBjejY2Y3
         BmaA==
X-Received: by 10.180.104.98 with SMTP id gd2mr11937930wib.53.1421295279395;
 Wed, 14 Jan 2015 20:14:39 -0800 (PST)
Received: by 10.27.11.225 with HTTP; Wed, 14 Jan 2015 20:14:39 -0800 (PST)
In-Reply-To: <CAKJhZwR+iMYAMCxurgc7z2dhqoqx_RxV1G4Jh3phPAOGptp_XQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262455>

Hi Zoltan,

I can't make a statement for the git project but I consider this kind
of brute-force removal a very problematic approach for languages like
C and C++. The reason for that is simple: Often header files include
other header files since their content depends on those other header
files. Let's assume a header file a.h includes b.h. Now consider a
file c.c includes both a.h and b.h since they are actually using stuff
from both of them. Your brute-force approach would now remove b.h
since it is indirectly pulled in through a.h. While the removal would
no lead to technially incorrect code it would no longer reflect the
semantical situation (since c.c still uses stuff from b.h). Even worse
is that if you later modify c.c to no longer use stuff from a.h you
could no longer remove a.h since that way you would break the chain to
b.h.

Thus doing those kind of brute-force removals generally makes the
include structure in a project very fragile. The analysis itself you
did is still useful to identify header files that can potentially be
removed but removing them without further analysis I would consider
problematic.

Robert
