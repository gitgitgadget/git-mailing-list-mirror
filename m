From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 2/4] transport-helper: check if remote helper is alive
Date: Mon, 1 Apr 2013 22:58:16 -0600
Message-ID: <CAMP44s0m_Jzn=DBEwkZjJqrxU1MoAs1V3ES5C2cdSK5Eg9cROQ@mail.gmail.com>
References: <1364852804-31875-1-git-send-email-felipe.contreras@gmail.com>
	<1364852804-31875-3-git-send-email-felipe.contreras@gmail.com>
	<7v38v9ixqn.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Johannes Sixt <j6t@kdbg.org>, Aaron Schrab <aaron@schrab.com>,
	Clemens Buchacher <drizzd@aon.at>,
	David Michael Barr <b@rr-dav.id.au>,
	Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 02 06:58:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UMtJ2-0006No-3u
	for gcvg-git-2@plane.gmane.org; Tue, 02 Apr 2013 06:58:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760036Ab3DBE6U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Apr 2013 00:58:20 -0400
Received: from mail-la0-f49.google.com ([209.85.215.49]:50421 "EHLO
	mail-la0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759296Ab3DBE6T (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Apr 2013 00:58:19 -0400
Received: by mail-la0-f49.google.com with SMTP id fs13so27770lab.22
        for <git@vger.kernel.org>; Mon, 01 Apr 2013 21:58:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=4SAVYkc2Ka8kzZ5BysFEqm+x/uRQ63AXuCzP6j6BDZk=;
        b=LvntPkJOEhzj54A/8NF3HNX9/xGwOnxCvo/elOwgcTF5miXylnHdaNBg+jQ5pM3bGI
         qONPusyC0+/n59q8OxMYOnxIqkn1l4lXypVkfcWBsSWgVN47NfRYJKPxSw5G1iuxMOwj
         Nq5aZ5YK/e36lX3SAQAObwaM+Fl7XE3PoDfBdRkDFrkwN+PuzughJrqoWWPi7k/6Vxuy
         Etct9NKH8VY18WIPCAJ80qhoLcAuDzIAYffx5KjY4Whxe4m+OUxLa+l/flGlFvaribp9
         4UITAZY57/SJKvRyU9gsQSNpUEjiuChrGck1Wh+DU8uYVi03ncbYsZ9iWwEqBQLHxo0s
         wyqg==
X-Received: by 10.112.130.201 with SMTP id og9mr6991046lbb.65.1364878696855;
 Mon, 01 Apr 2013 21:58:16 -0700 (PDT)
Received: by 10.114.20.36 with HTTP; Mon, 1 Apr 2013 21:58:16 -0700 (PDT)
In-Reply-To: <7v38v9ixqn.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219733>

On Mon, Apr 1, 2013 at 6:26 PM, Junio C Hamano <gitster@pobox.com> wrote:

> OK, so the idea is that fetch_with_import() does
>
>  - get_helper(transport), which spawns a helper process;
>
>  - get_importer(transport, &fastimport), which spawns a fast-import
>    and make it read from the output of the helper process;
>
>  - we did finish_command() to wait for the fast-import to finish,
>    expecting that the fast-import would finish when the helper stops
>    feeding it, which in turn would mean the helper would have died.
>
> The same for the pushing side.

The difference with the pushing side is that it's the helper the one
waiting for fast-export and it can easily die.

> Shouldn't transport_disconnect() have called release_helper() which
> in turn calls disconnect_helper() to call finish_command() on the
> helper to wait for that procesanyway?  Is somebody discarding return
> value from transport_disconnect() or the current calling site of
> transport_disconnect() is too late to notice the error?

It's too late to notice the error. However, only in the case of pushing.

-- 
Felipe Contreras
