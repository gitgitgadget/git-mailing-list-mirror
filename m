From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Why not git reset --hard <path>?
Date: Mon, 28 Sep 2015 15:58:14 -0700
Message-ID: <xmqqr3lib189.fsf@gitster.mtv.corp.google.com>
References: <xmqq612ucm3p.fsf@gitster.mtv.corp.google.com>
	<20150928223607.15594.qmail@ns.horizon.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, jacob.keller@gmail.com, tytso@mit.edu
To: "George Spelvin" <linux@horizon.com>
X-From: git-owner@vger.kernel.org Tue Sep 29 00:58:24 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZghNF-0000a7-Q1
	for gcvg-git-2@plane.gmane.org; Tue, 29 Sep 2015 00:58:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753428AbbI1W6R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Sep 2015 18:58:17 -0400
Received: from mail-pa0-f45.google.com ([209.85.220.45]:34223 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753253AbbI1W6R (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Sep 2015 18:58:17 -0400
Received: by padhy16 with SMTP id hy16so186289712pad.1
        for <git@vger.kernel.org>; Mon, 28 Sep 2015 15:58:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=jErQxfYKpIfgSnIO1fww26OueG0q+z2KncvWgp9Vx4A=;
        b=B7+BLNEIc90Bit62R+10dQLdbqIfSrF9rj3lOE9FI+yFwRgxOxt0S/cOB3pnyliL48
         7F4HPAZO0SqOh1/Y18yT/R3uF8Hn5EIM4vNWFXTnYd0FkIxDHCC9v5wSRMrFRXCi6cyZ
         Dmx/CKWpNEvLCIzBaTNPagecb86eFb4wfCxzeZQQyNa/+3k0KqSZR7/SmOnHyUyqTGPi
         U8k3H3wvlCfE+6O9la9zm4z/gFnLFoOsqHlRIcQc/WG7HEMkV+K8v5hJkKgOhtb2Y3Ch
         7i69VXRdOoLTRnIV0hrDuSkNzCZqQiaol1XgvayLR7UPg7OegS9IHh8zma6LrkhQRDKH
         KX0w==
X-Received: by 10.68.69.17 with SMTP id a17mr29177706pbu.10.1443481096712;
        Mon, 28 Sep 2015 15:58:16 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:b19c:d31d:b45e:3f4e])
        by smtp.gmail.com with ESMTPSA id fa14sm21578834pac.8.2015.09.28.15.58.15
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 28 Sep 2015 15:58:15 -0700 (PDT)
In-Reply-To: <20150928223607.15594.qmail@ns.horizon.com> (George Spelvin's
	message of "28 Sep 2015 18:36:07 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278800>

"George Spelvin" <linux@horizon.com> writes:

> Junio C Hamano <gitster@pobox.com> wrote:
>> "git checkout HEAD <pathspec>" is a 99% acceptable substitute for it
>> (the only case where it makes a difference is when you added a path to
>> the index that did not exist in HEAD).
>
> Er, wait a minute...
>
> "git checkout <tree-ish> <pathspec>" modifies the index?
>
> Damn, I've been using git for years and I never knew that.

... which would be an indication that the behaviour is most likely
the most natural one.

> But I just tested, and it does.  Damn, now I have to figure out
> how to "leapfrog" a file from history into the working tree without
> overwriting the index; that's occasionally useful.

... and indeed it is useful in some rare cases.  Either

    git diff <tree-ish> <pathspec> | git apply -R

or

    git checkout <tree-ish> <pathspec> &&
    git reset <pathspec>

are what I would use, and as an old-timer, the former is what I do.
