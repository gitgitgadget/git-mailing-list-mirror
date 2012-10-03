From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: erratic behavior commit --allow-empty
Date: Wed, 3 Oct 2012 08:29:37 +0100
Organization: OPDS
Message-ID: <90464C79DA97415C9D66846A77ECAA4A@PhilipOakley>
References: <CAB9Jk9BynCunFHRFhGKoyDA-qof1iu6w952sAgSs2_JWb8+U3A@mail.gmail.com><506AA51E.9010209@viscovery.net><7vzk449449.fsf@alter.siamese.dyndns.org><CAB9Jk9CSW0ObJtgsfSwjf+k438=V8i7dP0p+YUehqdh2Z0k6tA@mail.gmail.com><7vhaqc7in6.fsf@alter.siamese.dyndns.org> <CAB9Jk9D-eJ8goYx7LWqGcWcLgRDS8+qLZVUsvvJ+QOtryP9-zg@mail.gmail.com>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: "Johannes Sixt" <j.sixt@viscovery.net>, "git" <git@vger.kernel.org>
To: "Angelo Borsotti" <angelo.borsotti@gmail.com>,
	"Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 03 09:30:08 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TJJOs-0006H5-JP
	for gcvg-git-2@plane.gmane.org; Wed, 03 Oct 2012 09:29:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756119Ab2JCH3h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Oct 2012 03:29:37 -0400
Received: from out1.ip01ir2.opaltelecom.net ([62.24.128.237]:55173 "EHLO
	out1.ip01ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756111Ab2JCH3g (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 3 Oct 2012 03:29:36 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AuIKAK3Sa1BcHmKZ/2dsb2JhbABFi0yyEgEDgQ6BCYIbBQEBBAEIAQEuEQUIAQEcBQUGAgMFAgEDFAEMJRQBBAgQAgYHFwYBBwsIAgECAwEMBIdSAwkKB64+DYlUij9kODIDJIRJYAOII4VGhiuCaooLhQuCaA
X-IronPort-AV: E=Sophos;i="4.80,527,1344207600"; 
   d="scan'208";a="405458253"
Received: from host-92-30-98-153.as13285.net (HELO PhilipOakley) ([92.30.98.153])
  by out1.ip01ir2.opaltelecom.net with SMTP; 03 Oct 2012 08:29:33 +0100
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206863>

From: "Angelo Borsotti" <angelo.borsotti@gmail.com>
> Hi Junio,
>
>> It does create one; it just is the same one you already happen to 
>> have,
>> when you record the same state on top of the same history as the
>> same person at the same time.
>>
>
> No, it does not create one:

Angelo
This is a semantics problem. It is like the confusion as to whether zero 
is a natural number that can be used in counting.

In this case we have created two commits. However they are, by design 
and definition, identical to each other for this case of identical 
content and identical administration fields. They cannot be 
distinguished.

So when the file system is asked to 'write' the second commit, it (the 
file system in conjunction with the git code) does a no-op, and reports 
'done'.

It is a common (systems) engineering problem. Software engineering 
usually allows an empty subroutine to exist, while physical engineering 
wouldn't. Git cannot have two unique but identical commits (a 
contradiction in terms).

Normally git will create a new (different & unique) commit for each and 
every commit, but in this special case a second identical commit was 
'created', but the uniqueness requirement means it _is_ the same as the 
first commit.

> as you can see from the trace of the execution
> of my script, the sha of the commit is the same as that of the other,
> which means
> that in the .git/objects there is only one such commit object, and not 
> two with
> the same sha. The meaning of the word "create" is to bring into being 
> something
> that did not exist before. There is no "creation" if the object 
> already exists.
>
>>
>> And how would it help what to insert a sleep for 1 second (or 1 year
>> for that matter)?  As you said, it reads from the system clock, and
>> there are millions of systems in the world that have Git installed.
>> You may record the same state on top of the same history as the same
>> person on two different machines 5 minutes in wallclock time in
>> between doing so.  These two machines may end up creating the same
>> commit because one of them had a clock skewed by 5 minutes.
>
> I understood that the command does not create a new commit if all its 
> data, i.e.
> tree, committer, ... and date are the same, representing the date with 
> 1 second
> precision. Sleeping for 1 second guarantees that there is no commit in 
> the repo
> that has the same time as the time after the sleep, i.e. that the
> command creates
> a (new) commit.
>
>>
>> What problem are you really trying to solve?  You mentioned
>> importing from the foreign SCM,
>
> I quoted a piece of the man page of git commit, that states that
> --allow-empty bypasses
> the safety check that prevents to make a new commit. That piece
> incidentally states
> that it is "primarily" used by foreign SCM interface scripts. But of
> course it can be used
> in any script that needs to build a commit on top of another.
>
>>
>> You also did not seem to have read what I wrote, or deliberately
>> ignored it (in which case I am wasting even more time writing this,
>> so I'll stop).
>
> I did not deliberately ignore what you wrote. I might have missed some
> point though.
>
>> This does not have anything to do with "--allow-empty"; removing
>> "the option" would not help anything, either.
>
> I am reporting a problem with --allow-empty, so why you say that this
> does not have
> anything to do with it?
> Removing the option removes a behavior that is not predictable.
> Often it is better to remove a feature that turns out to be
> inconsistent than to leave it
> in the software. Of course a much better avenue is to make it 
> consistent.
>
>> Run the following on a fast-enough machine.
>>
> I did, and obtained most of the times "I was quick enough" and
> sometimes "I was not quick enough", which is the same kind of behavior
> of my script.
>
> The problem I am trying to solve is to push to a remote server the
> source files only,
> while keeping in the local repo both sources and binaries. To do it, I
> keep an orphan
> branch, say "sources". When I make a commit on the master branch, I 
> make also a
> commit on the sources one after having un-staged (git rm --cached) the 
> binaries.
> The script that does this must cope also with the particular case in
> which in the commit
> on the master branch there are no sources. Basically the script does:
>
> # this is the commit on the master branch
> git init
> echo "aaa" >f1
> git add f1
> git commit -m A
>
> # this is the piece of the script that builds the sources branch
> git checkout --orphan sources
> # git rm --cached ...   remove binaries, if any"
> git commit -m A --allow-empty
> git rev-list --all --pretty=oneline
>
> When there are binaries in the commit A, they are removed, and the
> tree for the second
> git commit is then different, and the commit is actually created.
> When there are no binaries (as in the script above, in which the
> removal is commented out),
> the second git commit would not create any new commit, and I would not
> have an orphan
> branch. Thence the --allow-empty to force it to create a new commit.
> Unfortunately, it creates a new commit only if the system clock
> changes the seconds of
> the system time between the two git commits.
> If you insert a "sleep 1" before the second git commit, the commit is
> really created.
>
> I spent many hours to spot this time-dependent error ....
>
> -Angelo
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
> -----
> No virus found in this message.
> Checked by AVG - www.avg.com
> Version: 2012.0.2221 / Virus Database: 2441/5305 - Release Date: 
> 10/02/12
> 
