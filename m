From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [PATCH] remote-curl: Fix push status report when all branches fail
Date: Fri, 20 Jan 2012 07:15:02 -0800
Message-ID: <CAJo=hJtCb=WFfuSKWvPk+S4sRQmSGemG_Ugqj+k1TZCOJj9vLQ@mail.gmail.com>
References: <7vzkdjgv1i.fsf@alter.siamese.dyndns.org> <1327029129-11424-1-git-send-email-spearce@spearce.org>
 <7vobtyhq16.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 20 16:16:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RoGCx-0006A0-Em
	for gcvg-git-2@lo.gmane.org; Fri, 20 Jan 2012 16:16:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753919Ab2ATPQq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Jan 2012 10:16:46 -0500
Received: from mail-pw0-f46.google.com ([209.85.160.46]:50321 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753717Ab2ATPPX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Jan 2012 10:15:23 -0500
Received: by pbaa10 with SMTP id a10so376082pba.19
        for <git@vger.kernel.org>; Fri, 20 Jan 2012 07:15:23 -0800 (PST)
Received: by 10.68.212.130 with SMTP id nk2mr19818333pbc.69.1327072523130;
 Fri, 20 Jan 2012 07:15:23 -0800 (PST)
Received: by 10.68.50.10 with HTTP; Fri, 20 Jan 2012 07:15:02 -0800 (PST)
In-Reply-To: <7vobtyhq16.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188882>

On Thu, Jan 19, 2012 at 22:00, Junio C Hamano <gitster@pobox.com> wrote:
> "Shawn O. Pearce" <spearce@spearce.org> writes:
>> +cat >exp <<EOF
>> +remote: error: hook declined to update refs/heads/dev2
>
> Curious. Where do we get these eight trailing whitespaces?

I think this is padding being added to the end of the line by
recv_sideband(). I noticed the trailing whitespace in the diff, but
the test passed with it present, so I had to leave it in.

> The call to rp_error("hook declined to update %s", name) seems to be
> giving the name properly.

Yea, I think the server is sending the correct data in the sideband
channel, its just the sideband client padding out the line. I think
this padding is a fudge against progress meters that are being written
and over-written with \r lines in subsequent sideband packets.
