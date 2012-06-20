From: Andreas Ericsson <ae@op5.se>
Subject: Re: 'git branch' when origin branch with same name exists
Date: Wed, 20 Jun 2012 10:31:39 +0200
Message-ID: <4FE18A6B.9020207@op5.se>
References: <4FE091FB.7020202@desrt.ca> <20120619200648.2cc8a861.kostix@domain007.com> <4FE0B1A1.9030509@desrt.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Konstantin Khomoutov <flatworm@users.sourceforge.net>,
	git@vger.kernel.org
To: Ryan Lortie <desrt@desrt.ca>
X-From: git-owner@vger.kernel.org Wed Jun 20 10:32:07 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ShGKc-0001q9-JE
	for gcvg-git-2@plane.gmane.org; Wed, 20 Jun 2012 10:32:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754725Ab2FTIbt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Jun 2012 04:31:49 -0400
Received: from mail-lb0-f174.google.com ([209.85.217.174]:62876 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754663Ab2FTIbp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jun 2012 04:31:45 -0400
Received: by lbbgm6 with SMTP id gm6so280959lbb.19
        for <git@vger.kernel.org>; Wed, 20 Jun 2012 01:31:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding
         :x-gm-message-state;
        bh=OWSs2CnmSr1R+AAJIwoj0p/eC4IPg7jRTPRtjuChBYs=;
        b=lzf/3rLVrMQt5DmWaaudRLSebY3Pxkxd+QnkM4MDE3k/jbRtea1kVQFMDGRzCyUmoZ
         CTHueUvGUIz36y0cqJyk4c3l5OG0cgskgyeTLGXTCU/JaajctgTHNG6N8eGD1FXAuSr1
         5Z9uLKVLW+zuxEOCijOjG10OfTd/+AKbbHM0rU485pQsB9s4lVZbFonGozWEE8T5p6LS
         jy9P3PwESawquPqYztNeBvPVU6HVQOKO3uLoCKj8c4J02e8sg0KlJHxSbPmnBoVTZy3r
         2AznyNeGUXF4ntPnhDVGWSfz1jBnhD6pEeqGrp8BcgMu8RrmyTz2WfGgjK636bL5euko
         EXhA==
Received: by 10.112.83.169 with SMTP id r9mr9281876lby.66.1340181103515;
        Wed, 20 Jun 2012 01:31:43 -0700 (PDT)
Received: from vix.int.op5.se (c80-217-218-226.bredband.comhem.se. [80.217.218.226])
        by mx.google.com with ESMTPS id gd9sm15688261lbb.15.2012.06.20.01.31.40
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 20 Jun 2012 01:31:41 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:12.0) Gecko/20120430 Thunderbird/12.0.1
In-Reply-To: <4FE0B1A1.9030509@desrt.ca>
X-Gm-Message-State: ALoCoQnwGZE4+FI/0VSLSG8he10XzD2+VqXdLIlMfYYd1YKdbeAbICyBJO0JKaW7tc0yp1GI3Wjh
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200289>

On 06/19/2012 07:06 PM, Ryan Lortie wrote:
> 
>> Anyway, this will make each call to git-branch to perform a crawl
>> over the refs/heads hierarchy which, I think, is not worth the
>> result.
> 
> I know branching is lightweight with git, but I don't understand that
> the operation is so performance-critical that a enumerating a
> directory and doing a few stats would be a huge issue...
> 
> If it is decided to only check the 'origin' remote then we're talking
> about one single stat() syscall.
> 

Not really. I don't remember which repository it was, but the "packed-refs"
feature came about as a result of one repository having in excess of 120k
refs. So your "a few stat() calls" could well end up nuking performance
totally for someone else, and "one stat call for origin" is only true if
origin only has one ref, which is obviously not the case for some of the
larger projects.

In general, assuming everyone else uses a piece of software the same way
you do is a recipe for creating poorly performing programs.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231

Considering the successes of the wars on alcohol, poverty, drugs and
terror, I think we should give some serious thought to declaring war
on peace.
