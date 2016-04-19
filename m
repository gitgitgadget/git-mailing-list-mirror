From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 2/2] xdiff: implement empty line chunk heuristic
Date: Tue, 19 Apr 2016 08:17:38 -0700
Message-ID: <CAGZ79kbzg7SmJHFpxeJNKmLaEEw+irCxUedo45jGx8G8fmPtKg@mail.gmail.com>
References: <1461013950-12503-1-git-send-email-sbeller@google.com>
	<1461013950-12503-3-git-send-email-sbeller@google.com>
	<20160419050342.GA19439@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Jacob Keller <jacob.keller@gmail.com>,
	Jacob Keller <jacob.e.keller@intel.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Apr 19 17:17:45 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1asXPM-0002ry-L0
	for gcvg-git-2@plane.gmane.org; Tue, 19 Apr 2016 17:17:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932433AbcDSPRl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Apr 2016 11:17:41 -0400
Received: from mail-io0-f171.google.com ([209.85.223.171]:33623 "EHLO
	mail-io0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932106AbcDSPRk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Apr 2016 11:17:40 -0400
Received: by mail-io0-f171.google.com with SMTP id f89so11737473ioi.0
        for <git@vger.kernel.org>; Tue, 19 Apr 2016 08:17:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=TWTiRZPc4Su6BtummJoPDsAP92+EwrgVmVszXfO4toI=;
        b=XZLQFep7BPEni7akZqmTG4vD8FR7D86ABw60DCzROfepg1m4DkuoVSj+rFh+yyceb6
         qOYeFnC8j/yrY5MPVQwmV2+WLUv1dcw0ACzhXDXFvvEyaBYgm8XdJQsMNLYjq2S1Bsbf
         mSmokyv1a6LPlVDTfoxqR1PcCizonF8Ov8gnGJ2eTxumtLIhIs9MsrK1wLIGJciUKSPU
         EyqasYO/3o+rUYEvkLZyFvFu//xK6NdGcEtHDg+41tkoHetBkKBvnNq+TMfNQSYOuwEf
         j80E2UVvA0JQLHiYNOZNuCjUr2B3/huN02MbG22lpb2/pDvwUBIhg0NSWhkOeQ74ZqiZ
         7Z3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=TWTiRZPc4Su6BtummJoPDsAP92+EwrgVmVszXfO4toI=;
        b=ELwhZWAKT2O2IGg7AEKiO00x+gHyFBJ10EJHnvbEPNslPvP32lySihvkMiF5Tb2ItH
         wHTVRvJho013hN1C0G+3QDEHH+KTmTDOKWVD8sPxlJVouFgdEuk9GjfXLdTLNP38VM9d
         PjdgQXO9QOokRw5zhlLTdZpRpuxYRZMmNwJ7vVpjyBz/qEE2/o+1QGeVsWf+sfKJ12Ug
         o3BOZtWaqXYLipQrphBeGO3s42yC7MYFO7ke715VSCmVcz7iiKh4Mzget/uNFY0v4WpK
         edXJQPuW0pu5xlLc0RUz8gstjMiLnF66lTbWjREKrBuAZpvg98ajP8F2pqGmdOHR7t6n
         69eg==
X-Gm-Message-State: AOPr4FXMtgtetRMarGcKJ+Ng396/St2WXTEUqHpyHhWpjAUHKelRP9FlVL6544gx4Vq7EtzILNX97I4TTg5oHY4r
X-Received: by 10.107.184.8 with SMTP id i8mr4302206iof.96.1461079059115; Tue,
 19 Apr 2016 08:17:39 -0700 (PDT)
Received: by 10.107.17.27 with HTTP; Tue, 19 Apr 2016 08:17:38 -0700 (PDT)
In-Reply-To: <20160419050342.GA19439@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291873>

On Mon, Apr 18, 2016 at 10:03 PM, Jeff King <peff@peff.net> wrote:

> I guess this will invalidate old patch-ids, but there's not much to be
> done about that.

What do you mean by that? (What consequences do you imagine?)
I think diffs with any kind of heuristic can still be applied, no?

Thanks,
Stefan

>
> -Peff
