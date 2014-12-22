From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 1/7] receive-pack.c: add protocol support to negotiate atomic-push
Date: Mon, 22 Dec 2014 17:52:48 -0500
Message-ID: <CAPig+cRStBZMNj_K-81n2aZ3SzvH8VSeXwwk0MM5Q01FANRdPg@mail.gmail.com>
References: <1419017941-7090-1-git-send-email-sbeller@google.com>
	<1419017941-7090-2-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: ronnie sahlberg <ronniesahlberg@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git List <git@vger.kernel.org>,
	Ronnie Sahlberg <sahlberg@google.com>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Mon Dec 22 23:52:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y3BqQ-0001w2-Fg
	for gcvg-git-2@plane.gmane.org; Mon, 22 Dec 2014 23:52:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752556AbaLVWwu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Dec 2014 17:52:50 -0500
Received: from mail-yh0-f50.google.com ([209.85.213.50]:46319 "EHLO
	mail-yh0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751466AbaLVWwt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Dec 2014 17:52:49 -0500
Received: by mail-yh0-f50.google.com with SMTP id 29so2912563yhl.23
        for <git@vger.kernel.org>; Mon, 22 Dec 2014 14:52:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=ZaRjF1E2tWrpSu1ObYpK0J2aXCbU761EoqGoJGP7mN8=;
        b=xBKaFsip3mF4UFR4N0bqNwtgCWsttlgd6HtEovc/zx82zfDW3YJgXW+eWMDOPbAO60
         5bVv4Ueq6THx0gDnFJ02FpNHBssjg4tnVszWiA1OGAWsBpQs1FnFGXaOj5/b/1Nv3jXz
         Aip6dEM4XEVasPVbwg2AllpePnwewt66k/Ig75ryLwa/vbSaH2PbgJAw+y3Tw8kigBmE
         UNftAohkwKLeCiK+Rprw/62EPhSiDjxYIk8ZBXu8xNo640Xp/3SeNuSpWdHEWeZR1BDZ
         tP9I6mCQyMerg7eUGmETT3RWKPP05mtcyQ4t9bnGFTNWnBqevka9ryhgsqs68m5uqBMW
         v+hQ==
X-Received: by 10.170.127.5 with SMTP id t5mr4834304ykb.2.1419288768701; Mon,
 22 Dec 2014 14:52:48 -0800 (PST)
Received: by 10.170.73.7 with HTTP; Mon, 22 Dec 2014 14:52:48 -0800 (PST)
In-Reply-To: <1419017941-7090-2-git-send-email-sbeller@google.com>
X-Google-Sender-Auth: s2ewgs7MT6NrC946i9wUeXLDKdA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261692>

On Fri, Dec 19, 2014 at 2:38 PM, Stefan Beller <sbeller@google.com> wrote:
> From: Ronnie Sahlberg <sahlberg@google.com>
>
> This adds support to the protocol between send-pack and receive-pack to
> * allow receive-pack to inform the client that it has atomic push capability
> * allow send-pack to request atomic push back.
>
> There is currently no setting in send-pack to actually request that atomic
> pushes are to be used yet. This only adds protocol capability not ability
> for the user to activate it.
>
> Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
> diff --git a/Documentation/technical/protocol-capabilities.txt b/Documentation/technical/protocol-capabilities.txt
> index 6d5424c..4f8a7bf 100644
> --- a/Documentation/technical/protocol-capabilities.txt
> +++ b/Documentation/technical/protocol-capabilities.txt
> @@ -244,6 +245,14 @@ respond with the 'quiet' capability to suppress server-side progress
>  reporting if the local progress reporting is also being suppressed
>  (e.g., via `push -q`, or if stderr does not go to a tty).
>
> +atomic
> +------
> +
> +If the server sends the 'atomic' capability it is capable of accepting
> +atomic pushes. If the pushing client requests this capability, the server
> +will update the refs in one atomic transaction. Either all refs are

Not itself worth a re-send, but if you re-send for some other reason...

"one atomic" still smacks of redundancy; "an atomic" sounds better.

> +updated or none.
> +
>  allow-tip-sha1-in-want
>  ----------------------
