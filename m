From: Michael Witten <mfwitten@gmail.com>
Subject: Re: [PATCH] Docs: git checkout --orphan: `root commit' and 
                                                  `branch head'
Date: Tue, 27 Sep 2011 17:50:41 -0000
Message-ID: <2ab64110f87d419a84da2c94ebf0b1be-mfwitten@gmail.com>
References: <1316960136073-6829212.post@n2.nabble.com>
            <1316961212.4388.5.camel@centaur.lab.cmartin.tk>
            <7vaa9r2jii.fsf@alter.siamese.dyndns.org>
            <1317073309.5579.9.camel@centaur.lab.cmartin.tk>
            <e88b6e560cab4ed1937dd191b4180387-mfwitten@gmail.com>
            <4E81F080.7010905@drmicha.warpmail.net>
            <CAMOZ1BsvnZ7PyfjOJURX+B7vCZcYheLS4pissGvPNjEivbYXtw@mail.gmail.com>
            <7v39fhyk21.fsf@alter.siamese.dyndns.org>
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Carlos =?ISO-8859-1?Q?Mart=EDn?= Nieto <cmn@elego.de>,
	vra5107 <venkatram.akkineni@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 27 19:57:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R8bul-0006F1-QA
	for gcvg-git-2@lo.gmane.org; Tue, 27 Sep 2011 19:57:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752741Ab1I0R5q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Sep 2011 13:57:46 -0400
Received: from mail-vx0-f174.google.com ([209.85.220.174]:41569 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752248Ab1I0R5o (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Sep 2011 13:57:44 -0400
Received: by vcbfk10 with SMTP id fk10so3910231vcb.19
        for <git@vger.kernel.org>; Tue, 27 Sep 2011 10:57:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=subject:date:from:to:cc:message-id:in-reply-to:references;
        bh=U0W7c/mAXp/D5VuUNIiLbnyBLEtZy76FemXb7mJigZQ=;
        b=TcMHXGuo2jvxSiGrCQEwEPs3fvLrbLVveShw/ms74HyJYOPCG/L6xWZw4RuKewwIH+
         h48mSchchncolE7S2+lptm14CA7wXBtutIqlLK8IxObT38yjnfPzvM2uvIsUYTiweZvJ
         QTetOwyEqPBADoOtQ4aUe7Bh9LlAYuvn+P3/w=
Received: by 10.68.11.200 with SMTP id s8mr38777681pbb.9.1317146263240;
        Tue, 27 Sep 2011 10:57:43 -0700 (PDT)
Received: from gmail.com (tor-exit-readme-2wh1.kromyon.net. [68.169.35.41])
        by mx.google.com with ESMTPS id h5sm6929401pbf.4.2011.09.27.10.57.39
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 27 Sep 2011 10:57:42 -0700 (PDT)
In-Reply-To: <7v39fhyk21.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182260>

On Tue, 27 Sep 2011 10:25:10 -0700, Junio C Hamano wrote:

> Michael Witten <mfwitten@gmail.com> writes:
>
>> It seems like a more logical approach would be instead for "git
>> commit" to take a "--root" option that would create a new root commit
>> based on the current index and then point the current branch head to
>> the new root commit. Thus:
>>
>>   $ git checkout -b new_branch old_branch
>>   $ # Manipulate or not
>>   $ git commit --root
>>
>> That's how people think.
>
> This may indeed be an improvement. I suspect that we'd need to think about
> it a bit more, but it feels right (perhaps introduce this new option,
> deprecate --orphan from the checkout, and then eventually remove it
> sometime in 1.8.0 timeframe).
>
>>>>  The index and the working tree are adjusted as if you had previously run
>>>>  "git checkout <start_point>".  This allows you to start a new history
>>>> -that records a set of paths similar to <start_point> by easily running
>>>> +that records a set of paths similar to <start_point> by just running
>>>>  "git commit -a" to make the root commit.
>>>
>>> "similar" is an understatement here, maybe "as in"?
>
> I do not think "as in" is an improvement. It completely ignores the
> "Manipulate or not" part in the above, and "similar" was very much an
> attempt to say "you do not have to commit it right away, but start from
> the state and commit a deviation of it".

Actually, that kind of change might make a lot of sense with respect to
[PATCH v2]; here's the kind of text that [PATCH v2.1] will yield:

  ...
  
  Furthermore, the working tree and the index are adjusted as if
  you ran "git checkout <start_point>"; thus, by just running
  "git commit", you can create a root commit with a tree that is
  exactly the same as the tree of <start_point>.
  
  Naturally, before creating the commit, you may manipulate the
  index in any way you want. For example, if you want to create
  a root commit with a tree that is totally different from the
  tree of <start_point>, then just clear the working tree and
  index first: From the top level of the working tree, run
  "git rm -rf .", and then prepare your new working tree
  and index as desired.
