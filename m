From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH/RFC/GSOC] make git-pull a builtin
Date: Sat, 21 Mar 2015 18:27:31 +0100
Organization: gmx
Message-ID: <0c67273f0d1b8af3391db66617b24de5@www.dscho.org>
References: <1426600662-32276-1-git-send-email-pyokagan@gmail.com>
 <4cae16222697894b19856d12b062f68e@www.dscho.org>
 <CACRoPnQ4iJMn7+eujOXUN6dks2HMQYRw+nYfM1QvOD+k7BCtEQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Git List <git@vger.kernel.org>, Duy Nguyen <pclouds@gmail.com>
To: Paul Tan <pyokagan@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 21 18:27:56 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YZNBU-00087i-RO
	for gcvg-git-2@plane.gmane.org; Sat, 21 Mar 2015 18:27:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751622AbbCUR1h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Mar 2015 13:27:37 -0400
Received: from mout.gmx.net ([212.227.15.18]:60374 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751403AbbCUR1f (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Mar 2015 13:27:35 -0400
Received: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx002) with
 ESMTPSA (Nemesis) id 0LvENG-1ZZPle1Buk-010OQs; Sat, 21 Mar 2015 18:27:32
 +0100
In-Reply-To: <CACRoPnQ4iJMn7+eujOXUN6dks2HMQYRw+nYfM1QvOD+k7BCtEQ@mail.gmail.com>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.0
X-Provags-ID: V03:K0:Qg++5i/zKbQvQr+1gTy42LHk6kbVjlb6q1vJOfQ/PZS9uKGI33c
 SfxR9BFvt4IG02dutLrIthtoeBdmFhnrucSDdIkpuR8HulNkxmS4/Qk2qQ/cmWv2AUw1CFn
 P7yInnNpI9jJh0JQ6UZrU9Qh8cxqLamflL03dY1Bp/Vxxv4NLgrAohl/CdAZEXvt4oBCHMe
 peiyTjhtMxcX09g82bMzA==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266026>

Hi Paul,

On 2015-03-21 15:00, Paul Tan wrote:

> Thanks for your suggestions, I agree with most of them :).
> 
> On Wed, Mar 18, 2015 at 5:00 PM, Johannes Schindelin
> <johannes.schindelin@gmx.de> wrote:
>>> +static int parse_opt_rebase(const struct option *opt, const char
>>> *arg, int unset)
>>> +{
>>> +     if (arg)
>>> +             *(int *)opt->value = parse_rebase(arg);
>>> +     else
>>> +             *(int *)opt->value = unset ? REBASE_FALSE : REBASE_TRUE;
>>> +     return (*(int *)opt->value) >= 0 ? 0 : -1;
>>> +}
>>
>> In this function (and also in other places below), there is this pattern that a `struct option` pointer is passed to the function, but then only `*(int *)opt->value` is written to. Therefore, I would suggest to change the signature of the function and pass `(int *)opt->value` as function parameter.
> 
> It's used as a callback for the argument parser though, so the
> callback signature is required.

Good point ;-)

For readability, I would then suggest to declare `int *result = (int *)opt->value;` on the top of the function and then use `*result = ...` later.

>>> +static int has_unstaged_changes(void)
>>
>> Yeah, this function, as well as the ones below it, look as if they are so common that they *should* be already somewhere in libgit.a. But I did not find them, either...
>>
>> Of course it *would* be nice to identify places where essentially the same code is needed, and refactor accordingly. But I think that is outside the scope of this project.
> 
> Actually, I think that identifying the places where code can be
> trivially shared (without requiring major refactoring) should be part
> of the project, otherwise lots of code may be duplicated and cause
> code bloat. The obvious one would be fork_point() in this patch, which
> is copied from the merge-base builtin and not accessible because it
> has static linkage. The project should, at the very least, allow the
> function to be shared between git-pull and git-merge-base, as well as
> to modify the function so that it can fail without die()-ing.

Yes, I agree wholeheartedly. But I like your choice to strike a balance for the sake of a proof-of-concept.

Ciao,
Johannes
