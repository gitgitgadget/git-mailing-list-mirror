From: Paul Tan <pyokagan@gmail.com>
Subject: Re: [PATCH 2/5] am: teach StGit patch parser how to read from stdin
Date: Tue, 9 Jun 2015 17:38:25 +0800
Message-ID: <CACRoPnTAOsJE_VWJCadHh6Hpcw_c9DK7qARA5kC8_BBoXWHH6A@mail.gmail.com>
References: <1433778531-18260-1-git-send-email-pyokagan@gmail.com>
	<1433778531-18260-3-git-send-email-pyokagan@gmail.com>
	<xmqqh9qi9dmh.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Chris Packham <judge.packham@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 09 11:38:33 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z2FzL-00029R-V5
	for gcvg-git-2@plane.gmane.org; Tue, 09 Jun 2015 11:38:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753348AbbFIJi2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Jun 2015 05:38:28 -0400
Received: from mail-lb0-f180.google.com ([209.85.217.180]:36684 "EHLO
	mail-lb0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753310AbbFIJi1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Jun 2015 05:38:27 -0400
Received: by lbbqq2 with SMTP id qq2so6901972lbb.3
        for <git@vger.kernel.org>; Tue, 09 Jun 2015 02:38:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=eviXUfqj5e+zcxs+JEl1KnwYNDf9Vhs3aGYuDJ+ykv0=;
        b=MnhiyAZ3ofFn4vOO5+ZZc9hMRvkjcY1L5Jm8MWAIVxWH/Q/kf/9Zy907bo4i+RWTi8
         FW0muzGCUdkamM4Fny1BZiWH4POBEv+RIbxeFeFGUGo+6dYkCR9yaLelGHqvUtnSImOV
         iTxA+BVxGnALrEM8FrZ0/eUgt7Q6OoAZZOwGbN9lWmAglpZNrYtVNuLJJuZOYGZGoV9D
         tKHGR7nGZVfIVqh5ejdguKTuYyo13OiXxmltEPVDEXUWgcbzZ2IAXrq3YTM8blxaROdg
         3gKhHzweYg0BTyK7nhM1HSaYvTQtHg4Dw1nhzyJxRSA8a7JRxeL5tzNXRCDs39uMIaUo
         pPxA==
X-Received: by 10.152.2.38 with SMTP id 6mr21924792lar.80.1433842705785; Tue,
 09 Jun 2015 02:38:25 -0700 (PDT)
Received: by 10.112.74.133 with HTTP; Tue, 9 Jun 2015 02:38:25 -0700 (PDT)
In-Reply-To: <xmqqh9qi9dmh.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271159>

On Tue, Jun 9, 2015 at 3:57 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Paul Tan <pyokagan@gmail.com> writes:
>
>> git-mailsplit, which splits mbox patches, will read the patch from stdin
>> when the filename is "-" or there are no files listed on the
>> command-line.
>>
>> To be consistent with this behavior, teach the StGit patch parser to
>> read from stdin if the filename is "-" or no files are listed on the
>> command-line.
>
> Hmm, doesn't
>
>         perl -ne 'processing for each line'
>
> with or without a BEGIN {} block, read from the standard input (if
> no filename is given) or the given file (if given), and more
> importantly, doesn't it treat a lone "-" as STDIN anyway?
>
> That is, wouldn't it make more sense to do something like:
>
>         test $# != 0 || set -- -
>         for stgit
>         do
>                 ...
>                 @@PERL@@ -ne 'BEGIN { $subject = 0 }
>                         ...
>                 ' "$stgit" >"$dotest/$msgnum" || clean_abort
>         done
>
> Same for patch 5/5.

Ah yes, this makes more sense.

Thanks,
Paul
