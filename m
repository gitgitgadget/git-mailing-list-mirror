From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 4/4] Only re-encode certain parts in commit object, not
 the whole
Date: Wed, 22 Feb 2012 09:01:20 +0700
Message-ID: <CACsJy8BZixyzf73TGPdf+_=rz59J4GWUq8B8WXuf+n97-OF=sQ@mail.gmail.com>
References: <1329834292-2511-1-git-send-email-pclouds@gmail.com>
 <1329834292-2511-4-git-send-email-pclouds@gmail.com> <20120221182559.GB32668@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Feb 22 03:02:04 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S01Wm-0007Yp-Uw
	for gcvg-git-2@plane.gmane.org; Wed, 22 Feb 2012 03:01:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753597Ab2BVCBw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 21 Feb 2012 21:01:52 -0500
Received: from mail-we0-f174.google.com ([74.125.82.174]:46916 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752022Ab2BVCBv convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 21 Feb 2012 21:01:51 -0500
Received: by werb13 with SMTP id b13so4192989wer.19
        for <git@vger.kernel.org>; Tue, 21 Feb 2012 18:01:50 -0800 (PST)
Received-SPF: pass (google.com: domain of pclouds@gmail.com designates 10.180.99.65 as permitted sender) client-ip=10.180.99.65;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of pclouds@gmail.com designates 10.180.99.65 as permitted sender) smtp.mail=pclouds@gmail.com; dkim=pass header.i=pclouds@gmail.com
Received: from mr.google.com ([10.180.99.65])
        by 10.180.99.65 with SMTP id eo1mr31691741wib.13.1329876110261 (num_hops = 1);
        Tue, 21 Feb 2012 18:01:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=yxNHLGiaJXsaa4BxfO3YATjbkufojhxIyEJSHK6GRFU=;
        b=sktXwyvMyuV11fsaDGFHqwzUpPCEYi6IUL3mTvQTrX5Wn8+iZFSseh7mIXtamtBR9g
         dwrL6T4sdfWJu/ND6wgSXoYTuuSm6z1e1e1rtte2TQu8iS1h01kFxvjJ3StHHjP6jJgC
         fbZsXMfQByklJ1sD0KuSA0sXdlhy3Jx0Xr91w=
Received: by 10.180.99.65 with SMTP id eo1mr26443764wib.13.1329876110228; Tue,
 21 Feb 2012 18:01:50 -0800 (PST)
Received: by 10.223.13.5 with HTTP; Tue, 21 Feb 2012 18:01:20 -0800 (PST)
In-Reply-To: <20120221182559.GB32668@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191218>

2012/2/22 Jeff King <peff@peff.net>:
> On Tue, Feb 21, 2012 at 09:24:52PM +0700, Nguyen Thai Ngoc Duy wrote:
>
>> Commit object has its own format, which happens to be in ascii, but
>> not really subject to re-encoding.
>>
>> There are only four areas that may be re-encoded: author line,
>> committer line, mergetag lines and commit body. =C2=A0Encoding of ta=
gs
>> embedded in mergetag lines is not decided by commit encoding, so lea=
ve
>> it out and consider it binary.
>
> Is this worth the effort? Yes, re-encoding the ASCII bits of the comm=
it
> object is unnecessary. But do we actually handle encodings that are n=
ot
> ASCII supersets? IOW, I could see the point if this is making it
> possible to hold utf-16 names and messages in your commits (though wh=
y
> you would want to do so is beyond me...). But my understanding is tha=
t
> this is horribly broken anyway by other parts of the code. And even
> looking at your code below:

No, utf-16 and friends are out of question. 617/1168 supported
encodings in iconv translate chars 10,32-126 to something else, some
of them does not generate NUL. I suppose none of these are actually
used nowadays. Looking again, some don't even successfully translate
the given input. No, it's probably not worth the effort.
--=20
Duy
