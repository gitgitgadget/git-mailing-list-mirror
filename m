From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: scan entire repo for changes to file
Date: Tue, 16 Nov 2010 12:20:43 -0600
Message-ID: <20101116182043.GA14552@burratino>
References: <ibi59v$pjg$1@dough.gmane.org>
 <AANLkTi=uKhrvAS6ApnmCZnfbFboYU77rNcKDpaSBn1id@mail.gmail.com>
 <20101112014434.GA10679@burratino>
 <7vk4kdi2h4.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	Neal Kreitzinger <neal@rsss.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 16 19:21:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PIQ9w-0003dY-9r
	for gcvg-git-2@lo.gmane.org; Tue, 16 Nov 2010 19:21:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756651Ab0KPSV1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Nov 2010 13:21:27 -0500
Received: from mail-ww0-f44.google.com ([74.125.82.44]:65051 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756567Ab0KPSV0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Nov 2010 13:21:26 -0500
Received: by wwa36 with SMTP id 36so1053429wwa.1
        for <git@vger.kernel.org>; Tue, 16 Nov 2010 10:21:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=mwifer8cxuOML2HZBrWy0tRU+yi1fP8Jjr4URnMOMzA=;
        b=eC5vFDeJASl8ZI/CmpHJRnb9YL0zIlliZAjScmZh8VjE15/BN6Z+7XYWpk00WH1XdE
         xdVEgPg5HEdGLiyt2KHMdywHRWBLbZ8xs2Jk8z4yVcU80ebnKLvJQ9Elv2fiWrCG1L3l
         qwdHy1i9lGplUT/qqZ9zL9szRzqrCwGbFVxFo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=jTluHvIIcWmQcs+K/fg+CMqdSyC7lnKBqAnNCWmS03JEXexbPTaCGI3Icd8OUpFSVQ
         P6bejdrjIj194Hp6BXDkpfiT1rHkYSmYdx0wO1L0+vzvaMXLoek1N3krL3b457il/nMP
         zOJVdKI/bTE4QrG35SH2NIxGyvZ6MQhGn5J7c=
Received: by 10.216.177.81 with SMTP id c59mr551856wem.81.1289931684144;
        Tue, 16 Nov 2010 10:21:24 -0800 (PST)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.sbcglobal.net [68.255.106.176])
        by mx.google.com with ESMTPS id l51sm713984wer.26.2010.11.16.10.21.21
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 16 Nov 2010 10:21:22 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <7vk4kdi2h4.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161573>

Junio C Hamano wrote:
> Jonathan Nieder <jrnieder@gmail.com> writes:
>> Martin von Zweigbergk wrote:
>>> On Thu, Nov 11, 2010 at 8:28 PM, Neal Kreitzinger <neal@rsss.com> wrote:

>>>> Is there a way to scan my entire repo (many unmerged branches) for any
>>>> changes to a file?
>>>> e.g.
>>>> $ git log * -- somepath/myblob
>>>> would return all commits in the repo that changed myblob.
>>>
>>> Might replacing '*' by '--all' give you what are looking for?
>>
>> Probably with --full-history if you want to know what happened on
>> historic branches, too.
>
> You would need to clarify what you mean by "historic branches" here.

Yes, quite right.  I meant failed experiments of a certain kind.

The "git log -- path" facility can be used to learn the nature and
origin of a collection of files.

	$ git log --graph --oneline -- block-sha1/
	* 078e9bc msvc: Select the "fast" definition of the {get,put}_be32() macros
[...]
	* d7c208a Add new optimized C 'block-sha1' routines

The result is a list of commits that explains the current state of
that file, without commits irrelevant to that purpose.

What happens to merges?  Consider a history like this (history flowing
left to right):

 A --- B --- C --- D --- E --- F --- G ---- M --- H
              \                            /
               I ...                  ... J

There is a main line and a side branch.  On the mainline, the selected
files have been getting better and better.  The side branch does not
touch those files.  Then the side branch would irrelevant to the
history of those files.

To flesh out this idea, git history simplification.  When walking
through history, if a merge is encountered (M) and one of the parents
already matches the resulting state (G), then git will follow that
parent and ignore the others.  If no parent matches the resulting
state, git follows all parents.  So we get a simpler history that
should still adequately explain the result.

Consider another scenario, though:

 A --- B --- C --- D --- E --- F --- G ---- M' --- H'
              \                            /
               I' ...                ... J'

There is a mainline and a side branch.  On the mainline, the selected
files have been getting better and better.  On the side branch, there
was an abortive experiment; some changes were made to the selected
files there, but none of these changes survived as far as the merge M'.

The side branch is _still_ irrelevant to the purpose of explaining the
current state of those files.  Git will notice that (G matches M') and
ignore the side branch.  But if your goal is not to explain the
current state but to delve into the history of all thoughts this
project remembers on a subject, such history simplification would not
be appropriate and you should be using the --full-history option.

The History Simplification section of git-log(1) has details.

Caveat: the list of commits selected with --full-history --dense do
not convey a coherent history.  M' is uninteresting but some of the
commits on the I' ... J' track are; how do we stitch the interesting
commits together?  So history visualization tools cop out and show
all merges when --full-history is enabled.  (Put another way,
--parents --full-history implies --no-dense.)

Hope that helps.
