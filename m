Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19925C7EE2D
	for <git@archiver.kernel.org>; Fri,  3 Mar 2023 15:19:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229930AbjCCPTk (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Mar 2023 10:19:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229804AbjCCPTj (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Mar 2023 10:19:39 -0500
Received: from mout.web.de (mout.web.de [212.227.17.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79EA11BEE
        for <git@vger.kernel.org>; Fri,  3 Mar 2023 07:19:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
        t=1677856772; i=l.s.r@web.de;
        bh=OxmP4cMGuMCLWiOLaQksg0HMO5Yo71dhdDCrbqlpk+0=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=vhYu40q41q2BjUGepw+a+VzXWgixBgh6d0GI6brTORUS/MWkk1zrtszkH06EahmJ0
         BcTPUjh8VjG5UjAxi4W6e778SyIrwyB/belfDesmpOy50SB9tOuw8Szz81wSsKvMcr
         aB+snEB5K6M/UFJE8l/R0wi45uE5T+hUXivE08tiwXW5dINN1/4azWrGaLv1YQgEtC
         UOQHsCrJBtH5wc7KswwKymE8tqq0wZ82NgDGZpz/YItKJT+oVuM4jHORQNyeLVlObu
         wFpxVW/SgC1w5vEeUSxRGf+cY/woMpoE+WhL/bRaODUjTCu/jxD7owBDFOibgxhViq
         xjfgcG6+oZB/A==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([79.203.21.51]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MDvDi-1pi3MN3pA4-00AJZJ; Fri, 03
 Mar 2023 16:19:31 +0100
Message-ID: <c7b21faa-68dd-8bd9-4670-2cf609741094@web.de>
Date:   Fri, 3 Mar 2023 16:19:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.8.0
Subject: Re: Bug in git archive + .gitattributes + relative path
Content-Language: en-US
To:     Cristian Le <cristian.le@mpsd.mpg.de>, git@vger.kernel.org
References: <42f13cda-9de6-bfc6-7e81-64c94f5640db@mpsd.mpg.de>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <42f13cda-9de6-bfc6-7e81-64c94f5640db@mpsd.mpg.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:SjR8jiie+STwMTCZNqbe4kV4tL91jomHVlMgBzVCFcpJEcF10og
 Cu4hX4sopHcCsjST//ndkxILfyCScqjxE36KSVhnAGZLY1zInnfz+gR64ZR1SjDpFy6nkK2
 rm1evflOsyDBnEZsE48qTioNh3QU3WedSWBk1Zm0YBlleBUmiuEYfUBDQeblo5lcZlPAvXZ
 vzU7tD1dgCgf5xOChhR6Q==
UI-OutboundReport: notjunk:1;M01:P0:T1kK7spwPQM=;pXUC60h8Lf+DzHYAdy0+N6R2dTS
 zua7Us0+ooUgmu6mvpuM88C5RyOe+1q9PYkyjjFJAjrmR/QL3+C2Jmq0WrF7RmrpF2jV0CkSv
 vytYAqJLkfNXXpbRF6lS4YADHfLf5+LRFKXLRnfzNdt3dhOF/PMeWQKzyhEE0MTDfpMGOyNEg
 b11RWQ9lpvt4CStwFWSVA44Z7XhpeCwMeRzBt3ApszcSH3nowVNIOoz05cy1mUV9fCh1IEjle
 OMz4nxoSMr+l6exuroNq9j+jYt08mFxJI/FtNHQy8EwhF7iQo81dqKiQVAXL/ahvlA6n7j6F+
 nymZ+urjCFiFkNNOgDsrxFbsxW2cATJGO791W71oQ7osGo4zcdxf9XmvtKi8BljS8fN70lUDX
 YpeN69NlCUFQFnlSVValByobH7vCxL5EREr0+jDwpAKTR0nvjstKJEJ/LnRX51sOQ0Ikl0IN7
 aJjEyGNYEIIuitICaE0uV/zFgalO+McPcKGaMQNWpqXeWHHvyTYBWSwPyn5PoUYPjKhZa1X4U
 RGTKeVjwGc6Ny4eJC7vOoPUIzZKtMJ3lGfE3TwNVFP0fHQGwXOANu71omEGybwzpH+1boMrs3
 Z6c7I8CrrnSKcQdQeufBt5XxgAgE3adylcwRwPjdpiyc03aFLX2Wk14E2D8OfNbW7GCF9fsVS
 7CdNunx2liuPK9taEm2Lj88Uh+/G52KPi8BZsXtZ9/beo0IMtxZ/G0eBTq4cBuEIn0aOYCyXr
 5Uu8/fdjN1byExlOedFyyhDwm6Eq51MqnqwB0gPUNSAN3uMh59CjtQVbRDd0LaHR3seEesqa4
 C4TJONzmwtjv1bofcbL1Rn/nfcATQ3yj+go8iX2yG7HRFSmQRnMizOo4UTHQhE1UIqSUYH6Cz
 +DHZmDPtRkDL4Nf/L6tfcx4XfZRZ2Oc2a4laqlGiSVkdY7qJXtOPiZw0I4Frfpd11FVwYTmQp
 n9v4l2BR6AOFkHkO2W4PdfiNurQ=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 03.03.23 um 11:25 schrieb Cristian Le:
> Using `git archive` with or without `--worktree-attributes` does not pro=
perly read `.gitattributes` files if using a relative path in `<tree-ish>`=
.
> Related github comment: https://github.com/rpm-software-management/tito/=
pull/445#issuecomment-1450298871
> Related stackoverflow discussion: https://stackoverflow.com/questions/52=
804334/how-to-ignore-files-directories-in-git-archive-and-only-create-an-a=
rchive-of-a
>
> Git version: `2.39.2`
> Mwe git repo: Two files:
> ```
> # .gitattributes:
> .git_archival.txt export-subst
> ```
> ```
> # .git_archival.txt:
> node: $Format:%H$
> ```
>
> Commands to reproduce and expected behaviour:
> ```console
> $ git archive HEAD:./ --output=3Dtest.tar.gz
> $ tar -axf test.tar.gz .git_archival.txt -O
> node: 745ce26169fb44e04d91d40ee581cccd591c941e
> ```
> Important: Notice the path `./` given after `HEAD`.
>
> Actual output:
> ```console
> $ tar -axf test.tar.gz .git_archival.txt -O
> node: $Format:%H$
> ``>
> It doesn't matter if `.gitattributes` is in a subfolder, or if I change =
the relative path `./` to a subfolder, the files are still not properly ge=
nerated.
>
> Using `--worktree-attributes` did not have any effect either.

That's expected behavior.  You specify a tree (HEAD:./), while
export-subst requires a commit.  git-archive(1) doesn't spell that out,
but advises to "See gitattributes(5) for details.", which states: "The
expansion depends on the availability of a commit ID, i.e., if
git-archive(1) has been given a tree instead of a commit or a tag then
no replacement will be done.".

The other attribute supported by git archive, export-ignore, does not
require a commit.

The Stack Overflow discussion seems to be about a different issue:
Attributes are always based on the repository root directory, which
gives unexpected results when archiving a subtree.

> According to the documentation, I understand that the expected behaviour=
 with regards to `--worktree-attributes`:
> - Read the `.gitattributes` of the relative path, e.g. `./sub_dir` regar=
dless of `--worktree-attributes`. (similar behaviour as not passing a rela=
tive path)
> - Include the `.gitattributes` of the top-level path if `--worktree-attr=
ibutes` is passed
>
> Maybe the intended behaviour is to completely ignore all `.gitattributes=
` unless `--worktree-attributes` is provided, in which case, it does not h=
ave the intended behaviour and please include a flag to achieve the above =
behaviour.
>

The option --worktree-attributes allows uncommitted .gitattribute files
to be read, but has no effect on whether export-subst can actually be
applied.

So on the Git side we could improve the documentation and improve
reading attributes when archiving subtrees (no idea how, though,
admittedly).  But that wouldn't help you, I suppose.  In your issue
#444 you write that "git archive HEAD" works, but "git archive HEAD:./"
doesn't.  Why do you need to use the latter?

Ren=C3=A9

