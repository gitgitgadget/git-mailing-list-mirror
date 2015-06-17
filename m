From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] t3404: demonstrate CHERRY_PICK_HEAD bug
Date: Wed, 17 Jun 2015 10:33:39 -0700
Message-ID: <xmqqtwu66xzg.fsf@gitster.dls.corp.google.com>
References: <20150616140612.Horde.a1irZQmh2o42SqDfxAytHg1@webmail.informatik.kit.edu>
	<cover.1434528725.git.johannes.schindelin@gmx.de>
	<f76ca5d0b6687a4d2ee4f587d8ba75a643a33c04.1434528725.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, szeder@ira.uka.de
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Jun 17 19:33:48 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z5HDe-00024R-Rs
	for gcvg-git-2@plane.gmane.org; Wed, 17 Jun 2015 19:33:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756499AbbFQRdn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Jun 2015 13:33:43 -0400
Received: from mail-ig0-f179.google.com ([209.85.213.179]:34896 "EHLO
	mail-ig0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753980AbbFQRdm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Jun 2015 13:33:42 -0400
Received: by igbzc4 with SMTP id zc4so108675244igb.0
        for <git@vger.kernel.org>; Wed, 17 Jun 2015 10:33:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=g5DYvvvl3PWpqAFX0coCAdorMhygTnpCpy42K9LTDGo=;
        b=W/CddRdnVGefpzeX4sXZJv1QqYosOiNNGH+3Y7wUbPxTsZiX+h5aJkPFQH9xgOJ+qM
         Dwb0sw+bu3G1zMeKMz4dbhgAjEn3vg9gKjnqpQH0wxjf7AnN5iMfO4kx303XiyOzJfys
         GRHUi0Q8RdxeEj9baq39IERK/tCcPdKdxolatki7JlknMIsrydMknwkyCVf9HYp6e+l6
         2YdpwYM3tqd4T9wAGKNiXtLwYOJLzOoD801/NqrRSj6vQx5Ca3sivOf+UY+bgt0vkng6
         23dEOlXkFwwesYazSAe5xsEviY3LAEgq7PMbeRr2E0RZiNuhcPYKM96E26V7vrMaVm26
         EMIg==
X-Received: by 10.43.171.70 with SMTP id nt6mr1398085icc.73.1434562421355;
        Wed, 17 Jun 2015 10:33:41 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:a4d4:8fab:953e:ec65])
        by mx.google.com with ESMTPSA id i4sm12478957igm.2.2015.06.17.10.33.40
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 17 Jun 2015 10:33:40 -0700 (PDT)
In-Reply-To: <f76ca5d0b6687a4d2ee4f587d8ba75a643a33c04.1434528725.git.johannes.schindelin@gmx.de>
	(Johannes Schindelin's message of "Wed, 17 Jun 2015 10:16:08 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271876>

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> +test_expect_failure 'rebase --continue removes CHERRY_PICK_HEAD' '
> +	git checkout -b commit-to-skip &&
> +	for double in X 3 1
> +	do
> +		seq 5 | sed "s/$double/&&/" >seq &&
> +		git add seq &&
> +		test_tick &&
> +		git commit -m seq-$double
> +	done &&
> +	git tag seq-onto &&
> +	git reset --hard HEAD~2 &&
> +	git cherry-pick seq-onto &&
> +	test_must_fail git rebase -i seq-onto &&

Shouldn't this explicitly specify what fake editor is to be used,
instead of relying on whatever the last test happened to have used?

I thought this deserved to go to older maintenance track, but the
fake editor that was used last are different between branches, so
"rebase -i" fails for a wrong reason (i.e. cannot spawn the editor)
when queued on say maint-2.2.

> +	test -d .git/rebase-merge &&
> +	git rebase --continue &&
> +	git diff seq-onto &&

I am puzzled with this "diff"; what is this about?  Is it a remnant
from an earlier debugging session, or is it making sure seq-onto is
a valid tree-ish?

> +	test ! -d .git/rebase-merge &&
> +	test ! -f .git/CHERRY_PICK_HEAD
> +'
> +
>  test_done

Thanks.
