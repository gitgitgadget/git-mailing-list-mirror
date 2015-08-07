From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] submodule: implement `module_name` as a builtin helper
Date: Fri, 07 Aug 2015 15:42:26 -0700
Message-ID: <xmqqpp2ywwj1.fsf@gitster.dls.corp.google.com>
References: <CAGZ79kY=jQSjJUxkznkwwupo527-nT05P_bKXy=GO=E4QjC8tQ@mail.gmail.com>
	<1438808880-9080-1-git-send-email-sbeller@google.com>
	<55C3BA5C.3030404@web.de>
	<xmqqlhdmyhtt.fsf@gitster.dls.corp.google.com>
	<CAGZ79kYtCgYRHuMcxNoi6f9+GYYYCq6aRTdvx4ZKELSuQErkVQ@mail.gmail.com>
	<xmqqa8u2yf6e.fsf@gitster.dls.corp.google.com>
	<CAGZ79kYjaXtGurWgPk47FauLhC=k-gBjLYhepuz4gJE6Rm_8DA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jens Lehmann <Jens.Lehmann@web.de>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Sat Aug 08 00:42:37 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZNqLS-0006G5-LH
	for gcvg-git-2@plane.gmane.org; Sat, 08 Aug 2015 00:42:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946382AbbHGWm3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Aug 2015 18:42:29 -0400
Received: from mail-pa0-f52.google.com ([209.85.220.52]:34283 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1946306AbbHGWm3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Aug 2015 18:42:29 -0400
Received: by pawu10 with SMTP id u10so97602173paw.1
        for <git@vger.kernel.org>; Fri, 07 Aug 2015 15:42:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=c88YZ9tY88z6SFjXGAmc3jeQ7OuiVC2izjE7w11N7cc=;
        b=kN0lDnrhtnmrZPRQg8Gu7yk8/nrbrOnzU9SumiwhRDf8R/AE0flXQb9eaAO9wyuqMd
         Q5d5RJA2oBiTILGnVC9/RAOBzisrFfBUeFjTPyUQlSWMRd6+fa1aVHZ27bKXZsUo585h
         KwzOuVf7oSZ4A1Ih/zBYbm57wfxzt90nihpdKj50tB7HQBWpVFEhlysRhjFim8cyS2FQ
         +QTu++A8+h1EZ9KZmb1TQfEnjHt+Vz+IdsFPTpVG4ICYS/S0TyZPnll9PRw0/hsvTe0S
         KGxsS9KaCejXxaSPyW7B31wzNBlzUFcBVQmXqTGsCYZbWCeXvqXabi0QvvCVv8AU+N+U
         P4tw==
X-Received: by 10.67.8.40 with SMTP id dh8mr19008434pad.129.1438987348561;
        Fri, 07 Aug 2015 15:42:28 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:6597:23b2:a33a:2b5b])
        by smtp.gmail.com with ESMTPSA id hi1sm10974178pbc.47.2015.08.07.15.42.27
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 07 Aug 2015 15:42:27 -0700 (PDT)
In-Reply-To: <CAGZ79kYjaXtGurWgPk47FauLhC=k-gBjLYhepuz4gJE6Rm_8DA@mail.gmail.com>
	(Stefan Beller's message of "Fri, 7 Aug 2015 14:21:52 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275497>

Stefan Beller <sbeller@google.com> writes:

> That's why I want to be a bit more generic and have this thread pool API
> done in C, such that "any for loop" in git can be easily replaced by using
> the thread pool. I think of "git fetch --all" specially.

One more thing, as I didn't notice that you kept repeating "thread"
pool API.

While I doubt that you would gain much by using threads in place of
processes to perform parallel "submodule update", "submodule clone",
"fetch all", etc., all of which are fairly well isolated and heavy
weight operations themselves, and I suspect that the implementation
simplicity of using separate processes would probably be huge plus
compared to any possible upside you may gain from using threads, if
you really want to go the "thread" route, the first thing to try
would be to see if a few places we already use threads for
parallelism (namely, "grep", "pack-objects", "preload-index" and
"index-pack") can be factored out and model your new API around the
commonality among them.
