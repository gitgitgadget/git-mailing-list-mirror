From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Mark trailing whitespace error in del lines of diff
Date: Mon, 25 May 2015 17:24:12 -0700
Message-ID: <xmqq617g9oer.fsf@gitster.dls.corp.google.com>
References: <9b8e349e223dc9cd871fc5f7915e590548322932.1432585659.git.cb@256bit.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Christian Brabandt <cb@256bit.org>, git@vger.kernel.org
To: Christian Brabandt <cblists@256bit.org>
X-From: git-owner@vger.kernel.org Tue May 26 02:24:21 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yx2fN-0003MX-5r
	for gcvg-git-2@plane.gmane.org; Tue, 26 May 2015 02:24:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751110AbbEZAYP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 May 2015 20:24:15 -0400
Received: from mail-ig0-f175.google.com ([209.85.213.175]:32991 "EHLO
	mail-ig0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751061AbbEZAYO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 May 2015 20:24:14 -0400
Received: by igbpi8 with SMTP id pi8so47065697igb.0
        for <git@vger.kernel.org>; Mon, 25 May 2015 17:24:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=4nywUIGxEUsG6SUZebJ5aIP//QQM8lD3TMnQBPpvnTQ=;
        b=OeGL27N+gB1p5gclUFmb0dXB5JtS3b0S2mOfVAo92TRIDKdkKp5pmejLpSBtDJR4uU
         NbmlnhBAS5LqeG62MBRHD38jnRjJEu2Oexc+odofVzXYSB00ZbW1IB6FBk9/UykI1Qct
         7cBovY1Gp/uKAmiwu/3UtJlMtQ8PNt56KfIMoU/PjpJNntwA/wZVZjvLyDdZIxGzxDyv
         3G8S/3eRmUArdrmgM50y9xIUVDQ/+lw73MrvF8PX9Rlh1h73vBr1D5Xl+/LP21LAJ4vq
         c5NuR9+S+ZA/+rZ5sfWrROIoPGJTnTMy6w0ZQfKmizJe/g5lzEH7Fkgfb/cdyAUhR28d
         g8Nw==
X-Received: by 10.42.238.14 with SMTP id kq14mr22292603icb.23.1432599853661;
        Mon, 25 May 2015 17:24:13 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:f93e:abc0:fe54:4a5a])
        by mx.google.com with ESMTPSA id f126sm9859541ioe.21.2015.05.25.17.24.12
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 25 May 2015 17:24:13 -0700 (PDT)
In-Reply-To: <9b8e349e223dc9cd871fc5f7915e590548322932.1432585659.git.cb@256bit.org>
	(Christian Brabandt's message of "Mon, 25 May 2015 23:11:34 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269917>

Christian Brabandt <cblists@256bit.org>, Christian Brabandt
<cb@256bit.org> writes:

> As far as I can see, this does not break any tests and also the 
> behaviour of git-diff --check does not change. 

Even if this change introduced a bug that changed the behaviour
(e.g. say, exited with failure status code when only preimage had
errors), I wouldn't be surprised if no existing test caught such a
breakage.  Because the existing tests were written with the
assumption that the code to check whitespace breakages would never
look at preimage, it is plausible that no preimage line used in the
test has any whitespace error in the first place.

In other words, you'd need to add new tests that change preimage
lines with various kinds of whitespace errors into postimage lines
with and without whitespace errors, and run "diff" with various
combinations of the existing set of core.whitespace values as well
as your new one.

But as I said in the other message, I think that the approach this
patch takes goes in a wrong direction.  Instead of adding a single
"check and highlight this and only kind of breakage on preimage"
option as a new kind to existing "what kind of use of whitespaces
are errors" set, it would be more sensible to add a single "check
and highlight breakages on preimage lines as well" option that is
orthogonal to the existing ones that specify "what kind of use of
whitespaces are errors".
