From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [bug] 2.5.0 build with NO_PERL is broken
Date: Fri, 14 Aug 2015 16:49:38 -0400
Message-ID: <CAPig+cR77oFo6D3f8BjAB_yM-xPt+3EUGK4vZr3eYWJGTtksAQ@mail.gmail.com>
References: <loom.20150814T171757-901@post.gmane.org>
	<loom.20150814T184447-932@post.gmane.org>
	<xmqq7foxiqu6.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Renato Botelho <garga@freebsd.org>, Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 14 22:49:45 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZQLv7-00074O-8L
	for gcvg-git-2@plane.gmane.org; Fri, 14 Aug 2015 22:49:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752527AbbHNUtk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Aug 2015 16:49:40 -0400
Received: from mail-yk0-f169.google.com ([209.85.160.169]:34436 "EHLO
	mail-yk0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751601AbbHNUtj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Aug 2015 16:49:39 -0400
Received: by ykdt205 with SMTP id t205so79375197ykd.1
        for <git@vger.kernel.org>; Fri, 14 Aug 2015 13:49:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=Ffdt23AOtqfye9b4rprzmLyk/5pNtySfMgN5dH6ZlCU=;
        b=TiKm7M9qHFuz1DVnfEdvDrddG+d//htMtHIfz2KaLlGAQ4e0zV96g/LluNMrHw/Du7
         oy739+Kzp5Fl5+YzCGAJfNYml3t38QerPVi42uhi/QBIRegU2tsmP3Rz1fbF0Og3ny0y
         ULwlUYnXUvscyUDD0wSsditu8M3B70+7keZTQrWNb3ip9Sihy+PHAogrkBWHmkutNJs7
         lHCSX7UR2SNkRZ2PURfBKRiT1UsGD0AnoDEhqZFouBpG10igjLLOdZZiGu4PoHfLlXzi
         zaGHXzQXqGm4C4TUck6LEHui6MOu7neE7ojrq47DIaNEwnRQppYHbemnjqQNIJSTy9cs
         pcUQ==
X-Received: by 10.170.97.9 with SMTP id o9mr47005524yka.84.1439585378848; Fri,
 14 Aug 2015 13:49:38 -0700 (PDT)
Received: by 10.37.208.78 with HTTP; Fri, 14 Aug 2015 13:49:38 -0700 (PDT)
In-Reply-To: <xmqq7foxiqu6.fsf@gitster.dls.corp.google.com>
X-Google-Sender-Auth: clxkV6-TUsk2QkugWAN7G5UaHek
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275948>

On Fri, Aug 14, 2015 at 3:59 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Renato Botelho <garga@FreeBSD.org> writes:
>> I also found that some commands require perl when NO_PERL is set:
>
> NO_PERL merely means "I want to build a subset of Git that is meant
> to be usable on a system without a working Perl installed".  These
> scripts that do require Perl installed are indeed not expected to
> work under NO_PERL (if you think about it, that would be natural and
> the only sensible expectation---otherwise we would have coded them
> without using Perl at all, in which case there will be no need for
> NO_PERL in the first place).

Nevertheless, there's still the problem, due to 527ec39
(generate-cmdlist: parse common group commands, 2015-05-21), that git
doesn't build at all anymore when Perl is unavailable.

One option would be to go with the awk version of
'generate-cmdlist'[1], which restricts itself to POSIX and was tested
on Linux, FreeBSD, and Mac OS X[2], though I'm not sure we really want
to go there, particularly if you're uncomfortable[3] about introducing
awk into the toolchain.

Another option would be to rewrite the (more complex) generate-cmdlist
in shell, which I think should be possible, though it will be uglier
and more verbose.

[1]: http://article.gmane.org/gmane.comp.version-control.git/269307/
[2]: http://article.gmane.org/gmane.comp.version-control.git/269336/
[3]: http://article.gmane.org/gmane.comp.version-control.git/269324/
