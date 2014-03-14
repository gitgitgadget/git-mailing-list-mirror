From: John Butterfield <johnb003@gmail.com>
Subject: Re: Proposal: Write git subtree info to .git/config
Date: Thu, 13 Mar 2014 17:46:37 -0700
Message-ID: <CAJ2ZDLJtp0Nz-HSyX8DWn96qj=J6Snvx8fKfSNg3qdbmj0=4nA@mail.gmail.com>
References: <CAJ2ZDL+HuBCv_xJCXEBb3Pex-qt86ocEX9yu=uV+CzdvqwECDA@mail.gmail.com>
	<xmqqmwgthdsp.fsf@gitster.dls.corp.google.com>
	<CAJ2ZDLK2wGJ5PG585dQRmp7Ck9bctRRtz1unwQ9S0OfVe8G-Bg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 14 01:46:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WOGGo-00049y-L6
	for gcvg-git-2@plane.gmane.org; Fri, 14 Mar 2014 01:46:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754359AbaCNAqi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Mar 2014 20:46:38 -0400
Received: from mail-we0-f182.google.com ([74.125.82.182]:54422 "EHLO
	mail-we0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752771AbaCNAqi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Mar 2014 20:46:38 -0400
Received: by mail-we0-f182.google.com with SMTP id p61so1497959wes.41
        for <git@vger.kernel.org>; Thu, 13 Mar 2014 17:46:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=UCWOzxpKnUWfZMJz5dWdIKwVLUY9HN+UXYUfyFobv6M=;
        b=t/ufdMTmrJ1ebUmQ/Y6HiA8WnzCpoSJ9jxbfcpZAHfWPE+q49Rov3Wh9N1VNAzh0uu
         DLLgWQLRpqSBFxbinlbrGFG7Gqb9Y/4tEDhqsRussGQxmuioLkV0GpgwBsgEmvq3TYcV
         1VHrH/QaHgzXGbOWOo8XfkCblCdAh6B7DIuJDj2a5hGrnNu40u6yCXru4EuFNGx+q97f
         GM/HBIbpyPVsk3619p2dugNQR0CATN5cnTQO6z2FUWaFoPXKGi0Fau+jpJhWztafSjbS
         oCS6l85V0SEBqv/RqfoCSTt3nuMBTP/pniIsDA+H5Nk9kciHvFkMGmIBfcyS1zcjj3Ao
         43Hg==
X-Received: by 10.180.83.137 with SMTP id q9mr3736054wiy.55.1394757997108;
 Thu, 13 Mar 2014 17:46:37 -0700 (PDT)
Received: by 10.194.174.226 with HTTP; Thu, 13 Mar 2014 17:46:37 -0700 (PDT)
In-Reply-To: <CAJ2ZDLK2wGJ5PG585dQRmp7Ck9bctRRtz1unwQ9S0OfVe8G-Bg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244066>

by "per folder" I meant, "for each subtree"

On Thu, Mar 13, 2014 at 5:43 PM, John Butterfield <johnb003@gmail.com> wrote:
>> A subtree biding can change over time, but .git/config is about
> recording information that do not change depending on what tree you
> are looking at, so there is an impedance mismatch---storing that
> information in .git/config is probably a wrong way to go about it.
>
> I see. How about a .gitsubtrees config file in the root of a project?
>
>> It might help to keep track of "In this tree, the tip of that other
> history is bound as a subtree at this path", which means that
> information more naturally belongs to each tree, I would think.
>
> Anything in the subdirectory must be part of the contents of the
> subtree repo. It should not know how it is linked to it's parent
> project; parents should know how their children are fetched. Therefore
> it cannot live in the subtree.
>
> Subtrees could be nested. So, should the config be in the root of the
> parent subtree? This makes sense to me.
>
> Example:
>
> /
>   A/
>   B/    # a subtree of (blah)
>     X/
>     Y/  # a subtree of (yada-yada)
>     Z/
>
> So, lets say B has many updates remotely, including pushing and
> pulling changes to Y.
>
> When pulling the changes from B, it would be convenient for it to come
> with the meta data, (subtree repo and commit info) for Y.
>
> So how does that sound; Could we store subtree repo and commit id
> references per folder in a .gitsubtrees file in the root of every
> project?
>
> (Project B is technically it's own project so it would pull it's own
> .gitsubtrees in /B/.gitsubtrees)
>
> `John
>
> On Thu, Mar 13, 2014 at 4:36 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> John Butterfield <johnb003@gmail.com> writes:
>>
>>> Has there been any talk about adding a stub for git subtrees in .git/config?
>>
>> I do not think so, and that is probably for a good reason.
>>
>> A subtree biding can change over time, but .git/config is about
>> recording information that do not change depending on what tree you
>> are looking at, so there is an impedance mismatch---storing that
>> information in .git/config is probably a wrong way to go about it.
>>
>> It might help to keep track of "In this tree, the tip of that other
>> history is bound as a subtree at this path", which means that
>> information more naturally belongs to each tree, I would think.
