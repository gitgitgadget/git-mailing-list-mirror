From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH 0/3] protocol v2
Date: Fri, 27 Feb 2015 16:26:58 -0800
Message-ID: <CAPc5daUhN5OcQRs6Xn2oHDioZVze0VaPZFJ4OQCNKFy642hjWA@mail.gmail.com>
References: <1424747562-5446-1-git-send-email-sbeller@google.com>
 <CACsJy8BSf2h_xD-Q1tudAg_xCzffRQM+7xzUgprONxD7vM5RYw@mail.gmail.com>
 <CAPc5daVbrUaU6LFM65evru0+1tBT916+0AOyids=f7DZThTPGw@mail.gmail.com>
 <CAGZ79kbZHtZuPrb6rEP41vbdnZqJmsMwq+8pNer-_D4U5B1xZw@mail.gmail.com>
 <CACsJy8BN2imGCW0cueh-jGKfN_nRg3=J-GTX2P5h2z0Tu=id6A@mail.gmail.com>
 <xmqqsidtoojh.fsf@gitster.dls.corp.google.com> <CAGZ79kZE2+tCZgDzeTrQBn6JQv1OWJ7t_8j4kYMQgVaAbsnnxw@mail.gmail.com>
 <CACsJy8ASR-O-7tozw=p1Ek0ugct5EVZyWtxY_YA2nqcUV_+ECw@mail.gmail.com>
 <xmqqzj80l9c7.fsf@gitster.dls.corp.google.com> <xmqqioenhs4p.fsf@gitster.dls.corp.google.com>
 <CACsJy8AqRPm8ked+u0k83R2sFCE+XCGDEzeT_d4QsrKOOXUwLw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Stefan Beller <sbeller@google.com>,
	Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 28 01:27:24 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YRVFb-0000uE-QD
	for gcvg-git-2@plane.gmane.org; Sat, 28 Feb 2015 01:27:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753130AbbB1A1T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Feb 2015 19:27:19 -0500
Received: from mail-ob0-f176.google.com ([209.85.214.176]:63054 "EHLO
	mail-ob0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752808AbbB1A1S (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Feb 2015 19:27:18 -0500
Received: by mail-ob0-f176.google.com with SMTP id wo20so21838414obc.7
        for <git@vger.kernel.org>; Fri, 27 Feb 2015 16:27:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=RlLcefHXH2KWdI5GOcCHIAqzvpKnycy0d0MSAyGLwy0=;
        b=pOR9JkxS9J5Afwv75sV7pABJ/7KArcIldgnTnkNxuiS4oDqNb20Pntl2i7BsvpeyMp
         rzhYtXlaG+A184uycA5AyrmMnEnuDGQ9cvV2E3Ao4LGah7/Ah7j4JyU1D1GmWFA78LQW
         f0GXnXXFsuwyIVAWDH65+PNcuY6q9UkbfPssj88pVqX3ysQvyDw5gbMfXgW6su7gk+h5
         SK9SC74pGdvoG+rVVawf48O9dlaenJPFqegTNqJUWbI16eF84RT51iHONwm3FcdBfPo8
         rtdD9hBV5wzqs5AoTKnt4Tzkj0AyXdjjwbxxVNa03qTi5o/nK0MSsvGqpPfASMXxr4hR
         o0vA==
X-Received: by 10.202.207.197 with SMTP id f188mr11213339oig.29.1425083238272;
 Fri, 27 Feb 2015 16:27:18 -0800 (PST)
Received: by 10.202.48.132 with HTTP; Fri, 27 Feb 2015 16:26:58 -0800 (PST)
In-Reply-To: <CACsJy8AqRPm8ked+u0k83R2sFCE+XCGDEzeT_d4QsrKOOXUwLw@mail.gmail.com>
X-Google-Sender-Auth: 1WHH3coAqkag7vNAFP5v43zJROw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264515>

On Fri, Feb 27, 2015 at 4:07 PM, Duy Nguyen <pclouds@gmail.com> wrote:
>
> There may be another hole, if we send "want <empty-tree>", it looks
> like it will go through without causing errors. It's not exactly no-op
> because an empty tree object will be bundled in result pack. But that
> makes no difference in pratice. I didn't verify this though.

In addition to "that's not a no-op" problem, unless the old server has a
ref that has an emtpy tree at its tip, such a fetch request will be rejected,
unless the server is configured to serve any object, no?

If your new server does have a ref that points at an empty tree, a client
may request you to send that, but this is not a problem, because the
new server can tell if the client is sending it as a no-op probe or a serious
request by looking at its capability request. A serious old client will not
tell you that he is new, a probing new client does, and a serious new
client does. So your new server can tell and will not be confused.

> as a commit. But even if the parsing is through, a non-empty
> shallowCommits set would disable pack bitmap.

Performance penalty is fine. Over time we would upgrade and the
point of the exercise is not to cause the old-new or new-old pair to
die but keep talking the old protocol and getting correct results.
