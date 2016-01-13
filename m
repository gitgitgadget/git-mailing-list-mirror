From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH] submodule: Port resolve_relative_url from shell to C
Date: Wed, 13 Jan 2016 15:37:35 -0800
Message-ID: <CAGZ79kYtb-m6evvnVAvFiHccOSpLwVCT7GcLRuSG=HFtrRqg6w@mail.gmail.com>
References: <1452708927-9401-1-git-send-email-sbeller@google.com>
	<CAPig+cTpghLgRdCCHu6CdM0v4TzytsOFFuE5p9=Z0myZ7+5xLQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j6t@kdbg.org>, Jeff King <peff@peff.net>,
	Jens Lehmann <jens.lehmann@web.de>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Thu Jan 14 00:37:42 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aJUz0-0003H9-5L
	for gcvg-git-2@plane.gmane.org; Thu, 14 Jan 2016 00:37:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753325AbcAMXhh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jan 2016 18:37:37 -0500
Received: from mail-io0-f179.google.com ([209.85.223.179]:36577 "EHLO
	mail-io0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753072AbcAMXhg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jan 2016 18:37:36 -0500
Received: by mail-io0-f179.google.com with SMTP id g73so240937854ioe.3
        for <git@vger.kernel.org>; Wed, 13 Jan 2016 15:37:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=gMPXBbuyjFalrgoMQ1IvTYnGVvV107kUcXFko5eDhgQ=;
        b=Mhn8ZM6QCyb7OqOP8NKkOR1qDt2/pauAfwvVrSz2ohOVccYBi2ggseGhUsCB7ZxOMD
         /goCH0ox/FxCIStNsF9AV8U9YSoliO7bsyjDPn0T75lFj5uABLREN/J7xbmCN+xNCQJQ
         4VP/qNUKGg5zHPzsTBMQ/WrNjxwxXvVOSK9qAgmZC6maUCFc+8yjWpmSnjMJv00HMIrB
         /N3FBYpu4FkTD0Td8cFBp1c9VdlABUEIPnBMesC3ejCFrJFS/cv1aZRiuuoBS368lYvF
         06WL5r5eG1zY81ZvzQ3ajbbQYA54fgB99t0zWxie4sDCijb3V2+PhVeZ+/OwdTVQI0SQ
         4Ung==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=gMPXBbuyjFalrgoMQ1IvTYnGVvV107kUcXFko5eDhgQ=;
        b=Ef5dMLO43EPJg3JIzfRzj9NTvLkoScVe17BIKnRtqb06eqK+ewL+OnvRIerVQPhpEL
         r4vNbVizpI/5pQAxZA2b2maqr+E16C3ciPtysPKYDJ16yEOosyuoKWWSn2452MNuWaze
         8yotfSVX10Ajs4bS0kzfucyXvwOe3T+NXLwZTsnJS1JLg9gaWNDEAy3ux7oU0pUu+5PY
         DEeqBmcuH+wQqrTHODGFsnTDb3UaN2x3jLOxK3BG+uxR5qYGTGXWLI61mQxHZm0s6wta
         b5TrI+oCStLzWvx2CY6BbC/xVLb6QZCVdbRe+65uPXZpDthydENg/HlpmNC5BZ2/OWLd
         WhhQ==
X-Gm-Message-State: ALoCoQm2pT0xbcrVNPJ3r9/cpDEy/wEOkaeAjh/hniwsaNmXsq7GsIkbVTH8uvAOoGmg90jNQkc19Kv2ASS+ooRB9Pc3zek4NN1f2vz9Sd9PBcfcxQ3WtZM=
X-Received: by 10.107.129.149 with SMTP id l21mr1620199ioi.174.1452728255461;
 Wed, 13 Jan 2016 15:37:35 -0800 (PST)
Received: by 10.107.8.74 with HTTP; Wed, 13 Jan 2016 15:37:35 -0800 (PST)
In-Reply-To: <CAPig+cTpghLgRdCCHu6CdM0v4TzytsOFFuE5p9=Z0myZ7+5xLQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283996>

On Wed, Jan 13, 2016 at 2:03 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> No time presently for a proper review, so just a few superficial comments...

Ok, I incorporated all your suggestions, too. Thanks for the superficial review!
