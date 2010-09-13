From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH] builtin/describe.c: ignore untracked changes in
 submodules
Date: Mon, 13 Sep 2010 19:59:27 +0200 (CEST)
Message-ID: <503065167.8606900.1284400767803.JavaMail.fmail@mwmweb047>
References: <CC-1wlyJRzGfkPwn1Ra8d4Ot7mMnUGxYChGZHdqp-lQ5URlUFhNp4Ilyrh4bGk1dWF6drZXvim0@cipher.nrlssc.navy.mil>
 <7vy6bajvnd.fsf@alter.siamese.dyndns.org>
 <1094265482.7527324.1284144028114.JavaMail.fmail@mwmweb047>,
 <AANLkTinMf-_vk2-gRazf-8FNykZoNbVwmu_+c+5ht8rY@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Brandon Casey <casey@nrlssc.navy.mil>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	johannes.schindelin@gmx.de
To: Brandon Casey <drafnel@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 13 19:59:48 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OvDJe-0002ix-0i
	for gcvg-git-2@lo.gmane.org; Mon, 13 Sep 2010 19:59:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753020Ab0IMR7f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Sep 2010 13:59:35 -0400
Received: from fmmailgate06.web.de ([217.72.192.247]:51597 "EHLO
	fmmailgate06.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751273Ab0IMR7e (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Sep 2010 13:59:34 -0400
Received: from mwmweb047  ( [172.20.18.56])
	by fmmailgate06.web.de (Postfix) with ESMTP id C6832574DA8;
	Mon, 13 Sep 2010 19:59:27 +0200 (CEST)
Received: from [92.104.70.131]  by  mwmweb047  with HTTP; Mon
 Sep 13 19:59:27 CEST 2010
In-Reply-To: <AANLkTinMf-_vk2-gRazf-8FNykZoNbVwmu_+c+5ht8rY@mail.gmail.com>
X-UI-Message-Type: mail
X-UI-ATTACHMENT-ID-POSTFIX: 2dce3080-c55b-49a4-949e-53613a85bad0
X-Priority: 3
Importance: normal
Sensitivity: Normal
X-Provags-ID: V01U2FsdGVkX1862d+MADKdrajwsW6uI9exszC61PvaOAFi8Djl7Rs+uTOgIjKRzNiy
 b0SXikXSOZpcjKaQZdEUfg2/cqxcx6Rxva8AN629CVE=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156103>

>Do you agree that there is an inconsistency between how untracked content is
>treated at the super-project level and at the submodule level? 

Yes, but I - and others included in that discussion some time ago - could not
come up with a sane and simple solution to that problem.


> Any thoughts
>about how the behavior should be made to be consistent?

The core of this issue is that for git a file is either untracked, modified or clean.
But submodules can have every combination of all these states - as they consist
of multiple files - and additionally their HEAD can differ from the commit recorded
in the superproject. So basically I see two ways to handle that:
a) add new states for an entry to represent all missing combinations of possible
   states for submodules and tell all porcelain to handle these.
b) simplify this problem by having a submodule show up as modified when
   either of these three conditions are met (and enable the user to choose what
   conditions she wants to see and what not).

Obviously a) will complicate all git by a large degree just for the sake of submodules.
I am arguing for b), because submodules itself can be seen as a bunch of files which
don't interest me as single entities until I want to take a closer look. I think the issue
we are discussing here is the price we have to pay for this abstraction. I am very
open to proposals how to better handle that but so far I haven't seen any.


>Perhaps the default setting of submodule.<name>.ignore should be 'untracked'?

I still vote for none. I think the default should be to not have untracked files in
your projects (like you should not have warnings when compiling your project).
If that is not wanted, just use the configuration options git provides to change it.
