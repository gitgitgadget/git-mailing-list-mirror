From: Michael Witten <mfwitten@gmail.com>
Subject: Re: vger doesn't like UTF-8 from send-email
Date: Sat, 12 Jun 2010 23:15:51 -0500
Message-ID: <AANLkTim1QajqLOp4y6-oIMAGp8Tkf7z9uTH6bwIIFYkH@mail.gmail.com>
References: <20100612000002.GA30196@neumann> <cover.1276336602.git.trast@student.ethz.ch> 
	<201006121211.12870.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Sun Jun 13 06:16:47 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ONeck-0006l4-CM
	for gcvg-git-2@lo.gmane.org; Sun, 13 Jun 2010 06:16:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750765Ab0FMEQY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Jun 2010 00:16:24 -0400
Received: from fg-out-1718.google.com ([72.14.220.153]:51483 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750706Ab0FMEQX (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Jun 2010 00:16:23 -0400
Received: by fg-out-1718.google.com with SMTP id l26so745590fgb.1
        for <git@vger.kernel.org>; Sat, 12 Jun 2010 21:16:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type;
        bh=JuGX8bGzFUXDbn1TvJm5O8XpqU6FIyyYUyNd00UqJFs=;
        b=dNP2xLQrtEdhEnr2OIELDs94k9etp4UqtR5d5cZSxgBonMnOryTV995/AEQBOyO+Au
         Vz5kYGFrNHpysvh4YwOY1a2fNo2CmMVDxsVC0aP34HwTAzcMOk4TxU6HBopuDLFaiGQr
         dfStyCEl2Kz7ZyCK/H1RXsRUPhXjyBdAEbVHE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=GGrth/+N4sVSoQuKWEx+Y6t/dkJPbBQN47641VjR6JDZ5OC2ZRo545UY5bukXuvy7Y
         dcbZXRGnlARz7WIXB55LY9VyAdjHPOcJmgqxpUe2Q3GpF+Y0hCGKHEpDSsLldlMBr4Rt
         vCg99USAwUhcYqpAjX+vohVHMqf91gZcelSkw=
Received: by 10.239.152.7 with SMTP id t7mr242369hbb.157.1276402581103; Sat, 
	12 Jun 2010 21:16:21 -0700 (PDT)
Received: by 10.239.189.143 with HTTP; Sat, 12 Jun 2010 21:15:51 -0700 (PDT)
In-Reply-To: <201006121211.12870.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149036>

On Sat, Jun 12, 2010 at 05:11, Thomas Rast <trast@student.ethz.ch> wrote:
> AFAICT the original message did not declare an encoding:
>
> Subject: [PATCH v2 0/2] bash completion: Support "divergence from upstream" warnings in __git_ps1
> Date: Sat, 12 Jun 2010 12:02:14 +0200
> Message-ID: <cover.1276336602.git.trast@student.ethz.ch>
> X-Mailer: git-send-email 1.7.1.561.g94582
> In-Reply-To: <20100612000002.GA30196@neumann>
> References: <20100612000002.GA30196@neumann>
> MIME-Version: 1.0
> Content-Type: text/plain
> Return-Path: trast@student.ethz.ch
> ...
> Is this a new vger policy, or am I hitting a send-email bug?

Let's assume the headers themselves are already properly encoded.

According to:

    http://www.faqs.org/rfcs/rfc2045.html

we have:

    The proper Content-Transfer-Encoding
    label must always be used.

and:

    An encoding type of 7BIT requires that
    the body is already in a 7bit mail-ready
    representation.  This is the default value
    -- that is, "Content-Transfer-Encoding: 7BIT"
    is assumed if the Content-Transfer-Encoding
    header field is not present.

Moreover, according to:

    http://www.faqs.org/rfcs/rfc2046.html

we have:

    4.1.2    Charset Parameter
    ...
    The default character set, which must be
    assumed in the absence of a charset parameter,
    is US-ASCII.

So, your email is indeed incorrect in 2 ways if the body contains
UTF-8 encoded data.

>From what I've skimmed, the mail user agent (MUA)---such as
send-email---could send your unmodified message body by producing
these headers:

    MIME-Version: 1.0
    Content-type: text/plain; charset=utf-8
    Content-transfer-encoding: 8bit

but only 7bit transfer encodings are guaranteed to make it intact to
the destination; consequently, it would probably be a good idea for
the MUA to transform your message into some 7bit encoding, preferably
a human-readable one such as the 'quoted-printable' encoding; after
such a transformation, the headers could be:

    MIME-Version: 1.0
    Content-type: text/plain; charset=utf-8
    Content-transfer-encoding: quoted-printable

Sincerely,
Michael Witten
