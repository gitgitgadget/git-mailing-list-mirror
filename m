From: Paul Tan <pyokagan@gmail.com>
Subject: Re: What's cooking in git.git (Aug 2015, #01; Mon, 3)
Date: Tue, 4 Aug 2015 08:16:29 +0800
Message-ID: <CACRoPnRj4apVat2oWVHvUgWdLp6RJZsWw-s=juB-Sdc3dL30ng@mail.gmail.com>
References: <xmqq38006mod.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 04 02:16:52 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZMPuT-0002SU-Oh
	for gcvg-git-2@plane.gmane.org; Tue, 04 Aug 2015 02:16:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755931AbbHDAQf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Aug 2015 20:16:35 -0400
Received: from mail-lb0-f172.google.com ([209.85.217.172]:33628 "EHLO
	mail-lb0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755915AbbHDAQb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Aug 2015 20:16:31 -0400
Received: by lbbyj8 with SMTP id yj8so86179624lbb.0
        for <git@vger.kernel.org>; Mon, 03 Aug 2015 17:16:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=OaoPhBGDNvzAmyo2Xk0D1vKTrONFuV6OR1soTTXpsVk=;
        b=AEiCZozEMzpXuDaNAFJjxEEsPzGgtCnpS0uOoPY+kOAyRzYgNNjb7nUnKym5wM57Vx
         g8Gj9XnqcouOwOBOdkv67TBx164yEGD59J738jxtPOFf+pifH1TVv9/zpBXo/eNOKZYo
         CQN10J1T/MWKf695NudapoxtyDYlnjQ0EGFx6IpuwbqipCnOCQ/PEWRm9STPnh5/mL7G
         PkHDDEULwIh37TkbyzsNsNXdCZNMGDfurBBGd+VwRvCqf4rkJA5PEFskoesjTiwGh41d
         IBcjrB6q1a4WQgRfqnOx4Q3tAh7abJMCLflw79sV6MMoli6XpTroV3mHfjEi7Mytoijk
         vD5w==
X-Received: by 10.152.3.199 with SMTP id e7mr595558lae.98.1438647389697; Mon,
 03 Aug 2015 17:16:29 -0700 (PDT)
Received: by 10.112.62.196 with HTTP; Mon, 3 Aug 2015 17:16:29 -0700 (PDT)
In-Reply-To: <xmqq38006mod.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275231>

On Tue, Aug 4, 2015 at 6:18 AM, Junio C Hamano <gitster@pobox.com> wrote:
>  - I think pt/am-builtin is more or less ready, but the fix to the
>    issue that options given to 'git am' when restarting were
>    rejected must be queued on that topic before we can start
>    thinking of merging it to 'master' for the next release.

Yeah, sorry for the lack of updates, but I'm working on it[1]. I've
added a patch that adds stdin pty support to test_terminal, and made
--signoff work when resuming.

However, it turns out that --keep, --message-id and --scissors do not
work as well, as they apply to the mail-parsing stage (git-mailinfo),
which comes before the patch application stage. It's tricky, as their
functionality is locked inside builtin/mailinfo.c. :-/

I'm thinking about leaving them broken for now to push this patch
series forward, until the future where the git-mailinfo functionality
gets moved into libgit.a or something so we can access the individual
functions directly and work something out.

Will send a re-roll once I look over the patches with a fresh set of eyes.

[1] https://github.com/pyokagan/git/compare/pt/builtin-am...pt/am-resume-override-opts

Thanks,
Paul
