From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: gitignore design
Date: Sat, 30 Jul 2011 10:10:16 +0700
Message-ID: <CACsJy8CurvKd_=hdRQyjjzWLvKF0jbWOQhbLSsmk1BqB_dK3og@mail.gmail.com>
References: <1311934832699-6632987.post@n2.nabble.com> <m3pqktql6s.fsf@localhost.localdomain>
 <4E32B637.1030201@viscovery.net> <201107292339.51753.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	llucianf <llucianf@gmail.com>, git@vger.kernel.org,
	Ferry Huberts <mailings@hupie.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jul 30 05:10:54 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qmzwz-0004HW-Ni
	for gcvg-git-2@lo.gmane.org; Sat, 30 Jul 2011 05:10:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752854Ab1G3DKs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Jul 2011 23:10:48 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:37285 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752588Ab1G3DKr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Jul 2011 23:10:47 -0400
Received: by fxh19 with SMTP id 19so2812176fxh.19
        for <git@vger.kernel.org>; Fri, 29 Jul 2011 20:10:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=NpLoRtenQ8IsdI3k/h82Sp/ZBw1IvnQcI0oZiKvjYhM=;
        b=XzZwgEfEi0vgEGt/m20ri5KR3F6VDUPXl+d4JjVdxvyTMMFLFnKLPDa+I1LweIZHXD
         KJkFrPexHkAj+VfmqF9X+h5K0m/JkKaiB+c0LKk64ygKSax2D5WZoQzzk2YxK1r5GvmY
         MCpLsRE5HKQN1CQd4YpA4iW/hovnYtHfcD+6g=
Received: by 10.204.131.213 with SMTP id y21mr555964bks.88.1311995446517; Fri,
 29 Jul 2011 20:10:46 -0700 (PDT)
Received: by 10.204.121.142 with HTTP; Fri, 29 Jul 2011 20:10:16 -0700 (PDT)
In-Reply-To: <201107292339.51753.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178174>

2011/7/30 Jakub Narebski <jnareb@gmail.com>
> True, it is *assume-unchanged*, not ignore-changes bit; though the latter
> would be also possible to implement, I think... but having some file not
> changing and marking it as such for better performance is saner use case
> than tracking some file but not really tracking it.

If you just want to ignore some files (or paths), then adding
--exclude option to diff machinery may be a better option.
--assume-unchanged is too low-level, and not really convenient to use.

> > No code reference, sorry, because I'm just parrotting what I've read
> > elsewhere on the list, for example,
> > http://thread.gmane.org/gmane.comp.version-control.git/146082/focus=146353
>
> Well, there is hint that there might be problems, but not really says
> that they are, and where (if one is lying about assume unchanged by changing
> assume-unchanged file).

There were problems in the past. See aecda37 (do not overwrite files
marked "assume unchanged" - 2010-05-01)

The only place that relies on checking files uptodate (which can be
faked by assume-unchanged bit) before overwriting them is
unpack-trees.c, verify_update_1(). With that fix in place, I think
assume-unchanged bit is safe now. However, as long as we don't
explicitly state that we will not carelessly overwrite
assume-unchanged files, there are still chances that some
optimizations in future may make it dangerous again.
--
Duy
