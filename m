From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v3 0/8] Hiding refs
Date: Tue, 18 Mar 2014 21:36:01 +0700
Message-ID: <CACsJy8C4P6Wy=5_nOeB_RSyGpYKpybqaDUUyXUmfF67+-7UFzg@mail.gmail.com>
References: <20140311014945.GB12033@sigill.intra.peff.net> <xmqqtxb4pm3u.fsf@gitster.dls.corp.google.com>
 <20140311200513.GB29102@sigill.intra.peff.net> <xmqq4n34pjnw.fsf@gitster.dls.corp.google.com>
 <20140311203650.GA31173@sigill.intra.peff.net> <CACsJy8AZ0CfqHRYDrnQD+z0ibVQnsFuSzktEHKRhCVwaXPQryg@mail.gmail.com>
 <CAJo=hJvy6KKMNT9iyZAnKy18Pa+rQkKPQtfqT1e+ddXoVwX0yg@mail.gmail.com>
 <CACsJy8DtuCCYmmsEFB_m-YPHOOQ4FuchvnYQeuv75-vcSMej_w@mail.gmail.com>
 <CAJo=hJuGBgkseQ_mvbxFnYbkFDDWEuassf2+ttj_F53AMzU_Nw@mail.gmail.com>
 <20140318041739.GA7252@sigill.intra.peff.net> <20140318142719.GA9393@lanh>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Shawn Pearce <spearce@spearce.org>,
	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Mar 18 15:36:38 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WPv89-00084r-6I
	for gcvg-git-2@plane.gmane.org; Tue, 18 Mar 2014 15:36:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755491AbaCROgd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Mar 2014 10:36:33 -0400
Received: from mail-qc0-f178.google.com ([209.85.216.178]:44299 "EHLO
	mail-qc0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752264AbaCROgc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Mar 2014 10:36:32 -0400
Received: by mail-qc0-f178.google.com with SMTP id i8so7744368qcq.23
        for <git@vger.kernel.org>; Tue, 18 Mar 2014 07:36:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=sH9fbfZtWumEJA/Ck0z3Mz9TRMTPDdcpjvKXIYZd1y4=;
        b=yACnFjqGPB8rsTgYEVrWWL8O+0ssNjLs/RfAFtUS+SVME2jwIC7WhJl4OKTYjUn8QK
         NEsB/KLPGfffozNfO5Q2zoVuTiYA9UhgvDiD3deO8DPbDTdXkgJkioSKYEhwlk3BW4/3
         nIxYxXXogIjopYToJBLa8PE4dDEYhd2DvRi3UJIuSE72z0yI3gV5T36V3bLnKWPxM7Qj
         IqmCoRPPaAkcsEIVY7e0R8t6NZXR07pO3gPfm7Xk5xgMnHrN1EBTY2Feq8WVc9y2nxag
         JEHC/5qYqoyY8bSlX58jS/n+8YNoXo2hBt2Kp6GjnmT70Eon6jn26ytGFgd5AeoXmmqG
         nrfw==
X-Received: by 10.224.11.10 with SMTP id r10mr29929551qar.8.1395153391921;
 Tue, 18 Mar 2014 07:36:31 -0700 (PDT)
Received: by 10.96.146.102 with HTTP; Tue, 18 Mar 2014 07:36:01 -0700 (PDT)
In-Reply-To: <20140318142719.GA9393@lanh>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244359>

On Tue, Mar 18, 2014 at 9:27 PM, Duy Nguyen <pclouds@gmail.com> wrote:
> I thought about "GIT_CAPABILITIES= git-upload-pack ..." (and actually
> added it in pack-protocol.txt then deleted). The thing is, if you want
> to new upload-pack, you would need new git-upload-pack at the remote
> end that must understand "git-upload-pack <repo> <caps>"
> already. Making it aware about GIT_CAPABILITIES is extra cost for
> nothing. And we have to update git-shell to support it eventually.
>
> Well, the "must understand" part is not entirely true. If you make
> git-daemon pass the early capabilities via GIT_CAPABILITIES too,
> upload-pack does not have to support "<repo> <caps>" syntax. The
> upside is if old git-upload-pack ignores this GIT_CAPABILITIES, it'll
> break the protocol (see below) and can print friendly error
> messages. git-daemon has no way of printing friendly messages because
> it can't negotiate side-band.

I should have read my mail one more time before sending. The
"git-upload-pack ignores..." sentence is wrong. If it's old, its
behavior is fixed and it cannot not send or do anything new.

But on the other hand, this is good. The new protocol expects
upload-pack to send its caps in a new pkt-line. The old upload-pack
does not follow this, which should be the indicator for the client
that this server does not support v2, so it could fall back to v1
gracefully. git:// still fails hard because git-daemon is likely old
too and rejects it from the beginning. But ssh:// (without git-shell)
should work, http:// too. This is a very good point for
GIT_CAPABILITIES.
-- 
Duy
