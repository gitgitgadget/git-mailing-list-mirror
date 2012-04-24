From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git add --ignore-errors doesn't ignore .gitignore errors
Date: Tue, 24 Apr 2012 12:46:44 -0700
Message-ID: <xmqqsjfsgbff.fsf@junio.mtv.corp.google.com>
References: <8A31466D-A791-4FF9-BFDC-029C4644ABE7@jetbrains.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Kirill Likhodedov <Kirill.Likhodedov@jetbrains.com>
X-From: git-owner@vger.kernel.org Tue Apr 24 21:46:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SMlhL-0004OL-Oj
	for gcvg-git-2@plane.gmane.org; Tue, 24 Apr 2012 21:46:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757253Ab2DXTqq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Apr 2012 15:46:46 -0400
Received: from mail-yw0-f74.google.com ([209.85.213.74]:41909 "EHLO
	mail-yw0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757112Ab2DXTqq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Apr 2012 15:46:46 -0400
Received: by yhgm50 with SMTP id m50so121126yhg.1
        for <git@vger.kernel.org>; Tue, 24 Apr 2012 12:46:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type:x-gm-message-state;
        bh=pdbfuFvVNpzffl+v1+EBZ6fPS2QSi0oRnb8513wFXqw=;
        b=cw1zo6FevoMpbJ7Urqrc7ebqanzeVnjgC5tGaNj171ythlD/5W7kHTjF3dAeRtggKC
         U2h1LLn014DyAuEUVoVmDRRoDAanqZuta0mtm8gIcd5PIcAudoIAfHuOxVIjiXlbLZvm
         vfyC4YKaT/y624Sco9u/GoCU66xg2BF5LIemG+OaHAYOVd4GeeYtDIJcU2ZpdXEiiyk4
         ChpjBMkihycWY+iFSmrmHcihxFBu2ef8Wk6aJT9VNm7TA+L7H4cRg6qK6SI6GL77UK3T
         QgNIE4k/d6x9kOub0ABtiVU8q/4Uc6aCQut+kVXsi3a4jGa05MiodbWsvOWGMIZK79p4
         gJmg==
Received: by 10.236.180.33 with SMTP id i21mr26256390yhm.1.1335296805478;
        Tue, 24 Apr 2012 12:46:45 -0700 (PDT)
Received: by 10.236.180.33 with SMTP id i21mr26256376yhm.1.1335296805411;
        Tue, 24 Apr 2012 12:46:45 -0700 (PDT)
Received: from wpzn4.hot.corp.google.com (216-239-44-65.google.com [216.239.44.65])
        by gmr-mx.google.com with ESMTPS id a33si2885625anp.2.2012.04.24.12.46.45
        (version=TLSv1/SSLv3 cipher=AES128-SHA);
        Tue, 24 Apr 2012 12:46:45 -0700 (PDT)
Received: from junio.mtv.corp.google.com (junio.mtv.corp.google.com [172.27.69.24])
	by wpzn4.hot.corp.google.com (Postfix) with ESMTP id 4EBBE1E004D;
	Tue, 24 Apr 2012 12:46:45 -0700 (PDT)
Received: by junio.mtv.corp.google.com (Postfix, from userid 110493)
	id EEBF7E125C; Tue, 24 Apr 2012 12:46:44 -0700 (PDT)
In-Reply-To: <8A31466D-A791-4FF9-BFDC-029C4644ABE7@jetbrains.com> (Kirill
	Likhodedov's message of "Tue, 24 Apr 2012 13:13:24 +0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1 (gnu/linux)
X-Gm-Message-State: ALoCoQmVnyGXhwyxQG2zpHxKn9f/dA5v/2VQJ2z/BvrGPSmqGOfvnmIrvJoln5ZfDevg4YlZC1i7ba5GVsg1VqROXIEiVnFp8mMsK9SQuU1H4iwao7KoMSOmmElha54S6cR4HXqBoP7QconjJxUd/WlYPU9SdUohOya46zl2XnB9STKUnatVsYQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196241>

Kirill Likhodedov <Kirill.Likhodedov@jetbrains.com> writes:

> Hi,
>
> git add has '--ignore-errors' parameter which, according to the man entry, allows to continue adding even if one of the files failed to add:
>
>  --ignore-errors
>            If some files could not be added because of errors indexing them, do not abort the
>            operation, but continue adding the others. The command shall still exit with non-zero
>            status. The configuration variable add.ignoreErrors can be set to true to make this
>            the default behaviour.
>
> However, if the error happens because a file is ignored by Git,
> git-add aborts, even if "--ignore-errors" is given:

That sounds like the command is behaving exactly as documented.  It
detected a user error that attempts to add an ignored path.  That is
totally different from "the contents of the path failed to be indexed"
(perhaps due to background virus checker keeping the file open on broken
operating system platform) case, which the option tells it to ignore and
continue.
