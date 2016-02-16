From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 04/18] add helpers for allocating flex-array structs
Date: Mon, 15 Feb 2016 20:47:30 -0500
Message-ID: <CAPig+cQAU6y4VfGen0N6vNiDt+rjdcDM8YC+BF9HpvVj2WTUng@mail.gmail.com>
References: <20160215214516.GA4015@sigill.intra.peff.net>
	<20160215215054.GD10287@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Feb 16 02:48:12 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aVUkN-00036d-Az
	for gcvg-git-2@plane.gmane.org; Tue, 16 Feb 2016 02:48:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751974AbcBPBrc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Feb 2016 20:47:32 -0500
Received: from mail-vk0-f65.google.com ([209.85.213.65]:33855 "EHLO
	mail-vk0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751915AbcBPBrb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Feb 2016 20:47:31 -0500
Received: by mail-vk0-f65.google.com with SMTP id e6so8927455vkh.1
        for <git@vger.kernel.org>; Mon, 15 Feb 2016 17:47:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=4tuWT71gdoxmVOgfNFODQzXiFRArVlkz6GV2zUtT3IE=;
        b=WpGiDrFlRD3tTSkHv3ZRGoAhtxGvIvfGLpxC2ePAC+6mtEBNuvvCSX5Hr4kUXp5+ga
         skMEuz+4tYzLHJcZ0yZ5mFGi6Yn2TC6WlZ2L1D1vT6SLwIMyXODR1FUBm96bxpTNPjZu
         4MPvU21y2nLt/PzOzvxPAKcHA8ALXeisvvZEe1xepyZHV4BIpM0UneJWR2I/NqAZ2zJj
         R2ZRyFE2PIrhLNZGkWSqP7L44khKusA/J54i3aABOyIw7IuqeEixdtiqm1ATUYBa5IOA
         CUy1HInYa1wGIpoc+w4IG0WY1tgPnaJ/7avzm1a4AZPa888CISeisaRHPbNpcC/a1zNU
         6lYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=4tuWT71gdoxmVOgfNFODQzXiFRArVlkz6GV2zUtT3IE=;
        b=IeJI6se+ihwTMM15dPfC9y+p9oBxaPFVQOnALcL/z5GsAbSKyziDkpBqVgJZDEdZFf
         X1j/M3iI8uB2JtgwuUgk1IykC6A7GmqIi21GVGa8nUsQvzNp1UTtF7aUfCwXm5LQfuy5
         cTZper2UBpCxN7InDlaUegZVfAHhAyHQmA7FQMWL5cmNP4aFuVJmThfu3RJdEBZm6Ona
         aPgJThm7JXNPYjC/7ax5BLOzmeux6ShwPuVJMAOeDa2z5Xp1i0dOcWYupoY4wmhsLlxY
         EZIZmblhJBv7ur23u5EymXIkeN1zyjtQvX0a33eNFrUIHOhgdv0jEgyIkqJ4NaV2Egsl
         TDTA==
X-Gm-Message-State: AG10YORe6WhZDSNUq3/GPNxDyRDQU74f1SdwQCCE9f5US9Dh18LqEC74GkO8aRMR2hnACQfy68/+ovpV5I9DlA==
X-Received: by 10.31.168.76 with SMTP id r73mr15616487vke.117.1455587250935;
 Mon, 15 Feb 2016 17:47:30 -0800 (PST)
Received: by 10.31.62.203 with HTTP; Mon, 15 Feb 2016 17:47:30 -0800 (PST)
In-Reply-To: <20160215215054.GD10287@sigill.intra.peff.net>
X-Google-Sender-Auth: jgy1H1X9PPGzUc5QoSBayFgImJU
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286304>

On Mon, Feb 15, 2016 at 4:50 PM, Jeff King <peff@peff.net> wrote:
> Allocating a struct with a flex array is pretty simple in
> practice: you over-allocate the struct, then copy some data
> into the over-allocation. But it can be a slight pain to
> make sure you're allocating and copying the right amounts.
>
> This patch adds a few helpers to turn simple cases of into a

Grammo: "cases of into"

> one-liner that properly checks for overflow. See the
> embedded documentation for details.
> [...]
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> diff --git a/git-compat-util.h b/git-compat-util.h
> @@ -782,6 +782,68 @@ extern FILE *fopen_for_writing(const char *path);
> + *   struct foo *f;
> + *   FLEX_ALLOC_STR(f, name, src);
> + *
> + * and "name" will point to a block of memory after the struct, which will be
> + * freed along with the struct (but the pointer can be repoined anywhere).

"repoined"?

> + * The *_STR variants accept a string parameter rather than a ptr/len
> + * combination.
