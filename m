From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: [git-users] Problem using detached worktrees with commands implemented in scripts
Date: Thu, 17 Oct 2013 23:38:09 +0100
Organization: OPDS
Message-ID: <1390B0AFBE7F4C4A875987C7469B0791@PhilipOakley>
References: <201310162003.r9GK3UYj014414@freeze.ariadne.com><xmqqeh7k51vg.fsf@gitster.dls.corp.google.com><29AA597BEBC146B09E8B370949EC2CE9@PhilipOakley><xmqqk3hc3jbw.fsf@gitster.dls.corp.google.com><3401D1F36F134CDDB0881B196F79CB3A@PhilipOakley> <xmqqr4bjy63y.fsf@gitster.dls.corp.google.com> <5A09FF55D37146E7A02DF2F640A46406@PhilipOakley>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: "Dale R. Worley" <worley@alum.mit.edu>,
	"Git List" <git@vger.kernel.org>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Oct 18 00:38:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VWwCd-0001Ek-Lg
	for gcvg-git-2@plane.gmane.org; Fri, 18 Oct 2013 00:38:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752786Ab3JQWhz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Oct 2013 18:37:55 -0400
Received: from out1.ip06ir2.opaltelecom.net ([62.24.128.242]:40806 "EHLO
	out1.ip06ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750811Ab3JQWhz (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 17 Oct 2013 18:37:55 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AgIMAPFlYFJOl3+a/2dsb2JhbABbgwc4iTm1GwQEAoEpF3RpAQGBHwEBFAEEAQEFCAEBLh4BASELAgMFAgEDFQwlFAEEGgYHFwYTCAIBAgMBhTgHAYIWI8Bqji6BI4MmgQcDiQSGEpp0gTosgT87
X-IPAS-Result: AgIMAPFlYFJOl3+a/2dsb2JhbABbgwc4iTm1GwQEAoEpF3RpAQGBHwEBFAEEAQEFCAEBLh4BASELAgMFAgEDFQwlFAEEGgYHFwYTCAIBAgMBhTgHAYIWI8Bqji6BI4MmgQcDiQSGEpp0gTosgT87
X-IronPort-AV: E=Sophos;i="4.93,517,1378854000"; 
   d="scan'208";a="591420111"
Received: from host-78-151-127-154.as13285.net (HELO PhilipOakley) ([78.151.127.154])
  by out1.ip06ir2.opaltelecom.net with SMTP; 17 Oct 2013 23:37:52 +0100
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236330>

From: "Philip Oakley" <philipoakley@iee.org>
> From: "Junio C Hamano" <gitster@pobox.com>
>> "Philip Oakley" <philipoakley@iee.org> writes:
>>
>>> From: "Junio C Hamano" <gitster@pobox.com>
>>>> "Philip Oakley" <philipoakley@iee.org> writes:
>>>>
>>>>> ... and the detection process for 'toplevel' may not work
>>>>> properly when in a separated work-tree environment.
>>>>
>>>> Without GIT_WORK_TREE exported to point at the top-level, there is
>>>> nothing that lets us "detect" it, as the working tree does not have
>>>> ".git" directory to tell us to stop, no?
>>>>
>>>
>>> "No", but not in that way.
>>>
>>> My point (to Dale) was, as you state, that the "cd to top level" was
>>> (IIUC) the probable causes of the fault, and that a documentation
>>> update would probably be appropriate for the discussion on exporting
>>> GIT_WORK_TREE, and that it would specifically mention those git
>>> commands that needed to "cd to top level", and hence would not work
>>> in
>>> such an environment. (I wasn't sure where the appropriate "cd to top
>>> level" function was)
>>>
>>> An explanation here on the list wouldn't solve the problems for
>>> others
>>> who are yet to make the same mistake, hence the implied suggestion.
>>
>> I understand what you mean by these last two lines. It was unclear
>> to me which part of our documentation needs updating and how, and
>> that was (and still is) what I was primarily interested in finding
>> out.
>>
> I was expecting that the places would be in git(1) [git.txt] and
> config(1) [config.txt], in the enironment variables GIT_WORK_TREE
> section and core.worktree sections repectively. However what the right
> text would be hasn't been fully determined yet, as it should be clear
> about which commands don't follow the stated 'rules'. Dale's use case
> does appear to be stretching...
>
> Philip

A bit more looking gave that the cd_to_toplevel () in git-sh-setup.sh
directly uses `git rev-parse --show-toplevel`, which simply returns
work_tree (static char *work_tree; in environment.c, with comment /*
This is set by setup_git_dir_gently() and/or git_default_config() */), 
apparently without a check for the GIT_WORK_TREE.

One option may be to either protect the cd_to_toplevel  code with a
check of `git rev-parse --local-env-vars` to see if GIT_WORK_TREE is
present. Or create `git rev-parse --work-dir` to match `--git-dir`. This 
would be a code level fix. This makes the assumption that if a deteched 
GIT_WORK_TREE is set then it is the top level.

In terms of command scripts that use git-sh-setup.sh we have a longish 
list, so a full list in the documentation is probably unreasonable 
(which suggests that a code fix would be more apprpriate)

commands:

git-am
git-bisect
git-filter-branch
git-instaweb
git-lost-found
git-merge-one-file
git-mergetool
git-pull
git-quiltimport
git-rebase
git-repack
git-request-pull
git-stash
git-submodule
git-web--browse

git\contrib\*various*



Philip
