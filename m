From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] clone: add `--seed` shorthand
Date: Sun, 24 May 2015 12:07:53 -0700
Message-ID: <xmqqtwv1bxpy.fsf@gitster.dls.corp.google.com>
References: <20150521041435.GA18978@peff.net> <20150521041619.GC5196@peff.net>
	<8895881cd3f324d2b8a827e311296a48@www.dscho.org>
	<3516DC60279A42188EE2AA394921FC70@PhilipOakley>
	<1be7702fa53d1705e913aff2e00eac21@www.dscho.org>
	<20150522064922.GA27716@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Philip Oakley <philipoakley@iee.org>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun May 24 21:08:05 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YwbFi-0000Pq-G7
	for gcvg-git-2@plane.gmane.org; Sun, 24 May 2015 21:08:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751275AbbEXTH5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 May 2015 15:07:57 -0400
Received: from mail-ig0-f174.google.com ([209.85.213.174]:36068 "EHLO
	mail-ig0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751267AbbEXTH4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 May 2015 15:07:56 -0400
Received: by igbpi8 with SMTP id pi8so23457385igb.1
        for <git@vger.kernel.org>; Sun, 24 May 2015 12:07:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=6ZZc4dIkrAfSadvKMADPGpREyIgeYO6IKwPkzdkqTSU=;
        b=xPcCS/fnqpZr6x9KoXuQ+ZLJWOUN+LH2h9rpDgCv0c+ld4LyxX1r5lgjVjDOljLYSM
         WfuUEIxNQ+tRqA02W1pjLcNNoF/jm7sf+oBJ5FYk+mjJ+9sEGE4QpM+aYZdHOruyRmBS
         DCToEvsqUSGckxf73gdIk9mY4LNUUdhxklpjMRIBmm+xSj3P6R4y575q0rKD70qXDLTP
         CN75L6i/TJ921VJkgKLNQaLnUcGB1Guc/BImNId1jCm8qPbfTRmlquG1E6Q66eEYV/gy
         ZjElxxgByyzQOj+vDEKAgVzOT8JLBL0toVGomGZS3Pgc54T0J1w8/7PGENloV4nfTUIc
         dD4g==
X-Received: by 10.50.33.19 with SMTP id n19mr19051857igi.8.1432494475712;
        Sun, 24 May 2015 12:07:55 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:45f7:b54f:6e94:918d])
        by mx.google.com with ESMTPSA id f7sm4320447igq.7.2015.05.24.12.07.53
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sun, 24 May 2015 12:07:54 -0700 (PDT)
In-Reply-To: <20150522064922.GA27716@peff.net> (Jeff King's message of "Fri,
	22 May 2015 02:49:23 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269831>

Jeff King <peff@peff.net> writes:

> Having slept on it, I really think "--seed" should be "fetch from the
> seed into temp refs", and not what I posted earlier.

Yeah, I think that is the right way to do it.

And it happens to mesh well with the (not so well advertised but not
so well hidden) plan to allow loaded server side to advise --seed
from bundle hosted elsewhere, e.g.

     * "clone" connects to upload-pack

     * upload-pack advertises --seed=http://cdn.github.com/project.bundle
       via capability

     * "clone" disconnects from upload-pack, and runs (resumable)
       wget to the seed to grab bundle.

     * "clone" then fetches refs/*:refs/remotes/origin/* from the bundle

     * "clone" then continues to fetch into +refs/remotes/origin/* as
       usual, but does an equivalent of using --prune for this fetch
       to drop anything extra/stale that the seed bundle may have
       had.

     * optionally "clone" can immediately "repack".

... which I wanted to see happen in a near future.

And that --seed thing that can name a local bundle file is a very
good first step toward the direction, I think.

Thanks.
