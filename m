From: Junio C Hamano <gitster@pobox.com>
Subject: Re: ref-format checking regression
Date: Fri, 27 Apr 2012 08:06:26 -0700
Message-ID: <xmqqr4v99pu5.fsf@junio.mtv.corp.google.com>
References: <20120427115000.GA8126@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>, Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Apr 27 17:06:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SNmkk-0002SY-Q3
	for gcvg-git-2@plane.gmane.org; Fri, 27 Apr 2012 17:06:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760236Ab2D0PG3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Apr 2012 11:06:29 -0400
Received: from mail-fa0-f74.google.com ([209.85.161.74]:51597 "EHLO
	mail-fa0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760199Ab2D0PG3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Apr 2012 11:06:29 -0400
Received: by faaa25 with SMTP id a25so46636faa.1
        for <git@vger.kernel.org>; Fri, 27 Apr 2012 08:06:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type:x-gm-message-state;
        bh=FzJDTG0ymwMoThiVtaZeCHT87JBrBZksh1LJG7BXCIs=;
        b=mo28Z2nSk6wIq86WKQSPbWb+hAkOk3TWvtV7oiBL3BafW9zKdBWGUre78BWFX6iXqK
         zyNqOMgN0Q7Z2nekyl7IoVEa4PXQiQJDdH+kDZXUaw71Gy9DcyhioHMRuOaLgj+zoBLb
         OSAY6DGfNGaAYzythBgu6mdwLlAP5nBNkkwRalQp1jLoa70uqhfWW7GRMXLeJtPnqH8a
         CVM0j3gaxM2d25Syvt+I83ar6knVzdCwEGmymLa37fsce8h9jhRY26TTpBaHpOPq5Qky
         /Q/keOl4JQEwoSmSEh43gyZADdtfQlU/kCSpfWlPucc2jB+abLZ1JyYpclFl/yS9Av/8
         +R1w==
Received: by 10.213.16.83 with SMTP id n19mr160303eba.6.1335539187695;
        Fri, 27 Apr 2012 08:06:27 -0700 (PDT)
Received: by 10.213.16.83 with SMTP id n19mr160290eba.6.1335539187504;
        Fri, 27 Apr 2012 08:06:27 -0700 (PDT)
Received: from hpza10.eem.corp.google.com ([74.125.121.33])
        by gmr-mx.google.com with ESMTPS id t8si6445902eef.1.2012.04.27.08.06.27
        (version=TLSv1/SSLv3 cipher=AES128-SHA);
        Fri, 27 Apr 2012 08:06:27 -0700 (PDT)
Received: from junio.mtv.corp.google.com (junio.mtv.corp.google.com [172.27.69.24])
	by hpza10.eem.corp.google.com (Postfix) with ESMTP id 4E170203A8D;
	Fri, 27 Apr 2012 08:06:27 -0700 (PDT)
Received: by junio.mtv.corp.google.com (Postfix, from userid 110493)
	id 9877FE125C; Fri, 27 Apr 2012 08:06:26 -0700 (PDT)
In-Reply-To: <20120427115000.GA8126@sigill.intra.peff.net> (Jeff King's
	message of "Fri, 27 Apr 2012 07:50:01 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1 (gnu/linux)
X-Gm-Message-State: ALoCoQnRgEe1cjJoA9ZrHufk7ABPNdmbEqOa78leWFa0cgtpXd1ylgejxl/i8BG/r6S7NbJmLLej+GdXD9e1gTF1ZrV8Xuu40sgRCmbZcSt/GGtf4FUOqKHQ2dFt0pWCaW7GU22LGFI2piSHK/0ix7dvDipcAOQdWXo/NRGUzuWuIkyhYD2LY/M=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196475>

Jeff King <peff@peff.net> writes:

> I upgraded git on a machine recently, and it created problems for a repo
> with a bogus character in a ref name.  Older versions of git never
> complained about it. Newer ones, containing your dce4bab ("add_ref():
> verify that the refname is formatted correctly") do. That's fine; it's
> bogus and git _should_ complain about it.
> 
> However, recovering from the situation is unnecessarily hard, ...
> ...
> I seem to recall discussing this format-tightening and trying to be sure
> that users were left with a way forward for fixing their repos. But I
> can't find the discussion, and I don't recall any conclusion we came to.

I haven't dug the archive but I do recall pointing many issues out
around the theme "be liberal in what you accept and strict in what you
produce" on this topic, and loosening one or two showstoppers during the
review cycle, but obviously we did not catch all of them.

Michael?
