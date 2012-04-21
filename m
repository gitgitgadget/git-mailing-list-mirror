From: Luke Diamand <luke@diamand.org>
Subject: Re: [PATCHv2 2/2] git p4: import/export of labels to/from p4
Date: Sat, 21 Apr 2012 18:59:35 +0100
Message-ID: <4F92F587.90305@diamand.org>
References: <1334157684-31402-1-git-send-email-luke@diamand.org> <1334157684-31402-3-git-send-email-luke@diamand.org> <20120418113422.GB19994@padd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Vitor Antunes <vitor.hda@gmail.com>
To: Pete Wyckoff <pw@padd.com>
X-From: git-owner@vger.kernel.org Sat Apr 21 19:59:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SLeb3-00034k-2U
	for gcvg-git-2@plane.gmane.org; Sat, 21 Apr 2012 19:59:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751572Ab2DUR7j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Apr 2012 13:59:39 -0400
Received: from mail-we0-f174.google.com ([74.125.82.174]:63882 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751022Ab2DUR7h (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Apr 2012 13:59:37 -0400
Received: by wejx9 with SMTP id x9so6679734wej.19
        for <git@vger.kernel.org>; Sat, 21 Apr 2012 10:59:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding
         :x-gm-message-state;
        bh=CZd8p7VlEzZzj3eg/sUZwwwZLlr/UcFnQ27Q7F+UHHo=;
        b=Wt+PNdA2++FTX5oE4qK2/Im2pLasnVKEDkJPR3goRCz582h1bTERAcx4H3XGqYQB4w
         LEZggRwXL7/79FtyRZEqEIM7D7KoczznkBL0/yK57/VK1ASYV/8zZ+B9NE2WqBg6u5bB
         dm/5f9PdJde5fdIizTPCPBFMFr8NazBRPj8J4Jsof4AeC6nW6tKO8QN9kXgwRIFfkLdu
         +j1Cz0Tu9v4chAx8XUC5IT1d3VE7mcxGuyFMw56BIBt1HWRUTPvqS260HP14T4vyLMtS
         jcaL4S0BeoCNdBxZk5r26BfYINjFDfA8xMWFST16ynE3sVzAzIuUCi6qrgQPy29iRrRI
         HuFQ==
Received: by 10.180.103.35 with SMTP id ft3mr7748315wib.0.1335031176473;
        Sat, 21 Apr 2012 10:59:36 -0700 (PDT)
Received: from [86.6.30.7] (cpc19-cmbg14-2-0-cust6.5-4.cable.virginmedia.com. [86.6.30.7])
        by mx.google.com with ESMTPS id j3sm11940442wiw.1.2012.04.21.10.59.35
        (version=SSLv3 cipher=OTHER);
        Sat, 21 Apr 2012 10:59:36 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:10.0.3) Gecko/20120324 Icedove/10.0.3
In-Reply-To: <20120418113422.GB19994@padd.com>
X-Gm-Message-State: ALoCoQlNCmlVLERIf8LM9zTH1D5eQo4+fCV5DVB4YVmISV2J348lNeJ3igxaABCUrrHTt2xRK2gL
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196055>

On 18/04/12 12:34, Pete Wyckoff wrote:
> luke@diamand.org wrote on Wed, 11 Apr 2012 17:21 +0200:
>> The existing label import code looks at each commit being
>> imported, and then checks for labels at that commit. This
>> doesn't work in the real world though because it will drop
>> labels applied on changelists that have already been imported,
>> a common pattern.
>>
>> This change adds a new --import-labels option. With this option,
>> at the end of the sync, git p4 gets sets of labels in p4 and git,
>> and then creates a git tag for each missing p4 label.
>>
>> This means that tags created on older changelists are
>> still imported.
>>
>> Tags that could not be imported are added to an ignore
>> list.
>>
>> The same sets of git and p4 tags and labels can also be used to
>> derive a list of git tags to export to p4. This is enabled with
>> --export-labels in 'git p4 submit'.
>
> This is a good approach.  Here's some late review comments.
>
>> diff --git a/Documentation/git-p4.txt b/Documentation/git-p4.txt
>
>> +git-p4.validLabelRegexp::
>> +	Only p4 labels matching this regular expression will be imported. The
>> +	default value is '[A-Z0-9_\-.]+$'.
>> +
>
> and
>
>> +git-p4.validLabelRegexp::
>> +	Only p4 labels matching this regular expression will be exported. The
>> +	default value is '[A-Z0-9_\-.]+$'.
>
> This one wants to be validTagRegexp.  Or you could combine them
> both into one.

I'll change to "validLabelExportRegexp" and "validLabelImportRegexp". I 
don't want to use the word "tag" as I think that gets confusing. The 
original "detect-labels" uses the p4 naming, and right or wrong, I guess 
we should stick with that choice.

 >  Why no small a-z characters?

Being very lazy, this happens to work well for me P

>
>> diff --git a/git-p4.py b/git-p4.py
>
>> +            # Get the p4 commit this corresponds to
>> +            changelist = None
>> +            for l in read_pipe_lines(["git", "log", "--max-count=1", name]):
>> +                match = commit_re.match(l)
>> +                if match:
>> +                    changelist = match.group(1)
>
> We have extractLogMessageFromGitCommit and extractSettingsGitLog
> to grep out the "git-p4.. change" tag.  They're not beautiful,
> but we should reuse them, in case this mechanism of connecting
> changes to commits ever changes.

ok.

>
>> +            # Get the tag details.
>> +            inHeader = True
>> +            isAnnotated = False
>> +            body = []
>> +            for l in read_pipe_lines(["git", "cat-file", "-p", name]):
>> +                l = l.strip()
>> +                if inHeader:
>> +                    if re.match(r'tag\s+', l):
>> +                        isAnnotated = True
>> +                    elif re.match(r'\s*$', l):
>> +                        inHeader = False
>> +                        continue
>> +                else:
>> +                    body.append(l)
>> +
>> +            if not isAnnotated:
>> +                body = ["lightweight tag imported by git p4\n"]
>
> The manual parsing, just to get the text in the tag (or ref),
> seems a bit awkward.  I looked at "git show --pretty=format:%B"
> as a way to get just the text, and "git cat-file -t ref" to get
> the tag/ref difference.  But no easy replacement.

Yes, slightly surprising that there's no way to do this other than 
parsing the output of git cat-file.

>
>> +            if change.has_key('change'):
>> +                # find the corresponding git commit; take the oldest commit
>> +                changelist = int(change['change'])
>> +                gitCommit = read_pipe(["git", "rev-list", "--max-count=1",
>> +                     "--reverse", ":/\[git-p4:.*change = %d\]" % changelist])
>> +                if len(gitCommit) == 0:
>> +                    print "could not find git commit for changelist %d" % changelist
>> +                else:
>> +                    gitCommit = gitCommit.strip()
>> +                    commitFound = True
>> +                    # Convert from p4 time format
>> +                    try:
>> +                        tmwhen = time.strptime(labelDetails['Update'], "%Y/%m/%d %H:%M:%S")
>> +                    except ValueError:
>> +                        print "Could not convert label time %s" % labelDetail['Update']
>> +                        tmwhen = 1
>> +
>> +                    when = int(time.mktime(tmwhen))
>> +                    self.streamTag(stream, name, labelDetails, gitCommit, when)
>> +                    if verbose:
>> +                        print "p4 label %s mapped to git commit %s" % (name, gitCommit)
>
> Nice, even the icky but required p4 time parsing.  We don't have
> a common function to go from change ->  commit yet.
>
>>   class P4Rebase(Command):
>>       def __init__(self):
>>           Command.__init__(self)
>> -        self.options = [ ]
>> +        self.options = [
>> +                optparse.make_option("--import-labels", dest="importLabels", action="store_true"),
>> +                optparse.make_option("--verbose", dest="verbose", action="store_true"),
>> +        ]
>> +        self.verbose = False
>> +        self.importLabels = False
>>           self.description = ("Fetches the latest revision from perforce and "
>>                               + "rebases the current work (branch) against it")
>> -        self.verbose = False
>
> All commands should have a --verbose.  Could you move the
> "--verbose" description in the man page up into "General
> options"?  Since it means the same thing in all the commands,
> roughly.

OK.

>
>>       def run(self, args):
>>           sync = P4Sync()
>> +        sync.importLabels = self.importLabels
>>           sync.run([])
>
> But no "sync.verbose = self.verbose"?  I wonder if P4Rebase should
> inherit from P4Sync, like Clone does.  But that is a bit obscure
> to me already.  Probably these all want to be split out into a
> bunch of functions; there isn't a lot of state tracking happening
> in the classes, and only one instance of each per invocation.

Or push the 'verbose' up into the Command base class?

>
>> diff --git a/t/t9811-git-p4-label-import.sh b/t/t9811-git-p4-label-import.sh
>> new file mode 100755
>> index 0000000..85d6049
>> --- /dev/null
>> +++ b/t/t9811-git-p4-label-import.sh
>> @@ -0,0 +1,202 @@
>> +#!/bin/sh
>> +
>> +test_description='git p4 label tests'
>
> This whole set of tests can go it the existing t9804, right?  It
> seems that the first few of these are duplicates of what is
> already in there.
>
> Nice test coverage, and you fixed the broken one in t9804.
>
> 		-- Pete

OK, I'll put these in t9804.

Thanks!
Luke
