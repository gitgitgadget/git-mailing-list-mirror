From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 14/14] pull --rebase: error on no merge candidate cases
Date: Tue, 19 May 2015 09:27:01 -0700
Message-ID: <xmqqoalg8re2.fsf@gitster.dls.corp.google.com>
References: <1431961571-20370-1-git-send-email-pyokagan@gmail.com>
	<1431961571-20370-15-git-send-email-pyokagan@gmail.com>
	<CAGZ79kbhA2+AJ1Vtz6khX5uEBCCUBUuXhpBezZApZsC_txhewA@mail.gmail.com>
	<5fcd2fa185fab4c64939ad09eb10e6d5@www.dscho.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Stefan Beller <sbeller@google.com>, Paul Tan <pyokagan@gmail.com>,
	git@vger.kernel.org, Stephen Robin <stephen.robin@gmail.com>
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue May 19 18:27:42 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YukMG-0007qA-Tk
	for gcvg-git-2@plane.gmane.org; Tue, 19 May 2015 18:27:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751751AbbESQ1F (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 May 2015 12:27:05 -0400
Received: from mail-ig0-f170.google.com ([209.85.213.170]:36243 "EHLO
	mail-ig0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751528AbbESQ1D (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 May 2015 12:27:03 -0400
Received: by igbpi8 with SMTP id pi8so80137375igb.1
        for <git@vger.kernel.org>; Tue, 19 May 2015 09:27:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=irfdWkrnQXS/WNYsPJQ1A7JtQuYoyWe4HAkGgSenHw0=;
        b=EeNGpUQ6//yBmkjT+kIlYngc/SHeh0NstzNUFdo1mRburPm2lz6r/v/o4SOZtifhjW
         fFDD8kvREU9oLL3ILatpp3nyu52Qg0FYNMFd0XPYsTcui3AiC8001oePBQKY2LsqskMR
         YEgrsmTFdgZj4lONNwx8vTIUIkm+0UY43tKxeqFCDDx6C4V39VyW9db3pzXF9k+9setS
         kR4huWtuLcmo3oFh1AQsY151JbTaJ346NB9fXlqJ5Nc6WfO6c4Q/r5E6rQsH2ZfzIzlf
         ZTTrp0MuqjxWiYgB2cu+0Nj1+BWt+lnS6cA51WuEINBSobaMTrcXKbhOtTppP/R0oOJ3
         LnRA==
X-Received: by 10.43.39.208 with SMTP id tn16mr40742094icb.27.1432052822851;
        Tue, 19 May 2015 09:27:02 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:799e:649b:b86b:7c03])
        by mx.google.com with ESMTPSA id pg7sm8178728igb.6.2015.05.19.09.27.02
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 19 May 2015 09:27:02 -0700 (PDT)
In-Reply-To: <5fcd2fa185fab4c64939ad09eb10e6d5@www.dscho.org> (Johannes
	Schindelin's message of "Tue, 19 May 2015 15:10:51 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269370>

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

>>> -               fprintf(stderr,
>>> -                       _("There are no candidates for merging among the refs that you just fetched.\n"
>>> -                       "Generally this means that you provided a wildcard refspec which had no\n"
>>> -                       "matches on the remote end.\n"));
>>> +               if (opt_rebase)
>>> +                       fputs(_("There is no candidate for rebasing against among the refs that you just fetched."), stderr);
>> 
>     The puts() function appends a <newline> while fputs() does not.

Yup, so this update makes the command spew unterminated lines, which
not something intended...
