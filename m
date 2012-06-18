From: Phil Hord <phil.hord@gmail.com>
Subject: Re: MERGE_RR droppings
Date: Mon, 18 Jun 2012 18:41:05 -0400
Message-ID: <CABURp0os2no40BW0P-biG_fXyi7MHRcLLYWmCbLTdBv1o1OXcg@mail.gmail.com>
References: <CABURp0omkVoLrz29GeOjjoZOpN238Rm6Nu5aOKQyVxFVnPihsw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org, davvid@gmail.com
X-From: git-owner@vger.kernel.org Tue Jun 19 00:41:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SgkdX-00018p-9h
	for gcvg-git-2@plane.gmane.org; Tue, 19 Jun 2012 00:41:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753952Ab2FRWl1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Jun 2012 18:41:27 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:41125 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753094Ab2FRWl0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Jun 2012 18:41:26 -0400
Received: by yenl2 with SMTP id l2so3734190yen.19
        for <git@vger.kernel.org>; Mon, 18 Jun 2012 15:41:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :content-type;
        bh=e+aeM0JonqfFt3IFxCrdFZw/J1srRZiwY2OSiuI04nc=;
        b=YL6P81y6wH2iUcyPZQi/GoeIrQG5ZrUDJM7LvL25x864pK6/kV7ExrNwytWe3Ab1/4
         LbF6qA6OfQCoE3GZ55gV7eWLk0hi+uvu3naFmtDnWNCP2PBrsh2VAojCnwxI/5s2R5Tq
         a8NlwfsPLV04Xc8LjVRydAel/PIc/DhEb6/s4oKJqs7ITJN8A1lbmWtXwuQZG6AeNbmd
         7n3rucqRZhy8oKs/ISRqXJWJy/XV26cQjlerZSfAq0v3svOU1fAqjTnxAI6GwOfwXwdF
         fHfT5JkJlzzQdU0Ys+et5dvjggwj0Qx6U8hsQZLygn/aUcOhMZq5SjH4rshsxEqYObl9
         DvFg==
Received: by 10.236.75.40 with SMTP id y28mr20158506yhd.65.1340059285674; Mon,
 18 Jun 2012 15:41:25 -0700 (PDT)
Received: by 10.146.150.18 with HTTP; Mon, 18 Jun 2012 15:41:05 -0700 (PDT)
In-Reply-To: <CABURp0omkVoLrz29GeOjjoZOpN238Rm6Nu5aOKQyVxFVnPihsw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200178>

git mergetool decides to use rerere-remaining based on the existence
of the .git/MERGE_RR file:

    if test -e "$GIT_DIR/MERGE_RR"
    then
        files=$(git rerere remaining)
    else
        files=$(git ls-files -u | sed -e 's/^[^ ]*      //' | sort -u)
    fi

But when I disabled rerere, I still had MERGE_RR files left over in my
.git directory.   This causes git-mergetool to do the wrong thing.

I do not know if the correct fix for this is to check rerere.enabled instead.

Is MERGE_RR leaking somewhere it should have been cleaned up?  I often
see leftover MERGE_RR files even though I am certain the project is
not in the middle of a merge.

Is this a bad semaphore to check?  I do not see it being used this way
anywhere else.


Phil
