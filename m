From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH] refs.c: interpret @ as HEAD
Date: Tue, 30 Apr 2013 19:31:28 +0700
Message-ID: <CACsJy8C7vcxTkzmfABSykMxeX+68rWnr-Ohfhb3oMPi=Q5Tg6g@mail.gmail.com>
References: <1367324685-22788-1-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Junio C Hamano <gitster@pobox.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 30 14:32:07 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UX9j4-00023q-FB
	for gcvg-git-2@plane.gmane.org; Tue, 30 Apr 2013 14:32:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760558Ab3D3McB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Apr 2013 08:32:01 -0400
Received: from mail-oa0-f53.google.com ([209.85.219.53]:41449 "EHLO
	mail-oa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760515Ab3D3McA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Apr 2013 08:32:00 -0400
Received: by mail-oa0-f53.google.com with SMTP id m6so422954oag.26
        for <git@vger.kernel.org>; Tue, 30 Apr 2013 05:32:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=c43biXAfgvmtEwj9NGjKrW25gzZj1gdN9z2jgpL44bg=;
        b=jPxkedIqhzs16va3WK6wGoxvvwyLEQ5e8NDF3fxOY+BokVfdfc8MrD3/QBtljhtT4R
         Ymof+KpINvKVqQdp/oFe+OBBHwAzw5pseISpdBOGdbH+qPcv2BgVZRx9+0cjh+otjON2
         +sWVuOhwE7OA//TMskCRBCkrDvK79NPNJzI5fAPAbvvIBjGGmijSV6z2N3FaHeXcjQ6B
         dkVRPIJdY2NZwFCxZwkL8ZSdL78iYR+8PI+mSe+Ny2SBsTPd8rviTHOuOvBxA7ivTw3c
         9CrbVdydxknDwL3QkatPF7CNHHgpodGw5Pb/HDRAgIju84Jhjt3Zg3k3JSvsxYicwN5U
         Ijrw==
X-Received: by 10.60.57.200 with SMTP id k8mr31642455oeq.117.1367325119965;
 Tue, 30 Apr 2013 05:31:59 -0700 (PDT)
Received: by 10.76.180.138 with HTTP; Tue, 30 Apr 2013 05:31:28 -0700 (PDT)
In-Reply-To: <1367324685-22788-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222932>

On Tue, Apr 30, 2013 at 7:24 PM, Ramkumar Ramachandra
<artagnon@gmail.com> wrote:
> The rev spec forms @{}, .., ... fill in HEAD as the missing argument
> automatically.  Unfortunately, HEAD~<n> is a very common idiom and
> there is no way to make HEAD implicit here (due the shell expansion of
> ~<n>).
>
> However, there is an alternative solution to the issue: overload the
> character @ to mean HEAD.  Do this at the lowest possible layer of
> abstraction: in dwim_ref(), substitute @ with HEAD just before calling
> resolve_ref_unsafe().  The program will only reach this point after
> the other specs like ~, ^ and @{} have been resolved; therefore, it is
> safe to do it here.
>
> This patch has the exact same effect as:
>
>     $ git symbolic-ref @ HEAD
>
> It means that you can now do @~1, @^2, and even topic..@.  However,
> since the @-parsing happens before we ever reach the symref
> resolution, @@{u} is invalid.  But this is okay, since @{u} already
> has an implicit HEAD in it.
>
> Inspired-by: Felipe Contreras <felipe.contreras@gmail.com>
> Inspired-by: Michael Haggerty <mhagger@alum.mit.edu>
> Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
> ---
>  I haven't included documentation/ tests because I want feedback on
>  this two-liner first.

You need more than that :) As Michael pointed out '@' is a perfectly
valid ref name. If you do this, you need to reject '@' as invalid ref
name. I guess another two lines in check_refname_format. But let's
wait for more feedback first.
--
Duy
