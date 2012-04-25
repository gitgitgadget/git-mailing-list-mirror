From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v8 4/4] git-rebase: add keep_empty flag
Date: Tue, 24 Apr 2012 18:50:26 -0700
Message-ID: <xmqqipgoeewl.fsf@junio.mtv.corp.google.com>
References: <1333136922-12872-1-git-send-email-nhorman@tuxdriver.com>
	<1334932577-31232-1-git-send-email-nhorman@tuxdriver.com>
	<1334932577-31232-5-git-send-email-nhorman@tuxdriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>,
	Clemens Buchacher <drizzd@aon.at>,
	Phil Hord <phil.hord@gmail.com>
To: Neil Horman <nhorman@tuxdriver.com>
X-From: git-owner@vger.kernel.org Wed Apr 25 04:14:43 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SMrkg-0001dp-JN
	for gcvg-git-2@plane.gmane.org; Wed, 25 Apr 2012 04:14:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757953Ab2DYCOi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Apr 2012 22:14:38 -0400
Received: from mail-lb0-f202.google.com ([209.85.217.202]:51884 "EHLO
	mail-lb0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757919Ab2DYCOh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Apr 2012 22:14:37 -0400
Received: by lbbge1 with SMTP id ge1so5773lbb.1
        for <git@vger.kernel.org>; Tue, 24 Apr 2012 19:14:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:references:message-id:user-agent
         :mime-version:content-type:x-gm-message-state;
        bh=obM5xrZKAs9zjgJHSAPz7RdvZkljgDKOBbB6S2DoK2Q=;
        b=OTg7o287DNNCyzQtvWRRE4wAwO6S1S7fVC22e0uK5+1d1xyp6ErWQTiI+UTovcevwk
         WmgxG+Kna5aUV/aTuVoR0nK1jiBP9A999FVaCrPUV8vN8BWLG373JO8M7I1ALOGESvF0
         JWLxjByvgkHpXbBe+vTMw9M4JrxeMjJH0yZvPYsFuTpfXQHWfP1AkLCVKR3N41OVtd55
         GWHj4A6QcmAXPewmhlhYv0LstXrZezJ9Dvz1s5aQaaaiYYnfZr3vbwfUTcHZ/3nYG+nc
         8Qu8JUnwItGK4XpKbOWmen1O0O6UcLJlR6PdXYhjSUvhwuynh7mckIEUrL7QHPuNd3W3
         HLFQ==
Received: by 10.213.27.20 with SMTP id g20mr132350ebc.17.1335320076022;
        Tue, 24 Apr 2012 19:14:36 -0700 (PDT)
Received: by 10.213.27.20 with SMTP id g20mr132326ebc.17.1335320075846;
        Tue, 24 Apr 2012 19:14:35 -0700 (PDT)
Received: from hpza10.eem.corp.google.com ([74.125.121.33])
        by gmr-mx.google.com with ESMTPS id t8si14735467eef.1.2012.04.24.19.14.35
        (version=TLSv1/SSLv3 cipher=AES128-SHA);
        Tue, 24 Apr 2012 19:14:35 -0700 (PDT)
Received: from junio.mtv.corp.google.com (junio.mtv.corp.google.com [172.27.69.24])
	by hpza10.eem.corp.google.com (Postfix) with ESMTP id A1F3720004E;
	Tue, 24 Apr 2012 19:14:35 -0700 (PDT)
Received: by junio.mtv.corp.google.com (Postfix, from userid 110493)
	id 0726AE125C; Tue, 24 Apr 2012 19:14:34 -0700 (PDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1 (gnu/linux)
X-Gm-Message-State: ALoCoQn82CFauKA1JUGfB6D8+53yvhDd5rTgn8vGw9DJk5Pg/u3nALPUmF/1jjmKeEZ+CGuVUI9MUksmN32xqUrZw0sab6a4DTyT5OlQjLVbYJAN2jqkQILHMTGdF4hn84fu17l3xLAf116dyeE9+9kIZKxDnMEON/PTUbuMxYt71A8wwTTVvWE=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196297>

Neil Horman <nhorman@tuxdriver.com> writes:

> Add a command line switch to git-rebase to allow a user the ability to specify
> that they want to keep any commits in a series that are empty.
> ...
> diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
> index 5812222..ef263e0 100644
> --- a/git-rebase--interactive.sh
> +++ b/git-rebase--interactive.sh
> @@ -167,6 +167,15 @@ has_action () {
>  	sane_grep '^[^#]' "$1" >/dev/null
>  }
>  
> +is_empty_commit() {
> +	tree=$(git rev-parse -q --verify "$1"^{tree} 2>/dev/null ||
> +		die "$1: not a commit that can be picked")
> +	ptree=$(git rev-parse -q --verify "$1"^^{tree} 2>/dev/null ||
> +		ptree=4b825dc642cb6eb9a060e54bf8d69288fbee4904)
> +
> +	return test "$tree" = "$ptree"
> +}

I've amended the above and removed "return " from the last line.

The series is now in 'next', so if we need further enhancement or fixup,
they need to come as incremental updates, not as replacements.

Thanks.
