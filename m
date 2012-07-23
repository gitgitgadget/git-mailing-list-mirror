From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH] Solve git-submodule issues with detached work trees
Date: Tue, 24 Jul 2012 01:17:45 +0200
Message-ID: <500DDB99.80103@web.de>
References: <CAHCkQtNfz8Kbn810LgXEQ_rkyk4qn5amGgHQsv2uR6H38sTSrg@mail.gmail.com> <7vsjcjnjvj.fsf@alter.siamese.dyndns.org> <500D8C30.9010807@web.de> <7v7gtumj88.fsf@alter.siamese.dyndns.org> <500DADEE.9060700@web.de> <7vd33mkyhj.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: =?ISO-8859-1?Q?Daniel_Gra=F1a?= <dangra@gmail.com>,
	git@vger.kernel.org,
	Richard Hartmann <richih.mailinglist@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 24 01:18:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1StRsz-0006Hn-Kc
	for gcvg-git-2@plane.gmane.org; Tue, 24 Jul 2012 01:17:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752825Ab2GWXRx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Jul 2012 19:17:53 -0400
Received: from mout.web.de ([212.227.17.12]:52755 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751687Ab2GWXRw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jul 2012 19:17:52 -0400
Received: from [192.168.178.48] ([91.3.175.185]) by smtp.web.de (mrweb102)
 with ESMTPA (Nemesis) id 0LlF9O-1TRxcW2uZy-00aMIS; Tue, 24 Jul 2012 01:17:51
 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:14.0) Gecko/20120713 Thunderbird/14.0
In-Reply-To: <7vd33mkyhj.fsf@alter.siamese.dyndns.org>
X-Provags-ID: V02:K0:7IMJ0PFTqu/iNiWNlmbH5vMB2gaL2xmHh1VdM2muXuR
 o8VgxJ5VSZAePkPckt9+wvCr73+GH3IEFsvKxMLVwGnzW2oBAn
 usDjTnqagbSI+BPZ4Mv21fKkzVuAnaOP9P2evE2m6I+VLKLbr2
 PBuuJeU6kK0ZAa7bof/8b0b8L+U7TZmjOkNiLJDTltt94DLVzz
 j1UNDV0oeyqprSF+dp3dw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202003>

Am 23.07.2012 22:34, schrieb Junio C Hamano:
> Jens Lehmann <Jens.Lehmann@web.de> writes:
> 
>> We could get rid of the core.worktree setting by assuming that the
>> directory a gitfile was found in is the root of the repo's work
>> tree (unless configured otherwise).
> 
> Now you lost me.  If you have .git that is not a directory but is a
> gitfile, then you do not need GIT_DIR nor GIT_WORK_TREE in the first
> place, no?

Not inside the submodule, me thinks they only make sense in the
superproject (that's why we clean the environment before working
inside the submodule). But setting the superproject's GIT_WORK_TREE
to something else won't work for an already initialized submodule,
as the core.worktree setting will still point to the old work tree
which was set when the submodule was initialized. One could expect
the submodule's work tree to be $GIT_WORK_TREE/$sm_path when
GIT_WORK_TREE is set, but it isn't.
