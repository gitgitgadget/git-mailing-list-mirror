From: Luke Diamand <luke@diamand.org>
Subject: Re: [PATCH 1/4] git-p4: handle p4 branches and labels containing
 shell chars
Date: Thu, 19 Jan 2012 09:12:16 +0000
Message-ID: <4F17DE70.2010204@diamand.org>
References: <1326755689-3344-1-git-send-email-luke@diamand.org> <1326755689-3344-2-git-send-email-luke@diamand.org> <20120117223949.GA811@padd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Pete Wyckoff <pw@padd.com>
X-From: git-owner@vger.kernel.org Thu Jan 19 10:12:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rno2l-0003P2-Jc
	for gcvg-git-2@lo.gmane.org; Thu, 19 Jan 2012 10:12:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755198Ab2ASJMX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Jan 2012 04:12:23 -0500
Received: from mail-we0-f174.google.com ([74.125.82.174]:52308 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752890Ab2ASJMT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jan 2012 04:12:19 -0500
Received: by werb13 with SMTP id b13so1029036wer.19
        for <git@vger.kernel.org>; Thu, 19 Jan 2012 01:12:18 -0800 (PST)
Received: by 10.216.145.1 with SMTP id o1mr69812wej.45.1326964338208;
        Thu, 19 Jan 2012 01:12:18 -0800 (PST)
Received: from [86.26.7.206] (cpc1-cmbg14-2-0-cust973.5-4.cable.virginmedia.com. [86.26.7.206])
        by mx.google.com with ESMTPS id fv6sm64137664wib.8.2012.01.19.01.12.16
        (version=SSLv3 cipher=OTHER);
        Thu, 19 Jan 2012 01:12:16 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:7.0.1) Gecko/20110929 Thunderbird/7.0.1
In-Reply-To: <20120117223949.GA811@padd.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188795>

On 17/01/12 22:39, Pete Wyckoff wrote:
> luke@diamand.org wrote on Mon, 16 Jan 2012 23:14 +0000:
>> Don't use shell expansion when detecting branches, as it will
>> fail if the branch name contains a shell metachar. Similarly
>> for labels.
>>
>> Add additional test for branches with shell metachars.
>
> Nice.  There will be a fixup on a command in Vitor's series,
> depending on which goes first.  He'll have a couple of
> un-listified read_pipe{,_lines} that we should treat similarly.
>
>> @@ -1758,7 +1758,7 @@ class P4Sync(Command, P4UserMap):
>>       def getLabels(self):
>>           self.labels = {}
>>
>> -        l = p4CmdList("labels %s..." % ' '.join (self.depotPaths))
>> +        l = p4CmdList(["labels", "%s..." % ' '.join (self.depotPaths)])
>>           if len(l)>  0 and not self.silent:
>>               print "Finding files belonging to labels in %s" % `self.depotPaths`
>
> I suspect the command "p4" "labels" "//depot/foo/...  //depot/bar/..."
> might confuse p4, but haven't tested.  Maybe tuck each one in its
> own argument?
>
>      ["labels"] + ["%s..." % p for p in self.depotPaths]

Yes, you're right. I'll resubmit. I suspect the previous code was 
actually broken as well as you end up with the "..." only on the last depot.

>
> What happened to your failing test?  It's fun to keep the broken
> ones around to inspire others to fix them.

I'll send that one through as well. I actually had a fix, but it needs 
to be reworked now. I'm reluctant to try to do much more on this though 
unless someone can tell me how the --detect-labels code can ever really 
work.

i.e. if you do:

  p4 submit
  git-p4 rebase --detect-labels
  p4 tag LABEL_A
  git-p4 rebase --detect-labels

At this point, LABEL_A won't show up in git until the _next_ p4 commit.

It's slowly working it's way towards the top of my todo list though!

Regards!
Luke
