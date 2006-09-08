From: Andreas Ericsson <ae@op5.se>
Subject: Re: Change set based shallow clone
Date: Fri, 08 Sep 2006 10:48:39 +0200
Message-ID: <45012E67.6050406@op5.se>
References: <9e4733910609071252ree73effwb06358e9a22ba965@mail.gmail.com>	 <edpuut$dns$1@sea.gmane.org> <9e4733910609071341u7e430214j71ddcbefa26810ca@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 08 10:48:52 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GLc2c-0002Nm-0J
	for gcvg-git@gmane.org; Fri, 08 Sep 2006 10:48:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750708AbWIHIso (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 8 Sep 2006 04:48:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750713AbWIHIso
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Sep 2006 04:48:44 -0400
Received: from linux-server1.op5.se ([193.201.96.2]:62683 "EHLO
	smtp-gw1.op5.se") by vger.kernel.org with ESMTP id S1750708AbWIHIso
	(ORCPT <rfc822;git@vger.kernel.org>); Fri, 8 Sep 2006 04:48:44 -0400
Received: by smtp-gw1.op5.se (Postfix, from userid 588)
	id C38D16BD37; Fri,  8 Sep 2006 10:48:42 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.1.4 (2006-07-25) on 
	linux-server1.op5.se
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=5.0 tests=AWL,BAYES_00 autolearn=ham 
	version=3.1.4
Received: from [192.168.1.20] (unknown [213.88.215.14])
	by smtp-gw1.op5.se (Postfix) with ESMTP
	id 41F6D6BD2F; Fri,  8 Sep 2006 10:48:40 +0200 (CEST)
User-Agent: Thunderbird 1.5.0.5 (X11/20060808)
To: Jon Smirl <jonsmirl@gmail.com>
In-Reply-To: <9e4733910609071341u7e430214j71ddcbefa26810ca@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26688>

Jon Smirl wrote:
> On 9/7/06, Jakub Narebski <jnareb@gmail.com> wrote:
>> I don't understand. Git is _not_ patchset based (like GNU Arch, or
> 
> I meant change set to refer to a commit plus trees plus blobs that
> make it up. These may be present in full or delta form.
> 
>> Mercurial, or CVS). It is snapshot based. So if you want to download
>> "skip", you need only for the local part of doenloader to make 
>> appropriate
>> grafts, like below
>>
>>
>>  *--*--*--*--*--*--*--*--*--*--*--HEAD    (server)
>>
>>  *--*--*...........*--*--*--*--*--HEAD    (shallow/sparse clone)
>>
>> But the part you were talking about is _easy_ part; the hard part is
>> merges including merging branch which was split off the trunk before
>> cutoff-point, history rewriting (c.f. 'pu' branch, and rebases), etc.
> 
> Does an average user do these things? The shallow clone is there to
> address the casual user who gags at a five hour download to get an
> initial check out Mozilla when they want to make a five line change or
> just browse the source for a few minutes.
> 

A better idea would be to allow those users to download a gzipped 
tarball of a pre-grafted repository. It shouldn't be terribly difficult 
to set up an update-hook that creates the pre-grafted repository for you 
whenever a tag (or some such) is created in the repo you host wherever 
everybody does their initial clone from.

As I understand it (although I've admittedly followed the git 
mailing-list sporadically the past three or so months), grafts already 
work as intended, and the users can then fetch into their grafted repo 
to get a bare minimum of objects.

> 
> There would also be a command to bring down all of the objects to
> fully populate a sparse tree. You could do the shallow clone to begin
> with and then do the full tree populate overnight or in the
> background.
> 

With the pre-grafted history this would work as follow

$ mkdir pregraft
$ wget http://pre-grafts.mozilla.org/pregrafted.git.tgz
$ cd pregraft
$ tar xvzf ../pregrafted.git.tgz
$ cd ..
$ git clone mozilla-repo-url >& /dev/null &
$ cd pregraft
# work, work, work; full clone completes
$ cd ../mozilla-repo
$ git pull ../pregraft master

or something similar.

iow, you get the small repo quickly and can start hacking while the 
full-history clone is downloading. If I understand grafts correctly, you 
could then merge in your changes made in the grafted repo to the one 
with full history.

> Maybe the answer is to build a shallow clone tool for casual use, and
> then if you try to run anything too complex on it git just tells you
> that you have to download the entire tree.
> 

I believe all tools that work with history understand grafts already, 
and if so they should provide sane messages when the user attempts to 
access history beyond the grafts. I might have missed or misunderstood 
something, but this seems to me like a simple solution to a complex problem.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
