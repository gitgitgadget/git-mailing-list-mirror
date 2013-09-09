From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3] Teach git to change to a given directory using -C option
Date: Mon, 9 Sep 2013 01:01:33 -0400
Message-ID: <CAPig+cTNeqNhGwD-EZ3uszh5vJ4JeJ6L0RXdTsveb1FgXE5t3Q@mail.gmail.com>
References: <20130903115944.GA29542@gmail.com>
	<xmqq8uzdplqv.fsf@gitster.dls.corp.google.com>
	<CAEY4ZpN4xgt+gJSVeTfDNC--xt3N+M7vVLFBC7FTWBQtjvN8tw@mail.gmail.com>
	<20130904122020.GA25538@gmail.com>
	<CAPig+cRt9o=6Amhx6qTkzfk5R9aQfRZ=357BOVELm_hPsWE3WQ@mail.gmail.com>
	<CAEY4ZpNEae1UprRcpC8XUPP4XBQ89bDXP1A7yVcFdW405HZr0w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
	Jeff King <peff@peff.net>, Jonathan Nieder <jrnieder@gmail.com>
To: Nazri Ramliy <ayiehere@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 09 07:01:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VItbX-0003uy-Ds
	for gcvg-git-2@plane.gmane.org; Mon, 09 Sep 2013 07:01:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751992Ab3IIFBf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Sep 2013 01:01:35 -0400
Received: from mail-la0-f41.google.com ([209.85.215.41]:65043 "EHLO
	mail-la0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751916Ab3IIFBe (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Sep 2013 01:01:34 -0400
Received: by mail-la0-f41.google.com with SMTP id ec20so4592314lab.0
        for <git@vger.kernel.org>; Sun, 08 Sep 2013 22:01:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=hv0T4awF+pHPv9ezeiO7kXT6N3CoSakuP5EDFs7Q6jI=;
        b=V9zk+WkQ0xTLklTg4QoAK3mRMoj3wk8O7DQbtuJxpcQnq4VgRkhuVZDLbWxe3oXyHR
         o2TZJA3OxcRfsL751j6BkKDbwVPY/II7ZPHKFX7vmOTXEcCjerA3MPVEM4s1mkCH7rbG
         5PaR3TJtlofKTI3M3vAxeScrP9wWSYfG9daniVakuH+Vfj+8FlJzubcVXjLanEUlETVb
         9KLt05Z98F0s1uSu/fE9egRljxR9ztP6eccTLR8if0VV5m7aHR9wFAvHRjRC7QCMx+rZ
         SzWBCRGx8SfKjQIKXnZR3DPpkdFlHnrCFkxgFZte97RjCJhO7Gjt1uKPr0ZQ1YHc+hl2
         93iQ==
X-Received: by 10.152.30.74 with SMTP id q10mr393040lah.27.1378702893271; Sun,
 08 Sep 2013 22:01:33 -0700 (PDT)
Received: by 10.114.182.236 with HTTP; Sun, 8 Sep 2013 22:01:33 -0700 (PDT)
In-Reply-To: <CAEY4ZpNEae1UprRcpC8XUPP4XBQ89bDXP1A7yVcFdW405HZr0w@mail.gmail.com>
X-Google-Sender-Auth: bAwDXVCVJn74jvReEt5YlEgrcYc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234308>

On Sun, Sep 8, 2013 at 9:49 PM, Nazri Ramliy <ayiehere@gmail.com> wrote:
> On Sun, Sep 8, 2013 at 6:32 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
>>> +This option affects options that expect path name like --git-dir and
>>> +--work-tree in that their interpretations of the path names would be
>>> +made relative to the working directory caused by the -C option. For
>>> +example the following invocations are equivalent:
>>> +
>>> +    git --git-dir=a.git --work-tree=b -C c status
>>> +    git --git-dir=c/a.git --work-tree=c/b status
>>
>> Is the interaction of -C with --work-tree and --git-dir desirable or
>> useful? (I'm genuinely curious.) Do you have use-cases in mind? Would
>> mentioning them in the commit message help to justify the interaction?
>
> The example is meant to clarify the effect of the -C option, rather than a
> proposed usage with the --work-tree and --git-dir options. The example came out
> due to the following discussions from an earlier version of this patch [1]:
> [1] http://article.gmane.org/gmane.comp.version-control.git/221766

Thanks for the reference. I did read that thread earlier. It doesn't
really answer my question, but perhaps it's not terribly important
since the interaction is documented. I was mainly asking if the choice
of locking in one particular interpretation was deliberate even though
other potentially valid (and perhaps more intuitive) interpretations
exists. More below TL;DR if you care to read on.

TL;DR

I was interested in knowing whether the exact interaction between -C
and --work-tree and --git-dir was intentional (and desirable) or an
"accident of implementation". I can see it going either way.

As implemented by the patch, -C is acted upon immediately (via
chdir()), whereas --work-tree and --git-dir have a delayed effect, so:

  git -C foo --work-tree=bar -C baz --git-dir=moo

means:

  work-tree = foo/baz/bar
  git-dir = foo/baz/moo

However, it would be equally valid for a user to expect the options to
be evaluated sequentially such that the above command line would mean:

  work-tree = foo/bar
  git-dir = foo/baz/moo

Is the former interpretation better than the latter possibly more
intuitive interpretation? This is a genuine question. I'm not
suggesting that one interpretation is better than the other, and it's
possible that it won't matter in practice [1], but it might be good to
know that alternate interpretations have been taken into consideration
before locking in a particular behavior.

This is why I was asking if you had particular use-cases in mind where
the former made more sense than the latter (or some other [2])
interpretation. Since there are multiple potential interpretations, it
might make sense to explain in the commit message why the one was
chosen over the other(s), and such use-cases could help solidify that
explanation.

[1]: Mixing of -C, --work-tree, and --git-dir may be sufficiently
unlikely that the reason the patch's behavior was chosen becomes
immaterial. Since the behavior is documented, a person can choose to
avoid -C if it doesn't work in a way suitable to his situation.

[2]: For example, a user might reasonably expect -C to be relative to
--work-tree or GIT_WORK_TREE rather than the other way around. So,
"git --work-tree=foo -C bar" or "git -C bar --work-tree=foo" would
chdir("foo/bar") before performing the git operation, and --git-dir
would be unaffected. Yet another possibility is that -C would impact
neither --work-tree nor --git-dir.
