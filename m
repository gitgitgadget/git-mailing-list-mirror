From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 1/2] sha1_name.c: signal if @{-N} was a true branch nameor
 a detached head
Date: Thu, 9 May 2013 14:24:42 -0400
Message-ID: <CAPig+cS-SyANELP5N9ch2UQgsDaJmfnm0qqPBQ+71ctGDXzzYg@mail.gmail.com>
References: <7vk3n9dvlu.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 09 20:24:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UaVWK-00018U-Jq
	for gcvg-git-2@plane.gmane.org; Thu, 09 May 2013 20:24:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752033Ab3EISYq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 May 2013 14:24:46 -0400
Received: from mail-lb0-f174.google.com ([209.85.217.174]:55077 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751944Ab3EISYo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 May 2013 14:24:44 -0400
Received: by mail-lb0-f174.google.com with SMTP id r10so3331580lbi.5
        for <git@vger.kernel.org>; Thu, 09 May 2013 11:24:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=Buf8byMwfVa1imLbU6d5TJPpi0SsvPLRAuh1bnsZ5Ik=;
        b=O0cItG1RAwZ08nSWy371/Ihj0+Bo51aaaZVxx7b24DOAdO5KBNVvGu9lzTLqxOOZoS
         hJyDn/Qll8Jx2/UyrTdjUe7uTZk1e9GGaTX1KZadjYYVPNFOhLKSyrR03JMztocr49UW
         4ZF1U+bPMb0GY9JGwFLkVVdXP4DDQzMFfXebo4dXTNclMnO6JXqS4DxqoNMtVSylW/Fn
         sKRaGpAKfSlvgoWBiq1ECM9S2muqpwDEx4P8FT3jPZocWzv2guzptF5AALVyYCKICwmZ
         2JQxVSr9KgOgjYw/PRN6uLsAqA+Hdt14CqfCmHM8wDy0l5w2Vl4+d8a46lHqo0JSGXHO
         OxNg==
X-Received: by 10.112.72.163 with SMTP id e3mr5956696lbv.28.1368123882310;
 Thu, 09 May 2013 11:24:42 -0700 (PDT)
Received: by 10.114.181.3 with HTTP; Thu, 9 May 2013 11:24:42 -0700 (PDT)
In-Reply-To: <7vk3n9dvlu.fsf@alter.siamese.dyndns.org>
X-Google-Sender-Auth: Eq0Yl-kEZoxxAc5Gjtrz1wq6IKY
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223768>

On Wed, May 8, 2013 at 5:12 PM, Junio C Hamano <gitster@pobox.com> wrote:
> sha1_name.c: signal if @{-N} was a true branch nameor a detached head

s/nameor/name or/

> The original API read "checkout: moving from (.*) to ..." from the
> reflog of the HEAD, and returned the substring between "from" and
> "to", but there was no way, if the substring was a 40-hex string, to
> tell if we were on a detached HEAD at that commit object, or on a
> branch whose name happened to be the 40-hex string.
>
> At this point, we cannot afford to change the format recorded in the
> reflog, so introduce a heuristics to see if the 40-hex matches the
> object name of the commit we are switching out of.  This will
> unfortunately mishandle this case:
>
>         HEX=$(git rev-parse master)
>         git checkout -b $HEX master
>         git checkout master
>
> where we were indeed on a non-detached $HEX branch (i.e. HEAD was
> pointing at refs/heads/$HEX, not storing $HEX), of course, but
> otherwise should be fairly reliable.
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
