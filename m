From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH] align D/F handling of "diff --no-index" with that of
 normal Git
Date: Sun, 22 Mar 2015 10:56:44 -0700
Message-ID: <CAPc5daWmgAg-_UKkKwi0KwX4_enYJU1SEK9oyReW84-TP_-R1A@mail.gmail.com>
References: <xmqqiodtd3b4.fsf@gitster.dls.corp.google.com> <550EB77F.3040005@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Sun Mar 22 18:57:15 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YZk7a-00059l-Or
	for gcvg-git-2@plane.gmane.org; Sun, 22 Mar 2015 18:57:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751797AbbCVR5G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Mar 2015 13:57:06 -0400
Received: from mail-oi0-f51.google.com ([209.85.218.51]:33857 "EHLO
	mail-oi0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751763AbbCVR5F (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Mar 2015 13:57:05 -0400
Received: by oier21 with SMTP id r21so125202822oie.1
        for <git@vger.kernel.org>; Sun, 22 Mar 2015 10:57:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=2IVze3ytwcfPrrdZUUAuGwsJ6AnrLPLTqHeIxzXjikE=;
        b=OcDNoeMwQzGjFC8/636vInz+zPCOdN0IZvrmnSLwmBPb7EV2JqDeD91USp0clx0bQZ
         ouq8j93XdKJ624HIhm0wxrUS1q/kMCs8+3zDONCM4ZWXq45YM5Ub9Nkdb7BmBzepVkLD
         uLwji2x42zAbo/YpbW7PxLpuXOIxSEEgj/kw76WHM456p0K0OKWPvUKt3r2zQ51PjlDt
         GXNS2a347Z0MzEi/A7MUSitCiQQo0W6SXEV9iUD1B/Pl4tkpwMCxDD6pXkFIzOgThrFU
         ntaL9+UqEEcW1HZXOR0MzBqoShK9wHAIn6p2PdQQrd06plOrtQhDP6/sBZDwK5beCmmp
         y57w==
X-Received: by 10.182.60.197 with SMTP id j5mr72262356obr.85.1427047024624;
 Sun, 22 Mar 2015 10:57:04 -0700 (PDT)
Received: by 10.202.87.85 with HTTP; Sun, 22 Mar 2015 10:56:44 -0700 (PDT)
In-Reply-To: <550EB77F.3040005@ramsay1.demon.co.uk>
X-Google-Sender-Auth: lbOsWfU1rhcAXVkci_Ju9U1YKVc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266075>

On Sun, Mar 22, 2015 at 5:37 AM, Ramsay Jones
<ramsay@ramsay1.demon.co.uk> wrote:
> On 22/03/15 05:11, Junio C Hamano wrote:
>> +             if (S_ISDIR(mode1)) {
>> +                     /* 2 is file that is created */
>> +                     d1 = noindex_filespec(NULL, 0);
>> +                     d2 = noindex_filespec(name2, mode2);
>> +                     name2 = NULL;
>> +                     mode2 = 0;
>> +             } else {
>> +                     /* 1 is file that is deleted */
>> +                     d1 = noindex_filespec(name1, mode2);
>
> I have not been following the discussion (or even really
> studied this patch), but the asymmetry here caught my eye
> as I was skimming the email.

Yes, the assymetry is a stupid cut-and-paste error. Thanks for
catching.

There was actually no discussion on this point other than
a tangential mention of the problem to be solved, so you
are up to date as long as you read the proposed log message
in the message you are responding to ;-)

Another thing I noticed while I was playing with this is that
when comparing D1 and D2, a path that was modified is
shown as a patch between a/D1/path and b/D2/path, but
a path that was created or removed shows D1 or D2 on
both sides of the comparison, which we may also want to
fix. This problem appears in the current codebase without
the patch under discussion.
