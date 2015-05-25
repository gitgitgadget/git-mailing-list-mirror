From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Mark trailing whitespace error in del lines of diff
Date: Mon, 25 May 2015 16:27:40 -0700
Message-ID: <xmqqbnh89r0z.fsf@gitster.dls.corp.google.com>
References: <9b8e349e223dc9cd871fc5f7915e590548322932.1432585659.git.cb@256bit.org>
	<20150525222215.GI26436@vauxhall.crustytoothpaste.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Christian Brabandt <cblists@256bit.org>,
	Christian Brabandt <cb@256bit.org>, git@vger.kernel.org
To: "brian m. carlson" <sandals@crustytoothpaste.net>
X-From: git-owner@vger.kernel.org Tue May 26 01:36:38 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yx1vB-0001ZN-Je
	for gcvg-git-2@plane.gmane.org; Tue, 26 May 2015 01:36:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751005AbbEYX1n (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 May 2015 19:27:43 -0400
Received: from mail-ig0-f173.google.com ([209.85.213.173]:38644 "EHLO
	mail-ig0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750894AbbEYX1m (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 May 2015 19:27:42 -0400
Received: by igcau1 with SMTP id au1so41323255igc.1
        for <git@vger.kernel.org>; Mon, 25 May 2015 16:27:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=zeNFV9Mt1k/HQrtdN+lVhHH8eSO+bOxt81emS1PMou0=;
        b=YCpd2GD/cBM+Iw7xLVkZ9J6Nmj9pnq8o+75xR7yF2fcUOF2+WOOrGttZKVddHznvI4
         iyzOABq7T6nmJHIf+csJiyqp2K+SmRjT8zErjs2b/iFA+FJtI6Y/BSI3bC+/+QlFjBUT
         EXwm5mGVUWGDgk0BYrLkUjcmkq2OP2b4Iq79jfxPzBUFthw1igCiEtu0Hw2lATpw5YI9
         JFV4EnYfAHM/5rZ8+09GMBYJoxaMiNbTTN5bTkhh1fAZg2DQypFGpdHYIiDHx5eWJs1I
         lVFim/COC6M/BUkuhf63DcigVgGbKeJKXKTDt877IUikqJ/nawuPU6ZDxhyi6DEBH9Mx
         q+Ww==
X-Received: by 10.107.27.7 with SMTP id b7mr29670075iob.64.1432596462129;
        Mon, 25 May 2015 16:27:42 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:f93e:abc0:fe54:4a5a])
        by mx.google.com with ESMTPSA id 71sm9761724ioe.16.2015.05.25.16.27.41
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 25 May 2015 16:27:41 -0700 (PDT)
In-Reply-To: <20150525222215.GI26436@vauxhall.crustytoothpaste.net> (brian
	m. carlson's message of "Mon, 25 May 2015 22:22:16 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269915>

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> I like this idea.

I don't.

> My use case is determining whether a patch to a pristine-tar
> repository introduced trailing whitespace (which is not okay) or
> just left it there (which is okay).

In your use case, where keeping trailing blank that is otherwise not
OK is fine only when the breakage was inherited from the preimage,
wouldn't it be equally fine to keep other kinds of breakages as long
as they were inherited from the preimage?  E.g. "The original used
8-space as leading indent, and you would not use that for your new
lines, but the breakage was inherited from the preimage" would want
to be treated the same way, no?  Why trailing blanks so special?

So, from that point of view, your "use case" does not justify this
particular implementation that special-cases trailing blanks on
deleted lines and mark them [*1*].

If the implementation were addition of a new option to check and
mark all kinds of errors core.whitespace would catch for new lines
also for old lines, then it would be a somewhat different story.  I
personally do not find such an option interesting, but at least I
can understand why some people might find it useful.


[Footnote]

*1* To support your use case with the ultimate ease-of-use, it would
be best if the new option were to squelch the whitespace error on
the new line when it was inherited from the old line, which is
different from showing and marking the breakage on the old line.
But I do not think it can be implemented sanely, so I will not go
there.
