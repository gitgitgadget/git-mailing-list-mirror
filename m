From: Paul Tan <pyokagan@gmail.com>
Subject: Re: [PATCH 6/6] am --abort: keep unrelated commits on unborn branch
Date: Tue, 9 Jun 2015 16:54:54 +0800
Message-ID: <CACRoPnT4CcJxQtTCzbOVRhHmN4MvzBx1S6x53CRuwFF9e+N4SQ@mail.gmail.com>
References: <1433591172-27077-1-git-send-email-pyokagan@gmail.com>
	<1433591172-27077-7-git-send-email-pyokagan@gmail.com>
	<xmqq4mmi9cwb.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Stefan Beller <sbeller@google.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 09 10:55:11 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z2FJO-0004Mh-Qi
	for gcvg-git-2@plane.gmane.org; Tue, 09 Jun 2015 10:55:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752460AbbFIIzB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Jun 2015 04:55:01 -0400
Received: from mail-la0-f49.google.com ([209.85.215.49]:34015 "EHLO
	mail-la0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933035AbbFIIy4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Jun 2015 04:54:56 -0400
Received: by laew7 with SMTP id w7so7205600lae.1
        for <git@vger.kernel.org>; Tue, 09 Jun 2015 01:54:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=UvxbudoWd42bJd8FX5vgmxYkBxiw/HXrXwo0h9bbT48=;
        b=Ds6FegNKeZuVYxyRom1SJe9bnhaLosYlDM+oS+Tb2ZtuUiZxO7wg6zynqPfEQkCPbY
         KNuKAZisYEPtRuM/XUP9vkhQfBXCBwaYbpDSoLMAUz/QGQTwrvV9+Y2i1DJLS/ZG0Ys6
         /kFgz2pffycmtHwxC9AN2QdIbx5Ab3PQaQXqqpDzNHrjXgDKLhKmPC/DoxE0Ymj8y+kW
         0koVDozHwHTHoXsbcKfmEk14ZvZfcbJpUxgxMykdCQvK+GPRphnSQrmatbhCRr6EohuN
         wRehxotr0wws60FOJ7OHQ5UR+izFeaFdSyT+GqtwdSXyOsBhWVKQUlp7totCKsawnNil
         dXvQ==
X-Received: by 10.152.164.193 with SMTP id ys1mr21374503lab.65.1433840094231;
 Tue, 09 Jun 2015 01:54:54 -0700 (PDT)
Received: by 10.112.74.133 with HTTP; Tue, 9 Jun 2015 01:54:54 -0700 (PDT)
In-Reply-To: <xmqq4mmi9cwb.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271154>

On Tue, Jun 9, 2015 at 4:13 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Paul Tan <pyokagan@gmail.com> writes:
>
>> Since 7b3b7e3 (am --abort: keep unrelated commits since the last failure
>> and warn, 2010-12-21), git-am would refuse to rewind HEAD if commits
>> were made since the last git-am failure. This check was implemented in
>> safe_to_abort(), which checked to see if HEAD's hash matched the
>> abort-safety file.
>>
>> However, this check was skipped if the abort-safety file was empty,
>> which can happen if git-am failed while on an unborn branch.
>
> Shouldn't we then be checking that the HEAD is still unborn if this
> file is found and says that there was no history in the beginning,
> in order to give the "am on top of unborn" workflow the same degree
> of safety?

We do already check to see if the HEAD is still unborn:

        abort_safety=$(cat "$dotest/abort-safety")
        if test "z$(git rev-parse --verify -q HEAD)" = "z$abort_safety"
        then
            return 0
        fi
        gettextln "You seem to have moved HEAD since the last 'am' failure.
    Not rewinding to ORIG_HEAD" >&2

If HEAD is unborn, then git rev-parse will not print anything, so we
would be comparing an empty string to an empty string.

Thanks,
Paul
