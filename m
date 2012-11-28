From: Thomas Berg <merlin66b@gmail.com>
Subject: Re: Millisecond precision in timestamps?
Date: Wed, 28 Nov 2012 09:19:53 +0100
Message-ID: <CABYiQpmEpdf3L56NYSvPWovNOs_ifqj5QctuPSMoygHyMrz8+g@mail.gmail.com>
References: <20121127204828.577264065F@snark.thyrsus.com>
	<CAJo=hJtZ+n+D4pOmeNApDeLNyZYeqnEDDYJWwSj_wLauQ+w4hQ@mail.gmail.com>
	<7vzk22lmz9.fsf@alter.siamese.dyndns.org>
	<20121127230419.GA26080@thyrsus.com>
	<CAJo=hJtOqRHcjWH1F71Qc5zvPkUAe+u1RrcC2pt_xQwLSUY0yg@mail.gmail.com>
	<20121128001231.GA27971@thyrsus.com>
	<CAMP44s3hpuxbo7mfKAD2trOkezPrV3nKYpNAzXOs3sQym102LQ@mail.gmail.com>
	<CAJo=hJuskvYaNTtCcTSqvU8YwEU=HwRpb_sqW-BSxfSr7xE57A@mail.gmail.com>
	<20121128011750.GA23498@sigill.intra.peff.net>
	<7v7gp6i3rx.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Jeff King <peff@peff.net>, Shawn Pearce <spearce@spearce.org>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Eric Raymond <esr@thyrsus.com>, git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 28 09:20:11 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TdcsM-0000nN-Jg
	for gcvg-git-2@plane.gmane.org; Wed, 28 Nov 2012 09:20:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751720Ab2K1ITz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Nov 2012 03:19:55 -0500
Received: from mail-lb0-f174.google.com ([209.85.217.174]:54582 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751134Ab2K1ITy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Nov 2012 03:19:54 -0500
Received: by mail-lb0-f174.google.com with SMTP id gi11so7358005lbb.19
        for <git@vger.kernel.org>; Wed, 28 Nov 2012 00:19:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=ZDwxtuqO7c8yeUcDPxHkt5VCrGqNmtxkRXw4vtkOxuU=;
        b=PivRFfRggznGjTMQzjbV4RnkzUYC+r/ONsqzx2Api/X/o2OjoBnlMiUEUDB9ML6y71
         TAuZSRzHxMId9az3w0eyFnujU67pQvwDcIUkTxzjMqqtHUfg79sm79Zxy992kcmyfhe6
         xgc06sL9U4l8ng5RSS21rj5mwUzQe+3fW9Bt5jZrwz7U+iDQruBL7pmky8gcvN3KTxlq
         vQw3Nqie1dO5lXa5S/3u7sAePH9MKpRl2yKTlKLHAh88x5kRtPFpvt9R7AQUN/Y8zcid
         PVGboIEpvS4EAWJNyKK5CN+oyzXNQU8QY2HSHnJW3tYXfe0IhI6mwMcBPGjXQ+P5Qf+N
         ryIw==
Received: by 10.152.103.100 with SMTP id fv4mr16971694lab.39.1354090793265;
 Wed, 28 Nov 2012 00:19:53 -0800 (PST)
Received: by 10.114.17.69 with HTTP; Wed, 28 Nov 2012 00:19:53 -0800 (PST)
In-Reply-To: <7v7gp6i3rx.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210720>

On Wed, Nov 28, 2012 at 8:29 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Jeff King <peff@peff.net> writes:
>
>> There is room for new headers, and older versions of git will ignore
>> them. You could add a new "committer-timestamp" field that elaborates on
>> the timestamp included on the committer line. Newer versions of git
>> would respect it, and older versions would fall back to using the
>> committer timestamp.
>>
>> But I really wonder if anybody actually cares about adding sub-second
>> timestamp support, or if it is merely "because SVN has it".
>
> Roundtrip conversions may benefit from sub-second timestamps, but
> personally I think negative timestamps are more interesting and of
> practical use.  Prehistoric projects need them even if they intend
> to switch to Git, never to go back to their original tarballs and
> collection of RCS ,v files.

If roundtripping to other version control systems is an argument,
adding sub-second timestamps could potentially create as many problems
as it solves. For example, I've been using the hg-git bridge, and it
supports roundtripping between git and mercurial today (for most repos
I've tried anyway). I may have missed something, but this could imply
that mercurial doesn't care about sub-second timestamps either. If so,
and if git suddenly were to record it, it would no longer be as
straight forward to represent git history in hg.

In my opinion it would be a shame to sacrifice this compatibility just
to reduce the distance to svn, which is much larger anyway.

- Thomas
