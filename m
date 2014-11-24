From: Alex Kuleshov <kuleshovmail@gmail.com>
Subject: Re: [PATCH] exec_cmd: system_path memory leak fix
Date: Mon, 24 Nov 2014 13:02:22 +0600
Message-ID: <87mw7haxdp.fsf@gmail.com>
References: <1416750981-24446-1-git-send-email-kuleshovmail@gmail.com> <1416750981-24446-2-git-send-email-kuleshovmail@gmail.com> <xmqqioi5ycme.fsf@gitster.dls.corp.google.com> <87sih9en65.fsf@gmail.com> <xmqq7fyly3xj.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "git\@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 24 08:09:00 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xsnlb-0004he-Vv
	for gcvg-git-2@plane.gmane.org; Mon, 24 Nov 2014 08:09:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752171AbaKXHI4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Nov 2014 02:08:56 -0500
Received: from mail-lb0-f177.google.com ([209.85.217.177]:57150 "EHLO
	mail-lb0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750881AbaKXHIz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Nov 2014 02:08:55 -0500
Received: by mail-lb0-f177.google.com with SMTP id 10so4027317lbg.36
        for <git@vger.kernel.org>; Sun, 23 Nov 2014 23:08:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=references:from:to:cc:subject:date:in-reply-to:message-id
         :mime-version:content-type;
        bh=344+/MqglKObF6pADwwkcJmuZ6C62/mcLYT/+Qbas0A=;
        b=cUh8KaMJ3cTSwjiGTqvvGWAVpG2lI6Gfd3Owx1uvcKr9w66x96fB49IOJ4QuWHQrvG
         7HQq+ThX9YLeANvCULm0rG2wjAHxZqPOGP9Pejycek659A/e64MKy/I2PCvMzapHA9SY
         A95BZ3PaXvXMaIvXJXbvIrc5Re9iTmTJnyi8gORUq2DcRHv1vDTSIoTCHax9XBJ9MX6G
         fgDEUEFLRLKWW0MloNol6rCAWkE1zSnzTK74lKuNOzRq6vLsW31N3XDCrcv5kLpx7fNV
         44vAqmHltnCrtl2gVvcKwZHnsT5zaZx2ja26YfEm8DL+ypg92ZBkm2mS97I0LbPZOjl0
         hNHg==
X-Received: by 10.152.5.38 with SMTP id p6mr7257777lap.64.1416812934084;
        Sun, 23 Nov 2014 23:08:54 -0800 (PST)
Received: from alex-desktop ([95.59.100.64])
        by mx.google.com with ESMTPSA id n7sm3320238lae.11.2014.11.23.23.08.52
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 23 Nov 2014 23:08:53 -0800 (PST)
In-reply-to: <xmqq7fyly3xj.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260113>


Jeff King:


>If I am reading this right, calls to system_path() will always reuse the
>same buffer, even if they are called with another "path" argument. So
>all callers must make sure to make a copy if they are going to hold on
>to it for a long time. Grepping for callers shows us saving the result
>to a static variable in at least git_etc_gitattributes, copy_templates,
>and get_html_page_path. Don't these all need to learn to xstrdup the
>return value?

Hello Jeff, yes as i wrote in previous message i saw that there some
places uses system_path function and I just wanted to find correct way
to solve problem with system_path, in near time i'll check and adapt if
need all of this places for updated system_path.

Eric Sunshine:

>Curious. Did the unit tests pass with this change?

Yes i launched unit tests and there are the same result as in origin/pu.

>Not sure what this change is about. The last couple lines of this function are:
>
>    setenv("PATH", new_path.buf, 1);
>    strbuf_release(&new_path);
>
>which means that the buffer held by the strbuf is being released
>anyhow, whether static or not.

Ah, yes, just a type, will update it.

Junio C Hamano:

>Fixing these callers are done as separate patches, that can be
>applied either before or after this patch.

How to do it better? Update this patch, fix all callers which broken and
concat this patches to one or make separate patches?

Thanks all for feedback.

--
Best regards.
0xAX
