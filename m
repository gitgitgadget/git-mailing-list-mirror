From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/8] apply: fix adding new files on i-t-a entries
Date: Tue, 25 Aug 2015 10:01:06 -0700
Message-ID: <xmqqh9nn1ewd.fsf@gitster.dls.corp.google.com>
References: <xmqqy4j80wdb.fsf@gitster.dls.corp.google.com>
	<1440205700-19749-1-git-send-email-pclouds@gmail.com>
	<1440205700-19749-4-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, phiggins@google.com, snoksrud@gmail.com
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 25 19:01:17 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZUHb0-0008Tb-Gm
	for gcvg-git-2@plane.gmane.org; Tue, 25 Aug 2015 19:01:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755416AbbHYRBJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 25 Aug 2015 13:01:09 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:33012 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751989AbbHYRBI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Aug 2015 13:01:08 -0400
Received: by pacti10 with SMTP id ti10so56685397pac.0
        for <git@vger.kernel.org>; Tue, 25 Aug 2015 10:01:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type:content-transfer-encoding;
        bh=Z/ECwM/r9gVz5NVIR56C3oPSP9kChHssaxU0AXRfMzo=;
        b=QTvT22Tp80DucFn2YlxsaBLmMd5w1yd6FRYIt/3kvlQl6PGVsaRLrN8+13PaB+jPQm
         BErO1PZzskqTgmlbVXxMOKPjcOl9+y5CDmF29TVTHNDfsEl6yPd8oJ0S/vW6BPyR5lmV
         X4p0gt29vJXkd6Ifx/Nl5eqvY+iJLhA5lqj5Li3wBgGvodwZSOGztG1DOPJs0a1AAwZC
         BgCr3peBgKyc+bfpZ+4IfXlNojD9NpoYE3NDrN0Ods1eVqh0i9EB6TL/xBlE5YnH8tH5
         LjMk4VjpkmsCgjHAH4aJ9Ziy8QitHcDFUORNUTfT0+6mFpHZnlZjCZehe9Pa9eXL4tgd
         VUNw==
X-Received: by 10.68.243.103 with SMTP id wx7mr57854017pbc.60.1440522067689;
        Tue, 25 Aug 2015 10:01:07 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:cdc0:fd6d:4069:6223])
        by smtp.gmail.com with ESMTPSA id w5sm7486432pda.80.2015.08.25.10.01.06
        (version=TLS1_2 cipher=AES128-SHA256 bits=128/128);
        Tue, 25 Aug 2015 10:01:06 -0700 (PDT)
In-Reply-To: <1440205700-19749-4-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Sat, 22
 Aug 2015 08:08:06 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276538>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> Applying a patch that adds a file when that file is registered with "=
git
> add -N" will fail with message "already exists in index" because
> git-apply checks, sees those i-t-a entries and aborts. git-apply does
> not realize those are for bookkeeping only, they do not really exist =
in
> the index. This patch tightens the "exists in index" check, ignoring
> i-t-a entries.

Suppose that you came up with some contents to register at path F in
your working tree, told Git about your intention with "add -N F",
and then tried to apply a patch that wants to _create_ F:

Without this patch, we would say "F already exists so a patch to
create is incompatible with our current state".

With this patch, we do not say that, but instead we'll hopefully
trigger "does it exist in the working tree" check, unless you are
running under "--cached".

Which means that this change will not lead to data loss in the
"untracked" file F in the working tree that was merely added to the
index with i-t-a bit.

As you did not say the equivalent of the last paragraph above in the
log message, my knee-jerk reaction was "why could this possibly be a
good idea?"

Please try again with a better log message.

Thanks.
