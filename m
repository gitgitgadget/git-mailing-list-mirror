From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Fix "git diff --stat" for interesting - but empty - file changes
Date: Wed, 17 Oct 2012 12:35:48 -0700
Message-ID: <CA+55aFzChDPv3Vu5D9rXmXvQmxoxsxgZYVEyf9CaUmYP+Xs0OA@mail.gmail.com>
References: <CA+55aFz88GPJcfMSqiyY+u0Cdm48bEyrsTGxHVJbGsYsDg=Q5w@mail.gmail.com>
 <7v4nltoswd.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 17 21:36:23 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TOZPh-0007DE-O2
	for gcvg-git-2@plane.gmane.org; Wed, 17 Oct 2012 21:36:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757606Ab2JQTgL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Oct 2012 15:36:11 -0400
Received: from mail-oa0-f46.google.com ([209.85.219.46]:52238 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753924Ab2JQTgJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Oct 2012 15:36:09 -0400
Received: by mail-oa0-f46.google.com with SMTP id h16so7827706oag.19
        for <git@vger.kernel.org>; Wed, 17 Oct 2012 12:36:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type;
        bh=XVbTrGn3TJOe/NpimJPLqNTTiJW1HU3y5HDEOSBhSoA=;
        b=qyoiIpTNGerLSmvh1OZUp01wzutOWDDSiRoq8vTyPG7dLslcGJtdWk4WmF9yYA9yId
         SH+25LQAuw84bEczHsvjH7XC7T7Fmq02/4Mxx0UcwEaCTHOM2N0MQOfXkqsyL6Cq5/gi
         lyMHZXWi/cxnzJWYFSv5WFPpVwencRA34R0cu3I3AHY8F+HFXqvc3BRRVNYNDvVhwH+N
         KQWfwMErMViI4qpyaeC0ydBh7+esdfSRm48tDhGncH1wITJdbiUbcYru1R4Gc6/fzchc
         DESGvb3oAlGK4ufyO3eF8S2yUfgj/V1RRWaSwMFbP/tMWFUSN31rL+H9CtrSdqGtJ8gC
         DuLw==
Received: by 10.60.28.68 with SMTP id z4mr16103803oeg.119.1350502569168; Wed,
 17 Oct 2012 12:36:09 -0700 (PDT)
Received: by 10.76.2.242 with HTTP; Wed, 17 Oct 2012 12:35:48 -0700 (PDT)
In-Reply-To: <7v4nltoswd.fsf@alter.siamese.dyndns.org>
X-Google-Sender-Auth: 9uimIfc327xzWFBbAXMTUxpYm74
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207937>

On Wed, Oct 17, 2012 at 11:28 AM, Junio C Hamano <gitster@pobox.com> wrote:
>
> I think listing a file whose content remain unchanged with 0 as the
> number of lines affected makes sense, and it will mesh well with
> Duy's
>
>   http://thread.gmane.org/gmane.comp.version-control.git/207749
>
> I first wondered if we would get a division-by-zero while scaling
> the graph, but we do not scale smaller numbers up to fill the
> columns, so we should be safe.

Note that we should be safe for a totally different - and more
fundamental - reason: the zero line case is by no means new. We've
always done it for the rename case.

> These days, we omit 0 insertions and 0 deletions, so I am not sure
> what you should get for this case, though:
>
>>  Makefile | 0
>>  1 file changed, 0 insertions(+), 0 deletions(-)
>
> Should we just say "1 file changed"?

If that is what it does for the rename case, then yes. I think it
should fall out naturally.

              Linus
