From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 7/7] submodule: implement `module_clone` as a builtin helper
Date: Wed, 19 Aug 2015 12:08:40 -0700
Message-ID: <xmqqy4h785af.fsf@gitster.dls.corp.google.com>
References: <1439857323-21048-8-git-send-email-sbeller@google.com>
	<1439935980-30087-1-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Jens.Lehmann@web.de, hvoigt@hvoigt.net
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Wed Aug 19 21:08:56 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZS8jE-0005W4-2x
	for gcvg-git-2@plane.gmane.org; Wed, 19 Aug 2015 21:08:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751364AbbHSTIm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Aug 2015 15:08:42 -0400
Received: from mail-pd0-f169.google.com ([209.85.192.169]:33883 "EHLO
	mail-pd0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750985AbbHSTIm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Aug 2015 15:08:42 -0400
Received: by pdbfa8 with SMTP id fa8so4636096pdb.1
        for <git@vger.kernel.org>; Wed, 19 Aug 2015 12:08:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=9HTVzU2Lgdc7Ll5aPg4JVftHofZe0ZYJCcfbvI41wh4=;
        b=frjEYSmTsH7ezrKDbNlWZNaP0jOVVg+mY7rjDY5KK8Zi44UWa3IbEsabwS/iJYP2Ou
         L63mVScRuAANE1YbuemzpDHj0l0Q3FvIoJwKR54Ka4hOzGEEkraOkvLWqO6IIbm5T5Bd
         zLT1VFhdqUEBobXGYsEoLBmgoSbgNdVkQDbdvZbLO+tbsBae18jwPpOu2vNGwVuYPCvA
         2piP5jpP13cueBg8PVcpnhiMsTzaH8ukMFCcInJ59VWU/bLJKvd7+lpX5WgXEsUixNdX
         hs+aKONrKqg7AujNJmgxWQGDgRuQtmPJ62Mi+R9dEhNOXt0Ek1v+DMMuZvmGxWvLv1R7
         T9vg==
X-Received: by 10.70.51.165 with SMTP id l5mr27368420pdo.75.1440011321704;
        Wed, 19 Aug 2015 12:08:41 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:a5d7:91a5:eac5:b635])
        by smtp.gmail.com with ESMTPSA id z3sm1726367pas.19.2015.08.19.12.08.40
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 19 Aug 2015 12:08:41 -0700 (PDT)
In-Reply-To: <1439935980-30087-1-git-send-email-sbeller@google.com> (Stefan
	Beller's message of "Tue, 18 Aug 2015 15:13:00 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276214>

Stefan Beller <sbeller@google.com> writes:

> `module_clone` is part of the update command, which I want to convert
> to C next.
>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>
> This is the only patch that broke by a last minute fix,
> so this replaces the previous PATCH 7/7.

... which still breaks 7400.82, though.

Output from running it with "-i -v" ends like this:

expecting success: 
        mkdir super &&
        pwd=$(pwd) &&
        (
                cd super &&
                git init &&
                git submodule add --depth=1 file://"$pwd"/example2 submodule &&
                (
                        cd submodule &&
                        test 1 = $(git log --oneline | wc -l)
                )
        )

Initialized empty Git repository in /home/gitster/w/git.git/t/trash directory.t7400-submodule-basic/super/.git/
fatal: Clone of 'file:///home/gitster/w/git.git/t/trash directory.t7400-submodule-basic/example2' into submodule path 'submodule' failed
not ok 82 - submodule add clone shallow submodule
#
#               mkdir super &&
#               pwd=$(pwd) &&
#               (
#                       cd super &&
#                       git init &&
#                       git submodule add --depth=1 file://"$pwd"/example2 submodule &&
#                       (
#                               cd submodule &&
#                               test 1 = $(git log --oneline | wc -l)
#                       )
#               )
#
