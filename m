From: Phil Hord <phil.hord@gmail.com>
Subject: Re: [BUG] Possible bug in `remote set-url --add --push`
Date: Wed, 16 Jan 2013 11:15:37 -0500
Message-ID: <CABURp0rR_wB6vcjrZajQU_=AVVvBq-aTGpggh5XxdCMYis3-ag@mail.gmail.com>
References: <CAN8TAOsnX1Mr72LPa47KKXDeUZPgSHTJ6u4YpPFPrtsK7VdN+A@mail.gmail.com>
 <7vliby98r7.fsf@alter.siamese.dyndns.org> <4836187.09xoy3kJnj@blacky>
 <CAN8TAOv0Cm8CgiJSweFtRzOqO78OtNKa4G+x7z6M5Bt+odUmiQ@mail.gmail.com>
 <50F40316.7010308@drmicha.warpmail.net> <7v1udnbmyz.fsf@alter.siamese.dyndns.org>
 <1D472234-A0A5-4F02-878D-D05DEE995FCD@gmail.com> <7vpq1755jb.fsf@alter.siamese.dyndns.org>
 <7vip6z54rh.fsf@alter.siamese.dyndns.org> <50F524F8.5090803@drmicha.warpmail.net>
 <7v4nii5tp2.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Jardel Weyrich <jweyrich@gmail.com>,
	Sascha Cunz <sascha-ml@babbelbox.org>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 16 17:16:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TvVfI-0006xK-FL
	for gcvg-git-2@plane.gmane.org; Wed, 16 Jan 2013 17:16:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758611Ab3APQP7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jan 2013 11:15:59 -0500
Received: from mail-vc0-f173.google.com ([209.85.220.173]:55958 "EHLO
	mail-vc0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758030Ab3APQP6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jan 2013 11:15:58 -0500
Received: by mail-vc0-f173.google.com with SMTP id fl15so1502922vcb.32
        for <git@vger.kernel.org>; Wed, 16 Jan 2013 08:15:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=t1ZPe1yMYRuV2ApkCCbRxlZvVGTcieFUNa+5DLs8GXM=;
        b=K2qb5C6KeqZSobueiq4+jJjD4+RIqmmCB4O+1WCx0L5fknbPRp6YLQsN1ADboTpkm4
         RYDYalxBwJ/lB9voGXd8RLvvMqb01uPRzPWPXdY4N55Q2OJfTkqZjgDXk97rULqfEOSR
         XORpweSaTEmC5za1w2yhCri1pO3NV6EEKTjMxG1pHQh6cgPkGg66wGHPQRCAMiARL7vB
         cQj3Lmzk5Um9SuNtO+aqxaL7VOLuuu2w8T8zmOBy5AG1z4LPB276wN10vwVmKyah6dA2
         DlrGZEudlktxqK+PEdy/1EHaejTAPEuSs2yvi9VD/GP8/Hp+3Ei14AdZDgFL+z+u+vgO
         ooqg==
X-Received: by 10.52.71.174 with SMTP id w14mr1502769vdu.122.1358352957981;
 Wed, 16 Jan 2013 08:15:57 -0800 (PST)
Received: by 10.58.241.203 with HTTP; Wed, 16 Jan 2013 08:15:37 -0800 (PST)
In-Reply-To: <7v4nii5tp2.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213762>

On Tue, Jan 15, 2013 at 10:53 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Michael J Gruber <git@drmicha.warpmail.net> writes:
>
>> That being said, I don't mind changing the behaviour of set-url.
>
> I do not think we want to change the behaviour of set-url.

I agree with Michael that changing the set-url behavior would be
appropriate here.  If I say "--add" this pushUrl, don't I mean to
create an additional url which is pushed to?

I agree that it makes the config situation messy; this is currently a
"clean" sequence, in that it leaves the config unchanged after both
steps are completed:

  git remote set-url --add --push origin /tmp/foo
  git remote set-url --delete --push origin /tmp/foo

If the behavior is changed like Michael suggested, it would not leave
the config clean (unless heroic steps were taken to keep track).  But
I'm not sure that's such a bad thing.  In simple command sequences,
the results would be clean and the only behavior change is that the
initial "--add" really acts like "add" and not "replace".  But more
complex sequences could be devised which were affected by this change.

I'm curious, Junio.  Do you think the set-url behavior is correct
as-is, or that changing it will cause breakage for some workflows, or
that it complicates the operation too much for people who are already
used to the config layout?

Phil
