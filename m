From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH (BUGFIX)] gitweb: Fix fixed string (non-regexp) project search
Date: Sat, 3 Mar 2012 11:55:59 +0100
Message-ID: <201203031156.00948.jnareb@gmail.com>
References: <20120228183919.26435.86795.stgit@localhost.localdomain> <201203022334.25544.jnareb@gmail.com> <7vwr72a6m6.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Ramsay Jones <ramsay@ramsay1.demon.co.uk>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Mar 03 11:56:43 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S3mdm-0004ph-VR
	for gcvg-git-2@plane.gmane.org; Sat, 03 Mar 2012 11:56:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752355Ab2CCK4J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Mar 2012 05:56:09 -0500
Received: from mail-ee0-f46.google.com ([74.125.83.46]:58663 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751216Ab2CCK4H (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Mar 2012 05:56:07 -0500
Received: by eekc41 with SMTP id c41so896769eek.19
        for <git@vger.kernel.org>; Sat, 03 Mar 2012 02:56:05 -0800 (PST)
Received-SPF: pass (google.com: domain of jnareb@gmail.com designates 10.213.108.201 as permitted sender) client-ip=10.213.108.201;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of jnareb@gmail.com designates 10.213.108.201 as permitted sender) smtp.mail=jnareb@gmail.com; dkim=pass header.i=jnareb@gmail.com
Received: from mr.google.com ([10.213.108.201])
        by 10.213.108.201 with SMTP id g9mr1693439ebp.86.1330772165572 (num_hops = 1);
        Sat, 03 Mar 2012 02:56:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=NUCAf/BxmqJ3nBXvVeJTU35Iu6xGb3Z3akg8cHTDb4Y=;
        b=lYmtJAst/yE1OkuGE78zMo6qneDzV+rI/S7TZ6ZEGnJpnHJpjvVXyPvs6BxUR9y0OJ
         O9eZPd7Gz9Qzu6fsdydj7bSGD9wnXhwMKb0+djUy3kQIPuE07E6Ap4aiahKOu818YyJC
         yAQK1N0sU7xtDE0aexm3FwOMkJMXaR6qkCwo6289kJ8yZMDyL+9HeNMXNTFDMkgp0NzV
         4j9m24VXSqYHsq3MWIzcTbmAKUMECrKzRMlg6TqCCs0gh2klaOerNbS0rIK7Ux1NiSlK
         tSx/ObuJ7YPHBQaJZ3AsImHi1q4amIo1OG6FAkvV4UsAqRROybmrQz3f69npOLCW+Npn
         /Omg==
Received: by 10.213.108.201 with SMTP id g9mr1306958ebp.86.1330772165462;
        Sat, 03 Mar 2012 02:56:05 -0800 (PST)
Received: from [192.168.1.13] (abwo91.neoplus.adsl.tpnet.pl. [83.8.238.91])
        by mx.google.com with ESMTPS id v51sm32510722eef.2.2012.03.03.02.56.03
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 03 Mar 2012 02:56:04 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <7vwr72a6m6.fsf@alter.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192103>

On Sat, 3 Mar 2012, Junio C Hamano wrote:
> Jakub Narebski <jnareb@gmail.com> writes:
> 
>> Use $search_regexp, where regex metacharacters are quoted, for
>> searching projects list, rather than $searchtext, which contains
>> original search term.
>>
>> Reported-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
>> Signed-off-by: Jakub Narebski <jnareb@gmail.com>
>> ---
>> I think this bug was here from the very beginning of adding project
>> search, i.e. from  v1.6.0.2-446-g0d1d154 (gitweb: Support for simple
>> project search form, 2008-10-03)  which was present since 1.6.1
>>
>> On Fri, 2 Mar 2012, Ramsay Jones wrote:
>> 
>>> This patch solves the problem for me when using a regex search
>>> (re checkbox checked), but *not* for a non-regex search.
>>> 
> 
> This patch depends on the more recent changes than the regexp fix, no?  I
> was hoping that we could merge the earlier fix for the regexp case to
> older maintenance tracks later, but if we were going to do so, we would
> want to do the same for a fix for fixed-string case.

The regexp and non-regexp bugs and fixes are different.

The regexp "bug" was just us forgetting that regexp is provided by user
input, and should be validated.  The bug as reported by Ramsay was here
from the very beginning, i.e. commit 0e55991 (gitweb: Clearly distinguish
regexp / exact match searches, 2008-02-26), which was present in v1.5.1
if I have checked correctly.  The fix is about adding new code and should
apply cleanly to 'maint' and even to older versions; the only trouble
with older version might be whitespace issue related to refactoring
code into subroutines.

The non-regexp project search bug was using $searchtext instead of
$search_regexp as search regexp in gitweb.  The bug was present from
the very addition of project search, namely commit 0d1d154 (gitweb:
Support for simple project search form, 2008-10-03), which was present
in v1.5.1 if I have checked correctly.  Unfortunately the fix affects
code that was changed recently in a1e1b2d (gitweb: improve usability
of projects search form, 2012-01-31); I'll try to come up with equivalent
patch to 'maint' soon (if the current one does not apply, and I guess it
doesn't).

-- 
Jakub Narebski
Poland
