From: Antoine Pelisse <apelisse@gmail.com>
Subject: Re: [PATCH v2] wt-status: Show ignored files in untracked dirs
Date: Thu, 27 Dec 2012 17:14:54 +0100
Message-ID: <CALWbr2wFg_9oDoZ_BUQwAzVV+UJSqBQRrMYmt6fv=fo02RL7Zg@mail.gmail.com>
References: <1356516985-31068-1-git-send-email-apelisse@gmail.com>
	<1356528674-2730-1-git-send-email-apelisse@gmail.com>
	<7vip7omd8c.fsf@alter.siamese.dyndns.org>
	<20121227034859.GA20817@sigill.intra.peff.net>
	<7va9t0m69o.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>, git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Dec 27 17:23:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ToGEx-000606-Qa
	for gcvg-git-2@plane.gmane.org; Thu, 27 Dec 2012 17:23:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753266Ab2L0QXD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Dec 2012 11:23:03 -0500
Received: from mail-ee0-f50.google.com ([74.125.83.50]:33505 "EHLO
	mail-ee0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753246Ab2L0QWx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Dec 2012 11:22:53 -0500
X-Greylist: delayed 476 seconds by postgrey-1.27 at vger.kernel.org; Thu, 27 Dec 2012 11:22:52 EST
Received: by mail-ee0-f50.google.com with SMTP id b45so4900601eek.23
        for <git@vger.kernel.org>; Thu, 27 Dec 2012 08:22:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=uar9YL8OLKtdM3tk+wkR76DZpNIVyT929aqHhrXLeW0=;
        b=DQJasLhhdhd7QlbBNlsCAVZLBe13GT6bjYTEN/NqxL/tAtTLfAYSBJStTWT7V4rNkq
         Q1qRl7pZpIZa2GIQPcxI0ILfMUFP/wNuhlFaWr7XzzbA1yacnEBqZd8fpZ0zEHG+g4g4
         7svDFxkhEcGX+UPNBEfgxyFAaSldxqZefBIg7hrXKXrwm0/wY496wCxRhoiEktdgs+Gn
         JHHuX2LFk5dljOWFf3Zh98YaX5ifY+KAS3Y7AiduAIyL53WMSLh36kG34JYefdrqervl
         9iOyI5SthJhmidVsxSlMdpIeUARE09MyGtdODVvZPxsnaO2Y8cXw2UhA8mLeIo/ElyB0
         ZQJA==
Received: by 10.14.1.195 with SMTP id 43mr79056246eed.31.1356624895319; Thu,
 27 Dec 2012 08:14:55 -0800 (PST)
Received: by 10.14.187.6 with HTTP; Thu, 27 Dec 2012 08:14:54 -0800 (PST)
In-Reply-To: <7va9t0m69o.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212204>

> Nicely analysed.  Perhaps we would want new test pieces to define
> the behaviour we want to see first?

I think we should.

I also thought about the use case of "committed" and ignored directory
which is also broken to me (point 3 in the table below).

Anyway I tried to make a table to sum-up/discuss the list of behaviors
we would like to see/test, taking Jeff mail into account.
(warning: that requires fixed width font)

|----------------------+---------------------+---------------------------|
| Output               | A. status --ignored | B. status --ignored -uall |
|                      |                     | (or with potential        |
|                      |                     | --ignored=all)            |
|----------------------+---------------------+---------------------------|
| 1. Untracked dirU    | Current:            | Current:                  |
| with ignored unco.ig | Empty               | Empty                     |
| in it                |                     |                           |
|                      | Expected:           | Expected:                 |
|                      | !!dirU/             | !!dirU/unco.ig            |
|----------------------+---------------------+---------------------------|
| 2. Untracked and     | Current (OK):       | Current:                  |
| ignored dirU with    | !!dirU/             | !!dirU/                   |
| file in it           |                     |                           |
|                      |                     | Expected:                 |
|                      |                     | !!dirU/unco               |
|----------------------+---------------------+---------------------------|
| 3. "Committed" dirA  | Current:            | Current:                  |
| yet ignored          | Empty               | Empty                     |
| with uncommitted     |                     |                           |
| file in it           | Expected:           | Expected:                 |
|                      | dirA/               | dirA/unco                 |
|----------------------+---------------------+---------------------------|
