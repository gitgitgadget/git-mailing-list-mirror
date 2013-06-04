From: Martin von Zweigbergk <martinvonz@gmail.com>
Subject: Re: [PATCH v5 1/7] add simple tests of consistency across rebase types
Date: Mon, 3 Jun 2013 22:14:43 -0700
Message-ID: <CANiSa6hGLKATn3uUJKoi4917R4qoiyRHHJWo-p8vFrCZsg5joQ@mail.gmail.com>
References: <1369982987-18954-1-git-send-email-martinvonz@gmail.com>
	<1370292135-1236-1-git-send-email-martinvonz@gmail.com>
	<1370292135-1236-2-git-send-email-martinvonz@gmail.com>
	<7v1u8ide2b.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>, Johannes Sixt <j.sixt@viscovery.net>,
	Chris Webb <chris@arachsys.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 04 07:14:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ujja8-0000A3-Dl
	for gcvg-git-2@plane.gmane.org; Tue, 04 Jun 2013 07:14:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753279Ab3FDFOq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Jun 2013 01:14:46 -0400
Received: from mail-we0-f175.google.com ([74.125.82.175]:42236 "EHLO
	mail-we0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751026Ab3FDFOp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Jun 2013 01:14:45 -0400
Received: by mail-we0-f175.google.com with SMTP id t59so1248444wes.6
        for <git@vger.kernel.org>; Mon, 03 Jun 2013 22:14:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=EpdQ7Yxp9a7z4T2fwCFyZAYmFFEBaGPzfSj8RjHUY1o=;
        b=EblHESlE7DsbVNCNPTQdE8k3BmCZlBYHRKgEigUzwm7JHJM4f6M4FuwvCBPKuRD0vb
         gvcu4q/VDYrOzZvoVDc5Ifvm1GPG/BIy9kcKBSQ8Z8+WELf4spu6V+VVDA4eTh+sviHA
         RK5w4UF8zLN5/+nJXeqvtkyFkXo4r8YbRai6YofDzkDc5k/p3Z041p79NCXSwWhKJBdX
         phcwA1rNFTMmR98BhBPKJLJGlV0l/54HoDDPc26XlTHri01GYnjx5lwHMiZhQYhRfKXI
         /Nd6c0LlToHdXftTJ4FgXOyzsgNLPQawiJ40inClZ04CbVUCH/GLMrxlmdQLtn5h2zsX
         wUtQ==
X-Received: by 10.180.99.232 with SMTP id et8mr1039107wib.17.1370322884034;
 Mon, 03 Jun 2013 22:14:44 -0700 (PDT)
Received: by 10.180.7.99 with HTTP; Mon, 3 Jun 2013 22:14:43 -0700 (PDT)
In-Reply-To: <7v1u8ide2b.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226311>

On Mon, Jun 3, 2013 at 3:28 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> +
>> +# checks that the revisions in "$2" represent a linear range with the
>> +# subjects in "$1"
>> +test_linear_range () {
>> +     ! { git log --format=%p "$2" | sane_grep " " ;} &&
>
> An interesting way to spell:
>
>     test $(git rev-list --merges "$2" | wc -l) = 0

Heh, true. I'll change that. ("My" version was based on the one in
git-rebase.sh, around line 495.)

>> +reset_rebase () {
>> +     git rebase --abort # may fail; ignore exit code
>
> test_might_fail to catch unusual exit codes?

Will change.

>> +# a---b---c
>> +#      \
>> +#       d---e

>> +test_run_rebase () {
>> +     result=$1
>> +     shift
>> +     test_expect_$result "rebase $* fast-forwards if an ancestor of upstream" "
>
> The description is a non-sentence, and while I can tell what it
> wants to say, I do not have a good suggestion for rephrasing this.

Changing description to "... fast-forwards from an ancestor of upstream".

> This is asking to rebase the history leading to b on top of e, but e
> already includes everything in b, so it just turns into a no-op of
> not moving from e.  So it is not even a fast-forward.
>
>> +             reset_rebase &&
>> +             git rebase $* e b &&
>> +             test_cmp_rev e HEAD

Well, "git rebase e b" is of course a kind of short form of "git
checkout b && git rebase e". While it's true that the implementation
doesn't bother checking out b first, that's just an optimization, but
let me know if you meant something else.

Thanks. Will wait another day or two for further comments before I
send another version.
