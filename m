From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [RFC/PATCH 04/48] builtin/apply: extract line_by_line_fuzzy_match()
 from match_fragment()
Date: Thu, 10 Mar 2016 09:36:15 +0100
Message-ID: <CAP8UFD2G-vXLhChKxmfNZsuj5yLWTD6foCHQzUWt-B04-huTZw@mail.gmail.com>
References: <1457545756-20616-1-git-send-email-chriscool@tuxfamily.org>
	<1457545756-20616-5-git-send-email-chriscool@tuxfamily.org>
	<CAGZ79kbKCZGrBw8OOJzMES0BpMm1V8KQ6Xh2oS5ARB9KNMo+dA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
	Karsten Blees <karsten.blees@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Christian Couder <chriscool@tuxfamily.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Thu Mar 10 09:36:24 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1adw50-0000dy-Hl
	for gcvg-git-2@plane.gmane.org; Thu, 10 Mar 2016 09:36:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754447AbcCJIgT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Mar 2016 03:36:19 -0500
Received: from mail-lb0-f180.google.com ([209.85.217.180]:34964 "EHLO
	mail-lb0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750902AbcCJIgR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Mar 2016 03:36:17 -0500
Received: by mail-lb0-f180.google.com with SMTP id bc4so101466889lbc.2
        for <git@vger.kernel.org>; Thu, 10 Mar 2016 00:36:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=8EeIiYZsm3aAlylrf8tmNbjwGIbDN3DB710vfF9y9RU=;
        b=qIsVCsE3AmB2IkYd0+OpNYdFGOFUZ3M0yt1+9vbCUFGgIxvFDL1K2FKdgNghoiISDC
         mt4bIMp9mXT0M7D8qz1UHV17ncrNmN+z4nbTEwOk0T+c7HLGbENUw+SKmnU2NQiV0noZ
         0lP89snO/E3paY/ntLz6vP4UTni2vJXMEkDYtpeUiGyiWzl2vYKpEV8TkL++Ltjr0VH9
         ppx45OHTj/ZSAy/C5yL3ggrcITn3ORnEF4KVW44ExeuWPrLwRnAh7OOdndXWy63YGjMS
         +M2GKvq3TKKAaMMxIRsoiNIjwFvCR+6gKzEgiN1KrsBu/D/6CM2mJJjx2Nl4W1KXBY8D
         /8jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=8EeIiYZsm3aAlylrf8tmNbjwGIbDN3DB710vfF9y9RU=;
        b=TxgiL+6QD7aAAxPYAIxeKzvmwNDbEq1Ge/fOHVSNt8ZdakTZ3U52X1oYbPjwpNww6H
         2wBkz7Pv/hU8+4fUk1rTBtP+43+VW9Os+1Bo852bmPKzx1rgFTvLSgQOci9B5KBz77DM
         dPxzsJ0JTi9cAtW2XxXwzXgg3OPMqCz1k+3id3WyUtI8aTSjweC+6apFIO05oTtpCclO
         QvbZKSH1LHYIYE7saek1r2D5dfmfUn6LkBtdQ+WB5eLKdtBZeJBMxQXdEQ/Ht/vltQ4Z
         xTlKGA+Gi7ZlHpPlnc4tKHOTRkrHit/lJIT6hJ9rI+dFfW6AHDPUWKx7UGJXA7O9B15s
         7L4Q==
X-Gm-Message-State: AD7BkJIPco9PsfVnYr33w4aUEbiWNFFVfgItbIUKstxNHvw3Nbjuc3HMgviPdjgRRJ6/3YTQXny0SebZS09C2g==
X-Received: by 10.25.83.138 with SMTP id h132mr733216lfb.7.1457598975195; Thu,
 10 Mar 2016 00:36:15 -0800 (PST)
Received: by 10.25.137.130 with HTTP; Thu, 10 Mar 2016 00:36:15 -0800 (PST)
In-Reply-To: <CAGZ79kbKCZGrBw8OOJzMES0BpMm1V8KQ6Xh2oS5ARB9KNMo+dA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288601>

On Wed, Mar 9, 2016 at 11:55 PM, Stefan Beller <sbeller@google.com> wrote:
> On Wed, Mar 9, 2016 at 9:48 AM, Christian Couder
> <christian.couder@gmail.com> wrote:
>
> Some words in the commit message would be nice here as this is one of
> the patches,
> which isn't "obviously" a good thing to to. This comment also applies
> to "builtin/apply:
> introduce 'struct apply_state' to start libifying" where you lay out
> the plan for the next
> ~40 patches.

Ok, I will try to explain better at least those 2 patches.

Thanks,
Christian.
