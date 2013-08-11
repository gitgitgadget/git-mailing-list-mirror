From: Stephen Haberman <stephen@exigencecorp.com>
Subject: Re: [PATCH] pull: Allow pull to preserve merges when rebasing.
Date: Sun, 11 Aug 2013 18:38:45 -0500
Organization: Exigence
Message-ID: <20130811183845.18381b8c@sh9>
References: <1376256387-30974-1-git-send-email-stephen@exigencecorp.com>
	<CAPrKj1b=QTdqVH+JtukJrfEc=EqxWOEYE4YG7oSY7413uqdKfg@mail.gmail.com>
	<20130811180915.390d660a@sh9>
	<CAPrKj1aMURcVoaiJ+WS64ekafUZgSagKrYSknTUk3+TL6tCETQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Andres Perera <andres.p@zoho.com>
X-From: git-owner@vger.kernel.org Mon Aug 12 01:39:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V8fE9-0005Ld-2p
	for gcvg-git-2@plane.gmane.org; Mon, 12 Aug 2013 01:39:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755166Ab3HKXis (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Aug 2013 19:38:48 -0400
Received: from mail-oa0-f54.google.com ([209.85.219.54]:62613 "EHLO
	mail-oa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755149Ab3HKXis (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Aug 2013 19:38:48 -0400
Received: by mail-oa0-f54.google.com with SMTP id o6so9051958oag.27
        for <git@vger.kernel.org>; Sun, 11 Aug 2013 16:38:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=exigencecorp.com; s=google;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-type:content-transfer-encoding;
        bh=M2ejuRdAr8YxeqPcMmb8jMeMss3TnhdGMNRcbeBL6nI=;
        b=XZL2FBKRl/m1Jf1g0ihZX8ULl3Ho/0wyyrb/JbPsQ+YdUx1LcTuPbvJqCURPwrt8m/
         ZE0SVFxwuHxT1ElDeKITyTaz/Pt8TfhLmP41THxVQQpeFZsrng9mNP+9W6rnXvl+Jywg
         ueRwnC7TraRRFq+jXWq9+FMab9pjxNa/OpOd8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-type
         :content-transfer-encoding;
        bh=M2ejuRdAr8YxeqPcMmb8jMeMss3TnhdGMNRcbeBL6nI=;
        b=j7BxNaboouRFAuzzULVV9gxURckjDwQeFZL5kJSjMlLs4WuqiF3ZXz0uIEEMA6TZrD
         zrvtnm/BiQ/00X8h0smFDrakoPvBLehyno2QZSDHnhto6MgdpQI+HSsdy97f4Tmtvt0G
         +3cDBSFAMsxyAEP65uT5/Xuzs+cbuUPsFNFR996s8dvYnECe86j+h6+0kgk1q/k5kh55
         WWZYmB1YpDiyK9g423BKnxYHyivYHZ3eP0aU+MMSYkm+ZaKsjaMP0tipS9nI4LmiVArG
         ZQ4KkgtVmDnqkRYask8hdW2kavqa1OcEVi3DpcGKo1sb686BOj78UYKGICe1EbUiPQ5U
         bqWA==
X-Gm-Message-State: ALoCoQkyv323frY9d1vPiDNFsLVJCs1uiVeAJrI0OFUa+SFRjIJQVk8Nlw8Tn/E6YdW3XibnMPJ6
X-Received: by 10.182.28.98 with SMTP id a2mr8667250obh.36.1376264327270;
        Sun, 11 Aug 2013 16:38:47 -0700 (PDT)
Received: from sh9 (wsip-184-187-11-226.om.om.cox.net. [184.187.11.226])
        by mx.google.com with ESMTPSA id g1sm31048607oeq.6.2013.08.11.16.38.46
        for <multiple recipients>
        (version=SSLv3 cipher=RC4-SHA bits=128/128);
        Sun, 11 Aug 2013 16:38:46 -0700 (PDT)
In-Reply-To: <CAPrKj1aMURcVoaiJ+WS64ekafUZgSagKrYSknTUk3+TL6tCETQ@mail.gmail.com>
X-Mailer: Claws Mail 3.9.1 (GTK+ 2.24.17; x86_64-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232145>

Hi Andres,

> i just realized that there are ambiguities:

> pull --rebase (true|false|preserve) foo # pull from remote named
> (true|false|preserve), branch foo

Yeah.

Right now, I did the latter. Around line 125, when parsing "--rebase
<somearg>", we accept <somearg> only if it's true, false, or preserve,
and shift it off. Otherwise we leave it alone and assume it's a remote
name.

Without this logic, t5520 fails because it uses "git pull --rebase .
copy", which, as you noted, is ambiguous, so "." was showing up as the
rebase argument.

So, this is technically handled right now, but I'm fine removing the
ambiguous "--rebase true|false|preserve" option if that is what is
preferred.

- Stephen
