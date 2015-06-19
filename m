From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/3] Move unsigned long option parsing out of pack-objects.c
Date: Fri, 19 Jun 2015 11:39:57 -0700
Message-ID: <xmqqh9q38ruq.fsf@gitster.dls.corp.google.com>
References: <1434705059-2793-1-git-send-email-charles@hashpling.org>
	<1434705059-2793-3-git-send-email-charles@hashpling.org>
	<xmqq7fqza8bo.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Charles Bailey <charles@hashpling.org>
X-From: git-owner@vger.kernel.org Fri Jun 19 20:40:07 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z61Cw-0004OB-1O
	for gcvg-git-2@plane.gmane.org; Fri, 19 Jun 2015 20:40:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752859AbbFSSkB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Jun 2015 14:40:01 -0400
Received: from mail-ig0-f174.google.com ([209.85.213.174]:33836 "EHLO
	mail-ig0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752746AbbFSSj7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Jun 2015 14:39:59 -0400
Received: by igboe5 with SMTP id oe5so22582634igb.1
        for <git@vger.kernel.org>; Fri, 19 Jun 2015 11:39:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=HqYF0EDDRupkPo6YhWLOfcIPiuja1obCC1vNQtWnbAk=;
        b=Fy4aolfEjxWLsZqfyUcj5pJyNBhBngMQhPVCXS0Go6SditxlQJRre56UalAbaU0uAt
         r9mxHirItkvs3u7KM/i4G0gAFiB5CuvqknBMompxFwjIM56V40x5uRv6Y8u9V6iMj2iV
         rIrrLSOLJOPfqYU837kMfqcsE24N7nIFeMx65FDwRRO53vIANCC0H/cjZmXYiSiPl10d
         6vQf5wirG2RKycjKZWh2I4h65qUZ98cK4YRagPdnaaAqz9lq3RROXNYW3gDSDvAw4e+E
         lOxsfM3/32oAtAdFlQg6WNHtjbaUv0fdQ7RcvP+dHh6h2icJW2GpmfHp8NKA6Pc/VRjp
         HdLw==
X-Received: by 10.50.66.174 with SMTP id g14mr6444549igt.7.1434739199151;
        Fri, 19 Jun 2015 11:39:59 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:80a8:63af:ca7c:ab61])
        by mx.google.com with ESMTPSA id j4sm2211412igo.0.2015.06.19.11.39.58
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 19 Jun 2015 11:39:58 -0700 (PDT)
In-Reply-To: <xmqq7fqza8bo.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Fri, 19 Jun 2015 10:58:51 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272181>

Junio C Hamano <gitster@pobox.com> writes:

> Except for the minor nits above, I think this is a good change.

Oh, I forgot to mention one thing.  I am not sure if this should be
called ULONG.  "unsigned long"-ness is not the most important part
of this thing from the end-user's point of view, and also from the
point of view of the programmer who supports end-users by using this
new feature.

It is "unlike OPT_INTEGER, the user can specify it as a human
readble scaled quantity" that is the reason to use this new thing.
I think we discussed to introduce OPT_HUMINT (HUM stands for HUMAN,
obviously) or some name like that a few years ago to do exactly
this, but that is not a great name, either.

I was tempted to suggest a name that has "size" in it, but because
places that we may conceivably want to use it in the future would be
to specify:

 - sizes, e.g. "split the packfiles into 4.3G chunks".

 - counts, e.g. "show me the most recent 2k commits".

 - bandwidth, e.g. "limit the transfer to consume at most 2M bps".

which is not limited to size, it is not a very good idea, either.

OPT_SCALED_ULONG(), or something with "scaled" in its name, perhaps?
