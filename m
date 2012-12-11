From: Zoltan Klinger <zoltan.klinger@gmail.com>
Subject: Re: [PATCH] git-clean: Display more accurate delete messages
Date: Tue, 11 Dec 2012 23:32:31 +1100
Message-ID: <CAKJhZwTEykP_w7-02YNUmi8D=X7nD8wSyFBD0_uGE6E760zkNQ@mail.gmail.com>
References: <1354788938-26804-1-git-send-email-zoltan.klinger@gmail.com>
	<7v8v9bjd44.fsf@alter.siamese.dyndns.org>
	<7d290bdc-8654-4526-ba73-89408fa99a16@DB3EHSMHS002.ehs.local>
	<CAKJhZwROXsTa4wu-C9rhfGysetL+cZRDECyFUn5VTb833pWzMQ@mail.gmail.com>
	<7v38zecrqc.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Soren Brinkmann <soren.brinkmann@xilinx.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 11 13:32:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TiP10-0000i8-53
	for gcvg-git-2@plane.gmane.org; Tue, 11 Dec 2012 13:32:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753052Ab2LKMcd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Dec 2012 07:32:33 -0500
Received: from mail-ia0-f174.google.com ([209.85.210.174]:49435 "EHLO
	mail-ia0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752525Ab2LKMcc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Dec 2012 07:32:32 -0500
Received: by mail-ia0-f174.google.com with SMTP id y25so6385480iay.19
        for <git@vger.kernel.org>; Tue, 11 Dec 2012 04:32:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=wxPITwsqySHAqTUmMui8JWgd8U2Ww+iTjsL1FHe0eTo=;
        b=yhbJz+/YppREboRsbjgHK6Ev8v5j9JC5gN7fHwnlfi46yc96/2B+VQK8AoHGM28V/Z
         perl0kgN7Jj4bnizeaLTLJ/MLaIKb/9RCCs/IgQ2VPwlKZ+Ln46BY4WsvJ9RWRNVjM0p
         AJjLt26U93vO8EFSmQwja52p3gOBRmQuWPnV+FG2+BXmPFqG4v3Idvg+Z2vLA+bIUnv3
         oqDUjHDueyoC2ImdEGk58z2ZSQG6WDUeSk58Vup/5slHrTITPRhoNQAEIQUtSvtRxk7O
         YOiPuP5IONVtIIiESeBj2FhihUC74ffMuSLbXqGUnmbKpv/Jc3we/JiT1YOu/i3kEOBu
         SfAQ==
Received: by 10.43.49.199 with SMTP id vb7mr13884788icb.6.1355229151784; Tue,
 11 Dec 2012 04:32:31 -0800 (PST)
Received: by 10.64.126.138 with HTTP; Tue, 11 Dec 2012 04:32:31 -0800 (PST)
In-Reply-To: <7v38zecrqc.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211287>

>> Use git clean --force --force to delete all untracked git repositories
>
> But I am not sure if this is ever sane.  Especially the one that
> removes an embedded repository is suspicious.  "git clean" should
> not ever touch it with or without --superforce or any other command.

My original intention with this patch was to provide more accurate
delete messages for the git-clean command when it's used with the
current set of command line options. I didn't know that --force
--force was so controversial.

The --force --force option has been around since v1.6.4.2. Commit
a0f4afbe introduced it. If the consensus is that it is not a sane
option to have let's remove it by all means. But I think it should be
done in a separate patch '[PATCH] git-clean: Never delete any embedded
git repository' or such.

> I do not think trying to remove something that cannot be removed due
> to filesystem permissions is sensible, either. We simply should treat
> such a case a grave error and have the user sort things out, instead
> of blindly attempt to "chmod" them ourselves (which may still fail).

But this is not how git-clean works with or without the --force
--force flag. The recursive delete does the right thing: it tries to
delete a file or directory, if that fails for whatever reason it will
report the error and move on. That's it. No "chmod" or any other
hackery at all. The --force --force flag only means "if during
recursion you encounter an embedded git directory that is not tracked
you are allowed to recurse into it and keep on deleting files and
sub-directories as per usual".

Cheers,
Zoltan
