From: David Michael Barr <david.barr@cordelta.com>
Subject: Re: [PATCH] contrib/svn-fe: Fast script to remap svn history
Date: Thu, 7 Oct 2010 18:17:13 +1100
Message-ID: <A609D4AA-04A8-4190-9CA9-3EF7F52BB93F@cordelta.com>
References: <1286431561-24126-1-git-send-email-david.barr@cordelta.com> <AANLkTim_3m=YmyVL7eEoWDGwDwmuDJsYkQMgx8ciVPH0@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 07 09:27:47 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P3ktF-0001Zq-D7
	for gcvg-git-2@lo.gmane.org; Thu, 07 Oct 2010 09:27:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759622Ab0JGH1k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Oct 2010 03:27:40 -0400
Received: from ironport1-mx.cbr1.mail-filtering.com.au ([203.88.115.241]:40515
	"EHLO ironport1-mx.cbr1.mail-filtering.com.au" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756018Ab0JGH1j (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 7 Oct 2010 03:27:39 -0400
X-Greylist: delayed 618 seconds by postgrey-1.27 at vger.kernel.org; Thu, 07 Oct 2010 03:27:39 EDT
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Av0EAFIQrUzLWHsF/2dsb2JhbACiSAhxuwmIToJzglQE
X-IronPort-AV: E=Sophos;i="4.57,296,1283695200"; 
   d="scan'208";a="252476978"
Received: from node2.alpha.aussiehq.net.au ([203.88.123.5])
  by ironport1-mta.cbr1.mail-filtering.com.au with ESMTP; 07 Oct 2010 18:17:15 +1100
Received: (qmail 32138 invoked from network); 7 Oct 2010 18:17:14 +1100
Received: from d110-33-95-167.mit3.act.optusnet.com.au (HELO ?192.168.1.1?) (110.33.95.167)
  by 203.88.123.185 with SMTP; 7 Oct 2010 18:17:14 +1100
In-Reply-To: <AANLkTim_3m=YmyVL7eEoWDGwDwmuDJsYkQMgx8ciVPH0@mail.gmail.com>
X-Mailer: Apple Mail (2.1081)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158379>

Hi,

>> This python script walks the commit sequence imported by svn-fe.
>> For each commit, it tries to identify the branch that was changed.
>> Commits are rewritten to be rooted according to the standard layout.
>> A basic heuristic of matching trees is used to find parents for the
>> first commit in a branch and for tags.
> 
> Nice, how easy would it be to extend it to deal with other layouts?

I think its just a matter of adjusting the regular expression to match roots
and the mapping from roots to refs.

>> diff --git a/fast-import.c b/fast-import.c
>> index 2317b0f..8f68a89 100644
>> --- a/fast-import.c
>> +++ b/fast-import.c
>> @@ -1454,6 +1454,15 @@ static int tree_content_set(
>>                n = slash1 - p;
>>        else
>>                n = strlen(p);
>> +       if (!slash1 && !n) {
>> +               if (!S_ISDIR(mode))
>> +                       die("Root cannot be a non-directory");
>> +               hashcpy(root->versions[1].sha1, sha1);
>> +               if (root->tree)
>> +                       release_tree_content_recursive(root->tree);
>> +               root->tree = subtree;
>> +               return 1;
>> +       }
>>        if (!n)
>>                die("Empty path component found in input");
>>        if (!slash1 && !S_ISDIR(mode) && subtree)
> 
> What is this hunk about?

My bad, that belongs in a separate commit. I'll break it out after review.

The subject would read: "fast-import: Allow filemodify to set the root".

--
David Barr
