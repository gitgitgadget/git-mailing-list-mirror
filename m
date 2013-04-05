From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] show-branch: use strbuf instead of static buffer
Date: Fri, 5 Apr 2013 16:49:15 -0700
Message-ID: <20130405234915.GU30308@google.com>
References: <20130405211550.GA4880@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Eric Roman <eroman@chromium.org>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Apr 06 20:06:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UOWRN-0001b9-7H
	for gcvg-git-2@plane.gmane.org; Sat, 06 Apr 2013 18:58:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1163062Ab3DEXtV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Apr 2013 19:49:21 -0400
Received: from mail-da0-f51.google.com ([209.85.210.51]:52643 "EHLO
	mail-da0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1162968Ab3DEXtU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Apr 2013 19:49:20 -0400
Received: by mail-da0-f51.google.com with SMTP id g27so1778935dan.10
        for <git@vger.kernel.org>; Fri, 05 Apr 2013 16:49:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=ufRGM/yPqBM63NHAeYybgDe1JKwU4JvYUyjSuTRnj8w=;
        b=vuLVoq2NR6XYK9ql7PvfpHZHw5nyh5B64fz/FF5gZrFmY0dl6NBOXOKWbEeK32h6Aq
         Mo1HhbWC3JIHFQKoBhLLXFz3+J3InbU9mdb7sFdYNunFAhDQ9uj5nsmtqv4q/4jQGXSo
         TfcPMnujU01Qk40oNknsc4TEotyc55RBGFe5QQyzKYTgfo8vH0x+PnP9sh0ToQKYXP0d
         /isFaiJ3CEA5hUJ8cyA+0Y/FMo8PlYbeUF4GVQ6cmIwq9dFE+QrJYtb40sQS00zoPTDX
         9bMqSeXgkgr3Qne/hmci8ymsT6oulv3qhY2Ap8McwJeretTihox+/USDKgvy/F0f7+Zc
         X1yA==
X-Received: by 10.68.176.68 with SMTP id cg4mr17035261pbc.49.1365205760290;
        Fri, 05 Apr 2013 16:49:20 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPS id ti8sm16144772pbc.12.2013.04.05.16.49.18
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 05 Apr 2013 16:49:18 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20130405211550.GA4880@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220254>

Jeff King wrote:

> When we generate relative names (e.g., "master~20^2"), we
> format the name into a static buffer, then xstrdup the
> result to attach it to the commit. Since the first thing we
> add into the static buffer is the already-computed name of
> the child commit, the names may get longer and longer as
> the traversal gets deeper, and we may eventually overflow
> the fixed-size buffer.

Good catch.

[...]
> Though this is a stack overflow, I don't know that it's exploitable for
> anything interesting; an attacker does not get to write arbitrary data,
> but rather only a sequence of "^%d" and "~%d" relative history markers.
> Perhaps in theory one could devise a history such that the sequence
> markers spelled out some malicious code, but it would be quite a
> challenge

Overwrite the return address and return-to-libc?

[...]
> --- a/builtin/show-branch.c
> +++ b/builtin/show-branch.c

Very clean and obviously correct.  Thanks.

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

A test would be nice, though.

Hope that helps,
Jonathan
