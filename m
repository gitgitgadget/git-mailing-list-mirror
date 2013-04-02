From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 1/3] send-email: use "return;" not "return undef;" on
 error codepaths
Date: Tue, 2 Apr 2013 13:29:01 +0530
Message-ID: <CALkWK0muF2Nx=ykD6jt4pvpmp9c3R2KhXhQMjLAyMWiHu_6iPA@mail.gmail.com>
References: <7vr4ivni5g.fsf@alter.siamese.dyndns.org> <1364780442-6015-1-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 02 10:00:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UMw8Y-0002oT-Cs
	for gcvg-git-2@plane.gmane.org; Tue, 02 Apr 2013 10:00:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755401Ab3DBH7m (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Apr 2013 03:59:42 -0400
Received: from mail-ie0-f169.google.com ([209.85.223.169]:45488 "EHLO
	mail-ie0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754081Ab3DBH7l (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Apr 2013 03:59:41 -0400
Received: by mail-ie0-f169.google.com with SMTP id qd14so128750ieb.14
        for <git@vger.kernel.org>; Tue, 02 Apr 2013 00:59:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=Wf432ReO/Z5HPMegV176tWcmyPFxtW4yhsdred5vvJs=;
        b=xqhG7y5Zc8QPdedLR2WKcfWZz7RBoKDEI+q0O74/0gDz3XGfJfQqPjFIOO5cuZBGT5
         h6LnzXr1QAAC+EQIwHAIbuw4nq0k4Fnkvmtsa5BPnYmDW2L5/++ZqXRldyyp5K51SB7S
         k1fRqgT8QlNGfwCCrWv37yazAtUwTaMKxC7ILd3LA1pxTiApJ2lrF0nXgPLybeNNfVWk
         fHH1dUCaDyGjrQWPWsdXpEE4QU1oZKH+eE6eYadywuUZdAV8hniGFutuOZJ/LdkJz1xu
         WGhhNvl1basLTAmmb0+pzxoRvmgYYonHpWRCxrch79rEwgRoXtrnM5MPdUhBKyZKYxDZ
         FLfQ==
X-Received: by 10.50.50.71 with SMTP id a7mr4700610igo.14.1364889581261; Tue,
 02 Apr 2013 00:59:41 -0700 (PDT)
Received: by 10.64.166.33 with HTTP; Tue, 2 Apr 2013 00:59:01 -0700 (PDT)
In-Reply-To: <1364780442-6015-1-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219753>

Junio C Hamano wrote:
> Note that we leave "return undef;" in validate_address on purpose,
> even though Perlcritic may complain.  The primary "return" site of
> the function returns whatever is in the scaler variable $address, so
> it is pointless to change only the other "return undef;" to "return".
> The caller must be prepared to see an array with a single undef as
> the return value from this subroutine anyway.

The way I understood it:
All callsites only ever call validate_address via
validate_address_list, which in turn maps a list of addresses by
calling validate_address on each address.  Therefore, validate_address
returning an undef in one codepath is correct.
