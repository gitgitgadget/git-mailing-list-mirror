From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git push keeps writing after server failure
Date: Fri, 12 Jun 2015 10:57:22 -0700
Message-ID: <xmqqtwucdd31.fsf@gitster.dls.corp.google.com>
References: <CAJo=hJvzjnLFhF4REBzX=pgFamBfu7hZeZidy_8Rmi_DwwR4Nw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git <git@vger.kernel.org>
To: Shawn Pearce <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Jun 12 19:57:31 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z3TCs-0005cp-AY
	for gcvg-git-2@plane.gmane.org; Fri, 12 Jun 2015 19:57:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752542AbbFLR5Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Jun 2015 13:57:25 -0400
Received: from mail-ie0-f182.google.com ([209.85.223.182]:36649 "EHLO
	mail-ie0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751128AbbFLR5Y (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Jun 2015 13:57:24 -0400
Received: by iebps5 with SMTP id ps5so29046529ieb.3
        for <git@vger.kernel.org>; Fri, 12 Jun 2015 10:57:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=U0y/KhAQXnQxedwh+ZLMruGyhdyxG+TXhkq3uZ6BjXg=;
        b=qk4PhibpCMvvciPTN/zf3r39akdhFMM6XF4RfHExV+uUxxXOzvQLJXguhj6oqoWOoY
         FAXfF/pxkingph42Io6XNALh1iPRRJsZAbwzy1hrV6dM17Mh1kZ6fx9XRSMFO553DlFi
         veEq0/ooESwVR9WfVzdWDO3OZ15BYu45kwQr3fbX7oKyxBwBnX+KaRPOdD8juan7CV7O
         bbe/B77e2j9TcHQEaPgL7E9ZOvIAE7Ad7X5t75Xv9Uobe3Qc/fv2xDM4xf398nTce/Gr
         DlsNJIM1VPfKKpFZktxGGsBXi/pyHKmFBfZEy/DXKur9/QcuZZXTLZX/oR1nxNFN/jdN
         z6zg==
X-Received: by 10.50.61.234 with SMTP id t10mr5936842igr.19.1434131844278;
        Fri, 12 Jun 2015 10:57:24 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:a12d:7c00:b954:bc66])
        by mx.google.com with ESMTPSA id v14sm1616268igd.12.2015.06.12.10.57.23
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 12 Jun 2015 10:57:23 -0700 (PDT)
In-Reply-To: <CAJo=hJvzjnLFhF4REBzX=pgFamBfu7hZeZidy_8Rmi_DwwR4Nw@mail.gmail.com>
	(Shawn Pearce's message of "Fri, 12 Jun 2015 10:31:33 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271505>

Shawn Pearce <spearce@spearce.org> writes:

> I did something stupid like trying to push a copy of WebKit[1] into my
> GitHub account. This is ~5.2 GiB of data, which GitHub prefers not to
> accept. Ok ...
> ...
> Shouldn't git push realize its stream is broken and stop writing when
> the peer is all like "uh, no, I'm not going to do that, but thanks for
> trying"?

Nice wish, but I am not sure if we are structured to do that easily.
The "fatal:" message is going on the sideband that is demultiplexed
by a separate async "sideband-demux" thread and pack_objects() is
oblivious to what is being said on the error channel #2.
