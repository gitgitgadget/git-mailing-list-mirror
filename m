From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 12/12] refs: move the remaining ref module declarations to refs.h
Date: Mon, 15 Jun 2015 11:13:22 -0700
Message-ID: <xmqqfv5salh9.fsf@gitster.dls.corp.google.com>
References: <cover.1434206062.git.mhagger@alum.mit.edu>
	<79947baebd702f8e9fe9b667e2eeb69afa73094b.1434206062.git.mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Mon Jun 15 20:13:34 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z4Yt1-0008Be-2v
	for gcvg-git-2@plane.gmane.org; Mon, 15 Jun 2015 20:13:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754161AbbFOSN0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Jun 2015 14:13:26 -0400
Received: from mail-ie0-f180.google.com ([209.85.223.180]:33372 "EHLO
	mail-ie0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751206AbbFOSNZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Jun 2015 14:13:25 -0400
Received: by iebgx4 with SMTP id gx4so68028480ieb.0
        for <git@vger.kernel.org>; Mon, 15 Jun 2015 11:13:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=+f4nSzeZ3INHnf/vFfxLJUDukqjT703PubOvpn5/mF8=;
        b=dLdeGGxf7OQXyN0+L9vBJN5Bbc//sUwz4INeekZzSOtV3NR4yS7GNbb3pXAgEq+PVJ
         flcBhXrB2DmhVLtM4VlCH0PzzWvBwphOlllJz7jhrQ2qz31kybEv4I6BjGuKVzj9xnsS
         2qrIc3bPmicUc5Fgp5shYLMu5qh6jgxZBiMshbZIFk3/ATYau5u7C/hvBnlzLUklCIUO
         C5B6mHlcTxxqiQ5bBoBmPFdTKb5h6Kl3yX0zwucBjb2E9GZmi2nHXgrKIBQvkiM2cmDp
         XRwubVsQxyy9eKQtEoE4ox9zJabJAmZ5p3oYseMh15zangFOEN50ajTRtxYHZeVd5JHZ
         RTHw==
X-Received: by 10.42.170.74 with SMTP id e10mr30799228icz.71.1434392004383;
        Mon, 15 Jun 2015 11:13:24 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:16f:c4ab:c37f:75f8])
        by mx.google.com with ESMTPSA id bc2sm8093049igb.7.2015.06.15.11.13.23
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 15 Jun 2015 11:13:23 -0700 (PDT)
In-Reply-To: <79947baebd702f8e9fe9b667e2eeb69afa73094b.1434206062.git.mhagger@alum.mit.edu>
	(Michael Haggerty's message of "Sat, 13 Jun 2015 16:42:15 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271696>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> Some functions from the refs module were still declared in cache.h.
> Move them to refs.h.

Yay.  But...

> Add some parameter names where they were missing.

... I do not think some of this is a good change.

> @@ -78,15 +170,15 @@ typedef int each_ref_fn(const char *refname,
>   * modifies the reference also returns a nonzero value to immediately
>   * stop the iteration.
>   */
> -extern int head_ref(each_ref_fn, void *);
> +extern int head_ref(each_ref_fn fn, void *cb_data);

For example, between these two, what did we gain?

Because of their types, it already was clear what the two parameters
are in the original, without noisewords like "fn" (which obviously
stands for a "function", but that is clear due to "each_ref_fn").

> -extern int for_each_glob_ref_in(each_ref_fn, const char *pattern, const char* prefix, void *);
> +extern int for_each_glob_ref_in(each_ref_fn fn, const char *pattern, const char* prefix, void *cb_data);

Likewise for addition of fn and cb_data.

If you really want to make unrelated changes to this file, what you
should fix is to update "const char* prefix" to "const char *prefix"
;-)
