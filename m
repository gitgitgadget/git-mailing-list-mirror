From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 1/2] git_mkstemps: correctly test return value of open()
Date: Thu, 18 Jul 2013 16:49:47 -0400
Message-ID: <CAPig+cRyRq3depm+eBzZp-nRa2iPKbK-JU8cXgZdzQnCduFTMA@mail.gmail.com>
References: <cover.1373618940.git.trast@inf.ethz.ch>
	<9af38018d55c95a6807d305bb3a088e48916baac.1373618940.git.trast@inf.ethz.ch>
	<878v16kfqy.fsf@linux-k42r.v.cablecom.net>
	<7v38rd6l3j.fsf@alter.siamese.dyndns.org>
	<51E7E05E.4000201@gmail.com>
	<7v4nbr4v7m.fsf@alter.siamese.dyndns.org>
	<201307182032.r6IKWtWC016218@freeze.ariadne.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>, n1xim.email@gmail.com,
	Thomas Rast <trast@inf.ethz.ch>,
	Git List <git@vger.kernel.org>, fonseca@diku.dk
To: "Dale R. Worley" <worley@alum.mit.edu>
X-From: git-owner@vger.kernel.org Thu Jul 18 22:49:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uzv99-0006tS-OF
	for gcvg-git-2@plane.gmane.org; Thu, 18 Jul 2013 22:49:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933835Ab3GRUtv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Jul 2013 16:49:51 -0400
Received: from mail-lb0-f176.google.com ([209.85.217.176]:33911 "EHLO
	mail-lb0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755103Ab3GRUtv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jul 2013 16:49:51 -0400
Received: by mail-lb0-f176.google.com with SMTP id z5so2856409lbh.21
        for <git@vger.kernel.org>; Thu, 18 Jul 2013 13:49:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=RDWXwGYllJ3f8AtcWWimYjLbwwl7vp+VvuD48Mb4fMo=;
        b=hxPySXSJsVCyx/aexwnYy6V0jBRKWs29cp1sgztuTXJvewJrmTzY6chNUIzgMSJcv2
         Tz6fQ30WBaBsEvJK8rD8AX86JEU1LGa0KcsaIc3YkCI1XQr8pXzWKuPHJrmvL+9XVoGI
         EHfvQ3wnY1FF8oxy9W5bzJWntyebK0Zhk4bktRafoLihHv+SS6jxxWnRgkWOGYtuEkUb
         5m4HB+lwUxoLek6aTd8d6ghu4ZG9TDpYn30ty8tG5r8TVkVtjLySvVeyHhsEvT1KaLLT
         montiOZ5ELOOGsecdHvHX9IMvJQQUhnW8nFvheRhlTv0cYHUEu4Y69s0fVpj9RfM8w4M
         YHrQ==
X-Received: by 10.152.87.172 with SMTP id az12mr6136444lab.24.1374180588050;
 Thu, 18 Jul 2013 13:49:48 -0700 (PDT)
Received: by 10.114.187.78 with HTTP; Thu, 18 Jul 2013 13:49:47 -0700 (PDT)
In-Reply-To: <201307182032.r6IKWtWC016218@freeze.ariadne.com>
X-Google-Sender-Auth: E0KIEbHIldMElBBOW9Ws5zgqzzU
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230742>

On Thu, Jul 18, 2013 at 4:32 PM, Dale R. Worley <worley@alum.mit.edu> wrote:
> I've been looking into writing a proper test for this patch.  My first
> attempt tests the symptom that was seen initially, that "git commit"
> fails if fd 0 is closed.
>
> One problem is how to arrange for fd 0 to be closed.  I could use the
> bash redirection "<&-", but I think you want to be more portable than
> that.  This version uses execvp() inside a small C program, and
> execvp() is a Posix function.

"<&-" is POSIX.

http://pubs.opengroup.org/onlinepubs/9699919799/utilities/V3_chap02.html#tag_18_07_05

> I've tested that this test does what it should:  If you remove the
> fix, "fd >= 0", the test fails.  If you then remove "test-close-fd-0"
> from before "git init" in the test, the test is nullified and succeeds
> again.
>
> Here is the diff.  What do people think of it?
