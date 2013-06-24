From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 1/2] status: really ignore config with --porcelain
Date: Mon, 24 Jun 2013 21:20:40 +0530
Message-ID: <CALkWK0kNFLn+XV2Ug3a1CtSkErCpfWZVO51z8xSNjD++uhHf2A@mail.gmail.com>
References: <1372077912-18625-1-git-send-email-artagnon@gmail.com>
 <1372077912-18625-2-git-send-email-artagnon@gmail.com> <vpqhagnwraj.fsf@anie.imag.fr>
 <7v8v1zd0du.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 24 17:51:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ur93A-0003qf-Km
	for gcvg-git-2@plane.gmane.org; Mon, 24 Jun 2013 17:51:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752566Ab3FXPvX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Jun 2013 11:51:23 -0400
Received: from mail-ie0-f172.google.com ([209.85.223.172]:60663 "EHLO
	mail-ie0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751006Ab3FXPvV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Jun 2013 11:51:21 -0400
Received: by mail-ie0-f172.google.com with SMTP id 16so25138526iea.17
        for <git@vger.kernel.org>; Mon, 24 Jun 2013 08:51:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=smYFqkvaMA3HBfehHMvNClNTIx5jJvRqn+q1EIya3h4=;
        b=tu/pN1jWNw2s7sI2arU0nxOz/WnrmUAjMaNBpw+rSBFSxttPXjrPdetDz39TVFS/hT
         2UVO1xAWpkjU4hlazPnEfTxa7Py7Wsx7JZ3IiuM3Lr6JNpVZ/Ic5OAgWOrJ4jlDtABrw
         NmUraDmngbW/Iw6ehyoFs9eKCEseQ1970C2BPJdt7C+yioARYbfba5grpXOCw56NYNno
         yZyUwc7YKaeMOBufCb7AR8GoMhfCsuDajlxXXlCedJUyxSwnD6N6KGyB398IU+rtLJlz
         XxLivM7ChtgGbT7jxY4meFoZgelcg2/ndqNyKSu1vhSKEsf1uF56wDpv8DdNwLCuvxql
         flGA==
X-Received: by 10.50.225.66 with SMTP id ri2mr5895847igc.55.1372089080473;
 Mon, 24 Jun 2013 08:51:20 -0700 (PDT)
Received: by 10.64.129.97 with HTTP; Mon, 24 Jun 2013 08:50:40 -0700 (PDT)
In-Reply-To: <7v8v1zd0du.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228842>

Junio C Hamano wrote:
> Configuration related to the output format (like color=always) must
> be ignored under "--porcelain", but if we do not read core-ish
> configuration variables (e.g. core.crlf) that affect the logic to
> list what is changed what is not, we would not give the right
> result, no?

Ah, ofcourse.  My stupidity.

>  My knee-jerk reaction is that, because the
> "--porcelain" output was designed to be extensible and scripts
> reading from it is expected to ignore what it does not understand,
> if the setting of status.branch is a problem, the reading side is
> buggy and needs to be fixed.

Are you 100% sure about this?

--porcelain::
	Give the output in an easy-to-parse format for scripts.
	This is similar to the short output, but will remain stable
	across Git versions and regardless of user configuration. See
	below for details.

status.branch is an exception, no doubt: it just adds one line clearly
prefixed with "##" to the beginning, and any script can ignore it easily.

> Do we have in-core reader that does not behave well when one or both
> of these configuration variables are set (perhaps something related
> to submodule?)???

Yeah, the submodule.c parser is very naively written (see
submodule.c:737), and I can fix it.  But the bigger question still
remains: if we have such a non-robust parser in git.git itself,
wouldn't you expect external parsers to be even worse?
