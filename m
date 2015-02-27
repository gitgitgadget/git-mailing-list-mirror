From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: Any chance for a Git v2.1.5 release?
Date: Fri, 27 Feb 2015 22:49:30 -0000
Organization: OPDS
Message-ID: <D1DF80CD81FD4C96BA973BFCD998E7B1@PhilipOakley>
References: <C5211E53-8905-41C9-9D28-26D7BB51E76A@gmail.com> <xmqqk2z7qe8s.fsf@gitster.dls.corp.google.com> <2D3EB6D1-3029-4F60-AF29-E044E92DB036@gmail.com> <xmqq4mqapo9r.fsf@gitster.dls.corp.google.com> <DCB8EEAA-F6C3-4321-833E-39B80673C7E9@gmail.com> <xmqqvbiol7fg.fsf@gitster.dls.corp.google.com> <35E11B78-6FF8-41DE-BBF5-8978DA2F87A6@gmail.com>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=response
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>,
	"Adam Spiers" <git@adamspiers.org>,
	"Junio C Hamano" <gitster@pobox.com>
To: "Kyle J. McKay" <mackyle@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 27 23:48:17 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YRThf-0002Em-Aa
	for gcvg-git-2@plane.gmane.org; Fri, 27 Feb 2015 23:48:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755472AbbB0WsK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Feb 2015 17:48:10 -0500
Received: from out1.ip02ir2.opaltelecom.net ([62.24.128.238]:58203 "EHLO
	out1.ip02ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755454AbbB0WsI (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 27 Feb 2015 17:48:08 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: A2BTEwAH8/BUPAFMFlxbgwJSWoclun6FagEDAQGBJ04BAQEBAQEFAQEBATg7hAoFAQEBAQMIAQEuHgEBIQsCAwUCAQMVAwklFAEECBIGBwMUBhMIAgECAwEIiAIDFQnEAY1gDYU/IIsSgkSCKoMegRQFiiyFSluDBINsM4JhESiFN4V3SYYKhBE+MYJDAQEB
X-IPAS-Result: A2BTEwAH8/BUPAFMFlxbgwJSWoclun6FagEDAQGBJ04BAQEBAQEFAQEBATg7hAoFAQEBAQMIAQEuHgEBIQsCAwUCAQMVAwklFAEECBIGBwMUBhMIAgECAwEIiAIDFQnEAY1gDYU/IIsSgkSCKoMegRQFiiyFSluDBINsM4JhESiFN4V3SYYKhBE+MYJDAQEB
X-IronPort-AV: E=Sophos;i="5.09,663,1418083200"; 
   d="scan'208";a="26962884"
Received: from host-92-22-76-1.as13285.net (HELO PhilipOakley) ([92.22.76.1])
  by out1.ip02ir2.opaltelecom.net with ESMTP; 27 Feb 2015 22:48:05 +0000
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264511>

From: "Kyle J. McKay" <mackyle@gmail.com>
> On Feb 26, 2015, at 12:54, Junio C Hamano wrote:
>
>> "Kyle J. McKay" <mackyle@gmail.com> writes:
>>
>>> I would like to better understand how the various heads are
>>> maintained.  I've read MaintNotes and I've got the concepts, but I'm
>>> still a little fuzzy on some details.  It looks to me like all 
>>> topics
>>> still only in pu after master has been updated are then rebased onto
>>> the new master and then pu is rebuilt.
>>
>> Topics in 'pu' not yet in 'next' _can_ be rebased, but unless there
>> is a good reason to do so, I wouldn't spend extra cycles necessary
>> to do such thing.  I even try to keep the same base when replacing
>> the contents of a branch with a rerolled series.  For example, today
>> I have this:
>>
>>    $ git config alias.lgf
>>    log --oneline --boundary --first-parent
>>    $ git lgf master..nd/slim-index-pack-memory-usage
>>    3538291 index-pack: kill union delta_base to save memory
>>    7b4ff41 FIXUP
>>    45b6b71 index-pack: reduce memory footprint a bit
>>    - 9874fca Git 2.3
>>
>> and Duy has a newer iteration of it starting at $gmane/264429.  What
>> I would do, after saving these patches in a mbox +nd-index-pack,
>> would be to
>>
>>    $ git checkout 9874fca
>>    $ git am -s3c ./+nd-index-pack
>>    $ git show-branch HEAD nd/slim-index-pack-memory-usage
>>    ... compare corresponding changes between the old and the new
>>    ... until I am satisified; otherwise I may tweak the new one
>>    $ git rebase -i 9874fca
>>    ... and then finally
>>    $ git branch -f nd/slim-index-pack-memory-usage HEAD
>>
>> to update the topic.  Of course, it would be necessary to rebuild
>> 'pu' by merging all the topics that are in it on top of 'master'.
>
> Thanks.  That's helpful.
>
>> After finishing 2.3.0 release, at some point while 'master' is still
>> at 2.3.0, something like this would happen:
>>
>>    $ git branch -m maint maint-2.2
>>    $ git branch maint master
>
> So the reason I don't notice force-updates to maint when this happens 
> is because of the "Sync with maint" commits that make sure the new 
> maint contains the old one.
>
>>> Also, how do you handle a down merge to maint when you have this:
>>>
>>> * (master)
>>> * merge topic foo
>>> |\
>>> | * topic foo
>>> |/
>>> * c
>>> * b
>>> * a
>>> * (tag: vX.X.X, maint)
>>> *
>>
>> I don't, and this is done by making sure I do not get into such a
>> situation in the first place.
>>
>> A general rule of thumb when applying a set of patches that are
>> fixes eventually worth having in older maintenance tracks is to find
>> the oldest maintenance branch and apply them there.
>
> If I were to keep a maint-lts branch somewhere I would need to cherry- 
> pick topics with desired fixes that fall into that situation.  That's 
> what I expected but when you mentioned down merging the fixes I wanted 
> to make sure I wasn't overlooking something.

<minor bikeshed>
The announcement a few days ago by Adam Spiers ($gmane/264405) of a new 
video of his git-deps tool ($gmane/262606) may be of interest for 
determining the dependency charts. It looked interesting for this type 
of issue.

His original blog is http://blog.adamspiers.org/2015/01/19/git-deps/ 
with repo at https://github.com/aspiers/git-deps
<\minor bikeshed>
>
> I'll see about setting up a maint-lts in a local git repository clone 
> and tracking LTS fixes.  If I'm able to keep that going without it 
> becoming a black-hole of temporal need that sucks the life right out 
> of me  ;)  then perhaps we can have a discussion at a future date 
> about what would be needed for you to consider pulling from it and 
> issuing LTS releases off it.  :)
>
> -Kyle
> --
Philip 
