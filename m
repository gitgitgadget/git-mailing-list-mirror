From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v12 03/13] ref-filter: introduce the ref_formatting_state stack machinery
Date: Wed, 19 Aug 2015 11:52:43 -0700
Message-ID: <xmqq37zf9klg.fsf@gitster.dls.corp.google.com>
References: <1439923052-7373-1-git-send-email-Karthik.188@gmail.com>
	<1439923052-7373-4-git-send-email-Karthik.188@gmail.com>
	<vpqvbcb2uoi.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Karthik Nayak <karthik.188@gmail.com>, git@vger.kernel.org,
	christian.couder@gmail.com
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Aug 19 20:53:03 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZS8Tn-0000JK-4I
	for gcvg-git-2@plane.gmane.org; Wed, 19 Aug 2015 20:52:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751913AbbHSSwq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Aug 2015 14:52:46 -0400
Received: from mail-pd0-f180.google.com ([209.85.192.180]:36735 "EHLO
	mail-pd0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751257AbbHSSwp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Aug 2015 14:52:45 -0400
Received: by pdbmi9 with SMTP id mi9so4478459pdb.3
        for <git@vger.kernel.org>; Wed, 19 Aug 2015 11:52:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=EjPecpbwvNTlEpHLgGB6zcU6fFFySxbDMeNWrOS7YF4=;
        b=DXYxgqV18+qUgcbHnSNrahfT/aslinJqPQ8m8cqqUfvAuN34BuaZY6ApGtOKrIRLkl
         NgpdpIEmGeDtBjbri7KDFuoMXPy0bRYI+v5fPAgZ486p60/Sei8ANS8W3N7aAuLGGNJB
         18MCaWb1lo98i93f0C1XyHxxeN+i8thDjOrjdnTikWo4TtCF2H73DGMK+qxsJfqsB3xI
         7ExxFW2BH+TzDQPjKakuKhabVgqt5lHuq1wawkRjBDTJiF3GGKH0ftxEudh8rv47wPwJ
         i7JDw16MjZXJIX8gutojsqBsZk3MVWYKULJgjSxjimL5GIsY4yZGt6Q68oCz4cuIOKhb
         K/NA==
X-Received: by 10.70.134.134 with SMTP id pk6mr27586113pdb.143.1440010364930;
        Wed, 19 Aug 2015 11:52:44 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:a5d7:91a5:eac5:b635])
        by smtp.gmail.com with ESMTPSA id ea4sm1687512pbc.48.2015.08.19.11.52.44
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 19 Aug 2015 11:52:44 -0700 (PDT)
In-Reply-To: <vpqvbcb2uoi.fsf@anie.imag.fr> (Matthieu Moy's message of "Wed,
	19 Aug 2015 16:56:45 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276213>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> You replaced the quote_style argument with ref_formatting_state, and I
> think you should have kept this argument and added ref_formatting_state.
> The other option is to add an extra indirection like
>
> struct ref_formatting_state {
> 	int quote_style;
> 	struct ref_formatting_stack *stack;
> }
>
> (ref_formatting_stack would be what you currently call
> ref_formatting_state). But that's probably overkill.

I think this is the right way to go.  As you explained in your later
messages, this is conceptually a global setting that applies to
anybody working in the callchain and not something individual
recursion levels would want to muck with.

Thanks.
