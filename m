From: Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCHv3 02/13] xread: poll on non blocking fds
Date: Mon, 21 Sep 2015 23:23:38 -0700
Message-ID: <CA+P7+xozmsT4mZsBdvSQkGx4Wk-bOE1h-vAbRG_LAL5A-MAwTw@mail.gmail.com>
References: <1442875159-13027-1-git-send-email-sbeller@google.com>
 <1442875159-13027-3-git-send-email-sbeller@google.com> <xmqq37y78gzt.fsf@gitster.mtv.corp.google.com>
 <5600DF2D.9010202@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Stefan Beller <sbeller@google.com>,
	Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Vitali Lovich <vlovich@gmail.com>
To: =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Tue Sep 22 08:24:29 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZeH05-00022G-1t
	for gcvg-git-2@plane.gmane.org; Tue, 22 Sep 2015 08:24:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751657AbbIVGX7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 22 Sep 2015 02:23:59 -0400
Received: from mail-io0-f182.google.com ([209.85.223.182]:35139 "EHLO
	mail-io0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750775AbbIVGX7 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 22 Sep 2015 02:23:59 -0400
Received: by ioiz6 with SMTP id z6so6538668ioi.2
        for <git@vger.kernel.org>; Mon, 21 Sep 2015 23:23:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=JO0riXVkbuMbXg68smp3ksOId22y/t8grTC1uLEObVE=;
        b=i3m4Pv80b8gH7XxCqOt929HMFNoWXwo4o1nM1J4X+Hmb8Tv0i2lGCVuWunZl97aVjO
         msPl2fIwYZp3fFycRlkiKKpwdhYLzjpxE6QwYTH5TZ2bg00HV3C409em0Y259guosCBD
         bKpv+0mshBYjLdHbDMiIk4BgCTlkzd9VfA9uOOuPHMNhRNI0DlMObcY1+iNTlrIZAmWr
         hL+826crjuB7A1qYfLuNJFDMHV8a+EQXOAFAkafaPZq+177Cx3YFJd6yjcT6/LDGDbkD
         q3njkJ3DeDuP3mK+CB9kwzRQ1P50QH8w5fg+KJzMZAd49n20Ny9vCUBci6l+syOj1ozS
         HG0Q==
X-Received: by 10.107.130.220 with SMTP id m89mr30675274ioi.146.1442903038302;
 Mon, 21 Sep 2015 23:23:58 -0700 (PDT)
Received: by 10.107.132.155 with HTTP; Mon, 21 Sep 2015 23:23:38 -0700 (PDT)
In-Reply-To: <5600DF2D.9010202@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278378>

On Mon, Sep 21, 2015 at 9:55 PM, Torsten B=C3=B6gershausen <tboegi@web.=
de> wrote:
> But in any case I suggest to  xread() as it is, and not to change the
> functionality
> behind the back of the users.
>
>

I don't think this patch actually changes behavior as it stands now. I
think Junio's suggestion does. Personally, I'd prefer some sort of
warning when you use xread and get EAGAIN or EWOULDBLOCK. I'd rather
see it somehow warn so that we can find the bug (since we really
really shouldn't be calling xread with a blocking socket, especially
if we have xread_noblock or similar as in this series.

Not sure if we really want to handle that, but I know we don't want to
change external behavior of xread... I think that polling is better
than the current "spinning" behavior.

Regards,
Jake
