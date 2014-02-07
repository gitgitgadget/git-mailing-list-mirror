From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 6/6] fetch-pack: fix deepen shallow over smart http with
 no-done cap
Date: Fri, 7 Feb 2014 07:52:06 +0700
Message-ID: <CACsJy8C_xzPyEF8npz3iQ2hvNFvZNRKwMKy5Tu8QuT3O=TPZpg@mail.gmail.com>
References: <1391699439-22781-1-git-send-email-pclouds@gmail.com>
 <1391699439-22781-7-git-send-email-pclouds@gmail.com> <xmqqbnykyrtl.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 07 01:52:44 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WBZgQ-0008R7-Es
	for gcvg-git-2@plane.gmane.org; Fri, 07 Feb 2014 01:52:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751933AbaBGAwi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 6 Feb 2014 19:52:38 -0500
Received: from mail-qc0-f170.google.com ([209.85.216.170]:43255 "EHLO
	mail-qc0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751531AbaBGAwh convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 6 Feb 2014 19:52:37 -0500
Received: by mail-qc0-f170.google.com with SMTP id e9so4717199qcy.15
        for <git@vger.kernel.org>; Thu, 06 Feb 2014 16:52:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=IDed4pt3+ZF5tsA6Ton0SjzM46/glEA8q3nfT0Vp0J8=;
        b=N881M0kwPlVPhyw8C9T9OQjY54Q4kVh2aBKhp9QNU2+wVnc8Tbyx+VfKPrVMceWUpa
         3XWryVxpTgjQou82W1aOLrDpwZ+Qrc6/PIRd2jrOLUY8ZesfMfzgw2ftu/v/YTJD6BSs
         HVCJoB+QxMG2HFrZXgXMFWHsNmpW0JpPb9eMWreaEfMeAr1osjMpNOBtDfDCjt6MfMv1
         9+1X3+6jxHHdoh1obhyKdon4qnftenJb2i1Sr+Bw+oTCbbNa3a76Q6znX3UN8s2kHi6u
         G7QysIgvIZL1pTdeQYqzcwAp55C2NSgELbSc6Aic3QAeknpmdhqNgGoQMbgrGI7GGdIa
         TrHw==
X-Received: by 10.140.47.212 with SMTP id m78mr15959913qga.21.1391734356834;
 Thu, 06 Feb 2014 16:52:36 -0800 (PST)
Received: by 10.96.215.102 with HTTP; Thu, 6 Feb 2014 16:52:06 -0800 (PST)
In-Reply-To: <xmqqbnykyrtl.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241759>

On Fri, Feb 7, 2014 at 2:16 AM, Junio C Hamano <gitster@pobox.com> wrot=
e:
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes=
:
>
>> In smart http, upload-pack adds new shallow lines at the beginning o=
f
>> each rpc response. Only shallow lines from the first rpc call are
>> useful. After that they are thrown away. It's designed this way
>> because upload-pack is stateless and has no idea when its shallow
>> lines are helpful or not.
>>
>> So after refs are negotiated with multi_ack_detailed and both sides
>> happy. The server sends "ACK obj-id ready", terminates the rpc call
>
> Is the above "... and both sides are happy, the server sends ..."?

Yes. Although think again, "both sides" is incorrect. If the server
side is happy, then it'll send "ACK.. ready" to stop the client. The
client can hardly protest.

> Do I understand the situation correctly if I said "The call to
> consume-shallow-list has been here from the very beginning, but it
> should have been adjusted like this patch when no-done was
> introduced."?

It's been there since the introduction of smart http (there are so
many "beginnings" in git). The rest is right.
--=20
Duy
