From: Stefan Beller <sbeller@google.com>
Subject: Re: [RFC PATCH, WAS: "weird diff output?" 0/2] implement better chunk heuristics
Date: Fri, 15 Apr 2016 10:33:41 -0700
Message-ID: <CAGZ79kZPsGuimv3pFAFdwuhD1ps74qx7Q6d1kqxxRX6VPwNYGQ@mail.gmail.com>
References: <20160415165141.4712-1-jacob.e.keller@intel.com>
	<CAGZ79kbCHA3L6mUfYn6OfVXLDEyhv70PwxXo-YHP_QZXXAB8ig@mail.gmail.com>
	<CAGZ79kZs33sJj+DPSS4FPoJTLqbCLpvSe_h9UUQM-dBe=8ExKw@mail.gmail.com>
	<xmqq1t66dbp8.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jacob Keller <jacob.e.keller@intel.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Jeff King <peff@peff.net>, Jens Lehmann <Jens.Lehmann@web.de>,
	Davide Libenzi <davidel@xmailserver.org>,
	Jacob Keller <jacob.keller@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 15 19:33:49 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ar7cp-0001Xi-QX
	for gcvg-git-2@plane.gmane.org; Fri, 15 Apr 2016 19:33:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752122AbcDORdn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Apr 2016 13:33:43 -0400
Received: from mail-io0-f182.google.com ([209.85.223.182]:35671 "EHLO
	mail-io0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751747AbcDORdm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Apr 2016 13:33:42 -0400
Received: by mail-io0-f182.google.com with SMTP id g185so141484748ioa.2
        for <git@vger.kernel.org>; Fri, 15 Apr 2016 10:33:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=/F3M6nleRVRJAGnuv8LwiyldzDdcvmKFSqTgeGPBUeg=;
        b=h5HaRKmW88aStdiiU2jWKJMWsj29ZGlIg+WylRfrJqy81mioUphjxkEUNf27Jg7dHY
         yBQhbah/qxnTCZ5FDKcvND+Llpiz2jKcYxuWsPhdHzPnioHDoZATbWNDqciVy4avMpBM
         dFxtrRqxyJ7sXQ+/gDlWBFLwefduVPocpnA4hvYdRP5W9caps6dghsrhTmLjB74cHHO9
         770PY0eBCFiZSMrqwzAlCp4Z8z1/GH0XE6jOWV9bKbNcnSSww8zo8Jb3+QJ9HayKAIrD
         jUu9c8kXd76WaTfYSvSO7MXzsyhmgJUnGgPBFwxpmYA5dBuKU8gfwU8MaDPlUjvgWJ49
         SOXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=/F3M6nleRVRJAGnuv8LwiyldzDdcvmKFSqTgeGPBUeg=;
        b=iOROusLwBHD6A2UnWamtIO7Pln21JTHTFUmWfNArlvLC+WG+FxIATmdmv/OVHz/S1p
         SCf3hhs+V9dgjTQ1QR4gW4aNLBf/VHj95iHNZYO/4BLE/sW1veW8cozCnQkexNCPAdfh
         rVuR6qxwbv85PC/XZohmkL2ppcPmfhHLsHW65UUcItYZ5PW356mRa0GA4BFVzyZnPBoK
         3NlX2suBkFuRUvL71xjqz2N+iIy+thYC449dEHrX9l3VrRIcdDGqPCUgA91vKfyNIwXK
         U0V7wwz/L3L+ZqtztMGXGEnK40+cKx6WyckDjuB3oyKUiIfLJPeTnv8FcBDO4ptMv37H
         QyLg==
X-Gm-Message-State: AOPr4FV90eRDYWi1z2mIWbwh+tSQjJpCxDODuCuJSg8+Hy2W4tJQdwPAqguvvdBrtTOtHNC3phaJ6WPpHxhGJHn/
X-Received: by 10.107.184.8 with SMTP id i8mr23916261iof.96.1460741621660;
 Fri, 15 Apr 2016 10:33:41 -0700 (PDT)
Received: by 10.107.17.27 with HTTP; Fri, 15 Apr 2016 10:33:41 -0700 (PDT)
In-Reply-To: <xmqq1t66dbp8.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291627>

On Fri, Apr 15, 2016 at 10:27 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> Actually we would only need to have the empty line count in the
>> second loop as the first loop shifted it as much up(backwards) as
>> possible, such that the hunk sits on one end of the movable
>> range. The second loop would iterate over the whole range, so that
>> would be the only place needed to count.
>
> The description makes me wonder if we can do without two loops ;-)

I think the existing 2 loops are needed to move "as much as possible"
to either boundary to see if there is overlap to another group and combine
the groups if so. (This whole construction prior to these patches remind
me of shaker sort)

>
> That is, can we teach the first loop not to be so aggressive to
> shift "as much as possible" but notice there is an empty line we
> would want to treat specially?

I think we need to be aggressive to find adjacent groups and only after
that is done we should think about optimizing look&feel? That is why I
even proposed to not touch the current 2 loops at all and have our own
loop to find out if there is at least one empty line.
