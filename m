From: "Steinar H. Gunderson" <sgunderson@bigfoot.com>
Subject: Re: Please document git-http-backend/Apache timeout interactions
Date: Mon, 22 Feb 2016 00:34:27 +0100
Message-ID: <20160221233427.GA13598@sesse.net>
References: <20160221221744.GA38068@sesse.net>
 <xmqqwppx8wwb.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 22 00:34:39 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aXdWO-0006x8-9z
	for gcvg-git-2@plane.gmane.org; Mon, 22 Feb 2016 00:34:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752471AbcBUXed (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Feb 2016 18:34:33 -0500
Received: from cassarossa.samfundet.no ([193.35.52.29]:32912 "EHLO
	cassarossa.samfundet.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752453AbcBUXec (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Feb 2016 18:34:32 -0500
Received: from pannekake.samfundet.no ([2001:67c:29f4::50] ident=unknown)
	by cassarossa.samfundet.no with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
	(Exim 4.84)
	(envelope-from <sesse@samfundet.no>)
	id 1aXdWF-0008Vd-6M; Mon, 22 Feb 2016 00:34:27 +0100
Received: from sesse by pannekake.samfundet.no with local (Exim 4.84)
	(envelope-from <sesse@samfundet.no>)
	id 1aXdWF-0004QN-3d; Mon, 22 Feb 2016 00:34:27 +0100
Content-Disposition: inline
In-Reply-To: <xmqqwppx8wwb.fsf@gitster.mtv.corp.google.com>
X-Operating-System: Linux 4.4.0 on a x86_64
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286847>

On Sun, Feb 21, 2016 at 03:29:56PM -0800, Junio C Hamano wrote:
> This feels 70% like "how to configure your Apache server when you
> run site that is contacted by a client that is slow to talk?", that
> is not necessarily specific to Git.

It's specific to Git in the sense that Git seemingly as a normal matter of
course posts very slowly to /git-upload-pack. Normal HTTP clients don't work
this way; they typically have their entire POST body ready before they decide
to make a request.

> Also while it may make sense to tweak the timeout on the server
> side, recommending to disable it altogether, instead of adjusting to
> the typical requirement for a sane client, feels just wrong.

True, although I have no idea what the right limits would be.

> Also, are all requests from one client slow to start, or are only
> some phases in the protocol exchange slow but not others?  If the
> server side can tell which ones could be normally slow, selectively
> loosening timeouts only for them might be more palatable, but I am
> sensing that you are not suggesting such an approach.

I know only of /git-upload-pack having this pattern, and it is the only one I
am seeing 408 errors for in my logs. It seems to fail very rarely (~0.2% of
all /git-upload-pack requests), but for some users, it's seemingly very
persistent.

/* Steinar */
-- 
Homepage: https://www.sesse.net/
