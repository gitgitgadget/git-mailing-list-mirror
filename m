From: Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCHv3 03/13] xread_nonblock: add functionality to read from
 fds nonblockingly
Date: Mon, 21 Sep 2015 23:26:48 -0700
Message-ID: <CA+P7+xpWPShFWokrKYsJ13dOnugaJAg9FhfEoxwi_wwscik=CQ@mail.gmail.com>
References: <1442875159-13027-1-git-send-email-sbeller@google.com>
 <1442875159-13027-4-git-send-email-sbeller@google.com> <xmqqsi6771r2.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Stefan Beller <sbeller@google.com>, Git List <git@vger.kernel.org>,
	Jeff King <peff@peff.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Vitali Lovich <vlovich@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 22 08:27:18 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZeH2p-0005d3-KD
	for gcvg-git-2@plane.gmane.org; Tue, 22 Sep 2015 08:27:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932563AbbIVG1L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Sep 2015 02:27:11 -0400
Received: from mail-io0-f178.google.com ([209.85.223.178]:34944 "EHLO
	mail-io0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932223AbbIVG1I (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Sep 2015 02:27:08 -0400
Received: by ioiz6 with SMTP id z6so6584716ioi.2
        for <git@vger.kernel.org>; Mon, 21 Sep 2015 23:27:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=xVdS4u8VKCOo7HB1ygPU1+8A//fWDt4B6poX5z8c9nc=;
        b=yQdZFKh+2Eom+prEtGyhcf3HOpZlMTomfE/dqMMZ1qDiq1AWDFgBo4ax/axvguxSM5
         VRrZqilo883ahmBMA+yerwyaMRa+SYCmyP+gFrKaVVqNNy2iJpLrbloya70GZtDix4QV
         Mm4GVDcSBmQKD0SuJLUge3ZdDrkefishZihqhGaFAl0z+BlrM/pJdS2Go4A2oMllPjAY
         RioL1Npy7sLSOZR8exZo+Za/Kh7V9hDx5oTDmc85qaAPHSBVM1WJ6qsEGIb6aeKxewUM
         YG5ey3RxCwuoQ6q4qMvv1haebzArMdX+yWJRk5Fh45LCuzte3tbFXfE+Qiawb6DMTcZD
         a8CQ==
X-Received: by 10.107.166.201 with SMTP id p192mr35714642ioe.0.1442903228101;
 Mon, 21 Sep 2015 23:27:08 -0700 (PDT)
Received: by 10.107.132.155 with HTTP; Mon, 21 Sep 2015 23:26:48 -0700 (PDT)
In-Reply-To: <xmqqsi6771r2.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278379>

On Mon, Sep 21, 2015 at 5:10 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> This wrapper just restarts on EINTR, but not on EAGAIN like xread
>> does. This gives less guarantees on the actual reading rather than
>> on returning fast.
>
> The last sentence is a bit hard to parse, by the way.
>

I'd imagine something more like:

Provide a wrapper to read(), similar to xread(), that restarts on
EINTR but not EAGAIN (or EWOULDBLOCK). This enables the caller to
handle polling itself, possibly polling multiple sockets or performing
some other action.

Regards,
Jake
