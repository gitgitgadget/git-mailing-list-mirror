From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: How to deal with historic tar-balls
Date: Sun, 1 Jan 2012 18:30:25 -0000
Organization: OPDS
Message-ID: <B375E525C4704EA8807B5A59257B690B@PhilipOakley>
References: <4EFF5CDA.5050809@gmail.com> <4EFFA868.50605@dbservice.com>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: "Git List" <git@vger.kernel.org>
To: "Tomas Carnecky" <tom@dbservice.com>,
	"nn6eumtr" <nn6eumtr@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jan 01 19:30:48 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RhQBD-00087q-5w
	for gcvg-git-2@lo.gmane.org; Sun, 01 Jan 2012 19:30:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752502Ab2AASaZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 Jan 2012 13:30:25 -0500
Received: from out1.ip06ir2.opaltelecom.net ([62.24.128.242]:40157 "EHLO
	out1.ip06ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750988Ab2AASaX (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 1 Jan 2012 13:30:23 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AsALAM+lAE9cGn1J/2dsb2JhbABDggWDCoVNoXmBBoFtBQEBBAEIAQEZBC8BASEFBgIDBQIBAw4HAQICAgUhAgIUAQQaBgcXBgESCAIBAgMBh2kCoxSQY4EviUozYwSNMZoF
X-IronPort-AV: E=Sophos;i="4.71,441,1320624000"; 
   d="scan'208";a="523087130"
Received: from host-92-26-125-73.as13285.net (HELO PhilipOakley) ([92.26.125.73])
  by out1.ip06ir2.opaltelecom.net with SMTP; 01 Jan 2012 18:30:21 +0000
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187827>

From: "Tomas Carnecky" <tom@dbservice.com> Sent: Sunday, January 01, 2012
12:27 AM
>On 12/31/11 8:04 PM, nn6eumtr wrote:
>> I have a number of older projects that I want to bring into a git
>> repository. They predate a lot of the popular scm systems, so they are
>> primarily a collection of tarballs today.
I'm doing a similar thing with a set of zip files. I grouped mine into
batches for easier checking and putting on to separate branches. Planning
your branch requirements is probably the biggest task, and will depend on
how you hope to use the new repo.

>> I'm fairly new to git so I have a couple questions related to this:
>>
>> - What is the best approach for bringing them in? Do I just create a
>> repository, then unpack the files, commit them, clean out the
>> directory unpack the next tarball, and repeat until everything is loaded?
Essentially yes; Obviously if you have an organisation in mind then you can
introduce maintenance branches etc as you develop the import.

If it is simply to create a nice history that isn't really looked at, then a
simple linear model is OK. If you need to keep old mintenance versions and
obtain diffs with newer versions then look at the various branching models
and populate appropriately.

>>
>> - Do I need to pay special attention to files that are renamed/removed
>> from version to version?
No; It is only if you use those file dates to determine the implied date for
the commit.

>>
>> - If the timestamps change on a file but the actual content does not,
>> will git treat it as a non-change once it realizes the content hasn't
>> changed?
Correct. In fact git doesn't record the time stamps anyway. It simply
records the content, and structure, of the snapshot.

>>
>> - Last, if after loading the repository I find another version of the
>> files that predates those I've loaded, or are intermediate between two
>> commits I've already loaded, is there a way to go say that commit B is
>> actually the ancestor of commit C? (i.e. a->>c becomes a->>b->>c if you
>> were to visualize the commit timeline or do diffs) Or do I just reload
>> the tarballs in order to achieve this?
You can use 'grafts' as a mechanism to re-arrange the commit order, and/or
join partial repos, and then use git filter-branch to re-write the lot as a
single cohesive repo. But this 'hack' does re-write all the commit SHA1
values, so you should minimise the number of times that happens...

It is worth capturing your import sequence as a script so that you can wash 
/ rinse / repeat as often as needed to get a result you like.

> There is a script which will import sources from multiple tarballs,
> creating a commit with the contents of each tarball. It's in the git
> repository under contrib/fast-import/import-tars.perl.
I wasn't aware of those scripts. I'll be having a look at the zip import
script for my needs.

My extra problem is that almost all my zips have an extra top level
directory that changes its name for every zip (but some don't..). The TLD
changes confuses the git rename detection if I don't remove them before
committing. Fortunately it's an internal development project with no formal
releases so creating the history is a bit of a personal project which
doesn't affect ongoing development (which is the crunch question for
fidelity of the repo you create).

> tom
Philip
