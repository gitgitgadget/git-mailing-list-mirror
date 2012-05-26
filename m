From: Andy Kitchen <kitchen.andy@gmail.com>
Subject: Re: git rebase -f --autosquash
Date: Sat, 26 May 2012 17:30:21 +1000
Message-ID: <33DF11B90FEF4CB6B4103BE0AAF9B256@gmail.com>
References: <D7BE2BACB49749DB9FC37D4ACCCD008B@gmail.com>
 <1336820755.3002.11.camel@centaur.lab.cmartin.tk>
 <7vipfyiuv6.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	=?utf-8?Q?Carlos_Mart=C3=ADn_Nieto?= <cmn@elego.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 26 09:30:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SYBSL-00026c-9R
	for gcvg-git-2@plane.gmane.org; Sat, 26 May 2012 09:30:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751327Ab2EZHa2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 May 2012 03:30:28 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:37299 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750886Ab2EZHa1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 May 2012 03:30:27 -0400
Received: by dady13 with SMTP id y13so2131940dad.19
        for <git@vger.kernel.org>; Sat, 26 May 2012 00:30:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject:x-mailer
         :mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=6XiA7fm16A7g27G0RmYV7BHG51/k8F3vn2WKr5OJkBI=;
        b=1DerjhAad2g/1O3MdfCoBNFC+18bvb4A3g6xz+un10DuvvN7biUd/CHMRDGlqn9/VO
         RLT1nL6JWuhIVjCeFiU1ZKOU9EKGSyag8NPOlEm6YX8QFCqrIRzD0m4soqlA4jsDSRqL
         kn5/shoxg5JrKEh9dG3asXFgJkapV/GPO255/67zKYSpB0i1d+kPx/bgLTmNL/NCesLl
         +uLk/gF5vT2KK/lV7ARPalnO9y2BZQbMPs/cs01ZvlzkyIyDeLzHUgZBQDdUwADJPY98
         0Afdceq9n2mo6dmYmd6gVvUU1tsHayvOaHcGL+1/DjQ63TnGC/cn9tVHoNeM58b9zB6v
         UhVQ==
Received: by 10.68.197.166 with SMTP id iv6mr5369330pbc.40.1338017426295;
        Sat, 26 May 2012 00:30:26 -0700 (PDT)
Received: from iceman.local (220-244-228-34.static.tpgi.com.au. [220.244.228.34])
        by mx.google.com with ESMTPS id qt8sm11714248pbb.32.2012.05.26.00.30.23
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 26 May 2012 00:30:25 -0700 (PDT)
In-Reply-To: <7vipfyiuv6.fsf@alter.siamese.dyndns.org>
X-Mailer: sparrow 1.5 (build 1043.1)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198542>

On Tuesday, 15 May 2012 at 2:35 AM, Junio C Hamano wrote:
> Given "EDITOR=: git commit args..." and "EDITOR=: git merge args..." are
> equivalent to giving "--no-edit" option to these commands, I would imagine
> "git rebase opts... --no-editor args..." would not be such a stretch.

I agree. However, I think it would be more intuitive to make --autosquash
work with -f or even just on its own in non-interactive mode.
It definitely makes sense practically and semantically to autosquash
non-interactively. Otherwise one needs to activate interactive mode
and effectively disable it in the same command which is a bit esoteric.

I am of the opinion that autosquashing is such a useful feature,
it's even worth having a separate command:

$ git fix

For generally rebuilding commits based on directives
placed in commit messages. Especially because it integrates
nicely with `git commit --fixup' as a kind of super amend. While
this can be easily added with a bit of customisation, I think
that it is generally applicable and useful enough to warrant being
a default part of git.

In summary, I propose:

1a)

$ git rebase -f --autosquash <base>
is made to be effectively equivalent to:
$ EDITOR=: git rebase -i --autosquash <base>

1b)

$ git rebase --autosquash <base>
(i.e. -f is implicit) is made to be effectively equivalent to:
$ EDITOR=: git rebase -i --autosquash <base>



3) A new command is created, for example one of:

$ git fix
$ git squash
$ git autosquash

For preening commits before pushing them upstream.

The default base for these operations would be HEAD@{upstream}

A config option could also be added to warn the user before pushing
commits with messages of the form /^fixup!/ etc.

It could also be less ad-hoc in its operation than --autosquash
currently is. For example, `git commit --fixup' could note the intended
target for the fix allowing `git fix' to operate correctly even when two
commits share the same message.




Of course as with any polite feature request, I am happy to write the
appropriate code, however not being familiar with the git code-base,
I would require some guidance.


Thank you for your time, suggestions welcomed

AK
