From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 5/5] pathspec: record labels
Date: Mon, 16 May 2016 10:55:56 -0700
Message-ID: <CAGZ79kbHW+qzQjoVu9gRYC0FBqpkq5bPPLU3=BdEFKeGc=U6sA@mail.gmail.com>
References: <20160513231326.8994-1-sbeller@google.com>
	<20160513231326.8994-6-sbeller@google.com>
	<xmqqk2iw78aq.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Duy Nguyen <pclouds@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 16 19:56:04 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b2MkM-0000vb-Bl
	for gcvg-git-2@plane.gmane.org; Mon, 16 May 2016 19:56:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754482AbcEPRz6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 May 2016 13:55:58 -0400
Received: from mail-io0-f177.google.com ([209.85.223.177]:36802 "EHLO
	mail-io0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754398AbcEPRz5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 May 2016 13:55:57 -0400
Received: by mail-io0-f177.google.com with SMTP id i75so214129480ioa.3
        for <git@vger.kernel.org>; Mon, 16 May 2016 10:55:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=ed5NmKo1E30gmN2tLhjjcjUcYNnrNrsNqBJdeQPmOaU=;
        b=eexMV5PM4Ro+aoibGK/rN6VW+xnlwbnyyoOv4mRL5UE/fWoR+71RlX38NbRxpRM/9g
         qssXtOYxCqa64RmsSFaGcvg3vrxrg26yIUxIKsotcUiBStio4qnnUHDpweSnYPKpFSFf
         QbrDMR8KjRXzck6Zm3i3AdlXcBSO/AwXTVQsfu23t3xLcX5ztGG5MXFktQQ39nTo7W9z
         tx7/UX/CXR8wjwhE8na5JbWP9wa4L4XQ4/IUIanECVx1UrLJUE/ZYX2+QWKcuupFOmGZ
         jJADKFqxyuaMjfwX1uzA5p5pmGMGrkSz2A5I5nMGngCYkwVU4PMfcjEbZXelaI467LYG
         rc7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=ed5NmKo1E30gmN2tLhjjcjUcYNnrNrsNqBJdeQPmOaU=;
        b=Ng0m1jIYEgTMg5xB6P4YsY+brg7IHOpri4Fc9wXK7NXRn+gv2KXbFNegbIUZOKQ+o1
         0y9avk2MrabCbq3C1Y1VGjWjDUYgNafOqw6ReKjC8VlRclnTA7aD684zrrUmx47b1GVO
         btr9hCoItV0wH2n0g5HDGUruAAwdQHGecx7cmnm9kxK1KOL3/oWBFTxM7nQ9D0If+DHj
         pD26bZCrZiyxK5oKPJxTWkPRsly99VO2xq1RE4T+RswydRfhQiip1cZZFCfhCTyOXHe+
         drt6qkoKv8phiY/KjmuGJiMK3dL6NQFjNwn8RjKXmz89dv4yPvyI+Iu/ntGrn5FNhtPz
         GP5A==
X-Gm-Message-State: AOPr4FVCeKJl7nZZ/G+fQGuUMou7mnQFTFNTbe95/MzrwEtCJNNz2iYHWMpdCBmQb7cF94jFdLkPH/EARpVij5fd
X-Received: by 10.107.173.3 with SMTP id w3mr8271031ioe.110.1463421356511;
 Mon, 16 May 2016 10:55:56 -0700 (PDT)
Received: by 10.107.2.3 with HTTP; Mon, 16 May 2016 10:55:56 -0700 (PDT)
In-Reply-To: <xmqqk2iw78aq.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294764>

> I am NOT suggesting to make this enhancement in the prototype to
> allow us experiment with submodule selection use case, but this is
> an obvious place to allow
>
>         :(label=A B):(label=C D)
>
> to mean ((A & B) | (C & D)) by making item->labels an array of set
> of labels.

This is what already works with the series. Or rather:

    ":(label=A B)" ":(label=C D)"

works as you would expect for (A&B) | (C&D).

So I am a bit hesitant to replace the string list by an array
of stringlists or such, as the future enhancement can also do that?

The enhancement may bring in more expressions into the label string,
so it may even parse that string into a tree for Lexicographical order
instead of just using an array of lists.

>
> And no, I do not think arbitrary boolean expression is too complex
> to understand to the end-users, especially if we have to stay within
> the pathspec magic syntax.  And my gut feeling is that it is not
> worth it to support anything more complex than "OR of these ANDed
> ones".
>
>> +                     string_list_split(item->labels, sb.buf, ' ', -1);
>> +                     string_list_remove_empty_items(item->labels, 0);
>> +                     strbuf_release(&sb);
>> +                     continue;
>
> The data structure to record the "required labels" is shared
> knowledge between this function and the has_all_labels() and nobody
> else knows it is done with string_list, so I think this is a good
> balance between expediency and future optimization possibilities (I
> am anticipating that linear search of string list would be found as
> performance bottleneck).
>
