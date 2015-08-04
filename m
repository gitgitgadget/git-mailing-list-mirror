From: Luke Diamand <luke@diamand.org>
Subject: Re: [git-p4] import with labels fails when commit is not transferred
Date: Tue, 04 Aug 2015 08:19:24 +0100
Message-ID: <55C0677C.6090202@diamand.org>
References: <A24B2157A13A04409644C1456B5AE27F1CE4B663@DEWDFEMB19A.global.corp.sap> <5597529D.9080100@diamand.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
To: "Holl, Marcus" <marcus.holl@sap.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Aug 04 09:19:29 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZMWVV-0005hb-8s
	for gcvg-git-2@plane.gmane.org; Tue, 04 Aug 2015 09:19:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752121AbbHDHTY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Aug 2015 03:19:24 -0400
Received: from mail-wi0-f177.google.com ([209.85.212.177]:35101 "EHLO
	mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751667AbbHDHTX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Aug 2015 03:19:23 -0400
Received: by wibxm9 with SMTP id xm9so152626607wib.0
        for <git@vger.kernel.org>; Tue, 04 Aug 2015 00:19:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=message-id:date:from:user-agent:mime-version:to:subject:references
         :in-reply-to:content-type:content-transfer-encoding;
        bh=VLLB1umWtX3doSv/TkxeA96K+mtDrY+h8Yht9lQqwvk=;
        b=U32+Pb2V0im1+ImhfLoq0SGWwRUl9nywf2tNukXs92zUexa6f5Co2gJaS15Th0+6DM
         4TO1L+g1IRAXcKL2LabI5NxQ67Ab4+xBXi+QoWdfRnjnpTpVJBzU7c7yoWDIZQZwGlzt
         JAoVm0WGX+XTme0ugXqQccESEJ2yQOsRIHavE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=VLLB1umWtX3doSv/TkxeA96K+mtDrY+h8Yht9lQqwvk=;
        b=ZbIxZ46OP/l3l63B6CQooPQ99JFk9WqrQLDpoVn1Adx3F234mzn6Njo1w1OmZ1tzN+
         rb5GF67mtTkZtaS5wL9X15CUbttrmqpvd70vTlanoFch9WyyIMKRq83UVNHCUcvauhXs
         v24UJODi2tGNKFZFkT6ReK25eWysXRDAFSSw5jLTl+8jcXo9EUGi8Rc6Jw24vmmdSSqF
         Ca1XNMXr1ET5vYxa2gEUtWn4BqY5CW+NIIwIr63C6jvDTez4Aizp4AHdcpVKpx+7u1/G
         YTaWBeveGANoYTAKCfFKjMO3RIXOeFtcv671LZAiwKCNqZS3pzInTEOqPsDxxakMALRC
         qFOg==
X-Gm-Message-State: ALoCoQnpQwP7NY+5OBAklsl6dEuOOXl7/yaxWygz1UhsavQcWBR2nejEw6VyLnh3T23BQp/u79eD
X-Received: by 10.180.39.163 with SMTP id q3mr5130652wik.82.1438672762176;
        Tue, 04 Aug 2015 00:19:22 -0700 (PDT)
Received: from [192.168.245.128] (cpc7-cmbg17-2-0-cust139.5-4.cable.virginm.net. [86.1.43.140])
        by smtp.gmail.com with ESMTPSA id i6sm234788wje.33.2015.08.04.00.19.20
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Aug 2015 00:19:21 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.6.0
In-Reply-To: <5597529D.9080100@diamand.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275238>

On 04/07/15 04:27, Luke Diamand wrote:
> Sorry for not replying earlier, and thanks for taking the time to
> investigate this!
>
> It's a pretty subtle corner case: I think a test case would be useful.
> I'm going to try to put something together, unless you beat me to it!
>
> (I think t9811-git-p4-label-import.sh is the one that needs extending).

I've been looking into this a bit more, and I think that you don't need 
a try/except - it's enough just to add "ignore_error=True" to the call 
to read_lines.

It also looks like this is a general problem of importing a label where 
the revision doesn't exist in git. For example, if you create a p4 
label, then clone at the revision after that, you will get the problem.

I've got a test case and a modified git-p4.py, but I haven't yet got to 
the point where I'm convinced it works. I think the fix is pretty much 
what you've shown (replacing try-except with ignore_error) but I'd like 
my test case to be a bit more convincing.

Thanks!
Luke

>
> On 30/06/15 09:45, Holl, Marcus wrote:
>> Hi,
>>
>> I have an issue with the git p4 tooling regarding import of labels.
>>
>> My git version is 2.4.5
>>
>> I try to transform a perforce repository. My command line is:
>> git p4 clone --verbose --detect-branches --import-local
>> --import-labels --destination <DESTINATION> //depot@all
>>
>>
>> The relevant parts in the gitconfig is:
>> [git-p4]
>>                  branchUser = <USERNAME>
>>
>>
>> For that user there is a branch mapping defined with a lot of entries
>> like:
>> //depot/trunk/... //depot/branches/ipro-status-8-2--branch/...
>> //depot/trunk/... //depot/branches/9-0-preview/...
>> //depot/trunk/... //depot/branches/release-8-0-0-branch/...
>> //depot/trunk/... //depot/branches/release-8-1-0-branch/...
>> //depot/trunk/... //depot/branches/release-8-2-0-branch/...
>> //depot/trunk/... //depot/branches/release-8-3-0-branch/...
>> //depot/trunk/... //depot/branches/release-8-4-branch/...
>> //depot/trunk/... //depot/branches/release-8-5-branch/...
>> ...
>>
>>
>> The import fails with the log output that can be found at the bottom
>> of this mail.
>>
>> git log -all -grep "\[git-p4:.*change\ =\ 69035\]" reports nothing.
>> The commit is not contained in the git repository.
>>
>> p4 describe for changelist 69035 returns a reasonable result. This
>> change contains one file located at a path in the perforce folder
>> structure that comes without corresponding entry in the perforce
>> branch mapping.
>>
>> According to the given branch mapping it looks reasonable to me that
>> the change is omitted in the git repository. But in my opinion the
>> import should not fail in such a case.
>>
>> A reasonable behavior would be to blacklist the label (add it to
>> git-p4.ignoredP4Labels) and to continue with the next label.
>>
>> Attached is a proposal for a fix that needs to be carefully reviews
>> since I'm not that experienced with python.
>>
>> Other proposals for resolving this issue are highly appreciated.
>>
>> Thanks a lot and best regards,
>> Marcus Holl
>>
>>
>> Log output:
>>
>> Reading pipe: ['git', 'rev-list', '--max-count=1', '--reverse',
>> ':/\\[git-p4:.*change = 69035\\]']
>> fatal: ambiguous argument ':/\[git-p4:.*change = 69035\]': unknown
>> revision or path not in the working tree.
>> Use '--' to separate paths from revisions, like this:
>> 'git <command> [<revision>...] -- [<file>...]'
>> ied with change: 69078, original Date: 2010-04-22T09:07:24.000000Z\n',
>> 'Update': '2013/11/02 07:40:31', 'Label': 'release-8-1-0-976',
>> 'Access': '2015/06/26 14:50:15', 'Owner': 'svn_p4_converter',
>> 'Options': 'unlocked noautoreload'}
>> p4 label release-8-1-0-976 mapped to git commit
>> 82a11809928b86a7bde03cf486428de52ab3380f
>> writing tag release-9-0-0-179 for commit
>> fb8370cd04806686c567ad720d065436f2334b4a
>> labelDetails= {'code': 'stat', 'Description': 'Created or modified
>> with change: 96984, original Date: 2011-12-22T16:01:25.681427Z\n',
>> 'Update': '2013/11/02 15:15:50', 'Label': 'release-9-0-0-179',
>> 'Access': '2015/06/26 14:50:16', 'Owner': 'build', 'Options':
>> 'unlocked noautoreload'}
>> p4 label release-9-0-0-179 mapped to git commit
>> fb8370cd04806686c567ad720d065436f2334b4a
>> Traceback (most recent call last):
>>    File "/usr/lib/git/git-p4", line 3297, in <module>
>>      main()
>>    File "/usr/lib/git/git-p4", line 3291, in main
>>      if not cmd.run(args):
>>    File "/usr/lib/git/git-p4", line 3165, in run
>>      if not P4Sync.run(self, depotPaths):
>>    File "/usr/lib/git/git-p4", line 3045, in run
>>      self.importP4Labels(self.gitStream, missingP4Labels)
>>    File "/usr/lib/git/git-p4", line 2421, in importP4Labels
>>      "--reverse", ":/\[git-p4:.*change = %d\]" % changelist])
>>    File "/usr/lib/git/git-p4", line 138, in read_pipe
>>      die('Command failed: %s' % str(c))
>>    File "/usr/lib/git/git-p4", line 106, in die
>>      raise Exception(msg)
>> Exception: Command failed: ['git', 'rev-list', '--max-count=1',
>> '--reverse', ':/\\[git-p4:.*change = 69035\\]']
>>
>
