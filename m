From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v5 3/6] git-p4: retry kill/cleanup operations in tests
 with timeout
Date: Tue, 17 Nov 2015 12:44:30 -0500
Message-ID: <CAPig+cT2aBrL6Qh3W3d-ODjj7S0GORkTZMyQ6PBfHCLVqeKBvQ@mail.gmail.com>
References: <1447592920-89228-1-git-send-email-larsxschneider@gmail.com>
	<1447592920-89228-4-git-send-email-larsxschneider@gmail.com>
	<CAPig+cQkNB3VzbC_R_T=ppkgvmTbOWnK22hFxyMzJH1DZ_iVhQ@mail.gmail.com>
	<52A9F66D-12C4-4BB5-A2D4-C476A1E12DC5@gmail.com>
	<CAPig+cR8igO1bWNgma_yZqrcru_jnKchpRH+i2_AaNj8Atcb9g@mail.gmail.com>
	<564AF48C.9040406@diamand.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Lars Schneider <larsxschneider@gmail.com>,
	Git List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Luke Diamand <luke@diamand.org>
X-From: git-owner@vger.kernel.org Tue Nov 17 18:45:00 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZykJN-00055o-WA
	for gcvg-git-2@plane.gmane.org; Tue, 17 Nov 2015 18:44:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932402AbbKQRox (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Nov 2015 12:44:53 -0500
Received: from mail-yk0-f176.google.com ([209.85.160.176]:33068 "EHLO
	mail-yk0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932450AbbKQRob (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Nov 2015 12:44:31 -0500
Received: by ykdv3 with SMTP id v3so18826965ykd.0
        for <git@vger.kernel.org>; Tue, 17 Nov 2015 09:44:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=o6gcv3InJMEHyPur2gdQciIwLzDqNaAvxFb0CIjcIDs=;
        b=yQxnwXXzqk4Ae35BUb/akbGDdFe3rmZ33kdS5E7SnKjhptHTr2542h/SOlW8Y7LL/L
         yiu69Y7kDGyosxmea4jW3/STmuNuXIbuAwvDARXmHSKsuhmTLnvH23zM2c9mTGhpwzUS
         G+qUQV6W0RzRWKmB9bbX5US0wCCMGWpQ40I79FdGfbYv3J/XjZ+cQZwQSyCx32/wJkXH
         SKb6tNd5Sox4YLR2yj5ho0aMBDRDDrD2Ioqo79K9HZkNCOrFscfDKalF/Py3lf/hKkuF
         9KPB5Sm44fiTKC7k0EvS80MoU1PsSoV0GHh2eQhPGoSmu9zhqsoaCfzi7CX0p3GlIbD7
         e0wA==
X-Received: by 10.129.107.134 with SMTP id g128mr15427519ywc.248.1447782270406;
 Tue, 17 Nov 2015 09:44:30 -0800 (PST)
Received: by 10.31.159.204 with HTTP; Tue, 17 Nov 2015 09:44:30 -0800 (PST)
In-Reply-To: <564AF48C.9040406@diamand.org>
X-Google-Sender-Auth: ZDFUjDnki2zDij8FneI2mUMBuP8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281413>

On Tue, Nov 17, 2015 at 4:34 AM, Luke Diamand <luke@diamand.org> wrote:
>>> While implementing it I thought more about it. P4D is only
>>> supported on platforms that support the date function. That means
>>> these tests will only run on platforms that support the date
>>> function. Consequently I wondered if this would justify the
>>> slightly more complicated code. However, if you think this change
>>> would help the patch to get accepted then I will add it.
>>
>> I don't feel strongly about it, and it's not my call anyhow. Opinions
>> of Junio, Peff (as interim maintainer), and Luke weigh much more
>> heavily than my own. Punting on dynamic detection of "date +%s" may be
>> perfectly acceptable with the attitude that it can be implemented
>> later if someone runs across a case where it's actually needed.
>
> Which other platforms are we talking about here?
>
> https://www.perforce.com/downloads/helix
>
> From there, you can get Solaris10, HP-UX, AIX and various flavours of BSD.
> Solaris supports "date +%s".

The question about "date +%s" portability arose with a suggestion to
employ it in git-filter-branch[1]. Apparently, the concern about
Solaris was raised in response to a Stack Overflow question[2] which
claimed that +%s was not supported by that OS. Unfortunately, however,
[2] did not indicate to which (older?) versions of Solaris that
shortcoming applied. If Solaris 10 does support +%s, and the Perforce
product is only available for Solaris 10, then perhaps concern about
+%s a non-issue(?).

[1]: http://git.661346.n2.nabble.com/FEATURE-REQUEST-Filter-branch-extend-progress-with-a-simple-estimated-time-remaning-td7638200.html#a7638504
[2]: http://stackoverflow.com/questions/2445198/get-seconds-since-epoch-in-any-posix-compliant-shell
