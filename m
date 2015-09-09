From: Junio C Hamano <gitster@pobox.com>
Subject: Re: fatal: ambiguous argument 'HEAD^': unknown revision or path not in the working tree.
Date: Wed, 09 Sep 2015 09:24:49 -0700
Message-ID: <xmqq7fnz7e7i.fsf@gitster.mtv.corp.google.com>
References: <loom.20101028T150254-457@post.gmane.org>
	<1441787643787-7639207.post@n2.nabble.com>
	<20150909092042.GC21892@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: davilda_ <vattolou@jam-difus.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Sep 09 18:25:17 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZZiBJ-0004HR-QC
	for gcvg-git-2@plane.gmane.org; Wed, 09 Sep 2015 18:25:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752283AbbIIQYw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Sep 2015 12:24:52 -0400
Received: from mail-pa0-f52.google.com ([209.85.220.52]:33557 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751443AbbIIQYv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Sep 2015 12:24:51 -0400
Received: by pacex6 with SMTP id ex6so14760955pac.0
        for <git@vger.kernel.org>; Wed, 09 Sep 2015 09:24:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=fGmZYm5kFafSs6i+E7Z2rb+DPlseplbFFaoza7NqQL8=;
        b=pPXnESkiXWz0EesBrjPBEk0QT/kGTNBPlo5bViYWaE8QDxacVym314HsnPgqudbaLs
         Qeo2fan1VlwkTILR3KAxb6FFH/5ow8Yeae+KTEqlzxwo17ES080QpJeZa6/ypP4WSaj0
         55WtlRPU1+TCcPwlUCUEPI5wky3+X+sex2C76b7S44v6gQxhTRJvX03Kaq55mkUj+9zf
         GZG0WRYAJQb3UqhgqD7B0uKu4v9qmEmg1ax7OL3/ZZCgd07sbk49yHXikqmYQPTvZ29F
         CwuGuI27sI9w01v3BoF37XKYPIuFT4/EFx5XmvacKpE96oDM6xqfirqmgdNbHX0wjGOB
         5QYA==
X-Received: by 10.68.104.98 with SMTP id gd2mr73192191pbb.130.1441815890872;
        Wed, 09 Sep 2015 09:24:50 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:31c8:2790:408d:8446])
        by smtp.gmail.com with ESMTPSA id vv2sm7555884pab.21.2015.09.09.09.24.49
        (version=TLS1_2 cipher=AES128-SHA256 bits=128/128);
        Wed, 09 Sep 2015 09:24:50 -0700 (PDT)
In-Reply-To: <20150909092042.GC21892@sigill.intra.peff.net> (Jeff King's
	message of "Wed, 9 Sep 2015 05:20:42 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277557>

Jeff King <peff@peff.net> writes:

> The "simplest" way to do that is:
>
>   rm .git/refs/heads/master
>
> but that is not guaranteed to work in future versions of git, and I
> wouldn't recommend it in general.

Yeah, "git checkout -b" has a stronger sibling "git checkout -B"
(i.e. I know that the named branch already exists, so this is not a
request to create a new one, but to repoint that existing one), but
there is no analogue for "git checkout --orphan".  That could be
worked around with something like this though:

    $ git checkout --orphan hu
    $ git branch -D master
    $ git checkout --orphan master

As I agree with your "amending is better", I do not think allowing
an easier access to such a feature is urgent or important, though.

> Probably a better workflow is to create the commit state you _do_ want
> (change files, "git add" them, etc), and then run "git commit --amend"
> to replace the bad commit.
